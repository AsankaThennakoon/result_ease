import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/helpers/dialog_helper.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/image_input.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _universityName = TextEditingController();
  final TextEditingController _faculty = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _email = TextEditingController();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? _pickedProfilePic;
  String ? _imageURL;
  void _selectedProfilePic(File profilePic) {
    _pickedProfilePic = profilePic;
  }

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  void loadUserProfile() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userProfileSnapshot = await _firestore
            .collection('university')
            .doc(currentUser.uid)
            .get();

        if (userProfileSnapshot.exists) {
          setState(() {
            _universityName.text = userProfileSnapshot['university_name'];
            _faculty.text = userProfileSnapshot['faculty'];
            _department.text = userProfileSnapshot['department'];
            _email.text = currentUser.email ?? '';
            _imageURL=userProfileSnapshot['image_url']??'';
          });
        }
      }
    } catch (error) {
      print("Error loading user profile: $error");
    }
  }

  void _save() async {
    // Implement your save logic here

    try {
      final currentUser = _firebaseAuth.currentUser;
      late String imageUrl = "";
      if (currentUser != null && _pickedProfilePic != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${currentUser.uid}.jpg');

        await storageRef.putFile(_pickedProfilePic!);
        imageUrl = await storageRef.getDownloadURL();
      }

      await FirebaseFirestore.instance
          .collection('university')
          .doc(currentUser!.uid)
          .update({
        'university_name': _universityName.text,
        'faculty': _faculty.text,
        'department': _department.text,
        'image_url': imageUrl
      });
    } on FirebaseAuthException catch (error) {
      DialogHelper.showErrorDialog(context, "Update Faile");
    }
  }

  void _cancel() {
    // Implement your cancel logic here
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
                        children: <Widget>[
                          const SizedBox(
                            height: 5,
                          ),
                          ImageInput(_selectedProfilePic, 'Profile PIC',imageUrl: _imageURL,),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "University",
                              controller: _universityName),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Faculty", controller: _faculty),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Department", controller: _department),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              isEditable: false,
                              labelName: "Email",
                              controller: _email),
                          const SizedBox(
                            height: 10,
                          ),
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
                                  onClick: _cancel,
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
