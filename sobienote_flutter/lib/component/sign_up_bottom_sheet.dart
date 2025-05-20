import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobienote_flutter/common/const/colors.dart';
import 'package:sobienote_flutter/user/request/sign_up_form.dart';

import '../user/user_provider.dart';

class SignUpBottomSheet extends ConsumerStatefulWidget {
  const SignUpBottomSheet({super.key});

  @override
  ConsumerState<SignUpBottomSheet> createState() => _SignUpBottomSheetState();
}

class _SignUpBottomSheetState extends ConsumerState<SignUpBottomSheet> {
  int _currentStep = 0;
  bool isGangwon = false;
  bool _isValid = false;

  final _nicknameController = TextEditingController();
  final _pwController = TextEditingController();
  final _pwConfirmController = TextEditingController();
  final _emailController = TextEditingController();

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
        _isValid = false;
      });
      _validate();
    } else{
      ref
          .read(userProvider.notifier)
          .signUp(
        form: SignUpForm(
          name: _nicknameController.text,
          password: _pwController.text,
          email: _emailController.text,

        ),
      );
    }
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(3, (index) {
        final isActive = index <= _currentStep;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.teal : Colors.grey[300],
          ),
        );
      }),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('닉네임을 입력해 주세요', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Text('소비채집에서 사용할 닉네임을 입력해 주세요.', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              controller: _nicknameController,
              onChanged: (_) => _validate(),
              decoration: InputDecoration(
                hintText: '닉네임',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('비밀번호를 입력해 주세요', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Text(
              '영어, 숫자, 특수문자를 포함하여 8~20자리까지\n입력해주세요.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              controller: _pwController,
              onChanged: (_) => _validate(),
              decoration: InputDecoration(
                hintText: '비밀번호',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              obscureText: true,
              controller: _pwConfirmController,
              onChanged: (_) => _validate(),
              decoration: InputDecoration(
                hintText: '비밀번호 확인',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이메일을 입력해 주세요', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Text('로그인 시 사용할 이메일을 입력해주세요', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              onChanged: (_) => _validate(),
              decoration: InputDecoration(
                hintText: 'abc@naver.com',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('강원청소년활동진흥센터인가요?'),
                CupertinoSwitch(
                  value: isGangwon,
                  onChanged: (bool) {
                    setState(() {
                      isGangwon = !isGangwon;
                    });
                  },
                ),
              ],
            ),
            if (isGangwon)
              Column(
                children: [
                  TextField(decoration: InputDecoration(hintText: '소속/나이')),
                  const SizedBox(height: 5),
                  TextField(decoration: InputDecoration(hintText: '이름')),
                ],
              ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.9,
      child: Padding(
        padding: MediaQuery.of(
          context,
        ).viewInsets.add(const EdgeInsets.all(24)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              _buildStepIndicator(),
              const SizedBox(height: 60),
              _buildStepContent(),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DARK_TEAL,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: _isValid ? _nextStep : null,
                  child: Text(
                    _currentStep == 2 ? '완료' : '다음',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate() {
    setState(() {
      if (_currentStep == 0) {
        _isValid = _nicknameController.text.trim().isNotEmpty;
      } else if (_currentStep == 1) {
        final pw = _pwController.text;
        final confirm = _pwConfirmController.text;
        _isValid = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#\$%^&*()_+~])[A-Za-z\d!@#\$%^&*()_+~]{8,20}$').hasMatch(pw) && pw == confirm;
      } else if (_currentStep == 2) {
        final email = _emailController.text.trim();
        _isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
      }
    });
  }
}
