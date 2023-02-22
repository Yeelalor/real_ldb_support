// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:testflutter/cores/configs/http_config.dart';
import 'package:testflutter/cores/widgets/alert_popup.dart';
import 'package:testflutter/cores/widgets/loading_process.dart';
import '../../cores/widgets/ThemeContainer.dart';
import '../../cores/widgets/WrapTheme.dart';
import '../../cores/widgets/button_widget.dart';
import '../../model/result_model.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CheckMoney extends StatefulWidget {
  const CheckMoney({super.key});
  @override
  State<CheckMoney> createState() => _CheckMoneyState();
}

class _CheckMoneyState extends State<CheckMoney> {
  List<result_model> sumFeeResulttList = [];
  TextEditingController accountController = TextEditingController();
  String dateToday = DateFormat("dd-MM-yyyy").format(DateTime.now());
  String timeNow = DateFormat("HH:mm:ss").format(DateTime.now());
  var filterdata = [];
  bool textfieldEmpty = false;
  bool emptydata = false;
  String getError = "";
  @override
  void initState() {
    super.initState();
  }

  void onCheckCustomerSumFee() async {
    try {
      if (accountController.text != '') {
        sumFeeResulttList = [];
        LoadingProccess().LoadingProcess(context);
        final response = await Network().getData('ListSumFee');
        final body = json.decode(response.body);
        filterdata = body
            .where((body) => body['fromAccount'] == (accountController.text))
            .toList();
        setState(() {
          for (var i = 0; i < filterdata.length; i++) {
            sumFeeResulttList.add(result_model.fromJson(filterdata[i]));
          }
          textfieldEmpty = true;
          if (sumFeeResulttList.isEmpty) {
            AlertPopup().alertMessageWarning(
                'ບໍ່ພົບຂໍ້ມູນ, ກະລຸນາກວດເລກບັນຊີໃຫ້ຖຶກຕ້ອງ',
                BuildContext,
                context);
          }
          Navigator.of(context).pop();
        });
      } else {
        setState(() {
          emptydata = true;
        });
      }
    } catch (e) {
      Navigator.of(context).pop();
      AlertPopup().alertMessageError(e, BuildContext, context);
    }
  }

  void showToastCopy(String? amount) async {
    await Clipboard.setData(ClipboardData(
        text:
            "${(amount)?.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"));
    showTopSnackBar(
      context,
      const CustomSnackBar.success(
        message: "ຄັດລອກຂໍ້ມູນສຳເລັດ",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WrapTheme(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'ກວດວົງເງິນສະສົມ',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ThemeContainer(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Container(
                        child: Column(children: [
                          const Text(
                            "ເລກບັນຊີຜູ້ໃຊ້",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(16)
                              ],
                              keyboardType: TextInputType.number,
                              controller: accountController,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontFamily: 'NotoSans'),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15,
                                ),
                                hintText: '0302000410XXXX 16 ໂຕ ',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 186, 194, 199)),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.blue)),
                              )),
                          emptydata
                              ? const Text(
                                  'ກະລຸນາປ້ອນເລກບັນຊີ',
                                  style: TextStyle(color: Colors.red),
                                )
                              : (const Center()),
                        ]),
                      ),
                      sumFeeResulttList.isNotEmpty
                          ? (Container(
                              margin: const EdgeInsets.only(left: 0, right: 0),
                              alignment: Alignment.center,
                              child: showSumFeeWidget(),
                            ))
                          : const Center(),
                    ]),
                  ),
                ],
              )),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              color: Colors.white,
              child: ButtonWidget(
                  onPressed: onCheckCustomerSumFee, title: 'ຕໍ່ໄປ'))
        ],
        // ),
      ),
    ));
  }

  Widget showSumFeeWidget() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        const Divider(
          thickness: 1,
          indent: 2,
          endIndent: 0,
          color: Color.fromARGB(255, 230, 221, 221),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 0,
                  child: Text("ວັນທີ:",
                      style: TextStyle(fontSize: 18, fontFamily: 'NotoSans')),
                ),
                Expanded(
                  flex: 0,
                  child: Text(
                    "${dateToday} ${timeNow}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Row(children: [
                      InkWell(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.copy,
                              size: 18,
                              color: Colors.blue,
                            ),
                            Text(
                              "ຄັດລອກຂໍ້ມູນ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          ],
                        ),
                        onTap: () {
                          showToastCopy(sumFeeResulttList[0].amount);
                        },
                      )
                    ]),
                  ),
                ),
              ]),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Row(children: [
            const Expanded(
              flex: 2,
              child: Text(
                "ຍອດເງິນສະສົມ:",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  "${(sumFeeResulttList[0].amount)?.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} kip",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )),
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Row(children: const [
            Expanded(
              flex: 2,
              child: Text(
                "ຍອດເງິນທັງໝົດ:",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  "10,000,000 kip",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 37, 42, 46)),
                ))
          ]),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          thickness: 1,
          indent: 2,
          endIndent: 0,
          color: Color.fromARGB(255, 230, 221, 221),
        )
      ],
    );
  }
}
