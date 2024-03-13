import 'package:diescam/feature/home/presentation/widget/info_card.dart';
import 'package:diescam/feature/home/presentation/widget/input_card.dart';
import 'package:diescam/feature/home/presentation/widget/thread_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("DieScam"),
        ),
        body: const Stack(children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: InfoCard()),
              SliverToBoxAdapter(child: InputCard()),
              ThreadCard()
            ],
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Card(
                  elevation: 6,
                  child: Padding(
                      padding: EdgeInsets.all(9),
                      child: Row(
                        children: [
                          Text("Made by "),
                          Text("ShiiBuukii ",
                              style: TextStyle(color: Colors.lightBlue)),
                          Text("with "),
                          Text("<3", style: TextStyle(color: Colors.pinkAccent))
                        ],
                      ))))
        ]));
  }
}
