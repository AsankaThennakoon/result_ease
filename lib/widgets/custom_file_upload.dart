import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:result_ease/utils/app_colors.dart';

class CustomFileUploadField extends StatelessWidget {
  final String labelName;
  final TextEditingController controller;
  final double width;
  final double height;

  const CustomFileUploadField({
    Key? key,
    required this.labelName,
    required this.controller,
    this.height = 50,
    this.width = double.maxFinite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
      width: width,
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: controller.text.isEmpty
                      ? AppColors.buttonColorDark
                      : AppColors.headingTextColor,
                ),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      labelName,
                      style: const TextStyle(
                          color: AppColors.headingTextColor, fontSize: 17),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: _pickFile,
                    child: const Icon(Icons.attach_file,
                        color: AppColors.headingTextColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['xlsx', 'xls']);
    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        controller.text = filePath;
      }
    }
  }
}
