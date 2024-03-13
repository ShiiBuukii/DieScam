import 'dart:isolate';

import 'package:diescam/config/dio_config.dart';
import 'package:diescam/config/random_user_agent.dart';
import 'package:diescam/core/constants/constants.dart';
import 'package:diescam/core/errors/failures.dart';
import 'package:diescam/core/parameters/isolate_parameter.dart';
import 'package:diescam/core/parameters/send_message_parameter.dart';
import 'package:diescam/feature/home/business/entities/isolate_entity.dart';
import 'package:diescam/feature/home/business/entities/send_message_entity.dart';
import 'package:diescam/feature/home/business/entities/thread_entity.dart';
import 'package:diescam/feature/home/data/datasources/remote_request.dart';
import 'package:diescam/feature/home/data/repositories/send_message_repository_impl.dart';
import 'package:diescam/feature/home/presentation/provider/homepage_provider.dart';

class AppIsolate {
  int _numThread = 1;
  int get numThread => _numThread;
  Map<String, IsolateEntity> isolates = {};
  Map<String, ThreadEntity> threads = {};
  bool _whileLoop = true;
  void setNumThread(int num) {
    _numThread = num;
  }

  void killIsolate(String key) {
    if (isolates[key]?.isolate != null) {
      isolates[key]?.isolate!.kill(priority: Isolate.immediate);
      isolates.remove(key);
    }
  }

  void removeAllIsolate(HomePageProvider homePageProvider) {
    isolates.forEach((key, value) {
      if (value.isolate != null) {
        print("[*] Killing $key");
        value.isolate?.kill(priority: Isolate.immediate);
      }
    });
    isolates = {};
    homePageProvider.notify();
  }

  void stopWhileLoop(String isolateKey) {
    if (isolates[isolateKey] != null) {
      isolates[isolateKey]!.isolate!.controlPort.send('stopWhileLoop');
    }
  }

  void prepare(String chatId, String text, String token,
      HomePageProvider homePageProvider) async {
    removeAllIsolate(homePageProvider);
    for (var i = 0; i < _numThread; i++) {
      String isolateKey = "isolate_${i.toString()}";
      ReceivePort receivePort = ReceivePort();
      threads[isolateKey] = ThreadEntity('...', 'Ready', null, null);

      isolates[isolateKey] = IsolateEntity(
          await Isolate.spawn(run, <String, dynamic>{
            "isolateParameter":
                IsolateParameter(chatId: chatId, text: text, token: token),
            "sendPort": receivePort.sendPort,
          }),
          null);
      receivePort.listen((message) {
        if (message is BadRequestFailure) {
          threads[isolateKey]?.info = 'Bad request';
          threads[isolateKey]?.failure = message;
          killIsolate(isolateKey);
          stopWhileLoop(isolateKey);
          threads[isolateKey]?.status = 'Stopped';
          homePageProvider.toggleExpandableController();
        } else if (message is UnauthorizedFailure) {
          threads[isolateKey]?.info = 'Invalid token';
          killIsolate(isolateKey);
          stopWhileLoop(isolateKey);
          threads[isolateKey]?.failure = message;
          threads[isolateKey]?.status = 'Stopped';
        } else if (message is RequestFailure) {
          threads[isolateKey]?.info = "Can't send request";
          killIsolate(isolateKey);
          stopWhileLoop(isolateKey);
          threads[isolateKey]?.failure = message;
          threads[isolateKey]?.status = 'Stopped';
        } else if (message is SendMessageEntity) {
          threads[isolateKey]?.info = 'Sent';
          threads[isolateKey]?.sendMessageEntity = message;
        } else if (message is SendPort) {
          isolates[isolateKey]?.sendPort = message;
        }
        homePageProvider.notify();
      });
    }
    homePageProvider.notify();
  }

  void executeAllIsolate(HomePageProvider homePageProvider) async {
    isolates.forEach((key, value) {
      print("[*] Executing $key");
      threads[key]!.status = "Running";
      value.sendPort!.send('execute');
    });
    homePageProvider.notify();
  }

  void run(Map<String, dynamic> parameter) async {
    ReceivePort isolateReceivePort = ReceivePort();
    SendPort sendPort = parameter['sendPort'];
    IsolateParameter isolateParameter = parameter['isolateParameter'];
    print(
        "[*] Waiting main thread to send 'execute' value to execute the isolate ");
    sendPort.send(isolateReceivePort.sendPort);
    isolateReceivePort.listen((message) async {
      print("[*] isolateReceivePort : $message");
      if (message == 'execute') {
        print("[*] Isolate execute");

        SendMessageRepositoryImpl sendMessageRepositoryImpl =
            SendMessageRepositoryImpl(
                remoteRequestImpl: RemoteRequestImpl(
                    dio: DioConfigImpl(randomUserAgent: RandomUserAgent())));

        SendMessageParameter sendMessageParameter = SendMessageParameter(
            chatId: isolateParameter.chatId,
            text: isolateParameter.text,
            token: isolateParameter.token);

        while (_whileLoop) {
          await sendMessageRepositoryImpl
              .sendRequest(
                  url: url.replaceFirst("<token>", isolateParameter.token),
                  sendMessageParameter: sendMessageParameter)
              .then((value) {
            value.fold((l) {
              print(l);
              sendPort.send(l);
            }, (r) {
              print(r);
              sendPort.send(r);
            });
          });
        }
      } else if (message == 'stopWhileLoop') {
        _whileLoop = false;
      }
    });
  }
}
