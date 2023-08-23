import 'dart:io';

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
    required this.pathsToPictures,
  });

  final String text;
  final String reminderTime;
  final void Function() onTap;
  final List<String> pathsToPictures;

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
                text.isNotEmpty ? Text(
                  text,
                  style: MainStyles.kBlackColor1W500(20.0),
                ) : const SizedBox(),
                pathsToPictures.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: SizedBox(
                          height: 100.0,
                          child: Row(
                            children: pathsToPictures.map((element) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6.0),
                                    child: Image.file(
                                      File(element),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : const SizedBox(),
                reminderTime != ''
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          Strings.reminder + reminderTime,
                          style: MainStyles.kBlackColor1W500(16.0),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
