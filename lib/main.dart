import 'package:flutter/material.dart';
import 'package:flutter_wewallet/home/Home.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:flutter_wewallet/common/const/data.dart';

void main() {
  KakaoSdk.init(nativeAppKey: NATIVE_APP_KEY);
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'NotoSans'),
        debugShowCheckedModeBanner: false,
        home: const Home());
  }
}
