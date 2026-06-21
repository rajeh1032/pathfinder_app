
abstract class ChatRemoteDataSource {
  Future<Map<String, dynamic>> createSession({String? title});
  Future<List<Map<String, dynamic>>> getSessions();
  Future<List<Map<String, dynamic>>> getMessages(String sessionId);
  Future<Map<String, dynamic>> sendMessage({
    required String sessionId,
    required String message,
  });
  Future<void> deleteSession(String sessionId);
}

