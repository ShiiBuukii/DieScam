import 'package:dartz/dartz.dart';
import 'package:diescam/core/errors/failures.dart';
import 'package:diescam/core/parameters/send_message_parameter.dart';
import 'package:diescam/feature/home/business/entities/send_message_entity.dart';
import 'package:diescam/feature/home/business/repositories/request_repository.dart';

class RequestUsecase {
  final RequestRepository requestRepository;

  RequestUsecase({required this.requestRepository});

  Future<Either<Failure, SendMessageEntity>> call(
      {required String url,
      required SendMessageParameter sendMessageParameter}) async {
    return await requestRepository.sendRequest(
        url: url, sendMessageParameter: sendMessageParameter);
  }
}
