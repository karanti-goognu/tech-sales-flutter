import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'file:///D:/Development/flutter/TechSalesFlutter/lib/presentation/features/mwp/data/model/AddMWPPlanModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
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
      mwpPlanList.add(new AddMwpModel(mwpNames[i], 10, 10));
    }
    return ListView.builder(
      //  padding: const EdgeInsets.all(8.0),
      itemCount: mwpPlanList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 70,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Text(
                  mwpPlanList[index].title,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: ColorConstants.lightGreyColor,
                  ),
                ),
                flex: 5,
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                      border: Border.all(width: 1,color: ColorConstants.lightOutlineColor)),
                  child: TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstants.lightGreyColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.number),
                ),
                flex: 1,
              ),
              SizedBox(width: 10,),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.white,
                      border: Border.all(width: 1,color: ColorConstants.lightOutlineColor)),
                  child: TextField(
                    textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          fontSize: 16,
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
    );
  }
}
