import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/screen/onboarding/login.dart';
import 'package:result_ease/utils/app_colors.dart';
import 'package:result_ease/widgets/custom_back_button.dart';
import 'package:result_ease/widgets/custom_button.dart';
import 'package:result_ease/widgets/custom_text_field.dart';
import '../../helpers/dialog_helper.dart';

final _firebase = FirebaseAuth.instance;

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _universityName = TextEditingController();
  final TextEditingController _faculty = TextEditingController();
  final TextEditingController _department = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmePassword = TextEditingController();
  var _isLoading = false;

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final universityCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text);

      await FirebaseFirestore.instance
          .collection('university')
          .doc(universityCredentials.user!.uid)
          .set({
        'university_name': _universityName.text,
        'faculty': _faculty.text,
        'department': _department.text,
      });
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully Registed "),
        ),
      );
      // Show success message or navigate to the next screen
    } catch (e) {
      String errorMessage = "Sign-up failed. Please try again.";

      // Customize error message based on the specific error, if needed
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'The email address is already in use.';
            break;
          case 'weak-password':
            errorMessage = 'The password provided is too weak.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          // Handle other FirebaseAuthExceptions as needed
          default:
            errorMessage = 'Sign-up failed. Please try again later.';
        }
      }

      // Handle other exceptions if needed

      DialogHelper.showErrorDialog(context, errorMessage);
    }
  }

  void _cancle() async {}

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
                          const SizedBox(height: 10),
                          const Text(
                            "Create an account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.buttonColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SvgPicture.asset(
                            'assets/images/splash_image.svg',
                            width: 125, // Adjust the width as needed
                            height: 100, // Adjust the height as needed
                          ),
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
                              labelName: "Email", controller: _email),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Password", controller: _password),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              labelName: "Confirm Password",
                              controller: _confirmePassword),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                  onClick: _signUp,
                                  label: "REGISTER",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?  ",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              InkWell(
                                hoverColor: Colors.black,
                                focusColor: Colors.grey,
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                                child: const Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: AppColors.accentColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
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
