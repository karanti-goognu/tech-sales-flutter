import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:get/get.dart';

class SpeedDialDetailsModel {
  String value;
  String imgURL;
  String navigateTo;

  SpeedDialDetailsModel(this.value, this.imgURL, this.navigateTo);
}

List<SpeedDialDetailsModel> speedDial = [
  new SpeedDialDetailsModel("Add Events", "assets/images/calendar.png", Routes.ADD_EVENTS),
  new SpeedDialDetailsModel("Add SR / Complaint", "assets/images/sr.png",
      Routes.SERVICE_REQUEST_CREATION),
  new SpeedDialDetailsModel("Add Influencer", "assets/images/img4.png",
      Routes.ADD_INFLUENCER),
  new SpeedDialDetailsModel(
      "Add MWP", "assets/images/mwp.png", Routes.ADD_MWP_SCREEN),
  new SpeedDialDetailsModel(
      "Add Lead", "assets/images/img2.png", Routes.ADD_LEADS_SCREEN),

];
final TextStyle customStyle =
    TextStyle(inherit: false, color: Colors.black, fontSize: 12);

class BackFloatingButton extends StatelessWidget {
  const BackFloatingButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          },
        ),
      ),
    );
  }
}

class SpeedDialFAB extends StatelessWidget {
  const SpeedDialFAB({
    Key key,
    @required this.speedDial,
    @required this.customStyle,
  }) : super(key: key);

  final List<SpeedDialDetailsModel> speedDial;
  final TextStyle customStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.0,
      width: 68.0,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            SizeConfig().init(context);
            Get.dialog(Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Container(
                height: 68.0,
                width: 68.0,
                child: FittedBox(
                  child: FloatingActionButton(
                      backgroundColor: Colors.amber,
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () => Get.back()),
                ),
              ),
              backgroundColor: Colors.transparent,
              bottomNavigationBar: BottomNavigatorWithoutTabs(),
              body: Row(
                children: [
                  Container(
                    width: SizeConfig.screenWidth / 2.22,
                  ),
                  Container(
                    width: SizeConfig.screenWidth / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: speedDial.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      Get.toNamed(speedDial[index].navigateTo);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Image.asset(
                                            speedDial[index].imgURL,
                                            height: 23,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 5.0),
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(speedDial[index].value,
                                              style: customStyle),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
            // gv.fromLead = false;
            // Get.toNamed(Routes.ADD_LEADS_SCREEN);
          },
        ),
      ),
    );
  }
}
