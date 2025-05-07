import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

DateTime parseDateTime(String str) {
  return DateTime.parse(str);
}

Future<XFile> downloadImageToXFile(String imageUrl, {required int boardId}) async {
  final dio = Dio();
  final ext = p.extension(Uri.parse(imageUrl).path).toLowerCase();
  final dir = await getTemporaryDirectory();

  final filePath = '${dir.path}/board_image_$boardId$ext';
  final file = File(filePath);

  if (await file.exists()) {
    await file.delete();
  }

  final response = await dio.download(imageUrl, filePath);

  if (response.statusCode == 200) {
    return XFile(filePath);
  } else {
    throw Exception('Failed to download image');
  }
}
