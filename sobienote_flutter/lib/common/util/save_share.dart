import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

Future<bool> requestPermission() async {
  if (Platform.isAndroid) {
    if (await Permission.photos.isGranted ||
        await Permission.storage.isGranted) {
      return true;
    }

    final photos = await Permission.photos.request();
    if (photos.isGranted) return true;

    final storage = await Permission.storage.request();
    return storage.isGranted;
  }
  return false;
}

Future<void> saveImageToGallery(Uint8List imageBytes) async {
  // ✅ 1. 권한 요청
  final hasPermission = await requestPermission();
  if (!hasPermission) {
    print("저장 권한이 없습니다.");
    return;
  }

  // ✅ 2. 임시 파일 저장
  final directory = await getTemporaryDirectory();
  final fileName = 'report_${DateTime.now().millisecondsSinceEpoch}.png';
  final filePath = '${directory.path}/$fileName';
  final file = File(filePath);
  await file.writeAsBytes(imageBytes);

  // ✅ 3. MediaStore를 통한 갤러리 저장
  final mediaStore = MediaStore();
  await mediaStore.saveFile(
    tempFilePath: filePath,
    dirType: DirType.photo, // 또는 DirType.image (지원하는 라이브러리에 따라)
    dirName: DirName.pictures, // 또는 DirName.dcim
  );

  print("이미지 저장 완료!");
}


Future<void> shareImage(Uint8List imageBytes) async {
  try {
    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/shared_report.png';
    final file = File(imagePath);
    await file.writeAsBytes(imageBytes);

    await Share.shareXFiles(
      [XFile(imagePath)],
      text: '이번 달 소비 리포트 📝',
    );
  } catch (e) {
    print("공유 실패: $e");
  }
}

Future<File> downloadNetworkImageToFile(String url) async {
  try {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/downloaded_image_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);

    final response = await Dio().download(
      url,
      filePath,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      return file;
    } else {
      throw Exception('Failed to download image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Image download failed: $e');
  }
}

Future<void> deleteTemporaryFile(File file) async {
  try {
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {
    print('파일 삭제 실패: $e');
  }
}
