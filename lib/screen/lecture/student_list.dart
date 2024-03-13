import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/widgets/studen_list_item.dart';

import '../../models/student.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final List<Student> _students = [
    Student(name: 'T.M.A.T Bandara', indexNo: 'GCOMP177'),
    Student(name: 'T.M.A.T Bandara', indexNo: 'GCOMP177'),
    Student(name: 'T.M.A.T Bandara', indexNo: 'GCOMP177'),
    Student(name: 'T.M.A.T Bandara', indexNo: 'GCOMP177'),
    Student(name: 'T.M.A.T Bandara', indexNo: 'GCOMP177'),
    Student(name: 'T.M.A.T Bandara', indexNo: 'GCOMP177'),
    Student(name: 'T.M.A.T Bandara', indexNo: 'GCOMP177'),
    Student(name: 'T.M.A.T Bandara', indexNo: 'GCOMP177'),
    Student(name: 'T.M.A.T Bandara', indexNo: 'GCOMP177'),
    // Add more _students as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorWhite,
      body: Stack(children: [
        Positioned(
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
              Text(
                "Student",
                style: Theme.of(context).textTheme.headline2,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    return StudenListItem(
                      
                      name: _students[index].name,
                      indexNo: _students[index].indexNo,
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