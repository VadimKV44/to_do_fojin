import 'package:flutter/material.dart';
import 'package:to_do_fojin/consts/colors.dart';
import 'package:to_do_fojin/consts/strings.dart';
import 'package:to_do_fojin/consts/styles.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.text,
    required this.reminderTime,
    required this.onTap,
  });

  final String text;
  final String reminderTime;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: MainColors.kWhiteColor1,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: MainColors.kGreyColor1.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: MainStyles.kBlackColor1W500(20.0),
                ),
                reminderTime != '' ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    Strings.reminder + reminderTime,
                    style: MainStyles.kBlackColor1W500(16.0),
                  ),
                ) : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
