import 'package:flutter/material.dart';
import 'package:result_ease/screen/lecture/edite_result.dart';
import '../utils/app_colors.dart';

class ResultViewItem extends StatefulWidget {
  final String subject;
  final String grade;
 final Function(String) onTap;// Changed the type to VoidCallback
  const ResultViewItem({
    Key? key,
    required this.subject,
    required this.grade,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ResultViewItem> createState() => _ResultViewItemState();
}

class _ResultViewItemState extends State<ResultViewItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.buttonColorDark,
          width: 1,
        ),
      ),
      height: 60,
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.buttonColorDark,
            ),
            child: Text(
              widget.grade,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                widget.onTap(widget.subject); // Invoke the callback function with subject
              },
              child: const Icon(Icons.edit, color: AppColors.buttonColorDark),
            ),
          ),
        ],
      ),
    );
  }
}
