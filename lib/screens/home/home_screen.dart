import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:testflutter/screens/FillMoney/fill_money_screen.dart';
import 'package:testflutter/screens/CustomerInfo/pages/customer_info_screen.dart';
import 'package:testflutter/screens/SumFee/sumfee_screen.dart';
import 'package:testflutter/screens/Waters/payment_water_screen.dart';
import 'package:testflutter/screens/EDL/EDL_screen.dart';
import 'package:testflutter/screens/TransferIn/transfer_in_screen.dart';
import 'package:testflutter/screens/TransactionFailed/tsn_failed_screen.dart';
import 'package:testflutter/screens/TransferOtherBank/tsn_other_bank_screen.dart';
import 'package:testflutter/screens/TransactionSuccess/tsn_success_screen.dart';
import '../OTP/otp_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyHomePage extends StatefulWidget {
  final String value;
  const MyHomePage({super.key, required this.value});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String localID = "";
  final String _localID = "";
  late DateTime currentBackPressTime;
  // ignore: unused_field
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // ignore: unused_field

  @override
  void initState() {
    super.initState();
  }

  void showSnackbar() {
    final snackBar = SnackBar(
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }

  DateTime prebackpress = DateTime.now();
  final List listFeatures = [
    {
      'name': 'SMS OTP',
      'icon': 'assets/icons/Frame 45.png',
      'link': const CheckOTP()
    },
    {
      'name': 'ຂໍ້ມູນລູກຄ້າ',
      'icon': 'assets/icons/Frame 46.png',
      'link': const ChecktCustomerInfo()
    },
    {
      'name': 'ວົງເງິນສະສົມ',
      'icon': 'assets/icons/Frame 47.png',
      'link': const CheckMoney()
    },
    {
      'name': 'ທຸລະກຳສຳເລັດ',
      'icon': 'assets/icons/success.png',
      'link': const CheckSuccess()
    },
    {
      'name': 'ທຸລະກຳບໍ່ສຳເລັດ',
      'icon': 'assets/icons/failed.png',
      'link': const CheckFailed()
    },
    // {
    //   'name': 'ກວດທຸລະກຳອື່ນໆ',
    //   'icon': 'assets/icons/Transfer.png',
    //   'link': '/five'
    // },
    {
      'name': 'ໂອນເງິນພາຍໃນ',
      'icon': 'assets/icons/Transfer.png',
      'link': const CheckTransferIn()
    },

    {
      'name': 'ຈ່າຍຄ່ານໍ້າ',
      'icon': 'assets/icons/water.png',
      'link': const CheckPayWater()
    },
    {
      'name': 'ໂອນເງິນຂ້າມທະນາຄານ',
      'icon': 'assets/icons/Transfer.png',
      'link': const CheckOtherBank()
    },
    {
      'name': 'ຈ່າຍຄ່າໄຟ',
      'icon': 'assets/icons/EDL.png',
      'link': const CheckPayElectrity()
    },

    {
      'name': 'ຕື່ມເງິນ',
      'icon': 'assets/icons/Refill money.png',
      'link': const CheckAddMoney()
    },

    //
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(prebackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        prebackpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          const snack = SnackBar(
            content: Text(
              'ກົດອີກຄັ້ງເພື່ອອອກຈາກລະບົບ',
              style: TextStyle(fontSize: 18),
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Menu bar
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.person,
                          size: 50,
                          color: Color.fromARGB(255, 223, 229, 232),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "ສະບາຍດີ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Text(
                                "ID: ${widget.value}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(0),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                            icon: const Icon(
                              Icons.power_settings_new,
                              size: 30,
                              color: Colors.white,
                            ),
                            tooltip: 'Increase volume by 10',
                            onPressed: () => exit(0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //  ທຸລະກຳ

            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: 4,
                                height: 30,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromARGB(255, 67, 179, 227),
                                        Color.fromARGB(255, 67, 179, 227),
                                      ]),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "ກວດທຸລະກຳ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 0.3,
                          indent: 0,
                          endIndent: 0,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listFeatures.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, '${listFeatures[index]['link']}');
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: listFeatures[index]['link'],
                                inheritTheme: true,
                                ctx: context,
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Center(
                                child: Image.asset(
                                  "${listFeatures[index]['icon']}",
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                              // const SizedBox(height: 8),
                              Center(
                                child: AutoSizeText(
                                  listFeatures[index]['name'],
                                  minFontSize: 16,
                                  maxLines: 2,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            )),

            // Tap menu two
          ],
        ),
      ),
    ));
  }
}
