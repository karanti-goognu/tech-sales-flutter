import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';

class InfluencerView extends StatefulWidget {
  @override
  _InfluencerViewState createState() => _InfluencerViewState();
}

class _InfluencerViewState extends State<InfluencerView> {
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return WillPopScope(
        onWillPop: () async {
          // disposeController(context);
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor: ColorConstants.backgroundColorGrey,
            appBar: AppBar(
              backgroundColor: ColorConstants.appBarColor,
              toolbarHeight: SizeConfig.screenHeight * .14,
              centerTitle: false,
              title:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        "INFLUENCER",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 22,
                            color: Colors.white,
                            fontFamily: "Muli"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                        child: DropdownButtonFormField(
                          onChanged: (value) {
                            setState(() {
                             // _selectedEnrollValue = value;
                            });
                          },
                          items: ['Yes', 'No']
                              .map((e) => DropdownMenuItem(
                            value: e,
                            child: Padding(
                              padding:  EdgeInsets.only(left : 2.0),
                              child: Text(e),
                            ),
                          ))
                              .toList(),
                          style: FormFieldStyle.formFieldTextStyle,

                          // validator: (value) =>
                          // value == null ? 'Please select Dalmia Master' : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              automaticallyImplyLeading: false,
            ),
            floatingActionButton:
                SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigator(),
            body: Container(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 15.0, bottom: 5, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Obx(
                    //       () =>
                    Text(
                      "Total Influencer : 89",
                      //  ${(_siteController.sitesListResponse.sitesEntity == null) ? 0 : _siteController.sitesListResponse.sitesEntity.length}",
                      style: TextStyle(
                        fontFamily: "Muli",
                        fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                        // color: HexColor("#FFFFFF99"),
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
              Expanded(child: leadsDetailWidget()),
            ]))));
  }

  Widget leadsDetailWidget() {
    return
        //   Obx(() => (_siteController == null)
        //     ? Container(
        //   child: Center(
        //     child: Text("Sites controller  is empty!!"),
        //   ),
        // )
        //     : (_siteController.sitesListResponse == null)
        //     ? Container(
        //   child: Center(
        //     child: Text("Sites list response  is empty!!"),
        //   ),
        // )
        //     : (_siteController.sitesListResponse.sitesEntity == null)
        //     ? Container(
        //   child: Center(
        //     child: Text("Sites list is empty!!"),
        //   ),
        // )
        //     : (_siteController.sitesListResponse.sitesEntity.length == 0)
        //     ?
        //   Container(
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text("You don't have any Sites..!!"),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         RaisedButton(
        //           onPressed: () {
        //             // _appController
        //             //     .getAccessKey(RequestIds.GET_LEADS_LIST);
        //           },
        //           color: ColorConstants.buttonNormalColor,
        //           child: Text(
        //             "TRY AGAIN",
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // )
        //     :
        ListView.builder(
            controller: _scrollController,
            itemCount: 10,
            //_siteController.sitesListResponse.sitesEntity.length,
            padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
            // itemExtent: 125.0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context, new CupertinoPageRoute(
                  //     builder: (BuildContext context) =>
                  //         ViewSiteScreen(siteId: _siteController.sitesListResponse.sitesEntity[index].siteId,tabIndex: 0,))
                  // );
                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  borderOnForeground: true,
                  elevation: 6,
                  margin: EdgeInsets.all(5.0),
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text("22-10-2020",
                                                // "Site ID (${_siteController.sitesListResponse.sitesEntity[index].siteId})",
                                                style: TextStyles
                                                    .formfieldLabelText),
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                                "Avg.Monthly Vol.:${'200MT'}",
                                                // "Site ID (${_siteController.sitesListResponse.sitesEntity[index].siteId})",
                                                style: TextStyles
                                                    .formfieldLabelText),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "Inf. Name :",
                                        // "District: ${_siteController.sitesListResponse.sitesEntity[index].siteDistrict} ",
                                        style: TextStyles.mulliBold18,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text("Base city",
                                                // "Site ID (${_siteController.sitesListResponse.sitesEntity[index].siteId})",
                                                style: TextStyles
                                                    .formfieldLabelText),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Chip(
                                              shape: StadiumBorder(
                                                  side: BorderSide(
                                                      color:
                                                          HexColor("#39B54A"))),
                                              backgroundColor:
                                                  HexColor("#39B54A"),
                                              label: Text("A. Site-43",
                                                  style: TextStyles.btnWhite),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //  FittedBox(
                                    //   child:
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setSp(2),
                                          right: ScreenUtil().setSp(2)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Chip(
                                            shape: StadiumBorder(
                                                side: BorderSide(
                                                    color:
                                                        HexColor("#39B54A"))),
                                            backgroundColor: HexColor("#39B54A")
                                                .withOpacity(0.1),
                                            label: Text(
                                              "Mason",
                                              style: TextStyle(
                                                  color: HexColor("#39B54A"),
                                                  fontSize: 11,
                                                  fontFamily: "Muli",
                                                  fontWeight: FontWeight.bold
                                                  //fontWeight: FontWeight.normal
                                                  ),
                                            ),
                                          ),
                                          Text("Contact Info",
                                              // " ${_siteController.sitesListResponse.sitesEntity[index].siteCreationDate}",

                                              style:
                                                  TextStyles.contactTextStyle),
                                        ],
                                      ),
                                    ),
                                    //  )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }
}

/*
class _InfluencerViewState extends State<InfluencerView> {
  Color _color= ColorConstants.backgroundColorBlue;
  final random = Random();
  Duration oneSec = const Duration(seconds:1);
  changeColors(){
    new Timer.periodic(oneSec, (Timer t) =>
    setState(() {
      _color = Color.fromRGBO(
        random.nextInt(100),
        random.nextInt(56),
        random.nextInt(256),
        0.1,
      );
    }));
  }
  @override
  void initState() {
    if(!this.mounted){
      changeColors();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BackFloatingButton(),
     body: AnimatedContainer(
       height: MediaQuery.of(context).size.height,
       width:MediaQuery.of(context).size.width,
       color: Colors.white,
       // color: _color,
       child: Center(child: Text("Page coming soon",),),
     duration: Duration(seconds: 4),curve: Curves.fastOutSlowIn,),
    );
  }

}

 */
