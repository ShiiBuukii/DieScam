import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                  children: [
                const TextSpan(
                  text: "Aplikasi ini membutuhkan ",
                ),
                TextSpan(
                    text: "koneksi Internet ",
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                const TextSpan(text: "yang "),
                TextSpan(
                    text: "Stabil.",
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                const TextSpan(text: " Karena aplikasi ini akan mengirim "),
                TextSpan(
                    text: "Permintaan",
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                const TextSpan(text: " berulang "),
                const TextSpan(text: " dengan jumlah "),
                TextSpan(
                    text: "Thread.",
                    style: TextStyle(color: Theme.of(context).primaryColor)),
              ]))),
    );
  }
}
