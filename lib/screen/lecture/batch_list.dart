import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/screen/lecture/add_batch.dart';

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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _addNewBatch() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddNewBatch()));
  }

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
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('batches')
                      .where('userId', isEqualTo: _auth.currentUser?.uid) //
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final List<Batch> batches = [];
                    final data = snapshot.data;
                    if (data != null) {
                      for (final doc in data.docs) {
                        batches.add(Batch(
                            batch: doc['batch'] ?? '',
                            semester: doc['semester'] ?? '',
                            year: doc['year'] ?? ''
                            
                            // Add more fields as needed
                            ));
                      }
                    }
                    return ListView.builder(
                      itemCount: batches.length,
                      itemBuilder: (context, index) {
                        return BatchListItem(
                          year:batches[index].year ,
                          batch:  batches[index].batch,
                          semester: batches[index].semester,
                        );
                      },
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBatch,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
