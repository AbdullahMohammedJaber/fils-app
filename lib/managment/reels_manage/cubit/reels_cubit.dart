import 'package:fils/core/data/response/reel/reel_response.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'reels_state.dart';

class ReelsCubit extends Cubit<ReelsState> {
  ReelsCubit() : super(ReelsInitial());

  // =============================
  // DATA
  // =============================
  final List<Reels> _reels = [];
  final List<VideoPlayerController?> _controllers = [];

  int _currentPage = 1;
  bool _hasMore = true;
  bool _loading = false;
  int _currentIndex = 0;

  final PageController pageController = PageController();

  List<Reels> get reels => _reels;

  VideoPlayerController? getController(int index) {
    if (index < 0 || index >= _controllers.length) return null;
    return _controllers[index];
  }

  // =============================
  // FETCH API
  // =============================
  Future<void> fetchReels({bool isRefresh = false}) async {
    if (_loading) return;

    _loading = true;
    emit(ReelsLoading(reels: List.from(_reels)));

    if (isRefresh) {
      _currentPage = 1;
      _hasMore = true;
      _reels.clear();
      _disposeControllers();
    }

    try {
      final result = await UserCase().reelUseCase.fetchReels(
        page: _currentPage,
      );

      result.handle(
        onSuccess: (response) async {
          _hasMore = response.meta.currentPage < response.meta.lastPage;

          final newData = response.data.reversed.toList();

          for (final reel in newData) {
            if (reel.videoLink.endsWith('.mp4')) {
              _reels.add(reel);
            }
          }

          _controllers.addAll(
            List<VideoPlayerController?>.filled(newData.length, null),
          );

          // ✅ تحميل الفيديو الحالي من الإنترنت مباشرة
          await _preloadVideo(_currentIndex);
          // ✅ تحميل الفيديو التالي من الإنترنت
          await _preloadVideo(_currentIndex + 1);

          final controller = getController(_currentIndex);
          if (controller != null && controller.value.isInitialized) {
            controller.play();
          }

          _currentPage++;
        },
      );
    } catch (e) {
      emit(ReelsError(message: e.toString()));
    } finally {
      _loading = false;
      emit(
        ReelsLoaded(
          reels: List.from(_reels),
          hasMore: _hasMore,
          loadingPage: _loading,
        ),
      );
    }
  }

  // =============================
  // PRELOAD (NETWORK ONLY)
  // =============================
Future<void> _preloadVideo(int index) async {
  if (index < 0 || index >= _reels.length) return;
  if (_controllers[index] != null) return;

  try {
    final controller = VideoPlayerController.network(_reels[index].videoLink);
    await controller.initialize();
    controller.setLooping(true);

    _controllers[index] = controller;

     emit(
      ReelsLoaded(
        reels: List.from(_reels),
        hasMore: _hasMore,
        loadingPage: _loading,
      ),
    );
  } catch (e) {
    debugPrint("PRELOAD ERROR [$index]: $e");
  }
}
  // =============================
  // PAGE CHANGE (REELS BEHAVIOR)
  // =============================
  Future<void> onPageChanged(int newIndex) async {
    if (newIndex < 0 || newIndex >= _reels.length) return;

    final oldIndex = _currentIndex;
    _currentIndex = newIndex;

    _pause(oldIndex);

    await _preloadVideo(newIndex);
    if (_currentIndex != newIndex) return;

    if (newIndex + 1 < _reels.length) {
      _preloadVideo(newIndex + 1);
    }

    _playOnly(newIndex);

    if (_hasMore && !_loading && newIndex == _reels.length - 1) {
      fetchReels();
    }

    emit(
      ReelsLoaded(
        reels: List.from(_reels),
        hasMore: _hasMore,
        loadingPage: _loading,
      ),
    );
  }

  // =============================
  // PLAY / PAUSE (CHROME STYLE)
  // =============================
  void _playOnly(int index) {
    for (int i = 0; i < _controllers.length; i++) {
      if (i != index) {
        _controllers[i]?.pause();
      }
    }

    final controller = getController(index);
    if (controller != null &&
        controller.value.isInitialized &&
        !controller.value.isPlaying) {
      controller.play();
    }
  }

  void _pause(int index) {
    final controller = getController(index);
    if (controller != null && controller.value.isPlaying) {
      controller.pause();
    }
  }

  /// عند الخروج من الشاشة
  void pauseCurrent() {
    _pause(_currentIndex);
  }

  // =============================
  // DISPOSE
  // =============================
  void _disposeControllers() {
    for (final c in _controllers) {
      c?.pause();
      c?.dispose();
    }
    _controllers.clear();
  }

  @override
  Future<void> close() {
    pauseCurrent();
    _disposeControllers();
   
    return super.close();
  }
}