import 'package:dartz/dartz.dart';
import 'package:diescam/core/errors/exceptions.dart';
import 'package:diescam/core/errors/failures.dart';
import 'package:diescam/core/parameters/send_message_parameter.dart';
import 'package:diescam/feature/home/business/entities/send_message_entity.dart';
import 'package:diescam/feature/home/business/repositories/request_repository.dart';
import 'package:diescam/feature/home/data/datasources/remote_request.dart';
import 'package:dio/dio.dart';

class SendMessageRepositoryImpl implements RequestRepository {
  final RemoteRequestImpl remoteRequestImpl;

  SendMessageRepositoryImpl({required this.remoteRequestImpl});
  @override
  Future<Either<Failure, SendMessageEntity>> sendRequest(
      {required String url,
      required SendMessageParameter sendMessageParameter}) async {
    try {
      final result = await remoteRequestImpl.sendRequest(
          url: url, sendMessageParameter: sendMessageParameter);
      return Right(result);
    } on DioException catch (err) {
      return Left(RequestFailure(err.message));
    } on UnauthorizedException catch (err) {
      return Left(UnauthorizedFailure(err.message));
    } on BadRequestException catch (err) {
      return Left(BadRequestFailure(err.message));
    } on RequestException catch (err) {
      return Left(RequestFailure(err.message));
    }
  }
}
