import 'package:actual/common/component/custom_text_form_field.dart';
import 'package:actual/restaurant/view/restaurant_screen.dart';
import 'package:actual/user/view/login_screen.dart';
import 'package:actual/user/view/root_tab.dart';
import 'package:actual/user/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
