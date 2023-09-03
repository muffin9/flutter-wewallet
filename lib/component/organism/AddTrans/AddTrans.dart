import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wewallet/common/const/colors.dart';
import 'package:flutter_wewallet/component/atoms/Button/Button.dart';
import 'package:flutter_wewallet/component/atoms/TextField/custom_text_form_field.dart';
import 'package:flutter_wewallet/utils/paymentMethod.dart';
import 'package:intl/intl.dart';

const TransType = {
  'INCOME': '수입',
  'EXPENDITURE': '지출',
  'TRANSFER': '이체',
};

class AddTrans extends StatefulWidget {
  const AddTrans({super.key});

  @override
  State<AddTrans> createState() => _AddTransState();
}

class _AddTransState extends State<AddTrans> {
  String price = '';
  String? transType = TransType['EXPENDITURE'];
  String memo = '';
  PaymentMethod paymentMethod = PaymentMethod(
    id: 'CASH',
    name: '현금',
    icon: const Icon(Icons.payment),
  );

  bool isBudget = false;
  DateTime currentDate = DateTime.now();
  String category = '';
  String subCategory = '';

  final TextEditingController _priceController = TextEditingController();

  String _formatNumber(String s) {
    var format = NumberFormat("#,###");
    var number = int.tryParse(s);
    if (number != null) {
      return format.format(number);
    } else {
      return s;
    }
  }

  @override
  void initState() {
    super.initState();
    _priceController.addListener(() {
      String text = _priceController.text.replaceAll(",", "");
      _priceController.value = TextEditingValue(
        text: _formatNumber(text),
        selection:
            TextSelection.collapsed(offset: _priceController.text.length),
      );
    });
  }

  void _showPaymentSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: paymentMethods.map((method) {
              return ListTile(
                leading: method.icon,
                title: Text(method.name),
                onTap: () {
                  setState(() {
                    paymentMethod = method;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          );
        });
  }

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime dateTime) {
              setState(() {
                currentDate = dateTime;
              });
            },
          ),
        );
      },
    );
  }

  void _showCategory(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 250,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "카테고리",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          category = "식비";
                                        });

                                        Navigator.pop(context);
                                        _showSubCategory(context);
                                      },
                                      child: const Text("식비",
                                          style: TextStyle(fontSize: 10.0)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          category = "카페/간식";
                                        });
                                        Navigator.pop(context);
                                        _showSubCategory(context);
                                      },
                                      child: const Text("카페간식",
                                          style: TextStyle(fontSize: 10.0)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          category = "술/유흥";
                                        });

                                        Navigator.pop(context);
                                        _showSubCategory(context);
                                      },
                                      child: const Text("술/유흥",
                                          style: TextStyle(fontSize: 10.0)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          category = "생활";
                                        });

                                        Navigator.pop(context);
                                        _showSubCategory(context);
                                      },
                                      child: const Text("생활",
                                          style: TextStyle(fontSize: 10.0)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          category = "온라인쇼핑";
                                        });

                                        Navigator.pop(context);
                                        _showSubCategory(context);
                                      },
                                      child: const Text("온라인쇼핑",
                                          style: TextStyle(fontSize: 10.0)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          category = "패션/쇼핑";
                                        });

                                        Navigator.pop(context);
                                        _showSubCategory(context);
                                      },
                                      child: const Text("패션/쇼핑",
                                          style: TextStyle(fontSize: 10.0)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          category = "뷰티/미용";
                                        });

                                        Navigator.pop(context);
                                        _showSubCategory(context);
                                      },
                                      child: const Text("뷰티/미용",
                                          style: TextStyle(fontSize: 10.0)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          category = "교통";
                                        });

                                        Navigator.pop(context);
                                        _showSubCategory(context);
                                      },
                                      child: const Text("교통",
                                          style: TextStyle(fontSize: 10.0)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ));
      },
    );
  }

  void _showSubCategory(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: 250,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "세부 카테고리",
                  style: TextStyle(fontSize: 10.0, color: Colors.black),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _showCategory(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(category, style: const TextStyle(fontSize: 10.0)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    subCategory = "커피/음료";
                  });
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("커피/음료", style: TextStyle(fontSize: 10.0)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    subCategory = "베이커리";
                  });
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("베이커리", style: TextStyle(fontSize: 10.0)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    subCategory = "디저트/떡";
                  });
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text("디저트/떡", style: TextStyle(fontSize: 10.0)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 32.0,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "거래처",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextFormField(
                        autofocus: true,
                        // controller: _priceController,
                        // keyboardType: TextInputType.number,
                        hintText: "가격을 입력해주세요.",
                        onChanged: (String value) {
                          setState(() {
                            price = value.replaceAll(",", "");
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 32.0,
                  padding: const EdgeInsets.only(bottom: 16.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: Text(
                          "분류",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            size: ButtonSize.small,
                            text: '수입',
                          ),
                          SizedBox(width: 8.0),
                          CustomButton(size: ButtonSize.small, text: "지출"),
                          SizedBox(width: 8.0),
                          CustomButton(size: ButtonSize.small, text: "이체"),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 32.0,
                  padding: const EdgeInsets.only(bottom: 16.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          "카테고리",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          showCursor: false,
                          onChanged: (String value) {},
                          onTap: () {
                            _showCategory(context);
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: category == "" && subCategory == ""
                                ? "미분류"
                                : "$category > $subCategory",
                            hintStyle: const TextStyle(
                                color: BODY_TEXT_COLOR, fontSize: 14),
                            fillColor: INPUT_BG_COLOR,
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 32.0,
                  padding: const EdgeInsets.only(bottom: 16.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          "거래처",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          cursorColor: PRIMARY_COLOR,
                          onChanged: (String value) {
                            setState(() {
                              memo = value;
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "거래처를 입력해주세요",
                            hintStyle:
                                TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
                            fillColor: INPUT_BG_COLOR,
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 32.0,
                  padding: const EdgeInsets.only(bottom: 16.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          "결제 수단",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          showCursor: false,
                          onTap: () {
                            _showPaymentSheet(context);
                          },
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: paymentMethod.name,
                            hintStyle: const TextStyle(
                                color: BODY_TEXT_COLOR, fontSize: 14),
                            fillColor: INPUT_BG_COLOR,
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 32.0,
                  padding: const EdgeInsets.only(bottom: 16.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          "날짜",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          showCursor: false,
                          onTap: () {
                            _showDatePicker(context);
                          },
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText:
                                '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
                            hintStyle: const TextStyle(
                                color: BODY_TEXT_COLOR, fontSize: 14),
                            fillColor: INPUT_BG_COLOR,
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 32.0,
                  padding: const EdgeInsets.only(bottom: 16.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          "메모 태그",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          cursorColor: PRIMARY_COLOR,
                          onChanged: (String value) {
                            setState(() {
                              memo = value;
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "메모를 입력해주세요",
                            hintStyle:
                                TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
                            fillColor: INPUT_BG_COLOR,
                            filled: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 32.0,
                  padding: const EdgeInsets.only(bottom: 16.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 100.0,
                        child: Text(
                          "예산에서 제외",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      Switch(
                        activeColor: PRIMARY_COLOR,
                        value: isBudget,
                        onChanged: (value) {
                          setState(() {
                            isBudget = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 32.0,
                child: const Text(
                  "저장",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
