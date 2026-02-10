import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<File> uint8ListToFile(Uint8List uint8list, String fileName) async {
  // الحصول على مسار الدليل لتخزين الملفات
  final directory = await getApplicationDocumentsDirectory();

  // تحديد مسار الملف النهائي
  final filePath = '${directory.path}/$fileName';

  // إنشاء ملف جديد باستخدام المسار
  final file = File(filePath);

   await file.writeAsBytes(uint8list);

  return file;
}