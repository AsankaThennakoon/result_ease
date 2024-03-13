import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/app_colors.dart';

class CustomDropDownItem extends StatefulWidget {
   final String labelName;
  final TextEditingController controller;
  final List<String> listValues;
  const CustomDropDownItem({super.key,required this.labelName,
    required this.controller,
    required this.listValues});

  @override
  State<CustomDropDownItem> createState() => _CustomDropDownItemState();
}

class _CustomDropDownItemState extends State<CustomDropDownItem> {
  String ? selectedYear;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(left: 30, right: 30,top:14),
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
              onChanged: (String? value) {
                setState(() {
                  selectedYear = value;
                  widget.controller.text = value?.toString() ?? '';
                });
              },
            ),
          ),
         
        ],
      ),
    );
  }
}