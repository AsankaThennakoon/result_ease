import 'package:flutter/material.dart';
import 'package:result_ease/utils/colors.dart';

class CustomTextField extends StatefulWidget {
  final String labelName;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.labelName,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
        cursorHeight: 30,
        style: const TextStyle(color: AppColors.headingTextColor, fontSize: 18, height: 1.5),
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: widget.labelName,
          labelStyle:
              const TextStyle(color: Colors.grey, fontSize: 17, height: 1),
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 2,
              color: widget.controller.text.isEmpty
                  ? Colors.grey // Change to your desired color
                  : AppColors.headingTextColor, // Change to your desired color
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 2,
              color: widget.controller.text.isEmpty
                  ? Colors.grey // Change to your desired color
                  : AppColors.headingTextColor, // Change to your desired color
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 2,
              color: widget.controller.text.isEmpty
                  ? Colors.grey // Change to your desired color
                  : AppColors.headingTextColor, // Change to your desired color
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 2,
              color: widget.controller.text.isEmpty
                  ? Colors.grey // Change to your desired color
                  : AppColors.headingTextColor, // Change to your desired color
            ),
          ),
        ),
      ),
    );
  }
}
