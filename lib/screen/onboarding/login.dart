import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/screen/onboarding/registration.dart';
import 'package:result_ease/screen/student/home_student.dart';
import 'package:result_ease/utils/app_colors.dart';
import 'package:result_ease/widgets/custom_button.dart';
import 'package:result_ease/widgets/custom_text_field.dart';

import '../../helpers/dialog_helper.dart';

final _firebase = FirebaseAuth.instance;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  var _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userCredentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _userName.text, password: _password.text);

      setState(() {
        _isLoading = false;
      });

      // Handle successful login - navigate to next screen or show success message
    } catch (e) {
      String errorMessage = "Login failed. Please try again.";

      // Customize error message based on the specific error, if needed
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'No user found with this email.';
            break;
          case 'wrong-password':
            errorMessage = 'Incorrect password provided.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid.';
            break;
          // Handle other FirebaseAuthExceptions as needed
          default:
            errorMessage = 'Login failed. Please try again later.';
        }
      }

      // Handle other exceptions if needed

      DialogHelper.showErrorDialog(context, errorMessage);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onLongPress() async {
    setState(() {
      _isLoading = false;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const StudentHome()));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                          const SizedBox(height: 100),
                          SvgPicture.asset(
                            'assets/images/splash_image.svg',
                            width: 125, // Adjust the width as needed
                            height: 100, // Adjust the height as needed
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              width: screenSize.width,
                              child: CustomTextField(
                                  labelName: "User Name",
                                  controller: _userName)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 30, right: 30),
                              width: screenSize.width,
                              child: CustomTextField(
                                controller: _password,
                                labelName: "Password",
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                                  onClick: _login,
                                  onLongPress: _onLongPress,
                                  label: "LOGIN",
                                  color: AppColors.buttonColorDark),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Did not have an account?  ",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              InkWell(
                                hoverColor: Colors.black,
                                focusColor: Colors.grey,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Registration()));
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
