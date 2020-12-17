import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/AddMWPPlanModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMWPPlan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddMWPPlanScreenPageState();
  }
}

class AddMWPPlanScreenPageState extends State<AddMWPPlan> {
  AddEventController _addEventController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> mwpNames = [
      "Total Conversion Vol. (MT)",
      "New ILP members",
      "DSP Slabs Conv. Nos.",
      "Site Conv. (Vol MT)",
      "Site Conv. (No. of sites)",
      "Site Visits (Total)",
      "Site Visits (Unique)",
      "Influencer Visits",
      "Mason Meet",
      "Counter Meet",
      "Contractor Meet",
      "Mini Contractor Meet",
      "Consumer Meet"
    ];
    List<AddMwpModel> mwpPlanList = new List();
    for (int i = 0; i < mwpNames.length; i++) {
      mwpPlanList.add(
          new AddMwpModel(mwpNames[i], 10, 10, new TextEditingController()));
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[],
                ),
                flex: 5,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    "Target",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.lightGreyColor,
                    ),
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    "Actual",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.lightGreyColor,
                    ),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
          ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 2),
            //  padding: const EdgeInsets.all(8.0),
            itemCount: mwpPlanList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 64,
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            mwpPlanList[index].title,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: ColorConstants.lightGreyColor,
                            ),
                          ),
                        ],
                      ),
                      flex: 5,
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                            border: Border.all(
                                width: 1,
                                color: ColorConstants.lightOutlineColor)),
                        child: returnTextField(index, mwpPlanList),
                      ),
                      flex: 1,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                            border: Border.all(
                                width: 1,
                                color: ColorConstants.lightOutlineColor)),
                        child: TextFormField(
                            enabled: false,
                            initialValue: "0",
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize: 14,
                                color: ColorConstants.lightGreyColor,
                                fontFamily: "Muli"),
                            keyboardType: TextInputType.number),
                      ),
                      flex: 1,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              );
            },
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RaisedButton(
                  color: ColorConstants.greenText,
                  highlightColor: ColorConstants.buttonPressedColor,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Text(
                      'SAVE',
                      style: ButtonStyles.buttonStyleBlue,
                    ),
                  ),
                ),
                flex: 5,
              ),
              SizedBox(
                width: 4,
              ),
              Flexible(
                child: RaisedButton(
                  color: ColorConstants.buttonNormalColor,
                  highlightColor: ColorConstants.buttonPressedColor,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Text(
                      'SUBMIT',
                      style: ButtonStyles.buttonStyleBlue,
                    ),
                  ),
                ),
                flex: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget returnTextField(int index, List<AddMwpModel> mwpPlanList) {
    return TextField(
        controller: mwpPlanList[index].textEditingController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        onChanged: (_) {
          print('text is :: $_');
          switch (index) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              break;
            case 4:
              break;
            case 5:
              break;
            case 6:
              break;
            case 7:
              break;
            case 8:
              break;
            case 9:
              break;
            case 10:
              break;
            case 11:
              break;
            case 12:
              break;
          }
        },
        style: TextStyle(
            fontSize: 14,
            color: ColorConstants.lightGreyColor,
            fontFamily: "Muli"),
        keyboardType: TextInputType.number);
  }
}
