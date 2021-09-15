import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/bindings/add_leads_binding.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/approved_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/detail_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/StartEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/StartEventResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/cancel_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_pending.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/update_dlr_inf.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/AddNewLeadForm.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailViewEvent extends StatefulWidget {
  int eventId;
  DetailViewEvent(this.eventId);

  @override
  _DetailViewEventState createState() => _DetailViewEventState();
}

class _DetailViewEventState extends State<DetailViewEvent> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition = new Position();
  DetailEventModel detailEventModel;
  DetailEventController detailEventController = Get.find();
  EventsFilterController _eventsFilterController = Get.find();
  int total;
  bool isVisible = false;
  String isEventStarted;
  String referenceID;

  @override
  void initState() {
    super.initState();
    getDetailEventsData();
  }

  setVisibility() {
    if (detailEventModel.mwpEventModel.eventStatusText ==
            StringConstants.approved &&
        isEventStarted == 'N') {
      isVisible = true;
    } else {
      isVisible = false;
    }
  }

  getDetailEventsData() async {
    await detailEventController.getDetailEventData(widget.eventId).then((data) {
      setState(() {
        detailEventModel = data;
      });
      referenceID = detailEventModel.mwpEventModel.referenceId;
      isEventStarted = detailEventModel.mwpEventModel.isEventStarted;
      setVisibility();
      print('DDDD: $data');
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    final btnStartEvent = FlatButton(
      onPressed: () {
        _getCurrentLocation();
        // Get.dialog(CustomDialogs().showStartEventDialog(
        //     'Confirmation', "Do you want to start event?"));
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
          side: BorderSide(color: Colors.white)),
      color: Colors.transparent,
      child: Text(
        'START EVENT',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );

    final btnAddLead = FlatButton(
      onPressed: () {
        Get.to(
            () => AddNewLeadForm(
                  eventId: widget.eventId,
                ),
            binding: AddLeadsBinding());
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
          side: BorderSide(color: Colors.white)),
      color: Colors.transparent,
      child: Text(
        'ADD LEAD',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );

    final editRow = PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        height: 50,
        color: ColorConstants.appBarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
                onPressed: () {
                  Get.dialog(CustomDialogs().showCancelEventDialog( widget.eventId,'Confirmation',
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
                  Get.to(
                      () => DetailPending(
                          detailEventModel.mwpEventModel.eventId,
                          ColorConstants.eventApproved),
                      binding: EGBinding());
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
    );

    final endRow = PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        height: 50,
        color: ColorConstants.appBarColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
              onPressed: () {
                Get.dialog(
                    CustomDialogs().showCommentDialog("Please Enter Comment",
                        context, detailEventModel.mwpEventModel.eventId),
                    barrierDismissible: false);
                // Get.toNamed(Routes.END_EVENT);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                  side: BorderSide(color: Colors.white)),
              color: Colors.transparent,
              child: Text(
                'END EVENT',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            FlatButton(
                onPressed: () async {
                  Map results =
                      await Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) {
                      return UpdateDlrInf(
                        detailEventModel.mwpEventModel.eventId,
                      );
                    },
                  ));

                  if (results != null && results.containsKey('reload')) {
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
                        size: ScreenUtil().setSp(20)),
                    SizedBox(
                      width: ScreenUtil().setSp(5),
                    ),
                    Text('UPDATE DLR & INF.', style: TextStyles.robotoBtn14),
                  ],
                ))
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.appBarColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('EVENTS DETAILS', style: TextStyles.appBarTitleStyle),
              (detailEventModel != null &&
                      detailEventModel.mwpEventModel != null)
                  ? (detailEventModel.mwpEventModel.eventStatusText ==
                              StringConstants.approved &&
                          isEventStarted == "Y")
                      ? btnAddLead
                      : Visibility(visible: isVisible, child: btnStartEvent)
                  : Container(child: Text(''))
            ],
          ),
          bottom: (isEventStarted == "N" &&
                  detailEventModel.mwpEventModel.eventStatusText ==
                      StringConstants.approved)
              ? editRow
              : (isEventStarted == "Y" &&
                      detailEventModel.mwpEventModel.eventStatusText ==
                          StringConstants.approved)
                  ? endRow
                  : PreferredSize(
                      preferredSize: Size.fromHeight(0),
                      child: Container(),
                    )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BackFloatingButton(),
      bottomNavigationBar: BottomNavigator(),
      backgroundColor: Colors.white,
      body: (detailEventModel != null && detailEventModel.mwpEventModel != null)
          // && detailEventModel.eventDealersModelList != null)
          ? ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: ScreenUtil().setSp(10),
                    right: ScreenUtil().setSp(10),
                    top: ScreenUtil().setSp(20),
                    bottom: ScreenUtil().setSp(20),
                  ),
                  child: Text(
                    '${detailEventModel.mwpEventModel.eventDate} | ${detailEventModel.mwpEventModel.eventTime}',
                    style: TextStyles.mulliBoldBlue,
                  ),
                ),
                displayInfo('Event Type',
                    detailEventModel.mwpEventModel.eventTypeText ?? ''),
                displayInfo('Dalmia Influencers',
                    '${detailEventModel.mwpEventModel.dalmiaInflCount}' ?? '0'),
                displayInfo(
                    'Non-Dalmia Influencers',
                    '${detailEventModel.mwpEventModel.nonDalmiaInflCount}' ??
                        '0'),
                displayInfo(
                    'Total Participants',
                    '${(detailEventModel.mwpEventModel.dalmiaInflCount) + (detailEventModel.mwpEventModel.nonDalmiaInflCount)}' ??
                        '0'),
                displayInfo('Venue Address',
                    detailEventModel.mwpEventModel.venueAddress),
                displayChip('Dealer(s) Detail'),
                displayInfo(
                    'Expected Leads',
                    '${detailEventModel.mwpEventModel.expectedLeadsCount}' ??
                        '0'),
                displayInfo(
                    'Gift distribution',
                    '${detailEventModel.mwpEventModel.giftDistributionCount}' ??
                        '0'),
                displayInfo('Event location',
                    detailEventModel.mwpEventModel.eventLocation ?? ''),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setSp(15),
                      right: ScreenUtil().setSp(15),
                      top: ScreenUtil().setSp(5),
                      bottom: ScreenUtil().setSp(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comment',
                        style: TextStyles.formfieldLabelTextDark,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 8, right: 8),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey, // Set border color
                              width: 1.0), // Set border width
                        ),
                        child: Text(
                          detailEventModel.mwpEventModel.eventComment,
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setSp(40),
                )
              ],
            )
          : Container(
              child: Center(
                child: Text("No data!!"),
              ),
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
              Flexible(
                flex: 1,
                child: Text(
                  title,
                  style: TextStyles.formfieldLabelTextDark,
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  value,
                  style: TextStyles.mulliBold16,
                  //maxLines: null,
                  overflow: TextOverflow.ellipsis,
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
                child: (detailEventModel != null &&
                        detailEventModel.eventDealersModelList != null &&
                        detailEventModel.eventDealersModelList.length > 0)
                    ? ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: detailEventModel.eventDealersModelList
                            .map((e) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
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
                                ))
                            .toList(),
                      )
                    : Container()),
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

  // Widget showCancelEventDialog(int eventId, String heading, String message) {
  //   return AlertDialog(
  //     content: SingleChildScrollView(
  //       child: ListBody(
  //         children: <Widget>[
  //           Text(
  //             heading,
  //             style: GoogleFonts.roboto(
  //                 fontSize: 20,
  //                 height: 1.4,
  //                 letterSpacing: .25,
  //                 fontWeight: FontWeight.bold,
  //                 color: ColorConstants.inputBoxHintColorDark),
  //           ),
  //           Text(
  //             message,
  //             style: GoogleFonts.roboto(
  //                 fontSize: 16,
  //                 height: 1.4,
  //                 letterSpacing: .25,
  //                 fontStyle: FontStyle.normal,
  //                 color: ColorConstants.inputBoxHintColorDark),
  //           ),
  //         ],
  //       ),
  //     ),
  //     actions: <Widget>[
  //       TextButton(
  //         child: Text(
  //           'NO',
  //           style: GoogleFonts.roboto(
  //               fontSize: 20,
  //               letterSpacing: 1.25,
  //               fontStyle: FontStyle.normal,
  //               color: ColorConstants.buttonNormalColor),
  //         ),
  //         onPressed: () {
  //           Get.back();
  //         },
  //       ),
  //       TextButton(
  //         child: Text(
  //           'YES',
  //           style: GoogleFonts.roboto(
  //               fontSize: 20,
  //               letterSpacing: 1.25,
  //               fontStyle: FontStyle.normal,
  //               color: ColorConstants.buttonNormalColor),
  //         ),
  //         onPressed: () {
  //           Get.back();
  //           Get.to(() => CancelEvent(eventId), binding: EGBinding());
  //           //Get.toNamed(Routes.CANCEL_EVENT);
  //         },
  //       ),
  //     ],
  //   );
  // }

  _getCurrentLocation() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.back();
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {
      geolocator
          .getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      )
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          startEvent();
        });
        Get.back();
      }).catchError((e) {
        Get.back();
        Get.dialog(CustomDialogs().errorDialog(
            "Access to location data denied "));
        print(e);
      });
    }
  }

  startEvent() async {
    StartEventResponse _startEventResponse;
    StartEventModel _startEventModel = StartEventModel.fromJson({
      'eventID': widget.eventId,
      'eventStartUserLat': _currentPosition.latitude,
      'eventStartUserLong': _currentPosition.longitude,
      'isEventStarted': 'Y',
      'referenceID': referenceID,
    });

    internetChecking().then((result) => {
          if (result == true)
            {
              _eventsFilterController
                  .getAccessKeyAndStartEvent(_startEventModel)
                  .then((data) {
                      _startEventResponse = data;
                      print('DD: $_startEventResponse');
                      if(_startEventResponse.respCode == "DM2044") {
                        Get.dialog(
                            redirectToEventDetailPg(data.respMsg, data.eventID),
                          barrierDismissible: false);

                      }else if(_startEventResponse.respCode == "DM2043") {
                        Get.dialog(
                            CustomDialogs()
                                .errorDialogForEvent(data.respMsg.toString()),
                            barrierDismissible: false);
                      }
                      else{
                          Get.dialog(
                              CustomDialogs()
                                  .messageDialogMWP(data.respMsg.toString()),
                              barrierDismissible: false);
                        }
              })
            }
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
            }
        });
  }

  Widget redirectToEventDetailPg(String message, int eventId) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  height: 1.4,
                  letterSpacing: .25,
                  fontStyle: FontStyle.normal,
                  color: ColorConstants.inputBoxHintColorDark),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'View Event',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            Get.back();
            Get.to(() => DetailViewEvent(eventId), binding: EGBinding());
          },
        ),
      ],
    );
  }
}


//{"respCode":"DM2043","respMsg":"The event MINI CONTRACTOR MEET is scheduled for 18-05-2021 , you can not start now.","eventID":86,"eventTypeId":4,"eventTypeText":"MINI CONTRACTOR MEET","eventDate":1621276200000}
//{"respCode":"DM2043","respMsg":"You have not ended previous event/meet MINI CONTRACTOR MEET & 18-05-2021","eventID":86,"eventTypeId":4,"eventTypeText":"MINI CONTRACTOR MEET","eventDate":1621276200000}