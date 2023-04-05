import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../CustomerInfo/pages/customer_info_screen.dart';
import '../EDL/EDL_screen.dart';
import '../FillMoney/fill_money_screen.dart';
import '../OTP/otp_screen.dart';
import '../SumFee/sumfee_screen.dart';
import '../TransactionFailed/tsn_failed_screen.dart';
import '../TransactionSuccess/tsn_success_screen.dart';
import '../TransferIn/transfer_in_screen.dart';
import '../TransferOtherBank/tsn_other_bank_screen.dart';
import '../Waters/payment_water_screen.dart';

class MenuListItem {
  final String title;
  final String icon;
  final String route;

  const MenuListItem(
      {required this.title, required this.icon, required this.route});
}

class HomePage extends StatefulWidget {
  final String value;
  const HomePage({Key? key, required this.value});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime prebackpress = DateTime.now();
  final List listFeatures = [
    {
      'name': 'OTP',
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
      'name': 'ຂ້າມທະນາຄານ',
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
        appBar: AppBar(
          title: Row(children: [
            Image.asset(
              "assets/logos/logo w ldb.png",
              width: 40,
              height: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Text('ID: ${widget.value}')
          ]),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.power_settings_new,
                size: 40,
                color: Colors.white,
              ),
              tooltip: 'Increase volume by 10',
              onPressed: () => exit(0),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            final timegap = DateTime.now().difference(prebackpress);
            final cantExit = timegap >= const Duration(seconds: 2);
            prebackpress = DateTime.now();
            if (cantExit) {
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
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 20),
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
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white, endIndent: 10, indent: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3 / 2.2,
                  ),
                  itemCount: listFeatures.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
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
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "${listFeatures[index]['icon']}",
                                  width: 60,
                                  height: 60,
                                ),
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Divider(color: Colors.white, endIndent: 10, indent: 20),
              ],
            ),
          ),
        ));
  }
}
