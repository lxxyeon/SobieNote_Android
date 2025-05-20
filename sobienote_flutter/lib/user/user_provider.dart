import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sobienote_flutter/user/request/social_login_request.dart';
import 'package:sobienote_flutter/user/user_repository.dart';

import '../common/const/data.dart';
import '../common/provider/secure_storage.dart';
import 'auth_repository.dart';
import 'model/user_model.dart';

final userProvider = StateNotifierProvider<UserStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return UserStateNotifier(
    authRepository: authRepository,
    userRepository: userRepository,
    secureStorage: secureStorage,
  );
});

class UserStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final FlutterSecureStorage secureStorage;

  UserStateNotifier({
    required this.authRepository,
    required this.userRepository,
    required this.secureStorage,
  }) : super(UserModelLoading()) {
    getMe();
  }

  Future<void> getMe() async {
    try {
      final type = await secureStorage.read(key: SOCIAL_TYPE_KEY) ?? '';
      final email = await secureStorage.read(key: EMAIL_KEY) ?? '';
      final name = await secureStorage.read(key: NAME_KEY) ?? '';
      final memberId = await secureStorage.read(key: MEMBER_ID_KEY) ?? '';

      if ([type, email, name, memberId].any((e) => e.isEmpty)) {
        state = UserModelError(message: '로그인 정보 없음');
        return;
      }

      await userRepository.socialLogin(
        SocialLoginRequest(
          email: email,
          name: name,
          type: SocialType.getByName(type),
        ),
      );

      state = UserModel(
        email: email,
        type: SocialType.getByName(type),
        nickName: name,
      );
    } catch (e, stack) {
      print(' getMe error: $e');
      print(stack);
      state = UserModelError(message: '로그인 실패');
    }
  }

  Future<void> logout() async {
    state = null;
    await Future.wait([
      secureStorage.delete(key: ACCESS_TOKEN_KEY),
      secureStorage.delete(key: MEMBER_ID_KEY),
      secureStorage.delete(key: SOCIAL_TYPE_KEY),
      secureStorage.delete(key: EMAIL_KEY),
      secureStorage.delete(key: NAME_KEY),
    ]);
  }

  Future<void> deleteAccount() async {
    final memberId = await secureStorage.read(key: MEMBER_ID_KEY);
    await userRepository.deleteAccount(int.parse(memberId!));
    await logout();
  }

  Future<UserModelBase> login({required SocialLoginRequest request}) async {
    try {
      state = UserModelLoading(); // 로딩 상태

      final resp = await authRepository.login(request: request);

      // 로그인 성공 시 토큰과 정보 저장
      await secureStorage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
      await secureStorage.write(key: MEMBER_ID_KEY, value: resp.memberId.toString());
      await secureStorage.write(key: SOCIAL_TYPE_KEY, value: request.type.name);
      await secureStorage.write(key: EMAIL_KEY, value: request.email);
      await secureStorage.write(key: NAME_KEY, value: request.name);

      final user = UserModel(
        email: request.email,
        type: request.type,
        nickName: request.name,
      );

      state = user;

      return user;
    } catch (e) {
      print('Login error: $e');
      state = UserModelError(message: '로그인에 실패했습니다.');
      return Future.value(state);
    }
  }

}
