import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_edu_app/common/component/custom_text_form_field.dart';
import 'package:flutter_edu_app/common/const/colors.dart';
import 'package:flutter_edu_app/common/const/data.dart';
import 'package:flutter_edu_app/common/dio/dio.dart';
import 'package:flutter_edu_app/common/layout/default_layout.dart';
import 'package:flutter_edu_app/common/secure_storage/secure_storage.dart';
import 'package:flutter_edu_app/common/view/root_tab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String userName = '';
  String userPassword = '';

  @override
  Widget build(BuildContext context) {
    final dio = ref.read(dioProvider);

    return DefaultLayout(
        child: SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _Title(),
                const SizedBox(height: 16.0),
                const _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  onChanged: (String value) {
                    userName = value;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  onChanged: (String value) {
                    userPassword = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      //ID:PASSWORD
                      String rawString = '$userName:$userPassword';
                      Codec<String, String> stringToBase64 = utf8.fuse(base64);
                      String token = stringToBase64.encode(rawString);

                      final result = await dio.post('$address/auth/login',
                          options: Options(
                            headers: {'authorization': 'Basic $token'},
                          ));

                      final refreshToken = result.data['refreshToken'];
                      final accessToken = result.data['accessToken'];

                      final storage = ref.read(secureStorageProvider);

                      await storage.write(
                          key: REFRESH_TOKEN_KEY, value: refreshToken);
                      await storage.write(
                          key: ACCESS_TOKEN_KEY, value: accessToken);

                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => RootTab()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    ),
                    child: const Text('로그인')),
                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('회원가입'),
                )
              ]),
        ),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인해주세요!\n'
      '오늘도 성공적인 주문이 되길:)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
