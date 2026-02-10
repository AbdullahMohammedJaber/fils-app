import 'dart:io';

class UploadedImageResult {
  final File file;
  final String imageId;

  UploadedImageResult({
    required this.file,
    required this.imageId,
  });
}
