import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';

class StartEvent extends StatefulWidget {
  @override
  _StartEventState createState() => _StartEventState();
}

class _StartEventState extends State<StartEvent> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    //_isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.appBarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('EVENTS DETAILS', style: TextStyles.appBarTitleStyle),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      side: BorderSide(color: Colors.white)),
                  backgroundColor: Colors.transparent,
                ),
                child: Text(
                  'ADD LEAD',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              )
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              padding: EdgeInsets.only(
                  left: 20.sp, bottom: 5.sp),
              color: ColorConstants.appBarColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                          side: BorderSide(color: Colors.white)),
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text(
                      'END TIME',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        //getBottomSheet();
                        //Get.toNamed(Routes.UPDATE_DLR_INF);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit,
                              color: ColorConstants.clearAllTextColor,
                              size: 20.sp),
                          SizedBox(
                            width: 5.sp,
                          ),
                          Text('UPDATE DLR & INF.',
                              style: TextStyles.robotoBtn14),
                        ],
                      ))
                ],
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10.sp,
              right: 10.sp,
              top: 20.sp,
              bottom: 20.sp,
            ),
            child: Text(
              '24-Mar-2021 | 12 PM',
              style: TextStyles.mulliBoldBlue,
            ),
          ),
          displayInfo('Event Type', 'Mason meet'),
          displayInfo('Dalmia Influencers', '15'),
          displayInfo('Non-Dalmia Influencers', '15'),
          displayInfo('Total Participants', '15'),
          // displayInfo('Venue', 'Booked'),
          displayInfo('Venue Address', 'XYZ'),
          displayChip('Dealer(s) Detail'),
          displayChip('New Influencer(s) Detail'),
          displayInfo('Expected Leads', 'Mason meet'),
          // displayInfo('Gift distribution', 'Mason meet'),
          //displayInfo('Event location', 'Mason meet'),
        ],
      ),
    );
  }

  getBottomSheet() {
    Get.bottomSheet(
      addInfluencerBottomSheetWidget(),
      isScrollControlled: true,
    ).then((value) => setState(() {}));
  }

  addInfluencerBottomSheetWidget() {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Container(
        height: SizeConfig.screenHeight / 1.3,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 8, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Influencer',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () => Get.back(), icon: Icon(Icons.clear))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 8, top: 12),
              child: TextFormField(
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return "Contact Name can't be empty";
                //   }
                //   //leagueSize = int.parse(value);
                //   return null;
                // },
                onChanged: (data) {
                  setState(() {
                    //_contactName = data;
                  });
                },
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Contact No.',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.backgroundColorBlue,
                        //color: HexColor("#0000001F"),
                        width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  filled: false,
                  focusColor: Colors.black,
                  isDense: false,
                  labelStyle: TextStyle(
                      fontFamily: "Muli",
                      color: ColorConstants.inputBoxHintColorDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0),
                  fillColor: ColorConstants.backgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
              child: TextFormField(
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return "Contact Name can't be empty";
                //   }
                //   //leagueSize = int.parse(value);
                //   return null;
                // },
                onChanged: (data) {
                  setState(() {
                    //_contactName = data;
                  });
                },
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Name',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.backgroundColorBlue,
                        //color: HexColor("#0000001F"),
                        width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  filled: false,
                  focusColor: Colors.black,
                  isDense: false,
                  labelStyle: TextStyle(
                      fontFamily: "Muli",
                      color: ColorConstants.inputBoxHintColorDark,
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0),
                  fillColor: ColorConstants.backgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8),
              child: DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    //requestDepartmentId = value;
                  });
                },
                items: [
                  'Influencer 1',
                  'Influencer 2',
                  'Influencer 3',
                  'Influencer 4'
                ]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                style: FormFieldStyle.formFieldTextStyle,
                decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Influencer Type"),
                validator: (value) =>
                    value == null ? 'Please select Influencer type ' : null,
              ),
            ),
            //SizedBox(height: 16),
            Container(
              // decoration:
              //     BoxDecoration(border: Border(top: BorderSide(width: 0.2))),
              padding:
                  EdgeInsets.only(top: 16, bottom: 20, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: HexColor('#1C99D4'),
                    onPressed: () {
                      setState(() {
                        _isVisible = true;
                      });
                    },
                    child: Text(
                      'ADD',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 40,
                  ),
                ],
              ),
            ),

            Visibility(
              visible: _isVisible,
              child: Container(
                //height: 50,
                color: ColorConstants.backgroundColorGrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 12, bottom: 12),
                      child: Text(
                        StringConstants.influencerDoesNotExist,
                        style: TextStyles.formfieldLabelTextDark,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, bottom: 12),
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() {
                            //requestDepartmentId = value;
                          });
                        },
                        items: [
                          'Influencer 1',
                          'Influencer 2',
                          'Influencer 3',
                          'Influencer 4'
                        ]
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        style: FormFieldStyle.formFieldTextStyle,
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Influencer Type"),
                        validator: (value) => value == null
                            ? 'Please select Influencer type '
                            : null,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.0),
                                  side: BorderSide(color: Colors.black)),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Add as a new influencer'.toUpperCase(),
                              style: ButtonStyles.buttonStyleWhite,
                            )),
                      ],
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget displayInfo(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.sp,
        right: 15.sp,
        top: 5.sp,
        bottom: 5.sp,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyles.formfieldLabelTextDark,
              ),
              Text(
                value,
                style: TextStyles.mulliBold16,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.sp),
            child: Divider(
              height: 1,
              color: ColorConstants.lightBlackBorderColor,
            ),
          )
        ],
      ),
    );
  }

  Widget displayChip(String title) {
    return Padding(
        padding: EdgeInsets.only(
          left: 15.sp,
          right: 10.sp,
          top: 0.sp,
          bottom: 10.sp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.formfieldLabelTextDark,
            ),
            SizedBox(
              height: 10.sp,
            ),
            Container(
              height: 30.sp,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: ['Chip1', 'Chip1Chip1']
                    // selectedRequestSubtypeObjectList
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(
                              e,
                              // e.serviceRequestTypeText,
                              style: TextStyle(
                                  fontFamily: "Muli",
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0),
                            ),
                            backgroundColor: Colors.white,
                            // elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              side: BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.sp),
              child: Divider(
                height: 1,
                color: ColorConstants.lightBlackBorderColor,
              ),
            )
          ],
        ));
  }
}
