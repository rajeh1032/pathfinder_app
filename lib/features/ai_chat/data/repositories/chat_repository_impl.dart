import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/error_messages.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/chat_session_entity.dart';
import '../../domain/repositories/chat_repo.dart';
import '../data_sources/remote/chat_remote_data_source.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._remoteDataSource, this._networkInfo);

  final ChatRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, ChatSessionEntity>> createSession({String? title}) =>
      _request(() async =>
          (await _remoteDataSource.createSession(title: title)).toEntity());

  @override
  Future<Either<Failure, List<ChatSessionEntity>>> getSessions() => _request(
        () async => (await _remoteDataSource.getSessions())
            .map((model) => model.toEntity())
            .toList(),
      );

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getMessages(
    String sessionId,
  ) =>
      _request(
        () async => (await _remoteDataSource.getMessages(sessionId))
            .map((model) => model.toEntity())
            .toList(),
      );

  @override
  Future<Either<Failure, ChatReplyEntity>> sendMessage({
    required String sessionId,
    required String message,
  }) =>
      _request(
        () async => (await _remoteDataSource.sendMessage(
          sessionId: sessionId,
          message: message,
        ))
            .toEntity(),
      );

  @override
  Future<Either<Failure, Unit>> deleteSession(String sessionId) => _request(
        () async {
          await _remoteDataSource.deleteSession(sessionId);
          return unit;
        },
      );

  Future<Either<Failure, T>> _request<T>(Future<T> Function() request) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(ErrorMessages.network));
    }
    try {
      return Right(await request());
    } on DioException catch (error) {
      return Left(DioErrorHandler.handle(error));
    } on FormatException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(UnknownFailure(ErrorMessages.unknown));
    }
  }
}
