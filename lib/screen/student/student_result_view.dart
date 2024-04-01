import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:result_ease/models/results.dart';
import 'package:result_ease/widgets/students/student_result_view_item.dart';

import '../../models/result.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';

class StudentResultView extends StatefulWidget {
  final Results results;
  const StudentResultView({super.key, required this.results});

  @override
  State<StudentResultView> createState() => _StudentResultViewState();
}

class _StudentResultViewState extends State<StudentResultView> {
  late List<Result> _students;

   Map<String, double> gradePointMap = {
    "A+": 4.0,
    "A": 4.0,
    "A-": 3.7,
    "B+": 3.3,
    "B": 3.0,
    "B-": 2.7,
    "C+": 2.3,
    "C": 2.0,
    "C-": 1.7,
    "D+": 1.3,
    "D": 1.0,
    "E": 0.0,
  };

  @override
  void initState() {
    super.initState();
    _generateResults();
  }

  void _generateResults() {
    _students = widget.results.courseData.entries
        .map((entry) => Result(subject: entry.key, grade: entry.value))
        .toList();

        print(calculateGPA().toString()+"GPSGPSGPSGPSGSPGPSGJSPGSGPJSPGJSPJSP");
  }

  double calculateGPA() {
    double totalCredits = 0;
    double totalGradePoints = 0;

    for (var entry in widget.results.courseData.entries) {
      String creditString = entry.key.substring(entry.key.length-2 , entry.key.length-1 );
      
      int credits = int.parse(creditString);
     
      double gradePoint = gradePointMap[entry.value.trim()] ?? 0.0;
     

      totalCredits += credits;
      totalGradePoints += credits * gradePoint;
    }

    if (totalCredits == 0) return 0.0;
    return totalGradePoints / totalCredits;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorWhite,
      body: Stack(children: [
        Positioned(
          top: 0,
          left: 0,
          child: SvgPicture.asset(
            'assets/images/top_circle.svg',
            width: 200, // Adjust the width as needed
            height: 200, // Adjust the height as needed
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Subject",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Grade",
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    return StudentResultViewItem(
                      subject: _students[index].subject,
                      grade: _students[index].grade,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(
            'assets/images/bottom_circle.svg',
            width: 100, // Adjust the width as needed
            height: 100, // Adjust the height as needed
          ),
        ),
        CustomBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ]),
    );
  }
}
