import 'package:diescam/config/dio_config.dart';
import 'package:diescam/core/errors/exceptions.dart';
import 'package:diescam/core/parameters/send_message_parameter.dart';
import 'package:diescam/feature/home/business/entities/send_message_entity.dart';

abstract class RemoteRequest {
  Future<SendMessageEntity> sendRequest(
      {required String url,
      required SendMessageParameter sendMessageParameter});
}

class RemoteRequestImpl implements RemoteRequest {
  final DioConfigImpl dio;

  RemoteRequestImpl({required this.dio});
  @override
  Future<SendMessageEntity> sendRequest(
      {required String url,
      required SendMessageParameter sendMessageParameter}) async {
    return await dio
        .get(url: url, parameter: sendMessageParameter)
        .then((response) {
      return SendMessageEntity(response: response);
    }).catchError((err) {
      if (err.response.statusCode == 401) {
        throw UnauthorizedException(
            message: 'May possible the token is invalid');
      } else if (err.response.statusCode == 400) {
        throw BadRequestException(message: 'May chat_id is invalid');
      } else {
        throw RequestException('Cannot send request');
      }
    });
  }
}
