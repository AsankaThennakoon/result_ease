import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomDropDownItem extends StatefulWidget {
  final String labelName;
  final TextEditingController controller;
  final List<String> listValues;
  final bool isEnabled;
  final String ? initalValue;
  final Function(String)? onChanged; // Add this field

  const CustomDropDownItem({
    Key? key,
    required this.labelName,
    required this.controller,
    required this.listValues,
    this.isEnabled = true,
    this.initalValue,
    this.onChanged, // Default value for isEnabled
  }) : super(key: key);

  @override
  State<CustomDropDownItem> createState() => _CustomDropDownItemState();
}

class _CustomDropDownItemState extends State<CustomDropDownItem> {
  String? selectedYear;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.initalValue!=null){
      selectedYear=widget.initalValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(left: 30, right: 30, top: 14),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                labelText: widget.labelName,
                labelStyle: const TextStyle(
                  color: AppColors.headingTextColor,
                  fontSize: 17,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              value: selectedYear,
              items: widget.listValues.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
              onChanged: widget.isEnabled
                  ? (String? value) {
                      setState(() {
                        selectedYear = value;
                        widget.controller.text = value?.toString() ?? '';
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(value ?? '');
                      }
                    }
                  : null, // Set onChanged to null if disabled
              autovalidateMode: widget.isEnabled
                  ? AutovalidateMode.always
                  : AutovalidateMode
                      .disabled, // Set autovalidateMode based on isEnabled
            ),
          ),
        ],
      ),
    );
  }
}
