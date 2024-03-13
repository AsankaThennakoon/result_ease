import 'package:flutter/material.dart';
import 'package:result_ease/screen/lecture/student_list.dart';
import 'package:result_ease/utils/app_colors.dart';

class BatchListItem extends StatelessWidget {
  final String batch;
  final String semester;

  const BatchListItem({
    Key? key,
    required this.batch,
    required this.semester,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to another screen here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentList()),
        );
      },
      child: Container(
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
        padding: const EdgeInsets.fromLTRB(19, 15, 19, 15),
        child: Row(
          children: [
            Image.asset(
              "assets/icons/batch.png",
              width: 41,
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  batch,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                semester,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
