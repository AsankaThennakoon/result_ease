import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/models/result.dart';
import 'package:result_ease/models/results.dart';
import 'package:result_ease/screen/lecture/edite_result.dart';
import 'package:result_ease/utils/app_colors.dart';
import 'package:result_ease/widgets/custom_back_button.dart';
import 'package:result_ease/widgets/result_view_list_item.dart';

class ResultView extends StatefulWidget {
  final Results results;

  const ResultView({Key? key, required this.results}) : super(key: key);

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  late List<Result> _students;

  @override
  void initState() {
    super.initState();
    _generateResults();
  }

  void _generateResults() {
    _students = widget.results.courseData.entries
        .map((entry) => Result(subject: entry.key, grade: entry.value))
        .toList();
  }

  
  void _editeResult(String subjectCode) {
    print(subjectCode);

      Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  EditeResult(result: widget.results, subjectCode: subjectCode,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorWhite,
      body: Stack(
        children: [
          Positioned(
            child: SvgPicture.asset(
              'assets/images/top_circle.svg',
              width: 200,
              height: 200,
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
                      "Subject",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Grade",
                      style: Theme.of(context).textTheme.headline2,
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _students.length,
                    itemBuilder: (context, index) {
                      return ResultViewItem(
                        subject: _students[index].subject,
                        grade: _students[index].grade,
                        onTap: _editeResult,
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
              width: 100,
              height: 100,
            ),
          ),
          CustomBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
