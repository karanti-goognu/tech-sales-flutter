import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/common_widgets/background_container_image.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/detail_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/save_event_form_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/saveEventModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CancelEvent extends StatefulWidget {
  int eventId;
  CancelEvent(this.eventId);
  @override
  _CancelEventtState createState() => _CancelEventtState();
}

class _CancelEventtState extends State<CancelEvent> {
  DetailEventModel detailEventModel;
  DetailEventController detailEventController = Get.find();
  SaveEventController saveEventController = Get.find();
  List<DealersModels> selectedDealersModels = [];
  final _cancelEventFormKey = GlobalKey<FormState>();
  int _reasonId;
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getDetailEventsData();
  }

  Future getEmpId() async {
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empID = prefs.getString(StringConstants.employeeId);
    });
    return empID;
  }

  getDetailEventsData() async {
    // await detailEventController.getAccessKey().then((value) async {
    //  // print(value.accessKey);
      await detailEventController
          .getDetailEventData(widget.eventId)
          .then((data) {
        setState(() {
          detailEventModel = data;
          selectedDealersModels = detailEventModel.dealersModels;
        });
        print('DDDD: $data');
      });
   // });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    final dropDwnReason = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _reasonId = value;
        });
      },
      items: detailEventModel == null
          ? []
          : detailEventModel.cancelReasonList
              .map((e) => DropdownMenuItem(
                    value: e.eventCancelReasonId,
                    child: Text(e.eventCancelReason),
                  ))
              .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Select Reason for Cancellation"),
      validator: (value) =>
          value == null ? 'Please select cancel reason' : null,
    );

    final comment = Container(
        color: ColorConstants.backgroundColorGrey,
        child: TextFormField(
          controller: _commentController,
          validator: (value) {
            if (value.isEmpty) {
              return "Please add comment";
            }
            return null;
          },
          maxLines: 3,
          // onChanged: (data) {
          //   setState(() {
          //     //_contactName = data;
          //   });
          // },
          style: TextStyles.robotoRegular14,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Comments',
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ColorConstants.backgroundColorBlue, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26, width: 1.0),
            ),
            filled: false,
            focusColor: Colors.black,
            isDense: false,
            labelStyle: TextStyles.formfieldLabelText,
          ),
        ));

    final btnSubmit = Container(
      padding: EdgeInsets.only(top: 24, bottom: 9, left: 30, right: 30),
      child: MaterialButton(
        color: HexColor('#1C99D4'),
        onPressed: () {
          btnPresssed();
          },
        child: Text(
          'SUBMIT',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
    BackgroundContainerImage(),
          Positioned(
              top: 30.sp,
              left: 8.sp,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.HOME_SCREEN);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: ColorConstants.clearAllTextColor,
                    ),
                    SizedBox(
                      width: 5.sp,
                    ),
                    Text(
                      'HOME',
                      style: TextStyles.robotoBtn14,
                    ),
                  ],
                ),
              )),
          // Positioned.fill(
          //     child:
          Center(
            child: Container(
              height: 500.sp,
              margin: EdgeInsets.only(
                left: 10.sp,
                right: 10.sp,
              ),
              child: Form(
                key: _cancelEventFormKey,
                child: Column(
                  children: [
                    Container(
                      height: 94.sp,
                      width: 76.sp,
                      child: Image.asset(
                        'assets/images/rejected.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                      'Cancelled',
                      style: TextStyles.mulliSemiBoldCancelStyle,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Text(
                      StringConstants.cancelAlertMsg,
                      style: TextStyles.robotoRegular14,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    dropDwnReason,
                    SizedBox(
                      height: 10.sp,
                    ),
                    comment,
                    SizedBox(
                      height: 20..sp,
                    ),
                    btnSubmit
                  ],
                ),
              ),
            ),
          )
          //)
        ]));
  }

  btnPresssed() async {
    print('bbb');
    if (_cancelEventFormKey.currentState.validate()) {
      _cancelEventFormKey.currentState.save();
      String empId = await getEmpId();
      List dealersList = List.empty(growable: true);
      selectedDealersModels.forEach((e) {
        setState(() {
          dealersList.add({
            'eventStage': 'PLAN',
            'eventId': widget.eventId,
            'dealerName': e.dealerName,
            'dealerId': e.dealerId,
            'createdBy': empId,
            'eventDealerId': 0,
            'isActive': 'Y'
          });
        });
      });
      print('DEALERS: $dealersList');
      MwpeventFormRequest _mwpeventFormRequest = MwpeventFormRequest.fromJson({
        'dalmiaInflCount': detailEventModel.mwpEventModel.dalmiaInflCount,
        'eventComment': detailEventModel.mwpEventModel.eventComment,
        'eventDate': detailEventModel.mwpEventModel.eventDate,
        'eventId': detailEventModel.mwpEventModel.eventId,
        'eventLocation': detailEventModel.mwpEventModel.eventLocation,
        'eventLocationLat': double.tryParse('${detailEventModel.mwpEventModel.eventLocationLat}'),
        'eventLocationLong': double.tryParse('${detailEventModel.mwpEventModel.eventLocationLong}'),
        'eventStatusId': 5,
        'eventTime': detailEventModel.mwpEventModel.eventTime,
        'eventTypeId': detailEventModel.mwpEventModel.eventTypeId,
        'expectedLeadsCount': detailEventModel.mwpEventModel.expectedLeadsCount,
        'giftDistributionCount':
            detailEventModel.mwpEventModel.giftDistributionCount,
        'nondalmiaInflCount': detailEventModel.mwpEventModel.nonDalmiaInflCount,
        'referenceId': empId,
        'venue': detailEventModel.mwpEventModel.venue,
        'venueAddress': detailEventModel.mwpEventModel.venueAddress,
        'eventCancelReasonId': _reasonId,
        'eventCancelComment': _commentController.text,
        'isEventStarted': 'N',
      });

      SaveEventFormModel _save =
          SaveEventFormModel.fromJson({'eventDealersModelList': dealersList});
      SaveEventFormModel _saveEventFormModel = SaveEventFormModel(
          mwpeventFormRequest: _mwpeventFormRequest,
          eventDealersModelList: _save.eventDealersModelList);

      print('PARAMS: ${json.encode(_mwpeventFormRequest)}');

      internetChecking().then((result) => {
            if (result == true)
              {
                saveEventController
                    .getAccessKeyAndSaveRequest(_saveEventFormModel)
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
  }
}
