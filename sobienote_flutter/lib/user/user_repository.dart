import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:sobienote_flutter/common/const/data.dart';
import 'package:sobienote_flutter/common/response/base_response.dart';
import 'package:sobienote_flutter/user/request/login_request.dart';
import 'package:sobienote_flutter/user/request/sign_up_form.dart';
import 'package:sobienote_flutter/user/request/social_login_request.dart';
import 'package:sobienote_flutter/user/response/oauth_response.dart';

import '../common/provider/dio_provider.dart';

part 'user_repository.g.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio, baseUrl: 'http://$ip/member');
});

@RestApi()
abstract class UserRepository {
  factory UserRepository(Dio dio, {String baseUrl}) = _UserRepository;

  @POST('/social')
  Future<BaseResponse<OAuthResponse>> socialLogin(
    @Body() SocialLoginRequest request,
  );

  @POST('/login')
  Future<BaseResponse<OAuthResponse>> login(@Body() LoginRequest request);

  @POST('/signup')
  Future<BaseResponse<SignUpForm>> signUp(@Body() SignUpForm request);
  
  @DELETE('/{memberId}')
  Future<BaseResponse<int>> deleteAccount(@Path('memberId') int memberId);
}
