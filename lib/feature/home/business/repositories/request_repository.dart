import 'package:dartz/dartz.dart';
import 'package:diescam/core/errors/failures.dart';
import 'package:diescam/core/parameters/send_message_parameter.dart';
import 'package:diescam/feature/home/business/entities/send_message_entity.dart';

abstract class RequestRepository {
  Future<Either<Failure, SendMessageEntity>> sendRequest(
      {required String url,
      required SendMessageParameter sendMessageParameter});
}
