import 'package:diescam/config/random_user_agent.dart';
import 'package:diescam/core/parameters/send_message_parameter.dart';
import 'package:dio/dio.dart';

abstract class DioConfig {
  Future<Response> get(
      {required String url, required SendMessageParameter parameter});
}

class DioConfigImpl implements DioConfig {
  final RandomUserAgent randomUserAgent;
  late Dio dio;
  DioConfigImpl({required this.randomUserAgent}) {
    dio = Dio();
  }

  @override
  Future<Response> get(
      {required String url, required SendMessageParameter parameter}) async {
    final String randomUA = randomUserAgent.generate();

    final response = await dio.get(url,
        data: {'chat_id': parameter.chatId, 'text': parameter.text},
        queryParameters: {'chat_id': parameter.chatId, 'text': parameter.text},
        options: Options(headers: {'User-Agent': randomUA}));

    return response;
  }
}
