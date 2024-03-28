import 'package:excel/excel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/widgets/custom_drop_down_item.dart';
import 'package:result_ease/widgets/custom_file_upload.dart';
import 'dart:io';

import '../../helpers/dialog_helper.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';

class AddResults extends StatefulWidget {
  const AddResults({super.key});

  @override
  State<AddResults> createState() => _AddResultsState();
}

class _AddResultsState extends State<AddResults> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _year = TextEditingController();
  final TextEditingController _batch = TextEditingController();
  final TextEditingController _semester = TextEditingController();

  List<String> _yearList = [];
  List<String> _batchList = [];
  List<String> _semesterList = [];
  String? _filePath;

  final _firebaseAuth = FirebaseAuth.instance;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load data from Firestore
    _loadData();
  }

  Future<void> readExcelFile(String filePath) async {
    setState(() {
      _isLoading = true;
    });
    // Open the Excel file
    var bytes = File(filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    // Get the first sheet
    var sheet = excel.tables.keys.first;

    // Access the first row for headers
    var headers = excel.tables[sheet]!.rows.first;
    // Print headers
    print('Headers: $headers');

// Print first row of data
    var firstRow = excel.tables[sheet]!.rows.first;
    print('First row: $firstRow');

    // Find the index of the column containing 'Index No' and 'Name'
    var indexNoColumn =
        headers.indexWhere((cell) => cell!.value.toString() == 'Index No');
    var nameColumn =
        headers.indexWhere((cell) => cell!.value.toString() == 'Name');

    // Iterate through the headers to determine the course code columns
    var courseColumns = <int>[];
    for (var i = 0; i < headers.length; i++) {
      if (i != indexNoColumn && i != nameColumn) {
        courseColumns.add(i);
      }
    }

// Loop through rows to extract data
    for (var row in excel.tables[sheet]!.rows.skip(1)) {
      // Access data using column index
      var indexNo = row[indexNoColumn]?.value;
      var name = row[nameColumn]?.value;

      // Extract course code data dynamically
      var courseData = <String, String>{};
      for (var column in courseColumns) {
        // Ensure the column index is within the range of headers
        if (column >= 0 && column < headers.length) {
          var courseCode = headers[column]?.value;
          var courseGrade = row[column]?.value;
          if (courseCode != null && courseGrade != null) {
            courseData[courseCode.toString()] = courseGrade.toString();
          }
        }
      }

      print('Index No: $indexNo, Name: $name, Course Data: $courseData');

      try {
        final currentUser = _firebaseAuth.currentUser;
        // Store the data in Firestore
        if (currentUser != null) {
          await FirebaseFirestore.instance.collection('results').add({
            'userId': currentUser.uid,
            'indexNo': indexNo.toString(),
            'name': name.toString(),
            'courseData': courseData,
            'year': _year.text,
            'batch': _batch.text,
            'semester': _semester.text,
            // Add other fields if needed
          });
        }
        DialogHelper.showSuccessSnackbar(context, 'Successfully Saved.');
      } on Exception catch (e) {
        DialogHelper.showErrorDialog(context, 'Failed to save batch details.');
        // TODO
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadData() async {
    final batchSnapshots = await FirebaseFirestore.instance
        .collection('batches')
        .where('userId', isEqualTo: _auth.currentUser?.uid) //
        .get();

    final years = <String>{};
    final batches = <String>{};
    final semesters = <String>{};

    for (final batch in batchSnapshots.docs) {
      final data = batch.data() as Map<String, dynamic>;
      years.add(data['year']);
      batches.add(data['batch']);
      semesters.add(data['semester']);
    }

    setState(() {
      _yearList = years.toList();
      _batchList = batches.toList();
      _semesterList = semesters.toList();
    });
  }

  void _save() async {
    if (_filePath != null) {
      await readExcelFile(_filePath!);
    } else {
      print('File path is null.');
    }
  }

  void _cancle() async {
    setState(() {
      _year.clear(); // Clear the text in the year controller
      _batch.clear(); // Clear the text in the batch controller
      _semester.clear(); // Clear the text in the semester controller
      _filePath = null; // Clear the selected file path
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55), //width and height
          child: SafeArea(
              child: Stack(
            children: [
              CustomBackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ))),
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: screenSize.height,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.blueGrey[200] as Color, blurRadius: 10)
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              )),
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: screenSize.width,
                minHeight: screenSize.height - 130,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/top_circle.svg',
                        width: 200, // Adjust the width as needed
                        height: 200, // Adjust the height as needed
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
                          ),
                          CustomFileUploadField(
                            onFileSelected: (filePathCall) {
                              setState(() {
                                _filePath = filePathCall;
                              });
                              // Do something with the file path, such as passing it to another widget or performing file operations
                              print('Selected file path: $filePathCall');
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isLoading
                                  ? CircularProgressIndicator()
                                  : CustomButton(
                                      onClick: _save,
                                      label: "SAVE",
                                      color: AppColors.buttonColorDark),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                  onClick: _cancle,
                                  label: "CANCEL",
                                  color: AppColors.accentColor),
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
