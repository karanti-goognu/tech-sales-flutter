import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/detail_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailViewEvent extends StatefulWidget {
  int eventId;

  DetailViewEvent(this.eventId);

  @override
  _DetailViewEventState createState() => _DetailViewEventState();
}

class _DetailViewEventState extends State<DetailViewEvent> {
  DetailEventModel detailEventModel;
  DetailEventController detailEventController = Get.find();
  int total;

  @override
  void initState() {
    super.initState();
    getDetailEventsData();
  }

  getDetailEventsData() async {
    await detailEventController.getAccessKey().then((value) async {
      print(value.accessKey);
      await detailEventController.getDetailEventData(value.accessKey, widget.eventId)
          .then((data) {
        setState(() {
          detailEventModel = data;
        });
        print('DDDD: $data');
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.appBarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('EVENTS DETAILS', style: TextStyles.appBarTitleStyle),
              FlatButton(
                onPressed: () {
                  Get.dialog(CustomDialogs().showStartEventDialog('Confirmation',
                      "Do you want to start event?"));
                 // Get.toNamed(Routes.START_EVENT);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                    side: BorderSide(color: Colors.white)),
                color: Colors.transparent,
                child: Text(
                  'START EVENT',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              )
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              color: ColorConstants.appBarColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                      onPressed: () {
                        Get.dialog(CustomDialogs().showCancelEventDialog('Confirmation',
                            "You will not be able to undo this action, are you sure you want to Cancel this event?"));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: ColorConstants.clearAllTextColor,
                            size: ScreenUtil().setSp(20),
                          ),
                          SizedBox(
                            width: ScreenUtil().setSp(5),
                          ),
                          Text('CANCEL', style: TextStyles.robotoBtn14),
                        ],
                      )),
                  FlatButton(
                      onPressed: () {
                          Get.toNamed(Routes.UPDATE_EVENT);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit,
                              color: ColorConstants.clearAllTextColor,
                              size: ScreenUtil().setSp(20)),
                          SizedBox(
                            width: ScreenUtil().setSp(5),
                          ),
                          Text('EDIT', style: TextStyles.robotoBtn14),
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
      body:(
          //detailEventModel != null && detailEventModel.mwpEventModel != null && detailEventModel.dealersModelList != null)?
      ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtil().setSp(10),
              right: ScreenUtil().setSp(10),
              top: ScreenUtil().setSp(20),
              bottom: ScreenUtil().setSp(20),
            ),
            child: Text(
              detailEventModel.mwpEventModel.eventDate,
             // '24-Mar-2021 | 12 PM',
              style: TextStyles.mulliBoldBlue,
            ),
          ),
          displayInfo('Event Type', detailEventModel.mwpEventModel.eventTypeText ?? ''),
          displayInfo('Dalmia Influencers', '${detailEventModel.mwpEventModel.dalmiaInflCount}' ?? '0'),
          displayInfo('Non-Dalmia Influencers', '${detailEventModel.mwpEventModel.nonDalmiaInflCount}' ?? '0'),
          displayInfo('Total Participants', '${(detailEventModel.mwpEventModel.dalmiaInflCount) + (detailEventModel.mwpEventModel.nonDalmiaInflCount)}' ?? '0'),
          displayInfo('Venue Address', detailEventModel.mwpEventModel.venueAddress),
          displayChip('Dealer(s) Detail'),
          displayInfo('Expected Leads', '${detailEventModel.mwpEventModel.expectedLeadsCount}' ?? '0'),
          displayInfo('Gift distribution', '${detailEventModel.mwpEventModel.giftDistributionCount}' ?? '0'),
          displayInfo('Event location', detailEventModel.mwpEventModel.eventLocation ?? ''),
        ],
      )
      //         : Container(
      //   child: Center(
      //     child: Text("No data!!"),
      //   ),
       ),
    );
  }

  Widget displayInfo(String title, String value) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtil().setSp(15),
        right: ScreenUtil().setSp(15),
        top: ScreenUtil().setSp(5),
        bottom: ScreenUtil().setSp(5),
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
                maxLines: null,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setSp(20)),
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
          left: ScreenUtil().setSp(15),
          right: ScreenUtil().setSp(10),
          top: ScreenUtil().setSp(0),
          bottom: ScreenUtil().setSp(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.formfieldLabelTextDark,
            ),
            SizedBox(
              height: ScreenUtil().setSp(10),
            ),
            Container(
              height: ScreenUtil().setSp(30),
              child:
              (detailEventModel != null && detailEventModel.dealersModelList != null && detailEventModel.dealersModelList.length > 0)?
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children:
                     detailEventModel.dealersModelList.map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Chip(
                            label: Text(
                              e.dealerName,
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
                        )).toList(),
              ):Container()
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setSp(20)),
              child: Divider(
                height: 1,
                color: ColorConstants.lightBlackBorderColor,
              ),
            )
          ],
        ));
  }
}
