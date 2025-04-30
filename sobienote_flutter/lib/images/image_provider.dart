import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobienote_flutter/images/model/board_image.dart';

import '../common/const/data.dart';
import '../common/provider/dio_provider.dart';
import 'image_repository.dart';

final imagesRepositoryProvider = Provider<ImageRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ImageRepository(dio, baseUrl: 'http://$ip/image');
});

final imagesProvider = FutureProvider.family<List<BoardImage>, (int year, int month)>(
      (ref, args) async {
    final repo = ref.watch(imagesRepositoryProvider);
    //todo 추후 바꾸기
    final response = await repo.getImages(args.$1, args.$2, 52);
    return response.data;
  },
);
