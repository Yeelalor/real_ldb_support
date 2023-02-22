// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testflutter/cores/configs/http_config.dart';
import 'package:testflutter/cores/widgets/alert_popup.dart';
import 'package:testflutter/cores/widgets/loading_process.dart';
import 'package:testflutter/cores/widgets/text_field.dart';
import '../../../cores/widgets/ThemeContainer.dart';
import '../../../cores/widgets/WrapTheme.dart';
import '../../../cores/widgets/button_widget.dart';
import '../../../model/customer_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ChecktCustomerInfo extends StatefulWidget {
  const ChecktCustomerInfo({super.key});

  @override
  State<ChecktCustomerInfo> createState() => _ChecktCustomerInfoState();
}

class _ChecktCustomerInfoState extends State<ChecktCustomerInfo> {
  TextEditingController username = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController account_CIF = TextEditingController();
  bool checkTelephone = false;
  bool checkUsername = false;
  bool loadingCustomerData = false;
  bool emptyCustomerData = false;
  String dateToday = DateFormat("dd-MM-yyyy").format(DateTime.now());
  String timeNow = DateFormat("HH:mm:ss").format(DateTime.now());
  List<customer_model> customerList = [];
  @override
  void initState() {
    super.initState();
  }

  void oncheckCustomerInfo() async {
    try {
      if (account_CIF.text != '') {
        customerList = [];
        LoadingProccess().LoadingProcess(context);
        final data = {
          "account": account_CIF.text,
          "cif": account_CIF.text,
          "user": ""
        };
        String enData = json.encode(data);
        final response = await Network().postData(enData, 'getAccountDetail');
        final body = json.decode(response.body);
        setState(() {
          for (var i = 0; i < body.length; i++) {
            customerList.add(customer_model.fromJson(body[i]));
          }
          checkTelephone = false;
          Navigator.of(context).pop();
          if (customerList.isEmpty) {
            AlertPopup().alertMessageWarning(
                'ບໍ່ພົບຂໍ້ມູນ, ກະລຸນາກວດເລກບັນຊີ ຫຼື CIF ໃຫ້ຖຶກຕ້ອງ',
                BuildContext,
                context);
          }
        });
      } else {
        setState(() {
          checkTelephone = true;
        });
      }
    } on PlatformException catch (e) {
      AlertPopup().alertMessageError(e, BuildContext, context);
      Navigator.of(context).pop();
    }
  }

  void onCopyDateNumber(birthdate) async {
    await Clipboard.setData(ClipboardData(text: birthdate.toString()));
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
        title: const Text(
          "ກວດຂໍ້ມູນລູກຄ້າ",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ThemeContainer(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      const Text(
                        "ເລກບັນຊີ ຫຼື CIF",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                          controller: account_CIF,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'NotoSans'),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            hintText: '030200041000XXX 16 ຫືຼ 6 ໂຕ',
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 186, 194, 199)),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.blue)),
                          )),
                      TextFieldWidgets(
                        controller: account_CIF,
                        hintText: 'hintText',
                        align: 'center',
                      ),
                      checkTelephone
                          ? const Text(
                              'ກະລຸນາປ້ອນເລກບັນຊີ ຫຼື CIF',
                              style: TextStyle(color: Colors.red),
                            )
                          : (const Text('')),
                    ]),
                  ),
                  (customerList.isNotEmpty
                      ? Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: customerWidgets,
                          ),
                        )
                      : const Text("")),
                ],
              )),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            color: Colors.white,
            child: ButtonWidget(onPressed: oncheckCustomerInfo, title: 'ຕໍ່ໄປ'),
          ),
        ],
        // )
      ),
    ));
  }

  List<Widget> get customerWidgets {
    return [
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: customerList.length,
        itemBuilder: (context, index) {
          return (Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  color: const Color.fromARGB(255, 214, 222, 226),
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 5, right: 5),
                  alignment: Alignment.center,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                                "0${index + 1} ${customerList[index].ccy}",
                                style: const TextStyle(fontSize: 18)),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Row(children: [
                                InkWell(
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.copy,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        "ຄັດລອກຂໍ້ມູນ",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    onCopyDateNumber(
                                        customerList[index].birdth);
                                  },
                                )
                              ]),
                            ),
                          ),
                        ),
                        // ]),
                        // ),
                      ]),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "CIF",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Text(
                          "${customerList[index].cif}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        )),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Acc No",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Text(
                          "${customerList[index].account}",
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        )),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    const Expanded(
                      child: Text(
                        "Acc Name",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${customerList[index].name1}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 37, 42, 46)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    const Expanded(
                      child: Text(
                        "Acc Name2",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${customerList[index].name2}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 37, 42, 46)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Birth date",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Container(
                          child: Row(
                            children: [
                              customerList[index].birdth == null
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            "${customerList[index].birdth}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    255, 37, 42, 46)),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      child: Row(children: [
                                        Text(
                                          "${customerList[index].birdth.toString().substring(0, 4)}/${customerList[index].birdth.toString().substring(4, 6)}/${customerList[index].birdth.toString().substring(6, 8)}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 37, 42, 46)),
                                        ),
                                      ]),
                                    ),
                            ],
                          ),
                        )),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Mobile No",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: Text(
                          "${customerList[index].mobileNo}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 37, 42, 46)),
                        )),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Status",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    Expanded(
                        flex: 0,
                        child: customerList[index].accountStatus == null
                            ? const Text(
                                "Active",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 37, 42, 46)),
                              )
                            : const Text(
                                "Inactive",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                  ]),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ));
        },
      ),
    ];
  }
}
