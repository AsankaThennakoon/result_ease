import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/screen/lecture/add_batch.dart';
import 'package:result_ease/screen/lecture/add_result.dart';
import 'package:result_ease/screen/lecture/batch_list.dart';
import 'package:result_ease/screen/lecture/edite_result.dart';
import 'package:result_ease/screen/lecture/profile_lecture.dart';
import 'package:result_ease/utils/app_colors.dart';
import 'package:result_ease/widgets/menu_card.dart';

class HomeLecture extends StatefulWidget {
  const HomeLecture({super.key});

  @override
  State<HomeLecture> createState() => _HomeLectureState();
}

class _HomeLectureState extends State<HomeLecture> {
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
        GridView(
          padding: const EdgeInsets.fromLTRB(10, 200, 10, 10),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          children: [
            CustomCard(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddResults()));
                },
                icon: Icons.add,
                title: "New Result"),
            CustomCard(
                onTap: () {Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  BatchList()));}, icon: Icons.list_alt_rounded, title: "View"),
            CustomCard(onTap: () {

                Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const EditeResult()));
            }, icon: Icons.edit_rounded, title: "Edite"),
            CustomCard(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                icon: Icons.account_box_rounded,
                title: "Profile"),
            CustomCard(onTap: () {
               Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AddNewBatch()));
            }, icon: Icons.grade, title: "Batch"),
          ],
        ),
        Positioned(
          right: 20,
          top: 20,
          child: InkWell(
            child: const Icon(Icons.close),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ]),
    );
  }
}
