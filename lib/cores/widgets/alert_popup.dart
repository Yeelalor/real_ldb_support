import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AlertPopup {
  void alertMessageSucess(msg, BuildContext, context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: 'ແຈ້ງເຕືອນ',
      desc: '$msg',
      btnOkColor: const Color(0xFF006FAE),
      btnOkOnPress: () {},
    ).show();
  }

  void alertMessageInfo(msg, BuildContext, context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: 'ແຈ້ງເຕືອນ',
      desc: '$msg',
      btnOkColor: const Color(0xFF006FAE),
      btnOkOnPress: () {},
    ).show();
  }

  void alertMessageError(msg, BuildContext, context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: 'ແຈ້ງເຕືອນ',
      desc: '$msg',
      btnOkColor: const Color(0xFF006FAE),
      btnOkOnPress: () {},
    ).show();
  }

  void alertMessageWarning(msg, BuildContext, context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      title: 'ແຈ້ງເຕືອນ',
      desc: '$msg',
      btnOkColor: const Color(0xFF006FAE),
      btnOkOnPress: () {},
    ).show();
  }

  void showSnackBar(context, msg) {
    final snackBar = SnackBar(
      content: Container(
          height: 35,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_sharp,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$msg',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          )),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
