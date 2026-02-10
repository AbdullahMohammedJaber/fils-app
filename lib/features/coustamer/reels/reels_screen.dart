import 'package:fils/features/coustamer/reels/anlayse_data.dart';
import 'package:fils/managment/reels_manage/cubit/reels_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
 
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReelsCubit>(
      create: (context) => ReelsCubit()..fetchReels(isRefresh: true),
      child: BlocBuilder<ReelsCubit, ReelsState>(
        builder: (context, state) {
          final cubit = context.read<ReelsCubit>();
      
          if (state is ReelsInitial ||
              (state is ReelsLoading && cubit.reels.isEmpty)) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: LoadingUi(),
              ),
            );
          }
      
          if (state is ReelsError) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
      
          final reels = cubit.reels;
      
          if (reels.isEmpty) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text(
                  "No Reels".tr(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
      
          return Scaffold(
            backgroundColor: Colors.black,
            body: PageView.builder(
              controller: cubit.pageController,
              scrollDirection: Axis.vertical,
              itemCount: reels.length,
              onPageChanged: cubit.onPageChanged,
              itemBuilder: (_, index) {
                final controller = cubit.getController(index);
      
              
                if (controller == null || !controller.value.isInitialized) {
                  return LoadingUi();
                }
      
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller.value.size.width,
                        height: controller.value.size.height,
                        child: VideoPlayer(controller),
                      ),
                    ),
      
                    if (reels[index].shopName != null)
                      PositionAnalyze(data: reels[index]),
      
                    if (reels[index].shopName != null)
                      positionTitle(reels[index], context, index),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}