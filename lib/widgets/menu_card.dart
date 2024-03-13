import 'package:flutter/material.dart';
import 'package:result_ease/utils/app_colors.dart';

class CustomCard extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String title;
  const CustomCard(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 20,
        color: AppColors.backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: AppColors.bodyTextColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.bodyTextColor,
                ))
          ],
        ),
      ),
    );
  }
}
