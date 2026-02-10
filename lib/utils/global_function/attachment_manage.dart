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
  final json = await DioClient(seller:seller ).request(
    path: endpoint,
    method: 'POST',
    isMultipart: true,
    file: file,
    fileFieldName: fileKey,
  );
  closeAllLoading();
  if (  json.isNoInternet ) { 
    showMessage(  StringApp.noInternet, value: false);
    return null;
  }else if(json.statusCode!=200 || json.data['result'] == false) { 
    showMessage(  json.data['message'] , value: false);
    return null;
  }
  showMessage(  json.data['message'], value: true);
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
    MaterialPageRoute(
      builder: (_) => FullImageEditorScreen(imageFile: image),
    ),
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
    seller: seller
  );

  if (imageId == null) return null;

  return UploadedImageResult(
    file: editedImage,
    imageId: imageId,

  );
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


/*
final result = await pickEditAndUploadImage(
  context: context,
  endpoint: "file/upload",
  fileKey: "aiz_file",
);

if (result != null) {
  imageFileOpenMarket = result.file;
  idImageLogo = result.imageId;
}
 */
