import 'package:actual/common/component/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:actual/common/const/color.dart';
import 'package:actual/common/layout/default_layout.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key); // key 파라미터를 올바르게 설정하세요.

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                SizedBox(height: 16.0),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png', // 경로를 'assets'로 수정하세요.
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                    hintText: '이메일을 입력해주세요',
                    onChanged: (String value) {},
                    obscureText: false),
                SizedBox(height: 16.0), // 비밀번호 입력 필드에서 obscureText를 false로 설정
                CustomTextFormField(
                    hintText: '비밀번호를 입력해주세요',
                    onChanged: (String value) {},
                    obscureText: true),
                ElevatedButton(
                  onPressed: () {
                    // 실제로 수행되어야 하는 동작을 추가하세요.
                  },
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                  child: Text(
                    '로그인',
                  ),
                ),
                TextButton(
                    onPressed: () {
                      // 실제로 수행되어야 하는 동작을 추가하세요.
                    },
                    child: Text(
                      '회원가입',
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
