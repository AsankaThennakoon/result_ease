import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/batch.dart';
import '../../utils/app_colors.dart';
import '../../widgets/batch_list_item.dart';
import '../../widgets/custom_back_button.dart';

class BatchList extends StatefulWidget {
  const BatchList({super.key});

  @override
  State<BatchList> createState() => _BatchListState();
}

class _BatchListState extends State<BatchList> {
  final List<Batch> batches = [
    Batch(batch: '16/17 COM', semester: '1.1'),
    Batch(batch: '16/17 PS', semester: '1.1'),
    Batch(batch: '16/17 COM', semester: '1.2'),
    Batch(batch: '16/17 PS', semester: '1.2'),
    Batch(batch: '16/17 COM', semester: '1.1'),
    Batch(batch: '16/17 PS', semester: '1.1'),
    Batch(batch: '16/17 COM', semester: '1.2'),
    Batch(batch: '16/17 PS', semester: '1.2'),
    Batch(batch: '16/17 COM', semester: '1.1'),
    Batch(batch: '16/17 PS', semester: '1.1'),
    Batch(batch: '16/17 COM', semester: '1.2'),
    Batch(batch: '16/17 PS', semester: '1.2'),
    // Add more batches as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorWhite,
      body: Stack(children: [
        Positioned(
          child: SvgPicture.asset(
            'assets/images/top_circle.svg',
            width: 200, // Adjust the width as needed
            height: 200, // Adjust the height as needed
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Batch",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Semester",
                    style: Theme.of(context).textTheme.headline2,
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: batches.length,
                  itemBuilder: (context, index) {
                    return BatchListItem(
                      
                      batch: batches[index].batch,
                      semester: batches[index].semester,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(
            'assets/images/bottom_circle.svg',
            width: 100, // Adjust the width as needed
            height: 100, // Adjust the height as needed
          ),
        ),
        CustomBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        
      ]),
    );
  }
}