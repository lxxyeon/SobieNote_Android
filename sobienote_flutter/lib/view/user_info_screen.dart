import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/component/default_layout.dart';

import '../common/const/text_style.dart';
import '../user/user_provider.dart';

class UserInfoScreen extends ConsumerWidget {
  static String get routeName => 'user-info';

  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoAsync = ref.watch(userInfoProvider);

    final textStyle = const TextStyle(fontSize: 17);

    return DefaultLayout(
      backgroundColor: LIGHT_TEAL,
      appBar: AppBar(
        title: Text('사용자 정보', style: kTitleTextStyle),
        centerTitle: true,
        forceMaterialTransparency: true,

      ),
      child: userInfoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('불러오기 실패: $err')),
        data:
            (user) => Column(
              children: [
                Stack(
                  children: [
                    // 원형 프로필 이미지
                    CircleAvatar(
                      radius: 70,
                      // backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : AssetImage('assets/images/logo.png'),
                      foregroundImage: AssetImage('assets/images/icon.png'),
                    ),
                    // 오른쪽 아래 카메라 아이콘 버튼
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: (){},
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(Icons.camera_alt, size: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                _buildInfoBox([
                  _buildInfoRow('닉네임', user.nickName, textStyle),
                  _buildDivider(),
                  _buildInfoRow('이메일', user.email, textStyle),
                ]),
                const SizedBox(height: 30),
                if (user.name != null ||
                    user.age != null ||
                    user.school != null)
                  _buildInfoBox([
                    if (user.name != null)
                      _buildInfoRow('이름', user.name!, textStyle),
                    if (user.name != null) _buildDivider(),
                    if (user.age != null)
                      _buildInfoRow('나이', user.age!, textStyle),
                    if (user.age != null) _buildDivider(),
                    if (user.school != null)
                      _buildInfoRow('소속', user.school!, textStyle),
                  ]),
              ],
            ),
      ),
    );
  }

  Widget _buildInfoBox(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: GRAY_09
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  Widget _buildInfoRow(String label, String value, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }

  Widget _buildDivider() => const Divider();
}
