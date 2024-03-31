import 'package:flutter/material.dart';
import 'package:result_ease/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String labelName;
  final TextEditingController controller;
  final double width;
  final double height;
  final bool isEditable; // New parameter to decide if the text field is editable

  const CustomTextField({
    Key? key,
    required this.labelName,
    required this.controller,
    this.height = 50,
    this.width = double.maxFinite,
    this.isEditable = true, // Default value is set to true for backward compatibility
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        cursorHeight: 30,
        style: const TextStyle(color: AppColors.headingTextColor, fontSize: 18, height: 1.5),
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        enabled: widget.isEditable, // Setting the enabled property based on the flag
        decoration: InputDecoration(
          labelText: widget.labelName,
          labelStyle: const TextStyle(color: AppColors.headingTextColor, fontSize: 17, height: 1),
          hintStyle: const TextStyle(color: AppColors.headingTextColor, fontSize: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              width: 1,
              color: widget.controller.text.isEmpty
                  ? AppColors.buttonColorDark // Change to your desired color
                  : AppColors.headingTextColor, // Change to your desired color
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              width: 1,
              color: widget.controller.text.isEmpty
                  ? AppColors.buttonColorDark // Change to your desired color
                  : AppColors.headingTextColor, // Change to your desired color
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              width: 1,
              color: widget.controller.text.isEmpty
                  ? AppColors.buttonColorDark // Change to your desired color
                  : AppColors.headingTextColor, // Change to your desired color
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(
              width: 1,
              color: widget.controller.text.isEmpty
                  ? AppColors.accentColor // Change to your desired color
                  : AppColors.headingTextColor, // Change to your desired color
            ),
          ),
        ),
      ),
    );
  }
}
