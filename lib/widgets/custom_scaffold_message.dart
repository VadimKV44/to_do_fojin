import 'package:flutter/material.dart';
import 'package:to_do_fojin/consts/colors.dart';
import 'package:to_do_fojin/consts/strings.dart';
import 'package:to_do_fojin/consts/styles.dart';

void showCustomScaffoldMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1200),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 40.0),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: MainColors.kWhiteColor1,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: MainColors.kBlackColor1.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Text(
              Strings.screenRotationDisable,
              textAlign: TextAlign.center,
              style: MainStyles.kBlackColor1W500(20.0),
            ),
          ),
        ],
      ),
    ),
  );
}