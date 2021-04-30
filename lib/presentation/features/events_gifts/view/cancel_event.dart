import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/detail_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';

class CancelEvent extends StatefulWidget {
  int eventId;
  CancelEvent(this.eventId);
  @override
  _CancelEventtState createState() => _CancelEventtState();
}

class _CancelEventtState extends State<CancelEvent> {
  DetailEventModel detailEventModel;
  DetailEventController detailEventController = Get.find();
  int _reasonId;

  @override
  void initState() {
    super.initState();
    getDetailEventsData();
  }

  getDetailEventsData() async {
    await detailEventController.getAccessKey().then((value) async {
      print(value.accessKey);
      await detailEventController
          .getDetailEventData(value.accessKey, widget.eventId)
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

    final dropDwnReason = DropdownButtonFormField(
      onChanged: (value) {
        setState(() {
          _reasonId = value;
        });
      },
      items: detailEventModel == null
          ? []
          :detailEventModel.cancelReasonList
          .map((e) => DropdownMenuItem(
                value: e.eventCancelReasonId,
                child: Text(e.eventCancelReason),
              ))
          .toList(),
      style: FormFieldStyle.formFieldTextStyle,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "No Dalmia Dealer in Vicinity"),
      validator: (value) => value == null ? 'Please select cancel reason' : null,
    );

    final comment = Container(
        color: ColorConstants.backgroundColorGrey,
        child: TextFormField(
          maxLines: 3,
          onChanged: (data) {
            setState(() {
              //_contactName = data;
            });
          },
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
        onPressed: () {},
        child: Text(
          'SUBMIT',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Positioned(
            top: 0,
            left: 200,
            right: 0,
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/Container.png',
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setSp(30),
              left: ScreenUtil().setSp(8),
              child: FlatButton(
            onPressed: (){
              Get.toNamed(Routes.HOME_SCREEN);
            },
            child: Row(
              children: [
                Icon(Icons.home, color: ColorConstants.clearAllTextColor,),
                SizedBox(width: ScreenUtil().setSp(5),),
                Text('HOME', style: TextStyles.robotoBtn14,),
              ],
            ),
          )),
          // Positioned.fill(
          //     child:
          Center(
            child: Container(
              height: ScreenUtil().setSp(500),
              margin: EdgeInsets.only(
                left: ScreenUtil().setSp(10),
                right: ScreenUtil().setSp(10),
                // top: ScreenUtil().setSp(20),
                // bottom: ScreenUtil().setSp(20),
              ),
              child: Column(
                children: [
                  Container(
                    height: ScreenUtil().setSp(94),
                    width: ScreenUtil().setSp(76),
                    child: Image.asset(
                      'assets/images/rejected.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setSp(20),
                  ),
                  Text(
                    'Cancelled',
                    style: TextStyles.mulliSemiBoldCancelStyle,
                  ),
                  SizedBox(
                    height: ScreenUtil().setSp(20),
                  ),
                  Text(
                    StringConstants.cancelAlertMsg,
                    style: TextStyles.robotoRegular14,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ScreenUtil().setSp(20),
                  ),
                  dropDwnReason,
                  SizedBox(
                    height: ScreenUtil().setSp(10),
                  ),
                  comment,
                  SizedBox(
                    height: ScreenUtil().setSp(20),
                  ),
                  btnSubmit
                ],
              ),
            ),
          )
          //)
        ]));
  }
}
