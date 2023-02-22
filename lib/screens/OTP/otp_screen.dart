// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:testflutter/cores/configs/http_config.dart';
import 'package:testflutter/cores/widgets/alert_popup.dart';
import 'package:testflutter/cores/widgets/loading_process.dart';
import '../../cores/widgets/ThemeContainer.dart';
import '../../cores/widgets/WrapTheme.dart';
import '../../cores/widgets/button_widget.dart';
import '../../model/check_otp_model.dart';

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

  void onCheckOtp() async {
    try {
      if (telephone.text != '') {
        OTP_list = [];
        LoadingProccess().LoadingProcess(context);
        final data = {
          "user": 'user',
          "mobileNo": telephone.text,
        };
        String enData = json.encode(data);
        final response = await Network().postData(enData, 'getOTP');
        final body = json.decode(response.body);
        Navigator.of(context).pop();
        setState(() {
          for (var i = 0; i < body.length; i++) {
            OTP_list.add(check_otp_model.fromJson(body[i]));
          }
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
    } on PlatformException catch (e) {
      AlertPopup().alertMessageError(e, BuildContext, context);
      Navigator.of(context).pop();
    }
  }

  void onCopyOTPNumber(message) async {
    await Clipboard.setData(ClipboardData(text: message.toString()));
    AlertPopup().showSnackBar(context, 'ສຳເລັດ');
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
              child: Scrollbar(
                  child: Scrollbar(
                radius: const Radius.circular(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
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
                              // autofocus: true,
                              controller: telephone,
                              keyboardType: TextInputType.phone,
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
                                      BorderSide(width: 1, color: Colors.blue),
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.red)),
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
                                          const SizedBox(height: 15),
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
                                                          height: 20),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
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
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 0,
                                                                child:
                                                                    Container(
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
                                                                            onCopyOTPNumber(OTP_list[index].message);
                                                                          },
                                                                        )
                                                                      ]),
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
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
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .black),
                                                              )),
                                                        ]),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Container(
                                                        margin: const EdgeInsets
                                                                .only(
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
                                                      const SizedBox(height: 20)
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
                          : const Center(),
                    ],
                  ),
                ),
              )),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            color: Colors.white,
            child: ButtonWidget(
                onPressed: () {
                  onCheckOtp();
                },
                title: 'ຕໍ່ໄປ'),
          ),
        ],
      ),
    ));
  }
}
