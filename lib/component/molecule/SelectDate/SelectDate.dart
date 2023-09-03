import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wewallet/Products/repository/provider/Products.provider.dart';

class SelectDate extends ConsumerWidget {
  final VoidCallback? prevClick;
  final VoidCallback? nextClick;

  const SelectDate({Key? key, this.prevClick, this.nextClick})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(monthProivder);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            ref
                .read(monthProivder.notifier)
                .update((state) => state == 1 ? 12 : state - 1);
          },
          child: Image.asset(
            'assets/img/calendar/arrow_left.png',
            color: Colors.white,
            width: 32,
            height: 32,
          ),
        ),
        Text(
          "$provider월",
          style: const TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        GestureDetector(
          onTap: () {
            ref
                .read(monthProivder.notifier)
                .update((state) => state == 12 ? 1 : state + 1);
          },
          child: Image.asset(
            'assets/img/calendar/arrow_right.png',
            color: Colors.white,
            width: 32,
            height: 32,
          ),
        ),
      ],
    );
  }
}
