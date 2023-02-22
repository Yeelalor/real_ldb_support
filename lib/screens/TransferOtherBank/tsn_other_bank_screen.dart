import 'package:flutter/material.dart';

import '../../cores/widgets/ThemeContainer.dart';
import '../../cores/widgets/WrapTheme.dart';
import '../../cores/widgets/button_widget.dart';

class CheckOtherBank extends StatefulWidget {
  const CheckOtherBank({super.key});

  @override
  State<CheckOtherBank> createState() => _CheckOtherBankState();
}

class _CheckOtherBankState extends State<CheckOtherBank> {
  @override
  Widget build(BuildContext context) {
    return WrapTheme(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('ກວດໂອນເງິນຂ້າມທະນາຄານ'),
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
