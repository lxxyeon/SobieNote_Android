import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/user/auth_provider.dart';
import 'package:sobienote_flutter/view/user_info_screen.dart';

import '../common/const/text_style.dart';
import '../component/default_layout.dart';
import '../goal/goal_provider.dart';
import '../images/image_provider.dart';
import '../user/user_provider.dart';

class SettingScreen extends ConsumerWidget {
  static String get routeName => 'setting-screen';

  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return DefaultLayout(
      backgroundColor: LIGHT_TEAL,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('설정', style: kTitleTextStyle),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSettingItem(
              Icon(Icons.person),
              '사용자 정보',
              Icon(Icons.chevron_right),
                  () {
                context.pushNamed(UserInfoScreen.routeName);
              },
              '',
            ),
            _buildSettingItem(Icon(Icons.logout), '로그아웃', null, () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text('로그아웃 하시겠습니까?'),
                    content: const Text('로그인 화면으로 이동합니다.'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(
                          '확인',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          auth.logout();
                          ref.invalidate(userProvider);
                          final now = DateTime.now();
                          ref.invalidate(
                            goalProvider((now.year, now.month)),
                          );
                          ref.invalidate(
                            imagesProvider((now.year, now.month)),
                          );
                          context.go('/login');
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text(
                          '취소',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            }, ''),
            _buildSettingItem(Icon(Icons.person_off), '탈퇴', null, () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text('회원 탈퇴하시겠습니까?'),
                    content: const Text('지난 소비기록이 모두 사라집니다.'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text(
                          '확인',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          auth.delete();
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text(
                          '취소',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            }, ''),
            _buildSettingItem(
              Icon(Icons.update),
              '앱 버전 정보',
              Icon(Icons.chevron_right),
              null,
              '1.0.0',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    Icon icon,
    String title,
    Icon? value,
    VoidCallback? onTap,
    String? version,
  ) {
    return ListTile(
      leading: icon,
      title: Text(title, style: TextStyle(fontSize: 17)),
      trailing:
          title == '앱 버전 정보'
              ? Text(version!, style: TextStyle(fontSize: 17))
              : title == '사용자 정보'
              ? value
              : null,
      onTap: onTap,
    );
  }
}
