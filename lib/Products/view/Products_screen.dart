import 'package:flutter/material.dart';
import 'package:flutter_wewallet/common/layout/default_main_layout.dart';
import 'package:flutter_wewallet/component/molecule/SelectDate/SelectDate.dart';
import 'package:flutter_wewallet/component/molecule/TransSection/TransSection.dart';
import 'package:flutter_wewallet/component/organism/Calendar/Calendar.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultMainLayout(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 32.0),
          SelectDate(),
          SizedBox(height: 32.0),
          TransSection(),
          SizedBox(height: 48.0),
          CalendarScreen(),
        ],
      ),
    ));
  }
}
