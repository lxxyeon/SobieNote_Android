import 'package:flutter/material.dart';

import '../common/const/text_style.dart';
import '../component/default_layout.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        title: Text('설정', style: kTitleTextStyle,),
        centerTitle: true,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('이름'),
            trailing: Icon(Icons.chevron_right),
            onTap: (){},
          ),
          ListTile(
            title: Text('이메일'),
            trailing: Icon(Icons.chevron_right),
            onTap: (){},
          ),
          ListTile(
            title: Text('로그아웃'),
            onTap: (){},
          ),
          ListTile(
            title: Text('탈퇴'),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
