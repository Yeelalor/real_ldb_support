import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/cores/alert_popup.dart';
import 'package:testflutter/cores/loading_process.dart';
import 'package:testflutter/widgets/ThemeContainer.dart';
import 'package:testflutter/widgets/WrapTheme.dart';
import '../model/customer_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../EndPoint/end_point.dart';
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
  List<customer_model> Customer_list = [];
  @override
  void initState() {
    super.initState();
  }

  // ignore: non_constant_identifier_names
  void OnhandleOTP() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      if (account_CIF.text != '') {
        // ignore: use_build_context_synchronously
        LoadingProccess().LoadingProcess(context);
        final queryParameters = {
          "account": account_CIF.text,
          "cif": account_CIF.text,
          "user": ""
        };
        String params = json.encode(queryParameters);
        final uri = Uri.parse('$END_POINT/getAccountDetail');
        final response = await http.post(uri,
            headers: {
              'Content-type': 'application/json',
              'Authorization': 'Bearer ${localStorage.getString('localToken')}'
            },
            body: params);
        final body = json.decode(response.body);
        List<customer_model> _Customer_list = [];
        for (var i = 0; i < body.length; i++) {
          _Customer_list.add(customer_model.fromJson(body[i]));
        }
        setState(() {
          Customer_list = _Customer_list;
          checkTelephone = false;
          Navigator.of(context).pop();
          if (Customer_list.isEmpty) {
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
    } catch (e) {
      AlertPopup().alertMessageError(e, BuildContext, context);
    }
  }

  void CopyBirthDateNumber(birthdate) async {
    await Clipboard.setData(ClipboardData(text: birthdate.toString()));
    showTopSnackBar(
      context,
      CustomSnackBar.success(
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
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 10),
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
                      checkTelephone
                          ? const Text(
                              'ກະລຸນາປ້ອນເລກບັນຊີ ຫຼື CIF',
                              style: TextStyle(color: Colors.red),
                            )
                          : (const Text('')),
                    ]),
                  ),
                  (Customer_list.isNotEmpty
                      ? Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: CustomerWidgets,
                          ),
                        )
                      : const Text("")),
                ],
              )),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: const Color(0xFF006FAD),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              minimumSize: const Size.fromHeight(55),
            ),
            onPressed: () {
              OnhandleOTP();
            },
            child: const Text(
              'ຕໍ່ໄປ',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
        // )
      ),
    ));
  }

  List<Widget> get CustomerWidgets {
    return [
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Customer_list.length,
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
                                "0${index + 1} ${Customer_list[index].ccy}",
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
                                    CopyBirthDateNumber(
                                        Customer_list[index].birdth);
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
                const SizedBox(
                  height: 10,
                ),
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
                          "${Customer_list[index].cif}",
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
                          "${Customer_list[index].account}",
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
                              "${Customer_list[index].name1}",
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
                              "${Customer_list[index].name2}",
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
                              Customer_list[index].birdth == null
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            "${Customer_list[index].birdth}",
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
                                          "${Customer_list[index].birdth.toString().substring(0, 4)}/${Customer_list[index].birdth.toString().substring(4, 6)}/${Customer_list[index].birdth.toString().substring(6, 8)}",
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
                          "${Customer_list[index].mobileNo}",
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
                        child: Customer_list[index].accountStatus == null
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
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ));
        },
      ),
    ];
  }
}
