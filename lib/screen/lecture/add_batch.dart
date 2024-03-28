import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/dialog_helper.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class AddNewBatch extends StatefulWidget {
  const AddNewBatch({super.key});

  @override
  State<AddNewBatch> createState() => _AddNewBatchState();
}

class _AddNewBatchState extends State<AddNewBatch> {
   final TextEditingController _year = TextEditingController();
  final TextEditingController _batch = TextEditingController();
  final TextEditingController _semester = TextEditingController();

  var _isLoading=false;
  
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void _save() async {
    setState(() {
      _isLoading=true;
    });
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await _firestore.collection('batches').add({
          'userId': currentUser.uid,
          'year': _year.text,
          'batch': _batch.text,
          'semester': _semester.text,
          // Add more fields as needed
        });
        
        
      DialogHelper.showSuccessSnackbar(context, "Successfully Saved");
      _cancle();
        
      } else {
        
      DialogHelper.showErrorDialog(context, 'User not logged in!');
      }

      
    } catch (error) {

      DialogHelper.showErrorDialog(context, 'Failed to save batch details.');
    }

    setState(() {
      _isLoading=false;
    });
  }
  void _cancle() async {
     _year.clear();
  _batch.clear();
  _semester.clear();
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
                          
                         
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Year",
                              controller: _year),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Batch", controller: _batch),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Semester", controller: _semester),
                          const SizedBox(
                            height: 10,
                          ),
                         
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _isLoading?CircularProgressIndicator():
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