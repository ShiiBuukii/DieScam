import 'dart:isolate';

class IsolateEntity {
  Isolate? isolate;
  SendPort? sendPort;
  IsolateEntity(this.isolate, this.sendPort);
}
