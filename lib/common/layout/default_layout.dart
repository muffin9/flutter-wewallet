import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final String? title;
  final Widget child;

  final Widget? bottomNavigationBar;

  const DefaultLayout(
      {required this.child,
      this.title,
      this.backgroundColor,
      this.bottomNavigationBar,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppBar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(title!,
            style:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
        foregroundColor: Colors.black,
      );
    }
  }
}
