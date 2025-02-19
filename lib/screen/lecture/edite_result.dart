import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:result_ease/helpers/dialog_helper.dart';

import '../../models/results.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class EditeResult extends StatefulWidget {
  final Results result;
  final String subjectCode;
  const EditeResult(
      {super.key, required this.result, required this.subjectCode});

  @override
  State<EditeResult> createState() => _EditeResultState();
}

class _EditeResultState extends State<EditeResult> {
  final TextEditingController _studentName = TextEditingController();
  final TextEditingController _indexNumber = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _semester = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _grade = TextEditingController();

  FirebaseFirestore firestore =
      FirebaseFirestore.instance; // Instance of Firestore

  @override
  void initState() {
    super.initState();
    _studentName.text = widget.result.name;
    _indexNumber.text = widget.result.indexNo;
    _year.text = widget.result.year;
    _semester.text = widget.result.semester;
    _subject.text = widget.subjectCode;
    _grade.text = widget.result.courseData[widget.subjectCode] ?? '';
  }

  void _save() async {
    DialogHelper.showConfirmationDialog(
        context, "Are you sure you want to save this?", () async {
      try {
        QuerySnapshot querySnapshot = await firestore
            .collection('results')
            .where('userId', isEqualTo: widget.result.userId)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot doc = querySnapshot.docs.first;
          await doc.reference.update({
            'name': _studentName.text,
            'indexNo': _indexNumber.text,
            'year': _year.text,
            'semester': _semester.text,
            'courseData.${_subject.text}': _grade.text,
          });
          DialogHelper.showSuccessSnackbar(
              context, "Changes saved successfully!");
               setState(() {});
        } else {
          DialogHelper.showErrorDialog(context,
              'No matching document found for user ID: ${widget.result.userId}');
        }
      } catch (error) {
        DialogHelper.showErrorDialog(context, 'Failed to save changes: $error');
      }
    });
  }

  void _cancle() async {Navigator.of(context).pop();}

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
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Student Name",
                              controller: _studentName),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Index Number",
                              controller: _indexNumber),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(labelName: "Year", controller: _year),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Semester", controller: _semester),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Subject", controller: _subject),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Grade", controller: _grade),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
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
