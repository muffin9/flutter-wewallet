import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String name;
  final Icon icon;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
  });
}

final List<PaymentMethod> paymentMethods = [
  PaymentMethod(id: 'CASH', icon: const Icon(Icons.payment), name: '현금'),
  PaymentMethod(
      id: 'CREDIT_CARD', icon: const Icon(Icons.credit_card), name: '신용카드'),
  PaymentMethod(
      id: 'CHECK_CARD', icon: const Icon(Icons.card_giftcard), name: '체크카드'),
  PaymentMethod(
      id: 'KAKAO_PAY', icon: const Icon(Icons.card_membership), name: '카카오페이'),
  PaymentMethod(
      id: 'TOSS', icon: const Icon(Icons.card_membership_rounded), name: '토스'),
  PaymentMethod(
      id: 'PAYCO', icon: const Icon(Icons.payment_outlined), name: '페이코'),
  PaymentMethod(
      id: 'POINT', icon: const Icon(Icons.point_of_sale_outlined), name: '포인트'),
  PaymentMethod(id: 'ETC', icon: const Icon(Icons.eco_outlined), name: '기타'),
];
