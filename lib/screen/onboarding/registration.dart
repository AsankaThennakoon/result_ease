import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/screen/onboarding/login.dart';
import 'package:result_ease/utils/colors.dart';
import 'package:result_ease/widgets/custom_text_field.dart';

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
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Saved successfully !'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }

  void _signUp() async {}
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
              Positioned(
                top: 15,
                left: 20,
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        )),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
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
                              ElevatedButton(
                                style: const ButtonStyle(
                                  alignment: Alignment.center,
                                ),
                                onPressed: _signUp,
                                child: const Text(
                                  "Register",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              ElevatedButton(
                                style: const ButtonStyle(
                                  
                                  alignment: Alignment.center,
                                ),
                                onPressed: _cancle,
                                child: const Text(
                                  "Cancle",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.headingTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
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
