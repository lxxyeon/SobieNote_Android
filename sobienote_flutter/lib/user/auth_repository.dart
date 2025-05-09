import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sobienote_flutter/common/provider/secure_storage.dart';
import 'package:sobienote_flutter/user/request/social_login_request.dart';
import 'package:sobienote_flutter/user/response/oauth_response.dart';
import 'package:sobienote_flutter/user/user_repository.dart';

import '../common/const/data.dart';
import '../common/provider/dio_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final storage = ref.watch(secureStorageProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthRepository(dio: dio,
      baseUrl: 'http://$ip/member',
      storage: storage,
      userRepository: userRepository);
});

class AuthRepository {
  final Dio dio;
  final String baseUrl;
  final FlutterSecureStorage storage;
  final UserRepository userRepository;

  AuthRepository(
      {required this.dio, required this.baseUrl, required this.storage, required this.userRepository});

  Future<OAuthResponse> login({
    required SocialLoginRequest request,
  }) async {
    if (request.type == SocialType.KAKAO) {
      if (await isKakaoTalkInstalled()) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공');
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');

          if (error is PlatformException && error.code == 'CANCELED') {
            return Future.value(null);
          }

          try {
            await UserApi.instance.loginWithKakaoAccount();
            print('카카오계정으로 로그인 성공');
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
          }
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
      User user = await UserApi.instance.me();
      print('kakao user info : ${user.kakaoAccount.toString()}');
      request = SocialLoginRequest(
        name: user.kakaoAccount!.profile!.nickname!,
        email: user.kakaoAccount!.email!,
        type: request.type,
      );
    }

    final resp = await userRepository.socialLogin(request);


    print('resp = ${resp.data.toString()}');

    await storage.write(key: NAME_KEY, value: request.name);
    await storage.write(key: EMAIL_KEY, value: request.email);
    await storage.write(key: SOCIAL_TYPE_KEY, value: request.type.name);

    return resp.data;
    }

}
