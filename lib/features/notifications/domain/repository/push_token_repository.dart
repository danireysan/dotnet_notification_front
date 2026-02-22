abstract class PushTokenRepository {
  Future<String?> getToken();

  Future<void> deleteToken();
}
