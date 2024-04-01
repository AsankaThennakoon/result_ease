import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:result_ease/models/results.dart';
import 'package:result_ease/screen/student/student_result_view.dart';

import '../../utils/app_colors.dart';

class HomeListItem extends StatefulWidget {
  final Results semester;
  const HomeListItem({super.key, required this.semester});

  @override
  State<HomeListItem> createState() => _HomeListItemState();
}

class _HomeListItemState extends State<HomeListItem> {

  String generateStringFromSemester(String semester) {
  List<String> parts = semester.split('.');
  String year = 'Year ${parts[0]}';
  String semesterNumber = 'Semester ${parts[1]}';
  return '$year $semesterNumber';
}
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another screen here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentResultView(results: widget.semester,)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6,horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.buttonColorDark, // Set border color here
            width: 1, // Set border width here
          ),
        ),
        height: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(19, 5, 19, 5),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,  alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.buttonColorDark),child:  Text(
                  widget.semester.semester,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  generateStringFromSemester(widget.semester.semester),
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
