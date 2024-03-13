import 'package:diescam/feature/home/presentation/provider/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogCard extends StatefulWidget {
  const LogCard({super.key});

  @override
  State<StatefulWidget> createState() => _LogCardState();
}

class _LogCardState extends State<LogCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Consumer<HomePageProvider>(
      builder: (context, value, child) {
        return Card(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(value.failure == null
                    ? value.sendMessageEntity == null
                        ? "Log"
                        : value.sendMessageEntity!.response!.statusCode
                            .toString()
                    : value.failure!.failMessage.toString())));
      },
    ));
  }
}
