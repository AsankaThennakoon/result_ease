import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/models/results.dart';
import 'package:result_ease/widgets/studen_list_item.dart';
import '../../models/student.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class StudentList extends StatefulWidget {
  final String batch;
  final String semester;
  final String year;

  const StudentList({Key? key, required this.batch, required this.semester, required this.year}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late Future<List<dynamic>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = _fetchStudents();
  }

  Future<List<dynamic>> _fetchStudents() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('results')
        .where('batch', isEqualTo: widget.batch)
        .where('semester', isEqualTo: widget.semester)
        .where('year', isEqualTo: widget.year)
        .get();

    List students = snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList();
    List results = snapshot.docs.map((doc) => Results.fromJson(doc.data())).toList();
    
    // return students;
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorWhite,
      body: Stack(
        children: [
          Positioned(
            child: SvgPicture.asset(
              'assets/images/top_circle.svg',
              width: 200,
              height: 200,
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
                  child: FutureBuilder<List<dynamic>>(
                    future: _studentsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return StudenListItem(
                             
                              result: snapshot.data![index],
                             
                            );
                          },
                        );
                      }
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
              width: 100,
              height: 100,
            ),
          ),
          CustomBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
