import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomBackButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 20,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          width: 40,
          height: 40,
          decoration:const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child:const Icon(
            Icons.arrow_back_ios,
            color: Colors.black, // Adjust the color as needed
          ),
        ),
      ),
    );
  }
}
