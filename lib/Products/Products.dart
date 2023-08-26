import 'package:flutter/material.dart';
import 'package:flutter_wewallet/common/layout/default_layout.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        title: "내역 보기",
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Products Page"),
          ],
        )));
  }
}
