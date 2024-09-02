import 'dart:convert';
import 'dart:io';

import 'package:code_factory_clone/common/component/custom_text_form_field.dart';
import 'package:code_factory_clone/common/const/colors.dart';
import 'package:code_factory_clone/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    final emulatorIp = '10.0.2.2:3000';
    final simulatorIp = '127.0.0.1:3000';

    final ip = Platform.isIOS ? simulatorIp : emulatorIp;

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(height: 16),
                const _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hitText: '이메일을 입력해주세요.',
                  obscureText: false,
                  onChanged: (String value) {
                    email = value;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  hitText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      // email:password
                      final rawString = '${email}:${password}';

                      // dart에서 base64로 인코딩하는 방법
                      Codec<String, String> stringToBase64 = utf8.fuse(base64);
                      String token = stringToBase64.encode(rawString);

                      print(ip);

                      // ! dio라는 인스턴스에 options을 넣어주는 객체화를 시켜줘야함
                      final res = await dio.post(
                        'http://${ip}/auth/login',
                        data: {
                          'email': email,
                          'password': password
                        },
                        options: Options(
                          headers: {
                            'Content-Type': 'application/json', // JSON 형식의 데이터를 보내기 위해 헤더 설정
                          },
                        ),
                      );
                      print(res);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR, // 버튼 배경색을 파란색으로 설정
                    ),
                    child: const Text(
                      '로그인',
                    ),
                ),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      '회원 가입'
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
        '환영 합니다.',
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          color: Colors.black
        ),
    );
  }
}


class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
        '이메일과 비밀번호를 입력해서 로그인 해주세요!\n오늘도 성공적인 주문이 되길 :)',
        style: TextStyle(
          fontSize: 16,
          color: BODY_TEXT_COLOR,
        ),
    );
  }
}
