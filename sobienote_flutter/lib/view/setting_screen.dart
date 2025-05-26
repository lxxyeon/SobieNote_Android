import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobienote_flutter/common/provider/secure_storage.dart';
import 'package:sobienote_flutter/user/auth_provider.dart';

import '../common/const/data.dart';
import '../common/const/text_style.dart';
import '../component/default_layout.dart';
import '../goal/goal_provider.dart';
import '../images/image_provider.dart';
import '../user/user_provider.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  Future<Map<String, String>> _loadUserInfo(WidgetRef ref) async {
    final storage = ref.read(secureStorageProvider);
    final name = await storage.read(key: NAME_KEY) ?? '';
    final email = await storage.read(key: EMAIL_KEY) ?? '';
    return {'name': name, 'email': email};
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return FutureBuilder<Map<String, String>>(
      future: _loadUserInfo(ref),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final name = snapshot.data!['name']!;
        final email = snapshot.data!['email']!;
        return DefaultLayout(
          appBar: AppBar(
            title: Text('설정', style: kTitleTextStyle),
            centerTitle: true,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildSettingItem('이름', name, null),
                _buildSettingItem('이메일', email, null),
                _buildSettingItem('로그아웃', '', () {
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
                              ref.invalidate(goalProvider((now.year, now.month)));
                              ref.invalidate(imagesProvider((now.year, now.month)));
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
                }),
                _buildSettingItem('탈퇴', '', () {
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
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingItem(String title, String value, VoidCallback? onTap) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: ListTile(title: Text(title), trailing: Text(value), onTap: onTap),
    );
  }
}
