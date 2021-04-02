import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/influencer_meet_view.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/visit_view.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:get/get.dart';

class AddEvent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddEventScreenPageState();
  }
}

class AddEventScreenPageState extends State<AddEvent> {
  AddEventController _addEventController = Get.find();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.toNamed(Routes.ADD_CALENDER_SCREEN);
          return true;
        },
        child: Scaffold(
          extendBody: true,
          backgroundColor: ColorConstants.backgroundColor,
          body: SingleChildScrollView(
            child: _buildAddEventInterface(context),
          ),
          floatingActionButton: Container(
            height: 68.0,
            width: 68.0,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: ColorConstants.checkinColor,
                child: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  if(_addEventController.selectedView == "Visit"){
                    this._addEventController.visitDateTime = "Visit Date";


                  }
                },
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigatorWithoutDraftsAndSearch(),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildAddEventInterface(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Add Event",
                      style: TextStyle(
                          color: ColorConstants.greenText,
                          fontFamily: "Muli-Semibold.ttf",
                          fontSize: 20,
                          letterSpacing: .15),
                    ),
                  ),
                  Expanded(
                    flex:5,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.white,
                          border: Border.all()),
                      child: DropdownButtonHideUnderline(
                          child: Obx(
                                () => DropdownButton<String>(
                              value: _addEventController.selectedView,
                              onChanged: (String newValue) {
                                _addEventController.selectedView = newValue;
                                if(_addEventController.selectedView=='Service Requests'){
                                  Get.offNamed(Routes.SERVICE_REQUEST_CREATION);
                                }
                              },
                              items: <String>[
                                'Visit',
                                'Influencers meet',
                                'Service Requests'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                    style: TextStyle(
                                        fontSize: SizeConfig.safeBlockHorizontal*3.8,

                                        fontFamily: "Muli"),
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Obx(() => (_addEventController.selectedView == "Visit")
                  ? AddEventVisit()
                  :
              (_addEventController.selectedView == "Influencers meet")
                  ? AddEventInfluencerMeet():
              AddEventInfluencerMeet()),
              SizedBox(
                height: 30,
              ),
            ],
          )),
    );
  }
}