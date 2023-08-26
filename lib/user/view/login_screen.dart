import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_wewallet/Products/Products.dart';
import 'package:flutter_wewallet/common/const/colors.dart';
import 'package:flutter_wewallet/common/const/data.dart';
import 'package:flutter_wewallet/common/layout/default_layout.dart';
import 'package:flutter_wewallet/component/atoms/TextField/custom_text_form_field.dart';
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

  bool isValidEmail(String email) {
    final RegExp regex =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    return regex.hasMatch(email);
  }

  bool isValidInput() {
    return isValidEmail(email) && password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    return DefaultLayout(
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 2,
              ),
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
                                  onPressed: isValidInput()
                                      ? () async {
                                          final response = await dio.post(
                                            'http://$ip/user/login',
                                            data: {
                                              'email': email,
                                              'password': password,
                                            },
                                          );

                                          // 서버에서 response로 token을 전달받는게 좋은걸까 ? 쿠키로 해결하는게 좋은걸까 ? 고민 필요.

                                          List<Cookie> cookieList =
                                              await cookieJar.loadForRequest(
                                                  response.requestOptions.uri);

                                          for (Cookie cookie in cookieList) {
                                            final String cookieName =
                                                cookie.name;
                                            if (cookieName == 'refresh-token') {
                                              await storage.write(
                                                  key: REFRESH_TOKEN_KEY,
                                                  value: cookieName);
                                            } else if (cookieName ==
                                                'access-token') {
                                              await storage.write(
                                                  key: ACCESS_TOKEN_KEY,
                                                  value: cookieName);
                                            }
                                          }

                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => const Products(),
                                            ),
                                          );
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: isValidInput()
                                          ? Colors.white
                                          : Colors.grey,
                                      backgroundColor: isValidInput()
                                          ? PRIMARY_COLOR
                                          : Colors.white,
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
                                            redirectUri:
                                                '$ip/api/auth/kakao/callback');
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
            )));
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
