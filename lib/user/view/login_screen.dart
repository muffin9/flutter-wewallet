import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wewallet/Products/view/products_screen.dart';
import 'package:flutter_wewallet/common/const/code.dart';
import 'package:flutter_wewallet/common/const/colors.dart';
import 'package:flutter_wewallet/common/const/data.dart';
import 'package:flutter_wewallet/common/layout/default_layout.dart';
import 'package:flutter_wewallet/common/secure_storage/secure_storage.dart';
import 'package:flutter_wewallet/component/atoms/Modal/Modal.dart';
import 'package:flutter_wewallet/component/atoms/TextField/custom_text_form_field.dart';
import 'package:flutter_wewallet/utils/validation.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String email = '';
  String password = '';
  final dio = Dio();

  @override
  void initState() {
    super.initState();
  }

  bool isValidInput() {
    return isValidEmail(email) && isValidPassword(password);
  }

  Future<void> handleLogin() async {
    final localContext = context;

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
      final refreshToken = response.headers.value('refresh-token');
      final accessToken = response.headers.value('access-token');

      final storage = ref.read(secureStorageProvider);

      await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

      Navigator.of(localContext).push(
        MaterialPageRoute(
          builder: (_) => const ProductsScreen(),
        ),
      );
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Modal(
            title: '로그인 실패', description: '이메일 또는 비밀번호가 일치하지 않습니다.');
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
