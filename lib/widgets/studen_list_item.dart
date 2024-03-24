import 'package:flutter/material.dart';
import 'package:result_ease/screen/lecture/result_view.dart';

import '../utils/app_colors.dart';

class StudenListItem extends StatefulWidget {
  final String name;
  final String indexNo;
  const StudenListItem({super.key, required this.name, required this.indexNo});

  @override
  State<StudenListItem> createState() => _StudenListItemState();
}

class _StudenListItemState extends State<StudenListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another screen here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultView()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding:const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.buttonColorDark, // Set border color here
            width: 1, // Set border width here
          ),
        ),
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/student.png",
              width: 41,
              height: 30,
              scale: 0.75,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                   Text(
                      widget.indexNo,
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
