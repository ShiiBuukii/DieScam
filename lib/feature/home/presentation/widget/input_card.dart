// ignore_for_file: camel_case_types

import 'package:diescam/feature/home/presentation/provider/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expandable/expandable.dart';

class InputCard extends StatefulWidget {
  const InputCard({super.key});

  @override
  State<StatefulWidget> createState() => _inputCardState();
}

class _inputCardState extends State<InputCard> {
  late TextEditingController token;
  late TextEditingController chatId;
  late TextEditingController text;
  late ExpandableController expandableController;

  bool _allSets = false;
  @override
  void initState() {
    super.initState();
    token = TextEditingController();
    chatId = TextEditingController();
    text = TextEditingController();
    expandableController = ExpandableController(initialExpanded: true);
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    homePageProvider.setExpandableController(expandableController);
  }

  @override
  void dispose() {
    token.dispose();
    chatId.dispose();
    text.dispose();
    expandableController.dispose();
    super.dispose();
  }

  void _toggleAllSets() {
    setState(() {
      _allSets = !_allSets;
    });
  }

  void snackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void sendRequest() {
    final HomePageProvider homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);

    homePageProvider.toggleExpandableController();

    print('sendRequest()');
    homePageProvider.appIsolate.executeAllIsolate(homePageProvider);
  }

  void test() {
    expandableController.toggle();
    Future.delayed(const Duration(seconds: 4)).whenComplete(() {
      expandableController.toggle();
    });
  }

  void sliderOnChange(double value) {
    final homePageProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    homePageProvider.setThreadCurrentValue(value);
  }

  @override
  Widget build(BuildContext context) {
    final homePageProvider = Provider.of<HomePageProvider>(context);
    return ExpandableNotifier(
        controller: expandableController,
        child: ScrollOnExpand(
            child: Expandable(
                collapsed: Row(
                  children: [
                    Expanded(
                        child: Card(
                      elevation: 5,
                      child: Padding(
                          padding: const EdgeInsets.all(9),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Processing..."),
                                  CircularProgressIndicator()
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(children: [
                                Expanded(
                                    child: FloatingActionButton.extended(
                                        onPressed: () {
                                          expandableController.toggle();
                                          homePageProvider.appIsolate
                                              .removeAllIsolate(
                                                  homePageProvider);
                                          homePageProvider.appIsolate.threads =
                                              {};
                                        },
                                        icon: const Icon(Icons.cancel),
                                        label: const Text("Batalkan")))
                              ])
                            ],
                          )),
                    ))
                  ],
                ),
                expanded: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            TextField(
                              enabled: _allSets ? false : true,
                              controller: token,
                              decoration: const InputDecoration(
                                  label: Text(
                                    "token",
                                    textAlign: TextAlign.start,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              enabled: _allSets ? false : true,
                              keyboardType: TextInputType.number,
                              controller: chatId,
                              decoration: const InputDecoration(
                                  label: Text(
                                    "chat_id",
                                    textAlign: TextAlign.start,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              enabled: _allSets ? false : true,
                              minLines: 5,
                              maxLines: 5,
                              controller: text,
                              decoration: const InputDecoration(
                                  label: Text(
                                    "text",
                                    textAlign: TextAlign.start,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8)))),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Card(
                                    elevation: 5,
                                    child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Text("Jumlah thread ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)))),
                                Card(
                                    elevation: 5,
                                    child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                            homePageProvider.threadCurrentValue
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400))))
                              ],
                            ),
                            const SizedBox(height: 5),
                            Slider(
                                value: homePageProvider.threadCurrentValue
                                    .toDouble(),
                                divisions: 4,
                                onChanged: _allSets ? null : sliderOnChange,
                                min: 1,
                                label: homePageProvider.threadCurrentValue
                                    .toString(),
                                max: 5),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: _allSets
                                        ? null
                                        : () {
                                            if (token.text.length <= 34) {
                                              snackBar(
                                                  'Panjang token tidak sesuai');
                                            } else if (chatId.text.isEmpty) {
                                              snackBar(
                                                  'Masukan chat_id dengan benar!');
                                            } else if (text.text.isEmpty) {
                                              snackBar(
                                                  'Masukan pesan minimal 1 huruf');
                                            } else {
                                              _toggleAllSets();

                                              homePageProvider.prepare(
                                                  token.text,
                                                  chatId.text,
                                                  text.text);
                                            }
                                          },
                                    child: const Text("Simpan")),
                                ElevatedButton(
                                    onPressed: _allSets
                                        ? () {
                                            _toggleAllSets();
                                            homePageProvider.appIsolate
                                                .removeAllIsolate(
                                                    homePageProvider);
                                          }
                                        : null,
                                    child: const Text("Batalkan"))
                              ],
                            ),
                            const SizedBox(height: 20),
                            _allSets
                                ? Row(children: [
                                    Expanded(
                                        child: FloatingActionButton.extended(
                                            icon: const Icon(Icons.send),
                                            onPressed: () {
                                              sendRequest();
                                            },
                                            label: const Text("Eksekusi")))
                                  ])
                                : const Center()
                          ],
                        ))))));
  }
}
