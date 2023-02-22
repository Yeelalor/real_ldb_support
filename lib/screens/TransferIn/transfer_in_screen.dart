import 'package:flutter/material.dart';

import '../../cores/widgets/ThemeContainer.dart';
import '../../cores/widgets/WrapTheme.dart';
import '../../cores/widgets/button_widget.dart';

class CheckTransferIn extends StatefulWidget {
  const CheckTransferIn({super.key});

  @override
  State<CheckTransferIn> createState() => _CheckTransferInState();
}

class _CheckTransferInState extends State<CheckTransferIn> {
  @override
  Widget build(BuildContext context) {
    return WrapTheme(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('ກວດໂອນເງິນພາຍໃນ'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ThemeContainer(
              child: SingleChildScrollView(
                child: Column(
                  children: [Text('test')],
                ),
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              color: Colors.white,
              child: ButtonWidget(onPressed: () {}, title: 'ຕໍ່ໄປ'))
        ],
      ),
    ));
  }
}
