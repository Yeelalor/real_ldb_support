// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidgets extends StatelessWidget {
  const TextFieldWidgets({
    Key? key,
    required this.controller,
    required this.hintText,
    this.sufFixIcon,
    this.preFixIcon,
    this.isShowPrefixIcon = false,
    this.isShowSuffixIcon = false,
    this.obscureText = false,
    this.number = false,
    this.phone = false,
    this.align = '',
    this.toggleShowPassword,
    this.onChange,
    this.prefixtext = '',
    this.label = '',
    this.onlyNumber = false,
    this.autofocus = false,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final IconData? sufFixIcon;
  final IconData? preFixIcon;
  final bool obscureText;
  final bool isShowPrefixIcon;
  final bool isShowSuffixIcon;
  final String align;
  final bool number;
  final VoidCallback? toggleShowPassword;
  final void Function(String)? onChange;
  final String prefixtext;
  final String label;
  final bool onlyNumber;
  final bool autofocus;
  final bool phone;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
        TextField(
          inputFormatters: onlyNumber ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))] : [],
          
          keyboardType: number
              ? TextInputType.number
              : phone
                  ? TextInputType.phone
                  : TextInputType.text,
          controller: controller,
          obscureText: obscureText,
          autofocus: autofocus,
          cursorColor: const Color(0xFF2171A1),
          style: const TextStyle(
            fontSize: 20,
          ),
          textAlign: align == 'center'
              ? TextAlign.center
              : align == 'right'
                  ? TextAlign.right
                  : TextAlign.left,
          onChanged: onChange,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            hintText: hintText,
            prefixText: prefixtext != '' ? prefixtext : null,
            prefixIcon:
                isShowPrefixIcon ? Icon(preFixIcon, color: Colors.grey) : null,
            suffixIcon: isShowSuffixIcon
                ? IconButton(
                    icon: Icon(
                      sufFixIcon,
                      size: 20.0,
                      color: Colors.grey,
                    ),
                    onPressed: toggleShowPassword,
                  )
                : null,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.red)),
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        )
      ],
    );
  }
}
