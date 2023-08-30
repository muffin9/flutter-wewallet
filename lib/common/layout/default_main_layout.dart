import 'package:flutter/material.dart';
import 'package:flutter_wewallet/component/atoms/Header/Header.dart';

class DefaultMainLayout extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;

  const DefaultMainLayout({
    super.key,
    required this.child,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Header(),
        backgroundColor: Colors.transparent,
        elevation: 0, // 제목의 그림자를 제거합니다.
      ),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
