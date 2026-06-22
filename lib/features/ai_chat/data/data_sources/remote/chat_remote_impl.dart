import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'chat_remote_data_source.dart';

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;

  ChatRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> createSession({String? title}) async {
    final response = await dio.post(
      '/chat/sessions',
      data: {'title': title ?? 'New chat'},
    );

    return response.data['session'] as Map<String, dynamic>;
  }

  @override
  Future<List<Map<String, dynamic>>> getSessions() async {
    final response = await dio.get('/chat/sessions');

    return List<Map<String, dynamic>>.from(
      response.data['sessions'] as List,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getMessages(String sessionId) async {
    final response = await dio.get('/chat/$sessionId/messages');

    return List<Map<String, dynamic>>.from(
      response.data['messages'] as List,
    );
  }

  @override
  Future<Map<String, dynamic>> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    final response = await dio.post(
      '/chat/$sessionId',
      data: {'message': message},
    );

    return response.data as Map<String, dynamic>;
  }

  @override
  Future<void> deleteSession(String sessionId) async {
    await dio.delete('/chat/sessions/$sessionId');
  }
}