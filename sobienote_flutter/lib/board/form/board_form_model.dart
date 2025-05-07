import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class BoardFormModel {
  int? category;
  int? emotion;
  int? factor;
  int? satisfaction;
  XFile? imageFile;
  final TextEditingController detailController;

  BoardFormModel({String? initialContent})
      : detailController = TextEditingController(text: initialContent ?? '');

  void clear() {
    category = null;
    emotion = null;
    factor = null;
    satisfaction = null;
    imageFile = null;
    detailController.clear();
  }

  bool get isComplete =>
      imageFile != null &&
          category != null &&
          emotion != null &&
          factor != null &&
          satisfaction != null &&
          detailController.text.isNotEmpty;
}
