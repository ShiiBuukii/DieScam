import 'package:diescam/core/errors/failures.dart';
import 'package:diescam/core/isolates/isolate.dart';
import 'package:diescam/feature/home/business/entities/isolate_entity.dart';
import 'package:diescam/feature/home/business/entities/send_message_entity.dart';
import 'package:diescam/feature/home/business/entities/thread_entity.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  SendMessageEntity? sendMessageEntity;
  Failure? failure;

  AppIsolate appIsolate = AppIsolate();
  double _threadCurrentValue = 1;
  int get threadCurrentValue => _threadCurrentValue.round();
  Map<String, IsolateEntity> get isolates => appIsolate.isolates;
  Map<String, ThreadEntity> get threads => appIsolate.threads;
  late ExpandableController expandableController;

  void setThreadCurrentValue(double value) {
    _threadCurrentValue = value;
    appIsolate.setNumThread(threadCurrentValue);
    notifyListeners();
  }

  void setExpandableController(ExpandableController expndController) {
    expandableController = expndController;
  }

  void toggleExpandableController() {
    expandableController.toggle();
  }

  void notify() {
    print("[*] notify()");
    notifyListeners();
  }

  void prepare(String token, String chatId, String text) {
    appIsolate.prepare(chatId, text, token, this);
  }
}
