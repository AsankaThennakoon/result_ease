import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:result_ease/widgets/students/student_result_view_item.dart';

import '../../models/result.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';

class StudentResultView extends StatefulWidget {
  const StudentResultView({super.key});

  @override
  State<StudentResultView> createState() => _StudentResultViewState();
}

class _StudentResultViewState extends State<StudentResultView> {
 
   final List<Result> _students = [
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    Result(subject: 'Software Engineering', grade: 'C'),
    // Add more _students as needed
  ];
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