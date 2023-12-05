import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//반환이되면 이 값을 계속 사용할거임임
final secureStorageProvider =
    Provider<FlutterSecureStorage>((ref) => FlutterSecureStorage());
