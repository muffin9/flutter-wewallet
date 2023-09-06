import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'access-token';
const REFRESH_TOKEN_KEY = 'refresh-token';
const NATIVE_APP_KEY = 'c78ed8a5fd0dc72ada0912b9638bff26';

const storage = FlutterSecureStorage();
const emulatorIp = '10.0.2.2:3000';
const simulatorIp = '127.0.0.1:4000';

final ip = Platform.isIOS ? simulatorIp : emulatorIp;
