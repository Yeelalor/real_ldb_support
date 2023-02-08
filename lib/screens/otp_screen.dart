// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:testflutter/cores/alert_popup.dart';
import 'package:testflutter/cores/loading_process.dart';
import 'package:testflutter/widgets/ThemeContainer.dart';
import 'package:testflutter/widgets/WrapTheme.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/check_otp_model.dart';
import '../EndPoint/end_point.dart';

class CheckOTP extends StatefulWidget {
  const CheckOTP({super.key});
  @override
  State<CheckOTP> createState() => _CheckOTPState();
}

class _CheckOTPState extends State<CheckOTP> {
  TextEditingController username = TextEditingController();
  TextEditingController telephone = TextEditingController();
  bool checkTelephone = false;
  bool loadingOTP = false;
  bool emptyOTPData = false;
  String dateToday = DateFormat("dd-MM-yyyy").format(DateTime.now());
  String timeNow = DateFormat("HH:mm:ss").format(DateTime.now());
  List<check_otp_model> OTP_list = [];
  late AnimationController localAnimationController;

  @override
  void initState() {
    super.initState();
  }

  DeleteAuthtoken() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('localToken');
    print("success: ${success}");
  }

  // ignore: non_constant_identifier_names
  // void Timeout() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   final queryParameters = {
  //     "user": 'user',
  //     "mobileNo": telephone.text,
  //   };
  //   String params = json.encode(queryParameters);
  //   try {
  //     final uri = Uri.parse('$END_POINT/getOTP');
  //     final response = await http
  //         .post(uri,
  //             headers: {
  //               'Content-type': 'application/json',
  //               'Authorization':
  //                   'Bearer ${localStorage.getString('localToken')}',
  //             },
  //             body: params)
  //         .timeout(const Duration(seconds: 10));
  //     final body = json.decode(response.body);
  //     print("Result: $body");
  //     Navigator.of(context).pop();
  //   } on TimeoutException catch (e) {
  //     Navigator.of(context).pop();
  //     print("Timeout reason: $e");
  //   }
  // }

  void OnhandleOTP() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var body = [];
      if (telephone.text != '') {
        LoadingProccess().LoadingProcess(context);
        final queryParameters = {
          "user": 'user',
          "mobileNo": telephone.text,
        };
        String params = json.encode(queryParameters);
        final uri = Uri.parse('$END_POINT/getOTP');
        final response = await http.post(uri,
            headers: {
              'Content-type': 'application/json',
              'Authorization': 'Bearer ${localStorage.getString('localToken')}',
            },
            body: params);
        final body = json.decode(response.body);

        List<check_otp_model> _OTP_list = [];
        for (var i = 0; i < body.length; i++) {
          _OTP_list.add(check_otp_model.fromJson(body[i]));
        }
        Navigator.of(context).pop();
        setState(() {
          OTP_list = _OTP_list;
          checkTelephone = false;
          if (OTP_list.isEmpty) {
            AlertPopup().alertMessageWarning(
                'ບໍ່ພົບຂໍ້ມູນ, ກະລຸນາກວດເບີໂທຂອງທ່ານໃຫ້ຖຶກຕ້ອງ',
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

  void CopyOTPNumber(message) async {
    await Clipboard.setData(ClipboardData(text: message.toString()));
    // ignore: use_build_context_synchronously
    showTopSnackBar(
        context,
        const CustomSnackBar.success(
          message: "ຄັດລອກຂໍ້ມູນສຳເລັດ",
        ),
        dismissType: DismissType.none,
        dismissDirection: DismissDirection.endToStart);
  }

  @override
  Widget build(BuildContext context) {
    return WrapTheme(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "ກວດ SMS OTP",
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
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20.0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: [
                        const Text(
                          "ເບີໂທລະສັບ",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            controller: telephone,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20, fontFamily: 'NotoSans'),
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
                              hintText: '20XXXXXXXX 10 ໂຕ',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 186, 194, 199)),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.blue)),
                            )),
                        checkTelephone
                            ? const Text(
                                'ກະລຸນາປ້ອນເບີໂທລະສັບ',
                                style: TextStyle(color: Colors.red),
                              )
                            : (const Text('')),
                      ]),
                    ),
                    OTP_list.isNotEmpty
                        ? (Container(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: OTP_list.length,
                                            itemBuilder: (context, index) {
                                              return (Container(
                                                color: index % 2 == 0
                                                    ? const Color.fromARGB(
                                                        255, 225, 229, 231)
                                                    : const Color.fromARGB(
                                                        255, 246, 252, 255),
                                                alignment: Alignment.center,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20.0,
                                                              right: 20.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Expanded(
                                                              flex: 0,
                                                              child: Text(
                                                                  "ວັນທີ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontFamily:
                                                                          'NotoSans')),
                                                            ),
                                                            Expanded(
                                                              flex: 0,
                                                              child: Text(
                                                                "${OTP_list[index].date}",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 0,
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Row(
                                                                    children: [
                                                                      InkWell(
                                                                        child:
                                                                            Row(
                                                                          children: const [
                                                                            Icon(
                                                                              Icons.copy,
                                                                              size: 20,
                                                                              color: Colors.blue,
                                                                            ),
                                                                            Text(
                                                                              "ຄັດລອກຂໍ້ມູນ",
                                                                              style: TextStyle(fontSize: 16, color: Colors.blue),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          CopyOTPNumber(
                                                                              OTP_list[index].message);
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
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20.0,
                                                              right: 0.0),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(children: [
                                                        const Expanded(
                                                          flex: 0,
                                                          child: Text(
                                                            "ເບີໂທ",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'NotoSans',
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        const Expanded(
                                                          flex: 0,
                                                          child: SizedBox(
                                                            width: 20,
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 0,
                                                            child: Text(
                                                              "${OTP_list[index].mobileNo}",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'NotoSans',
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black),
                                                            )),
                                                      ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20.0,
                                                              right: 20.0),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Expanded(
                                                              child: Text(
                                                                "Text",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'NotoSans',
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                flex: 5,
                                                                child: Text(
                                                                  "${OTP_list[index].message}",
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'NotoSans',
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          37,
                                                                          42,
                                                                          46)),
                                                                )),
                                                          ]),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    )
                                                  ],
                                                ),
                                              ));
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                        : const Text(""),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              // primary: const Color(0xFF006FAD),
              elevation: 0,
              primary: const Color(0xFF006FAD),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              minimumSize: const Size.fromHeight(55), //////// HERE
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
      ),
    ));
  }
}
