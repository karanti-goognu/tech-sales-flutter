import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/add_mwp_plan_view.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';

class AddMWP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddMWPScreenPageState();
  }
}

class AddMWPScreenPageState extends State<AddMWP> {
  AddEventController _addEventController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //
      backgroundColor: ColorConstants.backgroundColor,
      body: _buildAddEventInterface(context),
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
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: ColorConstants.appBarColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Get.toNamed(Routes.HOME_SCREEN);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: Colors.white60,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.drafts,
                          color: Colors.white60,
                        ),
                        Text(
                          'Drafts',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      Get.toNamed(Routes.SEARCH_SCREEN);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.white60,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildAddEventInterface(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: SingleChildScrollView(
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
                      flex: 3,
                      child: Text(
                        "MWP Planning",
                        style: TextStyle(
                            color: ColorConstants.greenText,
                            fontFamily: "Muli-Semibold.ttf",
                            fontSize: 20,
                            letterSpacing: .15),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8.0,
                            ),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                            child: Obx(
                          () => DropdownButton<String>(
                            value: _addEventController.selectedMonth,
                            onChanged: (String newValue) {
                              _addEventController.selectedMonth = newValue;
                            },
                            items: <String>[
                              'January',
                              'February',
                              "March",
                              "April",
                              "May",
                              "June",
                              "July",
                              "August",
                              "September",
                              "October",
                              "November",
                              "December"
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
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
                AddMWPPlan(),
              ],
            )),
      ),
    );
  }
}
