import 'package:diescam/core/errors/failures.dart';
import 'package:diescam/feature/home/business/entities/send_message_entity.dart';

class ThreadEntity {
  String? info;
  String? status;
  Failure? failure;
  SendMessageEntity? sendMessageEntity;
  ThreadEntity([this.info, this.status, this.failure, this.sendMessageEntity]);
}
