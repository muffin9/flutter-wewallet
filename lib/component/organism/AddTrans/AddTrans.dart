import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wewallet/Category/repository/Category.repository.dart';
import 'package:flutter_wewallet/Products/repository/Products.repository.dart';
import 'package:flutter_wewallet/common/const/code.dart';
import 'package:flutter_wewallet/common/const/colors.dart';
import 'package:flutter_wewallet/common/const/data.dart';
import 'package:flutter_wewallet/component/atoms/Button/Button.dart';
import 'package:flutter_wewallet/utils/categoryAllResponse.dart';
import 'package:flutter_wewallet/utils/paymentMethod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wewallet/utils/transActionPost.dart';

class AddTrans extends ConsumerStatefulWidget {
  const AddTrans({super.key});

  @override
  ConsumerState<AddTrans> createState() => _AddTransState();
}

class _AddTransState extends ConsumerState<AddTrans> {
  // category 데이터 받아와서 진짜 카테고리로 대체 필요.
  String price = '';
  String type = 'EXPENDITURE';
  int? categoryId;
  int? subCategoryId;
  String account = "";
  String paymentMethod = "CASH";

  DateTime currentDate = DateTime.now();
  String memo = '';
  bool isBudget = false;

  List<dynamic> allCategory = [];

  // final TextEditingController _priceController = TextEditingController();

  // String _formatNumber(String s) {
  //   return s.isEmpty
  //       ? ''
  //       : int.parse(s).toStringAsFixed(0).replaceAllMapped(
  //           RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _priceController.addListener(() {
  //     _handleTextChange;
  //   });
  // }

  // @override
  // void dispose() {
  //   _priceController.removeListener(_handleTextChange);
  //   _priceController.dispose();
  //   super.dispose();
  // }

  // void _handleTextChange() {
  //   String text = _priceController.text;

  //   String cleanText = text.replaceAll(',', '');

  //   if (cleanText.length > 10) {
  //     cleanText = cleanText.substring(0, 10);
  //   }

  //   String formattedText = _formatNumber(cleanText);

  //   // 텍스트의 변경을 피하기 위해 현재 삽입 위치를 계산
  //   int offset =
  //       _priceController.selection.start + (formattedText.length - text.length);

  //   setState(() {
  //     _priceController.text = formattedText;
  //     _priceController.selection = TextSelection.collapsed(offset: offset);
  //   });
  // }

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
                    paymentMethod = method.id;
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
            height: 400,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "카테고리",
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                            ),
                          ),
                          Wrap(
                            spacing: 16.0, // 가로 간격
                            children: allCategory.map((data) {
                              String CategoryName =
                                  data['category']['categoryName'];
                              String CategoryImageUrl =
                                  'http://$ip/${data['category']['categoryImageUrl']}';
                              List<dynamic> subCategories =
                                  data['category']['subCategory'];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    categoryId = data['category']['categoryId'];
                                  });
                                  _showSubCategory(context, subCategories);
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.network(
                                      CategoryImageUrl,
                                      width: 40,
                                      height: 40,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      CategoryName,
                                      style: const TextStyle(fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    )),
              ],
            ));
      },
    );
  }

  void _showSubCategory(BuildContext context, List<dynamic> subCategories) {
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
              Column(
                children: subCategories.map((data) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        subCategoryId = data['subCategoryId'];
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        data['subCategoryName'],
                        style: const TextStyle(
                            fontSize: 10.0, color: Colors.black),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    final response = await fetchDataFromAPI();

    if (response.status == CATEGORY_STATUS['CATEGORY_ALL_GET_SUCCESS']) {
      if (response.allCategories == null) {
        return;
      }

      setState(() {
        allCategory = response.allCategories!;
      });
    }
  }

  Future<CategoryAllResponse> fetchDataFromAPI() async {
    return await ref.watch(CategoryRepositoryProvider).getAllCategory();
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
                      TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          return RegExp(r'^[0-9]+$').hasMatch(value!)
                              ? null
                              : '숫자만 입력해주세요.';
                        },
                        decoration:
                            const InputDecoration(hintText: "금액을 입력해주세요."),
                        onChanged: (String value) {
                          setState(() {
                            price = value;
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
                  child: Row(
                    children: [
                      const SizedBox(
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
                              text: "수입",
                              isSelected: type == 'INCOME',
                              onPressed: () {
                                setState(() {
                                  type = 'INCOME';
                                });
                              }),
                          const SizedBox(width: 8.0),
                          CustomButton(
                              size: ButtonSize.small,
                              text: "지출",
                              isSelected: type == 'EXPENDITURE',
                              onPressed: () {
                                setState(() {
                                  type = 'EXPENDITURE';
                                });
                              }),
                          const SizedBox(width: 8.0),
                          CustomButton(
                              size: ButtonSize.small,
                              text: "이체",
                              isSelected: type == 'TRANSFER',
                              onPressed: () {
                                setState(() {
                                  type = 'TRANSFER';
                                });
                              }),
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
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            hintText: "미분류",
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
                          "거래처",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          cursorColor: PRIMARY_COLOR,
                          onChanged: (String value) {
                            setState(() {
                              account = value;
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
                            hintText: paymentMethod,
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
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final postProduct = TransActionPost(
                  price: price,
                  type: type,
                  categoryId: categoryId,
                  subCategoryId: subCategoryId,
                  account: account,
                  paymentMethod: paymentMethod,
                  currentDate: currentDate,
                  memo: memo,
                  isBudget: isBudget,
                );

                await ref.watch(ProductsRepositoryProvider).postProducts(
                      body: postProduct.toJson(),
                    );

                Navigator.of(context).pop();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 32.0,
                height: 40,
                child: const Center(
                  child: Text(
                    "저장",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
