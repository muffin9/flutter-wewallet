import 'package:flutter_riverpod/flutter_riverpod.dart';

final monthProivder = StateProvider<int>((ref) => DateTime.now().month);
