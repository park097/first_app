import 'package:actual/common/const/color.dart';

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    required this.onChanged,
    this.hintText,
    this.errorText,
    this.autofocus = false,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
        borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0));

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력할때
      obscureText: true,
      autofocus: false,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          errorText: errorText,
          hintStyle: TextStyle(
            color: BODY_TEXT_COLOR,
            fontSize: 14.0,
          ),
          fillColor: INPUT_BG_COLOR,
          filled: true,
          //모든 input 상태의 스타일 세팅
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
              borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ))
          //false- 배경색 없음
          ),
    );
  }
}
