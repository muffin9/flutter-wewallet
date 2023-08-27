import 'dart:io';

import 'package:flutter_wewallet/common/const/data.dart';

const Map<String, String> cookieToStorageKey = {
  'refresh-token': REFRESH_TOKEN_KEY,
  'access-token': ACCESS_TOKEN_KEY
};

Future<void> storeCookie(Cookie cookie) async {
  final String? storageKey = cookieToStorageKey[cookie.name];
  if (storageKey != null) {
    await storage.write(
      key: storageKey,
      value: cookie.name,
    );
  }
}
