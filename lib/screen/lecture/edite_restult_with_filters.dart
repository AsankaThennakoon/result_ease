import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/models/result.dart';
import 'package:result_ease/models/student.dart';
import 'package:result_ease/models/results.dart';
import 'package:result_ease/screen/lecture/edite_result.dart';
import 'package:result_ease/widgets/custom_drop_down_item.dart';
import 'package:result_ease/utils/app_colors.dart';
import 'package:result_ease/widgets/custom_back_button.dart';
import 'package:result_ease/widgets/custom_button.dart';

import '../../widgets/custom_text_field.dart';

class EditResultsWithFilters extends StatefulWidget {
  const EditResultsWithFilters({Key? key}) : super(key: key);

  @override
  _EditResultsWithFiltersState createState() => _EditResultsWithFiltersState();
}

class _EditResultsWithFiltersState extends State<EditResultsWithFilters> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _year = TextEditingController();
  final TextEditingController _batch = TextEditingController();
  final TextEditingController _semester = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _indexNo = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _grade = TextEditingController();

  List<String> _yearList = [];
  List<String> _batchList = [];
  List<String> _semesterList = [];
  var _studentsList = [];
  List<String> _nameList = [];
  List<String> _indexList = [];
  List<String> _subjectList = [];
  String? _subjectGrade;
  bool _isLoading = false;
  bool _isSubjectLoading = false;
  Map<String, String>? courseData;
  String? selctedCourseCode;
  List<Result> _result = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final batchSnapshots = await FirebaseFirestore.instance
          .collection('batches')
          .where('userId', isEqualTo: _auth.currentUser?.uid)
          .get();

      final years = <String>{};
      final batches = <String>{};
      final semesters = <String>{};

      batchSnapshots.docs.forEach((batch) {
        final data = batch.data();
        years.add(data['year']);
        batches.add(data['batch']);
        semesters.add(data['semester']);
      });

      setState(() {
        _yearList = years.toList();
        _batchList = batches.toList();
        _semesterList = semesters.toList();
      });
    } catch (error) {
      print('Error loading data: $error');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<List<dynamic>> _fetchStudents(
      String batch, String semester, String year) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('results')
        .where('batch', isEqualTo: batch)
        .where('semester', isEqualTo: semester)
        .where('year', isEqualTo: year)
        .get();

    return snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList();
  }

  void _onSemesterSelected(String value) async {
    setState(() {
      _nameList.clear();
      _indexList.clear();
      _isLoading = true;
    });

    try {
      _studentsList = await _fetchStudents(_batch.text, value, _year.text);
      _studentsList.forEach((student) {
        _nameList.add(student.name);
        _indexList.add(student.indexNo);
      });
    } catch (error) {
      print('Error loading students: $error');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onSelectStudentName(String name) {
    setState(() {
      _indexList.clear();
      _isSubjectLoading = true;
    });

    String? seletedStudentIndexNO;

    for (var element in _studentsList) {
      Student temp = element as Student;
      if (temp.name == name) {
        seletedStudentIndexNO = temp.indexNo;
      }
    }

    if (seletedStudentIndexNO != null) {
      setState(() {
        _indexList.add(seletedStudentIndexNO!);
      });
    }
  }

  void _onSelectIndexNo(String indexNo) {
    setState(() {
      _nameList.clear();
      _isSubjectLoading = true;
    });

    String? seletedStudentName;

    for (var element in _studentsList) {
      Student temp = element as Student;
      if (temp.indexNo == indexNo) {
        seletedStudentName = temp.name;
      }
    }

    if (seletedStudentName != null) {
      setState(() {
        _nameList.add(seletedStudentName!);
      });
    }

    _loadSubject(indexNo);
  }

  void _loadSubject(String indexNo) {
    setState(() {
      _subject.clear();
    });
    try {
      for (var element in _studentsList) {
        Student temp = element as Student;
        if (temp.indexNo == indexNo) {
          courseData = temp.courseData;
          _result = temp.courseData.entries
              .map((entry) => Result(subject: entry.key, grade: entry.value))
              .toList();

          print("HIHIHIHIHIH" + _result.toString());

          for (var element in _result) {
            _subjectList.add(element.subject);
            // _gradeList.add(element.grade);
          }
        }
      }
    } catch (e) {
      print("this is comming form subject loading" + e.toString());
    }
  }

  void _onSelectSubject(String subject) {
    for (var element in _result) {
      if (element.subject == subject) {
        setState(() {
          selctedCourseCode = subject;
          _subjectGrade = element.grade;
          _grade.text = _subjectGrade!;
        });
      }
    }
  }

  void _edite() async {
    Results object = Results(
        name: _name.text,
        indexNo: _indexNo.text,
        courseData: courseData!,
        batch: _batch.text,
        semester: _semester.text,
        year: _year.text,
        userId: _auth.currentUser!.uid);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditeResult(
                  result: object,
                  subjectCode: selctedCourseCode!,
                )));
  }

  void _cancel() {
    setState(() {
      _year.clear();
      _batch.clear();
      _semester.clear();
      _name.clear();
      _indexNo.clear();
      _subject.clear();
      _grade.clear();
      _nameList.clear();
      _indexList.clear();
      _subjectList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: SafeArea(
          child: Stack(
            children: [
              CustomBackButton(
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.blueGrey[200]!, blurRadius: 10),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height - 130,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/top_circle.svg',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomDropDownItem(
                            controller: _year,
                            labelName: "Selected Year",
                            listValues: _yearList,
                          ),
                          CustomDropDownItem(
                            controller: _batch,
                            labelName: "Selected Batch",
                            listValues: _batchList,
                          ),
                          CustomDropDownItem(
                            controller: _semester,
                            labelName: "Selected Semester",
                            listValues: _semesterList,
                            onChanged: _onSemesterSelected,
                          ),
                          CustomDropDownItem(
                            isEnabled: _nameList.isNotEmpty && !_isLoading,
                            controller: _name,
                            labelName: (_nameList.isEmpty)
                                ? "Selected Student Name"
                                : _nameList.length == 1
                                    ? _nameList.first
                                    : "Selected Student Name",
                            listValues: _nameList,
                            onChanged: _onSelectStudentName,
                            initalValue:
                                _nameList.length == 1 ? _nameList.first : null,
                          ),
                          CustomDropDownItem(
                            isEnabled: _indexList.isNotEmpty && !_isLoading,
                            controller: _indexNo,
                            labelName: "Selected Student IndexNo",
                            listValues: _indexList,
                            onChanged: _onSelectIndexNo,
                            initalValue: _indexList.length == 1
                                ? _indexList.first
                                : null,
                          ),
                          CustomDropDownItem(
                            isEnabled: _subjectList.isNotEmpty,
                            controller: _subject,
                            labelName: "Selected Subject",
                            listValues: _subjectList,
                            onChanged: _onSelectSubject,
                          ),
                          const SizedBox(height: 10,),
                          CustomTextField(
                              isEditable: false,
                              labelName: "Grade",
                              controller: _grade),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : CustomButton(
                                      onClick: _edite,
                                      label: "Edit",
                                      color: AppColors.buttonColorDark,
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                onClick: _cancel,
                                label: "CANCEL",
                                color: AppColors.accentColor,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
