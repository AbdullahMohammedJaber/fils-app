/*
// ignore_for_file: unused_field, unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../enum/message_type.dart';
import '../message_app/show_flash_message.dart';

class ImageView extends StatefulWidget {
  final List<dynamic> images;
  final dynamic initialIndex;

  const ImageView({super.key, required this.images, this.initialIndex = 0});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late PageController _pageController;
  late ProgressDialog _progressDialog;
  dynamic _currentIndex = 0;
  bool _downloading = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentIndex = widget.initialIndex;
    _progressDialog = ProgressDialog(context);
    super.initState();
  }

  Future<void> downloadFile(dynamic file, String fileName) async {
    await Permission.storage.request();
    Dio dio = Dio();

    try {
      _downloading = true;
      _progressDialog.show();
      setState(() {});

      if (file is String) {
        var response = await dio.get(
          file,
          options: Options(responseType: ResponseType.bytes),
        );
      } else if (file is File) {}

      _downloading = false;
      _progressDialog.hide();
      setState(() {});

      showCustomFlash(
        message: "Download Image Done".tr(),
        messageType: MessageType.Success,
      );
    } catch (e) {
      _downloading = false;
      _progressDialog.hide();
      setState(() {});
      print('Error downloading file: $e');
    }
  }

  ImageProvider<Object>? getImageProvider(dynamic image) {
    if (image is File) {
      return FileImage(image);
    } else if (image is String) {
      return NetworkImage(image);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: heigth * 0.1,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final currentImage = widget.images[_currentIndex];
              await downloadFile(currentImage, DateTime.now().toString());
            },
            icon: const Icon(Icons.download, color: Colors.white),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final image = widget.images[index];
          final imageProvider = getImageProvider(image);

          if (imageProvider == null) {
            return const Center(child: Text("Invalid image"));
          }

          return PhotoView(
            imageProvider: imageProvider,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            heroAttributes: PhotoViewHeroAttributes(tag: image),
            initialScale: PhotoViewComputedScale.contained * 0.8,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
      ),
    );
  }
}
*/
