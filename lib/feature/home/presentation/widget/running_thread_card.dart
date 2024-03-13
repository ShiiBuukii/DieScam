import 'package:diescam/feature/home/business/entities/thread_entity.dart';
import 'package:diescam/feature/home/presentation/provider/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RunningThreadCard extends StatefulWidget {
  final int isolateNum;

  const RunningThreadCard({super.key, required this.isolateNum});
  @override
  State<StatefulWidget> createState() => _RunningThreadCardState();
}

class _RunningThreadCardState extends State<RunningThreadCard> {
  Color statusColor(Map<String, ThreadEntity> threads) {
    if (threads['isolate_${widget.isolateNum}'] != null) {
      final isolate = threads['isolate_${widget.isolateNum}'];
      if (isolate!.status == 'Ready') {
        return Colors.blue;
      } else if (isolate.status == 'Undefined') {
        return Theme.of(context).colorScheme.onBackground;
      } else if (isolate.status == 'Stopped') {
        return Colors.red;
      } else if (isolate.status == 'Running') {
        return Colors.green;
      }
    }
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, value, child) {
        return Card(
            elevation: 4,
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Status",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            value.threads["isolate_${widget.isolateNum}"] !=
                                    null
                                ? value.threads["isolate_${widget.isolateNum}"]!
                                    .status
                                    .toString()
                                : "Undefined",
                            style: TextStyle(
                                color: statusColor(value.threads),
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Info",
                            style: TextStyle(fontWeight: FontWeight.w300)),
                        Text(
                            value.threads["isolate_${widget.isolateNum}"] !=
                                    null
                                ? value.threads["isolate_${widget.isolateNum}"]!
                                    .info
                                    .toString()
                                : "Undefined",
                            style: TextStyle(
                                color: statusColor(value.threads),
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                )));
      },
    );
  }
}
