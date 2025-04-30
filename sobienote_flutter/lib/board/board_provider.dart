import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sobienote_flutter/board/request/board_request.dart';
import 'package:sobienote_flutter/board/response/board_post_response.dart';
import 'package:sobienote_flutter/board/response/board_response.dart';

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
  BoardNotifier({required this.repository,required this.storage});

  Future<BaseResponse<BoardPostResponse>> postBoard(BoardRequest request) {
    // int memberId = storage.read(key: 'memberId') as int;
    //todo memberId로 바꿔야함
    final int memberId = 52;
    return repository.postBoard(
      memberId,
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

  Future<BaseResponse<BoardResponse>> getBoard(int boardId) {
    return repository.getBoard(boardId);
  }

  Future<BaseResponse<String>> deleteBoard(int boardId) {
    return repository.deleteBoard(boardId);
  }

  Future<BaseResponse<BoardResponse>> patchBoard(
    int boardId,
    BoardRequest request,
  ) {
    return repository.patchBoard(boardId, request);
  }
}
