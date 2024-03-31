// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:result_ease/utils/app_colors.dart';

class ImageInput extends StatefulWidget {
  final String title;
  final Function onSelectImage;
  final String? imageUrl;

  const ImageInput(this.onSelectImage, this.title, {this.imageUrl});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();

    // Show dialog to let the user choose between camera and gallery
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Image"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(source: source);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    print('**************' + fileName);
    File pathLast = File(imageFile.path);
    final savedImage = await pathLast.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.backgroundColorWhite,
          radius: 70,
          backgroundImage: (_storedImage != null)
              ? FileImage(
                  File(_storedImage!.path),
                )
              : (widget.imageUrl != null)
                  ? NetworkImage(widget.imageUrl!)
                  : Image.asset(
                      "assets/images/profile.png",
                      fit: BoxFit.contain,
                    ).image,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.buttonColorDark,
              borderRadius: BorderRadius.circular(17),
            ),
            child: IconButton(
              onPressed: _takePicture,
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: Theme.of(context).textTheme.button!.fontSize!,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        Positioned(
          top: 50,
          child: Text(
            "Logo",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ],
    );
  }
}
