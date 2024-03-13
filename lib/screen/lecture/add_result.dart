import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:result_ease/widgets/custom_drop_down_item.dart';
import 'package:result_ease/widgets/custom_file_upload.dart';

import '../../utils/app_colors.dart';
import '../../widgets/custom_back_button.dart';
import '../../widgets/custom_button.dart';

class AddResults extends StatefulWidget {
  const AddResults({super.key});

  @override
  State<AddResults> createState() => _AddResultsState();
}

class _AddResultsState extends State<AddResults> {
  
  final TextEditingController _year = TextEditingController();
  final TextEditingController _batch = TextEditingController();
  final TextEditingController _semester = TextEditingController();

  final List<String> _yearList=["2016","2017"];
  final List<String> _batchList=["COM","PS"];
  final List<String> _semesterList=["1.1","1.2"];
 
  void _save() async {}
  void _cancle() async {}
  @override
   Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55), //width and height
          child: SafeArea(
              child: Stack(
            children: [
              CustomBackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ))),
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: screenSize.height,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.blueGrey[200] as Color, blurRadius: 10)
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              )),
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: screenSize.width,
                minHeight: screenSize.height - 130,
              ),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/images/top_circle.svg',
                        width: 200, // Adjust the width as needed
                        height: 200, // Adjust the height as needed
                      ),
                    ),
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          CustomDropDownItem(controller: _year,labelName: "Selected Year",listValues: _yearList,),
                          CustomDropDownItem(controller: _batch,labelName: "Selected Batch",listValues: _batchList,),
                          CustomDropDownItem(controller: _semester,labelName: "Selected Semester",listValues: _semesterList,),
                          CustomFileUploadField(labelName: "Upload Result Excel",controller: _year,),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                  onClick: _save,
                                  label: "SAVE",
                                  color: AppColors.buttonColorDark),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomButton(
                                  onClick: _cancle,
                                  label: "CANCEL",
                                  color: AppColors.accentColor),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}