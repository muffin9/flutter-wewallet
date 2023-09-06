import 'package:flutter/material.dart';
import 'package:flutter_wewallet/common/const/colors.dart';
import 'package:flutter_wewallet/component/organism/AddTrans/AddTrans.dart';

class TransSection extends StatelessWidget {
  final Map<String, num> model;

  const TransSection({Key? key, required this.model}) : super(key: key);

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 64.0,
          child: Stack(
            children: [
              const SizedBox(height: 16.0),
              const AddTrans(),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final income = model['INCOME'];
    final expenditure = model['EXPENDITURE'];

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 동작이 안됨.
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        const Text("지출",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text("$expenditure원",
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.white))
                      ],
                    ),
                    Row(
                      children: [
                        const Text("수입",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text("$income원",
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _openBottomSheet(context);
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          )),
                      child: const Text('내역추가'),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: PRIMARY_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          )),
                      child: const Text('분석'),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
