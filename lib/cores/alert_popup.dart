import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AlertPopup {
  void alertMessageSucess(msg, BuildContext, context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: false,
      animType: AnimType.scale,
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
      title: 'ແຈ້ງເຕືອນ',
      desc: '$msg',
      btnOkColor: const Color(0xFF006FAE),
      btnOkOnPress: () {},
    ).show();
  }
}
