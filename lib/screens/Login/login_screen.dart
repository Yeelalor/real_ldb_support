// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/cores/configs/http_config.dart';
import 'package:testflutter/cores/widgets/alert_popup.dart';
import 'package:testflutter/cores/widgets/loading_process.dart';
import '../home/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController staffID = TextEditingController();
  final TextEditingController staffPassword = TextEditingController();
  final String localStaff = "";
  bool emptyStaffID = false;
  bool emptyPassword = false;
  bool showPassword = false;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    getdata();
    Network().getAuthToken();
  }

  void onLogin() async {
    try {
      if (staffID.text != '' && staffPassword.text != '') {
        var checkNetwork = await Connectivity().checkConnectivity();
        if (checkNetwork == ConnectivityResult.none) {
          AlertPopup().alertMessageWarning(
              'ກະລຸນາກວດການເຊື່ອມຕໍ່ອີນເຕີເນັດຂອງທ່ານ', BuildContext, context);
        } else {
          final String employeeId = staffID.text;
          LoadingProccess().LoadingProcess(context);
          final params = {
            "username": staffID.text,
            "password": staffPassword.text
          };
          String data = json.encode(params);
          final uri = Uri.parse(
              'https://vehome.ldblao.la/ldb/api/v1/hr-uat/auth/login');
          final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
          final response = await http.post(uri, headers: headers, body: data);
          if (response.statusCode == 200) {
            Navigator.of(context).pop();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => MyHomePage(value: employeeId)),
                (route) => false);
            storedata();
          } else {
            Navigator.of(context).pop();
            AlertPopup().alertMessageWarning(
                'ໄອດີ ຫຼື ລະຫັດຜ່ານບໍ່ຖຶກຕ້ອງ', BuildContext, context);
          }
        }
      } else {
        AlertPopup().alertMessageWarning(
            'ກະລຸນາປ້ອນຂໍ້ມູນໃຫ້ຄົບ', BuildContext, context);
      }
    } on PlatformException catch (e) {
      AlertPopup().alertMessageError(e, BuildContext, context);
    }
  }

  void showhidePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void getdata() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('localStaffID') != null) {
      final String? ID = prefs.getString('localStaffID');
      final String? Pass = prefs.getString('localPassword');
      setState(() {
        isChecked = true;
        staffID.text = ID!;
        staffPassword.text = Pass!;
      });
    } else {
      setState(() {
        isChecked = false;
      });
    }
  }

  void storedata() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('localStaffID', staffID.text);
    await prefs.setString('localPassword', staffPassword.text);
  }

  void removedata() async {
    final prefs = await SharedPreferences.getInstance();
    final removeID = await prefs.remove('localStaffID');
    final removePass = await prefs.remove('localPassword');
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };

      return Color.fromARGB(255, 226, 233, 237);
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/backgrounds/home.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24.0),
                        child: Image.asset(
                          "assets/logos/logo w ldb.png",
                          height: 90.0,
                          width: 90.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "LDB Support",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: const [
                            Text(
                              "ໃຊ້ລະຫັດພະນັກງານ",
                              style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: staffID,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: 'NotoSans'),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person,
                              color: Color.fromARGB(255, 141, 133, 133)),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          hintText: 'ໄອດີພະນັກງານ',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 186, 194, 199)),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF3C98CE))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFF3C98CE))),
                        ),
                      ),
                      emptyStaffID
                          ? const Text(
                              "ກະລຸນາປ້ອນໄອດີພະນັກງານ",
                              style: TextStyle(
                                  fontFamily: 'NotoSans', color: Colors.white),
                            )
                          : const Text(
                              "",
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                          obscureText: showPassword ? false : true,
                          controller: staffPassword,
                          style: const TextStyle(
                              fontSize: 20, fontFamily: 'NotoSans'),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 141, 133, 133),
                            ),
                            suffixIcon: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color.fromARGB(
                                          255, 141, 133, 133),
                                    ),
                                    onPressed: showhidePassword),
                              ],
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                            ),
                            hintText: 'ລະຫັດຜ່ານ',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 186, 194, 199)),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFF3C98CE))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xFF3C98CE))),
                          )),
                      emptyPassword
                          ? const Text(
                              "ກະລຸນາປ້ອນລະຫັດຜ່ານ",
                              style: TextStyle(
                                  fontFamily: 'NotoSans', color: Colors.white),
                            )
                          : const Text(
                              "",
                            ),
                      const SizedBox(
                        height: 0,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Row(children: [
                          InkWell(
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: const Color(0xFF3C98CE),
                                  activeColor: const Color(0xFF3C98CE),
                                  fillColor: MaterialStateProperty.resolveWith(
                                      getColor),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                const Text(
                                  "ຈື່ໄອດີ ແລະ ລະຫັດຜ່ານໄວ້",
                                  style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            onTap: () {},
                          )
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // primary: const Color(0xFF006FAD),
                          elevation: 0,
                          primary: Color(0xFF3C98CE),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          minimumSize: Size.fromHeight(45), //////// HERE
                        ),
                        onPressed: () {
                          onLogin();
                        },
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.asset(
                                    "assets/logos/ldbLogin.JPG",
                                    height: 30.0,
                                    width: 30.0,
                                  ),
                                ),
                              ),
                              const Expanded(
                                  flex: 0,
                                  child: Text(
                                    "ເຂົ້າສູ່ລະບົບ",
                                    style: TextStyle(
                                        fontFamily: 'NotoSans', fontSize: 18),
                                  )),
                              const Expanded(
                                  flex: 0,
                                  child: Icon(
                                    Icons.east,
                                    size: 20,
                                    color: Colors.white,
                                  ))
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
