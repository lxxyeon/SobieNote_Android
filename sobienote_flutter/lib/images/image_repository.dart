import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sobienote_flutter/common/const/data.dart';
import 'package:sobienote_flutter/images/model/board_image.dart';
import 'package:sobienote_flutter/images/response/image_response.dart';

import '../common/provider/dio_provider.dart';

part 'image_repository.g.dart';

final imagesRepositoryProvider = Provider<ImageRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ImageRepository(dio, baseUrl: 'http://$ip/image');
});

@RestApi()
abstract class ImageRepository {
  factory ImageRepository(Dio dio, {String baseUrl}) = _ImageRepository;
  
  @GET('/{year}/{month}/{memberId}')
  @Headers({'accessToken': 'true'})
  Future<ImageResponse> getImages(@Path('year') int year, @Path('month') int month, @Path('memberId') int memberId);

}