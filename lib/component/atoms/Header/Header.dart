import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/img/logo/logo.png',
              width: 40,
              height: 40,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/img/header/more.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 8.0), // 간격을 주기 위해 추가
                Image.asset(
                  'assets/img/header/doorbell.png',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 8.0), // 간격을 주기 위해 추가
                Image.asset(
                  'assets/img/header/more.png',
                  width: 16,
                  height: 16,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
