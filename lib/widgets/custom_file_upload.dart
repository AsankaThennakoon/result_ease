import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:result_ease/utils/app_colors.dart';

class CustomFileUploadField extends StatefulWidget {
  final double width;
  final double height;
  final void Function(String)? onFileSelected; // Callback function to pass file path

  CustomFileUploadField({
    Key? key,
    this.height = 50,
    this.width = double.maxFinite,
    this.onFileSelected, // Initialize the callback function
  }) : super(key: key);

  @override
  State<CustomFileUploadField> createState() => _CustomFileUploadFieldState();
}

class _CustomFileUploadFieldState extends State<CustomFileUploadField> {
  String? fileName = "Upload Result Excel";
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
      width: widget.width,
      height: widget.height,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 2,
                  color: fileName == null
                      ? AppColors.accentColor
                      : AppColors.headingTextColor,
                ),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      fileName == null ? "Upload Result Excel" : fileName!,
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
        // Extract file name from the file path
        String fileNameTemp =
            filePath.split('/').last; // Assuming the file path separator is '/'
        // Update the label name with the file name
        setState(() {
          fileName = fileNameTemp;
        });

        // Call the callback function with the file path
        if (widget.onFileSelected != null) {
          widget.onFileSelected!(filePath);
        }
      }
    }
  }
}
