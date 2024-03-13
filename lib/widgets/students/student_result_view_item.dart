import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/app_colors.dart';

class StudentResultViewItem extends StatefulWidget {
  final String subject;
  final String grade;
  const StudentResultViewItem({super.key,required this.subject,required this.grade});

  @override
  State<StudentResultViewItem> createState() => _StudentResultViewItemState();
}

class _StudentResultViewItemState extends State<StudentResultViewItem> {
   @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.buttonColorDark, // Set border color here
          width: 1, // Set border width here
        ),
      ),
      height: 60,
      padding: const EdgeInsets.fromLTRB(19, 5, 19, 5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.subject,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            width: 38,
            height: 38,
        alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: AppColors.buttonColorDark),
            child: Text(
              widget.grade,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),
       
        ],
      ),
    );
  }

}