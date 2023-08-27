import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_wewallet/Products/Products.dart';
import 'package:flutter_wewallet/common/const/code.dart';
import 'package:flutter_wewallet/common/const/colors.dart';
import 'package:flutter_wewallet/common/const/data.dart';
import 'package:flutter_wewallet/common/layout/default_layout.dart';
import 'package:flutter_wewallet/component/atoms/TextField/custom_text_form_field.dart';
import 'package:flutter_wewallet/utils/cookie_utils.dart';
import 'package:flutter_wewallet/utils/validation.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  final dio = Dio();
  final cookieJar = CookieJar();

  @override
  void initState() {
    super.initState();
    dio.interceptors.add(CookieManager(cookieJar));
  }

  bool isValidInput() {
    return isValidEmail(email) && isValidPassword(password);
  }

  Future<void> handleLogin() async {
    final response = await dio.post(
      'http://$ip/user/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    final status = response.data['status'];

    if (status == USER_STATUS['USER_NONE_EMAIL'] ||
        status == USER_STATUS['USER_MISMATCH_PASSWORD']) {
      _showErrorDialog();
      return;
    }

    if (status == USER_STATUS['USER_LOGIN_SUCCESS']) {
      List<Cookie> cookieList =
          await cookieJar.loadForRequest(response.requestOptions.uri);

      for (Cookie cookie in cookieList) {
        await storeCookie(cookie);
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const Products(),
        ),
      );
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('로그인 실패',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 20),
                const Text('아이디와 비밀번호를 다시 한 번 확인해주세요.'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Closes the dialog
                  },
                  child: const Text('닫기'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                const _Title(),
                const SizedBox(height: 90.0),
                CustomTextFormField(
                  hintText: "이메일을 입력해주세요.",
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 32.0),
                CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요.",
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 95.0),
                SizedBox(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: isValidInput() ? handleLogin : null,
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: PRIMARY_COLOR,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                          child: const Text('로그인'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (await isKakaoTalkInstalled()) {
                              try {
                                await AuthCodeClient.instance.authorize(
                                    redirectUri: '$ip/api/auth/kakao/callback');
                              } catch (error) {
                                print('카카오톡으로 로그인 실패 $error');
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                          child: const Text('카카오 로그인'),
                        ),
                      )
                    ],
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Text("We Wallet !",
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ));
  }
}
