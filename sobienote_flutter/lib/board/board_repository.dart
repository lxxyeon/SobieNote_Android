import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sobienote_flutter/board/request/board_request.dart';
import 'package:sobienote_flutter/board/response/board_post_response.dart';
import 'package:sobienote_flutter/board/response/board_response.dart';

import '../common/const/data.dart';
import '../common/provider/dio_provider.dart';
import '../common/response/base_response.dart';

part 'board_repository.g.dart';

final boardRepositoryProvider = Provider<BoardRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return BoardRepository(dio, baseUrl: 'http://$ip/board/posting');
});

@RestApi()
abstract class BoardRepository {
  factory BoardRepository(Dio dio, {String baseUrl}) = _BoardRepository;

  @POST('/{memberId}')
  @Headers({'accessToken': 'true'})
  @MultiPart()
  Future<BaseResponse<BoardPostResponse>> postBoard(
    @Path('memberId') int memberId,
    @Body() FormData formData,
  );

  @GET('/{boardId}')
  @Headers({'accessToken': 'true'})
  Future<BaseResponse<BoardResponse>> getBoard(@Path('boardId') int boardId);

  @DELETE('/{boardId}')
  @Headers({'accessToken': 'true'})
  Future<BaseResponse<String>> deleteBoard(@Path('boardId') int boardId);

  @PATCH('/{boardId}')
  @Headers({'accessToken': 'true'})
  Future<BaseResponse<BoardResponse>> patchBoard(
    @Path('boardId') int boardId,
    @Body() BoardRequest request,
  );
}
