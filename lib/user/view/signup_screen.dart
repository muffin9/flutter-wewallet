import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wewallet/Products/Products.dart';
import 'package:flutter_wewallet/common/const/code.dart';
import 'package:flutter_wewallet/common/const/colors.dart';
import 'package:flutter_wewallet/common/const/data.dart';
import 'package:flutter_wewallet/common/layout/default_layout.dart';
import 'package:flutter_wewallet/component/atoms/TextField/custom_text_form_field.dart';
import 'package:flutter_wewallet/utils/cookie_utils.dart';
import 'package:flutter_wewallet/utils/validation.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = '';
  String nickname = '';
  String name = '';
  String password = '';
  String checkPassword = '';
  final dio = Dio();
  final cookieJar = CookieJar();

  @override
  void initState() {
    super.initState();
    dio.interceptors.add(CookieManager(cookieJar));
  }

  bool isValidInput() {
    return isValidEmail(email) &&
        isValidNickName(nickname) &&
        isValidName(name) &&
        isValidPassword(password);
  }

  Future<void> handleSignup() async {
    final localContext = context;

    final response = await dio.post('http://$ip/user/signup', data: {
      'email': email,
      'nickname': nickname,
      'name': name,
      'password': password
    });

    final status = response.data['status'];

    if (status == USER_STATUS['USER_DUPLICATE_EMAIL']) {
      _showErrorDialog();
      return;
    }

    if (status == USER_STATUS['USER_CREATED']) {
      List<Cookie> cookieList =
          await cookieJar.loadForRequest(response.requestOptions.uri);

      for (Cookie cookie in cookieList) {
        await storeCookie(cookie);
      }

      Navigator.of(localContext).push(
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
                const Text('이메일 중복',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 20),
                const Text('다른 이메일을 사용해주세요.'),
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
        title: "회원가입",
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    hintText: "이메일을 입력해주세요.",
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    },
                    errorText: isValidEmail(email) ? null : '이메일 형식이 아닙니다.',
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    hintText: "별명을 입력해주세요.",
                    onChanged: (String value) {
                      setState(() {
                        nickname = value;
                      });
                    },
                    errorText:
                        isValidNickName(nickname) ? null : '별명은 6자 이하로 입력해주세요',
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                      hintText: "이름을 입력해주세요.",
                      onChanged: (String value) {
                        setState(() {
                          name = value;
                        });
                      },
                      errorText: isValidName(name) ? null : '이름은 영문으로 입력해주세요'),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                      hintText: "비밀번호를 입력해주세요.",
                      onChanged: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                      obscureText: true,
                      errorText: isValidPassword(password)
                          ? null
                          : '비밀번호는 영소(대)문자, 숫자로 이루어진 8자이상 입력해주세요.'),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                      hintText: "비밀번호 한 번 더 입력해주세요.",
                      onChanged: (String value) {
                        setState(() {
                          checkPassword = value;
                        });
                      },
                      obscureText: true,
                      errorText: isCheckValidPassword(password, checkPassword)
                          ? null
                          : '비밀번호가 같지 않습니다.'),
                  const SizedBox(height: 34.0),
                  SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: isValidInput() ? handleSignup : null,
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                        child: const Text('회원가입'),
                      ))
                ],
              ),
            )));
  }
}
