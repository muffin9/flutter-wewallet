import 'package:flutter/material.dart';
import 'package:flutter_wewallet/common/const/colors.dart';
import 'package:flutter_wewallet/component/organism/AddTrans/AddTrans.dart';

class TransSection extends StatelessWidget {
  const TransSection({Key? key}) : super(key: key);

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
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 동작이 안됨.
              children: [
                const Column(
                  children: [
                    Row(
                      children: [
                        Text("지출",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("1,075,331원",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white))
                      ],
                    ),
                    Row(
                      children: [
                        Text("수입",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("1,000원",
                            style: TextStyle(
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
