import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';

class EndEvent extends StatefulWidget {
  int eventId;
  EndEvent(this.eventId);

  @override
  _EndEventState createState() => _EndEventState();
}

class _EndEventState extends State<EndEvent> {
  ScrollController _scrollController;
  AllEventController _eventController = Get.find();
  @override
  void initState() {
    _eventController.getEndEventDetail(widget.eventId.toString());
    super.initState();
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
              btnCloseEvent
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.white,
      body: Obx(()=>
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
                  '${_eventController.endEventModel.mwpEndEventModel.eventDate} | ${_eventController.endEventModel.mwpEndEventModel.eventTime}',
                  style: TextStyles.mulliBoldBlue,
                ),
              ),
              displayInfo('Event Type', _eventController.endEventModel.mwpEndEventModel.eventTypeText),
              displayInfo('Dalmia Influencers', _eventController.endEventModel.mwpEndEventModel.dalmiaInflCount),
              displayInfo('Actual Dalmia Influencers', _eventController.endEventModel.mwpEndEventModel.actualDalmiaInflCount),
              displayInfo('Non-Dalmia Influencers', _eventController.endEventModel.mwpEndEventModel.nonDalmiaInflCount),
              displayInfo('Actual Non-Dalmia Influencers', _eventController.endEventModel.mwpEndEventModel.actualNonDalmiaInflCount),
              displayInfo('Total Participants', _eventController.endEventModel.mwpEndEventModel.totalParticipantsCount),
              displayInfo('Actual Total Participants', _eventController.endEventModel.mwpEndEventModel.actualTotalParticipantsCount),
              // displayInfo('Venue', 'Booked'),
              displayInfo('Venue Address', _eventController.endEventModel.mwpEndEventModel.venueAddress),
              displayInfo('Actual Venue Address', _eventController.endEventModel.mwpEndEventModel.actualVenueAddress),
              displayChip('Dealer(s) Detail', _eventController.endEventModel.eventInfluencerModelsList),
              displayChip('Influencer(s) Detail', _eventController.endEventModel.eventInfluencerModelsList),
              displayInfo('Expected Leads', _eventController.endEventModel.mwpEndEventModel.expectedLeadsCount),
              displayInfo('Actual Leads', _eventController.endEventModel.mwpEndEventModel.actualLeadsCount),
              displayInfo('Gift distribution', _eventController.endEventModel.mwpEndEventModel.giftDistributionCount),
              displayInfo('Actual Gift distribution', _eventController.endEventModel.mwpEndEventModel.actualGiftDistributionCount),
              displayInfo('Event location', _eventController.endEventModel.mwpEndEventModel.eventLocation),
              displayInfo('Actual Event location', _eventController.endEventModel.mwpEndEventModel.actualEventLocation),
              Card(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 20),
                elevation: 0,
                child: Theme(
                  data: ThemeData(splashColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Row(
                      children: [
                        Container(
                            height: 20,
                            width: 20,
                            child: Icon(Icons.insert_comment_outlined)),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Past Comments'),
                      ],
                    ),
                    children: [
                      (_eventController.endEventModel.eventCcommentsList != null && _eventController.endEventModel.eventCcommentsList.length > 0)?
                      getList(_eventController.endEventModel.eventCcommentsList):Container(
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('No Comments !!'),
                        ),),)
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom:30),
                width: 250,
                child:Center(child: btnCloseEventBottom,),)
            ],
          )),
    );
  }

  Widget displayInfo(String title, var value) {
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
              SizedBox(width: 40,),
              Flexible(
                child: Text(
                  value.toString(),
                  style: TextStyles.mulliBold16,
                ),
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

  Widget displayChip(String title, List list) {
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
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: list
                    .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Chip(
                    label: Text(
                      e.inflName,
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
              padding: EdgeInsets.only(top: ScreenUtil().setSp(20)),
              child: Divider(
                height: 1,
                color: ColorConstants.lightBlackBorderColor,
              ),
            )
          ],
        ));
  }

  Widget getList(List list) {
    //  getSortedData();
    return (list != null && list.length > 0 )
    //&& list != null)
        ? ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: list.length,
        padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {

            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              borderOnForeground: true,
              elevation: 0,
              margin: EdgeInsets.all(4.0),
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                        color:
                        Colors.white,
                        width: 0,
                      )),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            list[index].comments,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.normal),
                            // ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        })
        : Container(
      child: Center(
        child: Text("No data!!"),
      ),
    );
  }

  final btnCloseEvent = FlatButton(
    onPressed: () {
        Get.back();
    },
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
        side: BorderSide(color: Colors.white)),
    color: Colors.transparent,
    child: Text(
      'CLOSE',
      style: TextStyle(color: Colors.white, fontSize: 15),
    ),
  );
  final btnCloseEventBottom = FlatButton(
    onPressed: () {
      Get.back();
    },
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
        side: BorderSide(color: ColorConstants.appBarColor)),
    color: Colors.transparent,
    child: Text(
      'CLOSE',
      style: TextStyle(color: ColorConstants.appBarColor, fontSize: 15),
    ),
  );

}