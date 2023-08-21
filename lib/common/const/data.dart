import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

//localhost
const emulatorIp = 'http://10.0.2.2:3000';
const simulatorIp = 'http://localhost:3000';

final address = Platform.isIOS ? simulatorIp : emulatorIp;

final storage = FlutterSecureStorage();
