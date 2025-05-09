import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sobienote_flutter/board/request/board_request.dart';
import 'package:sobienote_flutter/board/response/board_post_response.dart';
import 'package:sobienote_flutter/board/response/board_response.dart';
import 'package:sobienote_flutter/common/const/data.dart';

import '../common/provider/secure_storage.dart';
import '../common/response/base_response.dart';
import 'board_repository.dart';

final boardProvider = Provider<BoardNotifier>((ref) {
  final repo = ref.watch(boardRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return BoardNotifier(repository: repo, storage: storage);
});

class BoardNotifier {
  final BoardRepository repository;
  final FlutterSecureStorage storage;

  BoardNotifier({required this.repository, required this.storage});

  Future<BaseResponse<BoardPostResponse>> postBoard(BoardRequest request) async{
    String? memberId = await storage.read(key: MEMBER_ID_KEY);
    return repository.postBoard(
      int.parse(memberId!),
      FormData.fromMap({
        'file': MultipartFile.fromFileSync(request.file!.path),
        'contents': request.contents,
        'categories': request.categories,
        'emotions': request.emotions,
        'factors': request.factors,
        'satisfactions': request.satisfactions,
      }),
    );
  }

  Future<BoardResponse> getBoard(int boardId) async {
    final resp = await repository.getBoard(boardId);
    return resp.data;
  }

  Future<BaseResponse<bool>> deleteBoard(int boardId) {
    return repository.deleteBoard(boardId);
  }

  Future<BaseResponse<BoardPostResponse>> patchBoard(
    int boardId,
    BoardRequest request,
  ) {
    return repository.patchBoard(
      boardId,
      FormData.fromMap({
        'file': MultipartFile.fromFileSync(request.file!.path),
        'contents': request.contents,
        'categories': request.categories,
        'emotions': request.emotions,
        'factors': request.factors,
        'satisfactions': request.satisfactions,
      }),
    );
  }
}
