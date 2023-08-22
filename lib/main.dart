import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/view/splash_screen.dart';

void main() {
  runApp(
      const _App()
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans'
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

