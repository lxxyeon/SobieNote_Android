import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sobienote_flutter/common/const/tags_data.dart';
import 'package:sobienote_flutter/component/tag_selector.dart';

import '../common/const/colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  int? _curCategory;
  int? _curEmotion;
  int? _curFactor;
  int? _curSatisfaction;
  XFile? _imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future<void> _pickAndCropImage(ImageSource source) async {
    final XFile? pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '이미지 자르기',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            hideBottomControls: true,
            cropFrameStrokeWidth: 2,
            showCropGrid: true,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _imageFile = XFile(croppedFile.path);
        });
      }
    }
  }

  void _showImageSourceDialog() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('사진 업로드 설정'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                final status = await Permission.camera.request();
                if (status.isGranted) {
                  await _pickAndCropImage(ImageSource.camera);
                } else {
                  print('카메라 권한이 거부됨');
                }
              },
              child: Text('사진 찍을래요'),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                final androidInfo = await DeviceInfoPlugin().androidInfo;
                final status =
                    androidInfo.version.sdkInt >= 33
                        ? await Permission.photos.request()
                        : await Permission.storage.request();

                if (status.isGranted) {
                  await _pickAndCropImage(ImageSource.gallery);
                }
              },
              child: Text('앨범에서 선택할래요'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: Text('취소', style: TextStyle(fontWeight: FontWeight.bold)),
            isDefaultAction: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '소비 기록',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: GRAY_00,
              ),
            ),
            renderUploadPic(),
            const SizedBox(height: 52),
            TagSelector(
              title: '오늘은 무엇을 샀나요?',
              tagList: categories,
              selectedIndex: _curCategory,
              onTagSelected: (index) {
                setState(() => _curCategory = index);
              },
            ),
            const SizedBox(height: 48),
            TagSelector(
              title: '사고 나서 어떤 기분이 들었나요?',
              tagList: emotions,
              selectedIndex: _curEmotion,
              onTagSelected: (index) {
                setState(() => _curEmotion = index);
              },
            ),
            const SizedBox(height: 48),
            TagSelector(
              title: '이 물건이 갖고 있는 가치나 의미는 무엇인가요?',
              tagList: factors,
              selectedIndex: _curFactor,
              onTagSelected: (index) {
                setState(() => _curFactor = index);
              },
            ),
            const SizedBox(height: 48),
            TagSelector(
              title: '이 달의 소비 목표를 이루는데 얼마나 기여했나요?',
              tagList: satisfactions,
              selectedIndex: _curSatisfaction,
              onTagSelected: (index) {
                setState(() => _curSatisfaction = index);
              },
            ),
            const SizedBox(height: 48),
            renderDetail(),
            const SizedBox(height: 20),
            SizedBox(
              width: screenWidth * 0.9,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: OLIVE,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {},
                child: Text('기록하기', style: TextStyle(color: GRAY_09)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget renderUploadPic() {
    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: SizedBox(
        width: 250,
        height: 250,
        child: Container(
          decoration: BoxDecoration(
            color: GRAY_09,
            borderRadius: BorderRadius.circular(16),
          ),
          child:
              _imageFile == null
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle, size: 50, color: OLIVE),
                      const SizedBox(height: 10),
                      Text(
                        '사진을 추가해주세요!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: OLIVE,
                        ),
                      ),
                    ],
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(_imageFile!.path),
                      fit: BoxFit.cover,
                      width: 250,
                      height: 250,
                    ),
                  ),
        ),
      ),
    );
  }

  Widget renderDetail() {
    return Column(
      children: [
        Text(
          '오늘의 소비에 대해 더 자세히 기록해 볼까요?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: GRAY_00,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: '물건의 특징이나 구매 동기 등을 적어보세요!',
              hintStyle: TextStyle(color: GRAY_06),
            ),
            maxLength: 40,
          ),
        ),
      ],
    );
  }
}
