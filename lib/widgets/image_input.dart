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
  // ignore: use_key_in_widget_constructors
  const ImageInput(this.onSelectImage, this.title);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _storedImage;
  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    // ignore: avoid_print
    print('**************' + fileName);
    // imageFile.=File('${appDir.path}/${fileName}');
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
            backgroundImage: _storedImage != null
                ? FileImage(
                    File(_storedImage!.path),
                  )
                : Image.asset(
                    "assets/images/profile.png",
                 
                    fit: BoxFit.contain,
                  ).image),

        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.buttonColorDark,
              borderRadius: BorderRadius.circular(
                  17), // Half of width or height to make it circular
            ),
            child: IconButton(
              onPressed: _takePicture,
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white, // Set icon color to white
                size: Theme.of(context)
                    .textTheme
                    .button!
                    .fontSize!, // Match icon size with default button text size
              ),
              padding: EdgeInsets.zero, // Remove padding
            ),
          ),
        ),

        Positioned(
          top:50,
        
            child: Text(
          "Logo",
          style: Theme.of(context).textTheme.headline3,
        ))

      
      ],
    );
  }
}
