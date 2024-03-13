import 'package:diescam/feature/home/presentation/provider/homepage_provider.dart';
import 'package:diescam/feature/home/presentation/widget/running_thread_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThreadCard extends StatefulWidget {
  const ThreadCard({super.key});

  @override
  State<StatefulWidget> createState() => _ThreadCardState();
}

class _ThreadCardState extends State<ThreadCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, value, child) {
        return SliverGrid(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return RunningThreadCard(isolateNum: index);
            }, childCount: value.threadCurrentValue),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 2.0));
      },
    );
  }
}
