import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:result_ease/helpers/dialog_helper.dart';
import 'package:result_ease/models/results.dart';
import 'package:result_ease/utils/app_colors.dart';
import 'package:result_ease/widgets/students/home_list_item.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final List<String> _semestersList = [];
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? currentUser;
  Results? userDetail;

  double finalGPA=0.0;
  

  List<dynamic> results = [];
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
    _loadData();
  }

  void _loadData() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        results = await _fetchResults(currentUser.uid);
        _loadSemester(results);
      }
    } catch (error) {
      print('Error loading data: $error');
      DialogHelper.showErrorDialog(context, 'Error loading data');
    }
  }

  void _loadSemester(List<dynamic> results) {
    
    int totalSemesters = 0;
    double totalGPA = 0.0;
    userDetail=results.first as Results;

    for (var element in results) {
      Results temp = element as Results;
      _semestersList.add(temp.semester);
      print(temp.semester + temp.batch);

      double semesterGPA = _calculateSemesterGPA(temp);

      totalGPA += semesterGPA;
      totalSemesters++;
      finalGPA=totalGPA/totalSemesters;

      setState(() {});
    }

    if (totalSemesters > 0) {
      double finalGPA = totalGPA / totalSemesters;
      print('Final GPA: $finalGPA');
      // Update UI with the final GPA
    } else {
      print('No valid semesters found.');
      // Handle case where no valid semesters are found
    }
  }

  double _calculateSemesterGPA(Results semesterResults) {
    double totalCredits = 0;
    double totalGradePoints = 0;

    for (var entry in semesterResults.courseData.entries) {
      String creditString = entry.key.substring(entry.key.length-2 , entry.key.length-1 );
      int credits = int.tryParse(creditString) ?? 0;
      double gradePoint = gradePointMap[entry.value.trim()] ?? 0.0;

      totalCredits += credits;
      totalGradePoints += credits * gradePoint;
    }

    if (totalCredits == 0) return 0.0;
    return totalGradePoints / totalCredits;
  }

  Future<List<dynamic>> _fetchResults(String currentUserId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('results')
          .where('indexNo', isEqualTo: currentUserId)
          .get();

      List<dynamic> results =
          snapshot.docs.map((doc) => Results.fromJson(doc.data())).toList();

      return results;
    } catch (error) {
      print('Error fetching results: $error');
      throw error;
    }
  }

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
                DialogHelper.showConfirmationDialog(
                  context,
                  'Are you sure you want to log out?',
                  () {
                    FirebaseAuth.instance.signOut();
                    // Navigate to login screen or perform any other actions after logout
                  },
                );
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
            child: topWidget(
                context, userDetail?.indexNo ?? "", userDetail?.name ?? "",finalGPA)),
      ),
      body: bodyWidget(context, results),
    );
  }
}

Widget bodyWidget(BuildContext context, List<dynamic> _result) {
  return Stack(children: [
    FutureBuilder<List<dynamic>>(
      future: Future.value(_result),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          final _semester = snapshot.data!;
          return ListView.builder(
            itemCount: _semester.length,
            itemBuilder: (context, index) {
              return HomeListItem(semester: _semester[index]);
            },
          );
        }
      },
    ),
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

Widget topWidget(BuildContext context, String userName, String indexNo,double totalGPA) {
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
                userName,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Text(
                indexNo,
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
                  totalGPA.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ))
      ],
    ),
  );
}
