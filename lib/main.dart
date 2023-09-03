import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_wewallet/home/Home.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:flutter_wewallet/common/const/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  KakaoSdk.init(nativeAppKey: NATIVE_APP_KEY);
  runApp((const ProviderScope(child: _App())));
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: const Locale('ko', 'KR'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('ko', 'KR'),
        ],
        theme: ThemeData(fontFamily: 'NotoSans'),
        debugShowCheckedModeBanner: false,
        home: const Home());
  }
}
