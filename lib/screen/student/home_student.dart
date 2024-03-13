import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:result_ease/utils/app_colors.dart';
import 'package:result_ease/widgets/students/home_list_item.dart';
import 'package:result_ease/widgets/students/student_result_view_item.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final List<String> _semesters = ["1.1", "1.2"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorWhite,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: InkWell(
              child: const Icon(
                Icons.close,
                color: AppColors.backgroundColorWhite,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        elevation: 15,
        backgroundColor: AppColors.backgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: topWidget(context)),
      ),
      body: bodyWidget(context,_semesters),
    );
  }
}

Widget bodyWidget(BuildContext context, List<String> _semester) {
  return Stack(children: [
    ListView.builder(
        itemCount: _semester.length,
        itemBuilder: (context, index) {
          return HomeListItem(semester: _semester[index]);
        }),
    Positioned(
      bottom: 0,
      right: 0,
      child: SvgPicture.asset(
        'assets/images/bottom_circle.svg',
        width: 200, // Adjust the width as needed
        height: 200, // Adjust the height as needed
      ),
    ),
  ]);
}

Widget topWidget(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "T.M.A.T.Bandara",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Text(
                "GSCPMP177",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: Image.asset(
              "assets/icons/student.png",
              scale: 0.75,
            )),
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "G P A",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "2.5",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ))
      ],
    ),
  );
}
