import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fils/core/data/request/attachments/atacchment_manage.dart';
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/class_edit_image.dart';
import 'package:fils/utils/global_function/unit8list.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> uploadImageToServer({
  required File file,
  required String endpoint,
  required String fileKey,
  bool seller = false,
}) async {
  showBoatToast();
  final json = await DioClient(seller: seller).request(
    path: endpoint,
    method: 'POST',
    isMultipart: true,
    file: file,
    fileFieldName: fileKey,
  );
  closeAllLoading();
  if (json.isNoInternet) {
    showMessage(StringApp.noInternet, value: false);
    return null;
  } else if (json.statusCode != 200 || json.data['result'] == false) {
    showMessage(json.data['message'], value: false);
    return null;
  }
  showMessage(json.data['message'], value: true);
  return json.data['data']['id']?.toString();
}

Future<File?> pickImage(BuildContext context) async {
  final ImageSource? source = await showDialog<ImageSource>(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        actions: [
          TextButton(
            child: DefaultText('Gallery'.tr(), color: secondColor),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
          TextButton(
            child: DefaultText('Camera'.tr(), color: secondColor),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
        ],
      );
    },
  );

  if (source == null) return null;

  if (source == ImageSource.gallery) {
    return await uploadImage();
  } else {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}

Future<File?> editImage(BuildContext context, File image) async {
  final edited = await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => FullImageEditorScreen(imageFile: image)),
  );

  if (edited == null) return null;

  return await uint8ListToFile(
    edited,
    "${DateTime.now().millisecondsSinceEpoch}.png",
  );
}

Future<UploadedImageResult?> pickEditAndUploadImage({
  required BuildContext context,
  required String endpoint,
  required String fileKey,
  bool seller = false,
}) async {
  final pickedImage = await pickImage(context);
  if (pickedImage == null) return null;

  final editedImage = await editImage(context, pickedImage);
  if (editedImage == null) return null;

  final imageId = await uploadImageToServer(
    file: editedImage,
    endpoint: endpoint,
    fileKey: fileKey,
    seller: seller,
  );

  if (imageId == null) return null;

  return UploadedImageResult(file: editedImage, imageId: imageId);
}

Future<File?> uploadImage() async {
  final picker = ImagePicker();

  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  } else {
    return null;
  }
}

Future<File?> uploadFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error: $e");
    }
  }
  return null;
}

Future<List<String>> uploadMultiImageToServer({
  required List<File> files,
  required String endpoint,
  required String fileKey,
  bool seller = false,
}) async {
  if (files.isEmpty) return [];

  showBoatToast();
  List<String> uploadedIds = [];

  try {
    for (int i = 0; i < files.length; i++) {
      final json = await DioClient(seller: seller).request(
        path: endpoint,
        method: 'POST',
        isMultipart: true,
        file: files[i],
        fileFieldName: fileKey,
      );

      if (json.isNoInternet) {
        continue;
      } else if (json.statusCode == 200 && json.data['result'] != false) {
        final id = json.data['data']['id']?.toString();
        if (id != null) {
          uploadedIds.add(id);
        }
      }
    }

    closeAllLoading();

    if (uploadedIds.isEmpty) {
      showMessage('Failed to upload images'.tr(), value: false);
    } else if (uploadedIds.length < files.length) {
      showMessage(
        '${'Uploaded'.tr()} ${uploadedIds.length}/${files.length} ${'images'.tr()}',
        value: true,
      );
    } else {
      showMessage(
        '${'Successfully uploaded'.tr()} ${uploadedIds.length} ${'images'.tr()}',
        value: true,
      );
    }

    return uploadedIds;
  } catch (e) {
    closeAllLoading();
    showMessage('Upload failed'.tr(), value: false);
    return [];
  }
}

Future<List<File>?> pickMultiImage(BuildContext context) async {
   final ImageSource? source = await showDialog<ImageSource>(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        actions: [
          TextButton(
            child: DefaultText('Gallery'.tr(), color: secondColor),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
          ),
          TextButton(
            child: DefaultText('Cancel'.tr(), color: secondColor),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
          ),
        ],
      );
    },
  );

 if (source == null) return null;

  if (source == ImageSource.gallery) {
     return await uploadMultipleImages();
  }   else {
    return null;
  }
 

 
}

Future<List<File>?> uploadMultipleImages() async {
  final picker = ImagePicker();

  final List<XFile> pickedFiles = await picker.pickMultiImage();

  if (pickedFiles.isNotEmpty) {
    return pickedFiles.map((file) => File(file.path)).toList();
  } else {
    return null;
  }
}

Future<List<File>?> editMultiImages(
  BuildContext context,
  List<File> images,
) async {
  if (images.isEmpty) return null;

  List<File> editedImages = [];

  for (int i = 0; i < images.length; i++) {
    final bool? shouldEdit = await showDialog<bool>(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: DefaultText('${'Edit image'.tr()} ${i + 1}/${images.length}'),
          actions: [
            TextButton(
              child: DefaultText('Skip'.tr(), color: Colors.grey),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: DefaultText('Edit'.tr(), color: secondColor),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );

    if (shouldEdit == true) {
      final edited = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FullImageEditorScreen(imageFile: images[i]),
        ),
      );

      if (edited != null) {
        final file = await uint8ListToFile(
          edited,
          "${DateTime.now().millisecondsSinceEpoch}_$i.png",
        );
        editedImages.add(file);
      } else {
        editedImages.add(images[i]);
      }
    } else {
      editedImages.add(images[i]);
    }
  }

  return editedImages.isEmpty ? null : editedImages;
}

Future<List<UploadedImageResult>?> pickEditAndUploadMultiImages({
  required BuildContext context,
  required String endpoint,
  required String fileKey,
  bool seller = false,
}) async {
  final pickedImages = await pickMultiImage(context);
  if (pickedImages == null || pickedImages.isEmpty) return null;

  final bool? wantEdit = await showDialog<bool>(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: DefaultText('Edit images?'.tr()),
        content: DefaultText('Do you want to edit the selected images?'.tr()),
        actions: [
          TextButton(
            child: DefaultText('No'.tr(), color: Colors.grey),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: DefaultText('Yes'.tr(), color: secondColor),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
    },
  );

  List<File> finalImages = pickedImages;
  if (wantEdit == true) {
    final edited = await editMultiImages(context, pickedImages);
    if (edited != null && edited.isNotEmpty) {
      finalImages = edited;
    }
  }

  final imageIds = await uploadMultiImageToServer(
    files: finalImages,
    endpoint: endpoint,
    fileKey: fileKey,
    seller: seller,
  );

  if (imageIds.isEmpty) return null;

  return List.generate(
    imageIds.length,
    (index) =>
        UploadedImageResult(file: finalImages[index], imageId: imageIds[index]),
  );
}

Future<List<UploadedImageResult>?> pickAndUploadMultiImages({
  required BuildContext context,
  required String endpoint,
  required String fileKey,
  bool seller = false,
}) async {
  final pickedImages = await pickMultiImage(context);
  if (pickedImages == null || pickedImages.isEmpty) return null;

  final imageIds = await uploadMultiImageToServer(
    files: pickedImages,
    endpoint: endpoint,
    fileKey: fileKey,
    seller: seller,
  );

  if (imageIds.isEmpty) return null;

  return List.generate(
    imageIds.length,
    (index) => UploadedImageResult(
      file: pickedImages[index],
      imageId: imageIds[index],
    ),
  );
}
