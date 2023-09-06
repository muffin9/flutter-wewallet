import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wewallet/Products/repository/Products.repository.dart';
import 'package:flutter_wewallet/Products/repository/provider/Products.provider.dart';
import 'package:flutter_wewallet/common/const/code.dart';
import 'package:flutter_wewallet/common/layout/default_main_layout.dart';
import 'package:flutter_wewallet/component/molecule/SelectDate/SelectDate.dart';
import 'package:flutter_wewallet/component/molecule/TransSection/TransSection.dart';
import 'package:flutter_wewallet/component/organism/Calendar/Calendar.dart';
import 'package:flutter_wewallet/utils/transActionGetTransResponse.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultMainLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder<TransActionGetTransResponse>(
          future: ref.watch(ProductsRepositoryProvider).getProducts(
                month: ref.read(monthProivder),
              ),
          builder: (_, AsyncSnapshot<TransActionGetTransResponse> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.status ==
                TRANS_STATUS['TRANSACTION_GET_SUCCESS']) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32.0),
                  const SelectDate(),
                  const SizedBox(height: 32.0),
                  TransSection(model: snapshot.data!.all),
                  const SizedBox(height: 48.0),
                  const CalendarScreen(),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
