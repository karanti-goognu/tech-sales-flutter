import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EndEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/update_dlr_inf.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:get/get.dart';

class EndEvent extends StatefulWidget {
  int eventId;
  int fromPage;
  EndEvent(this.eventId, this.fromPage);

  @override
  _EndEventState createState() => _EndEventState();
}

class _EndEventState extends State<EndEvent> {
  ScrollController _scrollController;
  AllEventController _eventController = Get.find();

  MwpEndEventModel mwpEndEventModel;
  List<EventCcommentsList> eventCcommentsList;
  List<EventDealersModelList> eventDealersModelList;
  List<EventInfluencerModelsList> eventInfluencerModelsList;
  bool isVisible = false;

  getDetailEventsData() async {
    await _eventController
        .getEndEventDetail(widget.eventId.toString())
        .then((data) {
      setState(() {
        isVisible = data.showUpdateButton;
        mwpEndEventModel = data.mwpEndEventModel;
        eventCcommentsList = data.eventCcommentsList;
        eventDealersModelList = data.eventDealersModelList;
        eventInfluencerModelsList = data.eventInfluencerModelsList;
      });
    });
  }

  @override
  void initState() {
    // _eventController.getEndEventDetail(widget.eventId.toString()).then((value) => {
    //
    // });
    super.initState();
    getDetailEventsData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return WillPopScope(
        onWillPop: () async {
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          if (widget.fromPage == 0) {
            Get.back();
            Get.back();
            Get.back();
            Get.back();
          } else {
            Get.back();
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorConstants.appBarColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('EVENTS DETAILS', style: TextStyles.appBarTitleStyle),
                TextButton(
                  onPressed: () {
                    if (widget.fromPage == 0) {
                      Get.back();
                      Get.back();
                      Get.back();
                      Get.back();
                    } else {
                      Get.back();
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                        side: BorderSide(color: Colors.white)),
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text(
                    'CLOSE',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: BackFloatingButton(),
          bottomNavigationBar: BottomNavigator(),
          backgroundColor: Colors.white,
          body: (mwpEndEventModel != null)
              ? ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.sp,
                        right: 10.sp,
                        top: 20.sp,
                        bottom: 20.sp,
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${mwpEndEventModel.eventDate} | ${mwpEndEventModel.eventTime}',
                            style: TextStyles.mulliBoldBlue,
                          ),
                          ////Changes for update event after end

                          Visibility(
                            visible: isVisible,
                            //visible: true,
                            child: TextButton(
                                onPressed: () async {
                                  Map results = await Navigator.of(context)
                                      .push(new MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return UpdateDlrInf(
                                          mwpEndEventModel.eventId);
                                    },
                                  ));

                                  if (results != null &&
                                      results.containsKey('reload')) {
                                    getDetailEventsData();
                                  }
                                  // Get.to(
                                  //     () => UpdateDlrInf(
                                  //           detailEventModel.mwpEventModel.eventId,
                                  //         ),
                                  //     binding: EGBinding());
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
                                )),
                          )
                        ],
                      ),
                    ),
                    displayInfo('Event Type', mwpEndEventModel.eventTypeText),
                    displayInfo(
                        'Dalmia Influencers', mwpEndEventModel.dalmiaInflCount),
                    displayInfo('Actual Dalmia Influencers',
                        mwpEndEventModel.actualDalmiaInflCount),
                    displayInfo('Non-Dalmia Influencers',
                        mwpEndEventModel.nonDalmiaInflCount),
                    displayInfo('Actual Non-Dalmia Influencers',
                        mwpEndEventModel.actualNonDalmiaInflCount),
                    displayInfo('Total Participants',
                        mwpEndEventModel.totalParticipantsCount),
                    displayInfo('Actual Total Participants',
                        mwpEndEventModel.actualTotalParticipantsCount),
                    // displayInfo('Venue', 'Booked'),
                    displayInfo('Venue Address', mwpEndEventModel.venueAddress),
                    displayInfo('Actual Venue Address',
                        mwpEndEventModel.actualVenueAddress),
                    displayChipForDealer(
                        'Dealer(s) Detail',
                        eventDealersModelList != null
                            ? _eventController
                                .endEventModel.eventDealersModelList
                            : []),
                    displayChip(
                        'Influencer(s) Detail',
                        eventInfluencerModelsList != null
                            ? _eventController
                                .endEventModel.eventInfluencerModelsList
                            : []),
                    displayInfo(
                        'Expected Leads', mwpEndEventModel.expectedLeadsCount),
                    displayInfo(
                        'Actual Leads', mwpEndEventModel.actualLeadsCount),
                    displayInfo('Gift distribution',
                        mwpEndEventModel.giftDistributionCount),
                    displayInfo('Actual Gift distribution',
                        mwpEndEventModel.actualGiftDistributionCount),
                    displayInfo(
                        'Event location', mwpEndEventModel.eventLocation),
                    displayInfo('Actual Event location',
                        mwpEndEventModel.actualEventLocation),
                    Card(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
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
                            (eventCcommentsList != null &&
                                    eventCcommentsList.length > 0)
                                ? getList(eventCcommentsList)
                                : Container(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('No Comments !!'),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      width: 250,
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            if (widget.fromPage == 0) {
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                            } else {
                              Get.back();
                            }
                          },
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                                side: BorderSide(
                                    color: ColorConstants.appBarColor)),
                            backgroundColor: Colors.transparent,
                          ),
                          child: Text(
                            'CLOSE',
                            style: TextStyle(
                                color: ColorConstants.appBarColor,
                                fontSize: 15),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(
                  child: Center(
                    child: Text("No data!!"),
                  ),
                ),
        ));
  }

  Widget displayInfo(String title, var value) {
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
              SizedBox(
                width: 40,
              ),
              Flexible(
                child: Text(
                  value.toString(),
                  style: TextStyles.mulliBold16,
                ),
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

  Widget displayChip(String title, List list) {
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
                children: (list == null)
                    ? []
                    : list
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
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
              padding: EdgeInsets.only(top: 20.sp),
              child: Divider(
                height: 1,
                color: ColorConstants.lightBlackBorderColor,
              ),
            )
          ],
        ));
  }

  Widget displayChipForDealer(String title, List list) {
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
                children: (list == null)
                    ? []
                    : list
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Chip(
                                label: Text(
                                  e.dealerName,
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

  Widget getList(List list) {
    //  getSortedData();
    return (list != null && list.length > 0)
        //&& list != null)
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: list.length,
            padding: const EdgeInsets.only(left: 6.0, right: 6, bottom: 10),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
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
                        color: Colors.white,
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
}
