import 'package:firebase_messaging/firebase_messaging.dart';

import '../../domain/repository/push_token_repository.dart';

class FirebasePushTokenRepository implements PushTokenRepository {
  final FirebaseMessaging _fcm;

  FirebasePushTokenRepository({FirebaseMessaging? fcm})
    : _fcm = fcm ?? FirebaseMessaging.instance;

  @override
  Future<String?> getToken() async {
    return await _fcm.getToken();
  }

  @override
  Future<void> deleteToken() async {
    await _fcm.deleteToken();
  }
}
