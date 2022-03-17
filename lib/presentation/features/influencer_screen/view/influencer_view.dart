

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/bindings/influencer_binding.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/view/influencer_detail_view.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/view/influencer_name_list.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InfluencerView extends StatefulWidget {
  @override
  _InfluencerViewState createState() => _InfluencerViewState();
}

class _InfluencerViewState extends State<InfluencerView> {
  ScrollController? _scrollController;
  InfController _infController = Get.find();
  InfluencerListModel? _influencerListModel;
  List<InfluencerTypeList>? _influencerTypeList;
  late List<InfluencerTypeList> _inf;
  int? _selectedValue;
  String total = " ";

  @override
  void initState() {
    super.initState();
    _infController.inflTypeId = "";
    getData();
  }

  getData() {
    internetChecking().then((result) => {
          if (result == true)
            {
              _infController.getInfluencerList().then((data) {
                setState(() {
                  if (data != null) {
                    _influencerListModel = data;
                    _influencerTypeList =
                        _influencerListModel!.response!.influencerTypeList;

                    List<InfluencerTypeList> infList = [
                      InfluencerTypeList(
                          inflTypeId: 0, inflTypeDesc: 'All', infRegFlag: 'Y')
                    ];

                    _inf = infList + _influencerTypeList!;
                    total =
                        '${(_influencerListModel!.response!.totalInfluencerCount == null) ? 0 : _influencerListModel!.response!.totalInfluencerCount}';
                  }
                });
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

  Widget build(BuildContext context) {
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
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor: ColorConstants.backgroundColorGrey,
            appBar: AppBar(
              backgroundColor: ColorConstants.appBarColor,
              toolbarHeight: SizeConfig.screenHeight! * .14,
              centerTitle: false,
              title:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
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
                          hint: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text("All"),
                          ),
                          onChanged: (dynamic value) {
                            setState(() {
                              _selectedValue = value;
                              if (_selectedValue == 0) {
                                _infController.inflTypeId = "";
                              } else {
                                _infController.inflTypeId = '$_selectedValue';
                              }
                              getData();
                            });
                          },
                          items: (_influencerListModel == null &&
                                  _influencerTypeList == null)
                              ? []
                              : _inf
                                  .map((e) => DropdownMenuItem(
                                        value: e.inflTypeId,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 2.0),
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(e.inflTypeDesc!)),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                          style: FormFieldStyle.formFieldTextStyle,
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
            bottomNavigationBar: BottomNavigator(
              searchType: "influencer",
            ),
            body: Container(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 15.0, bottom: 5, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Total Influencer : $total",
                      style: TextStyle(
                        fontFamily: "Muli",
                        fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: leadsDetailWidget()),
            ]))));
  }

  Widget leadsDetailWidget() {
    return (_influencerListModel == null)
        ? Container(
            child: Center(
              child: Text(""),
            ),
          )
        : (_influencerListModel!.response == null)
            ? Container(
                child: Center(
                  child: Text("Sites list response  is empty!!"),
                ),
              )
            : (_influencerListModel!.response!.ilpInfluencerEntity == null)
                ? Container(
                    child: Center(
                      child: Text("Influencer list is empty!!"),
                    ),
                  )
                : (_influencerListModel!.response!.ilpInfluencerEntity!.length ==
                        0)
                    ? Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("You don't have any Influencers..!!"),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  getData();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary:ColorConstants.buttonNormalColor,
                                ),
                                child: Text(
                                  "TRY AGAIN",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _influencerListModel!
                            .response!.ilpInfluencerEntity!.length,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, bottom: 80),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          InfluencerDetailView(
                                              _influencerListModel!
                                                  .response!
                                                  .ilpInfluencerEntity![index]
                                                  .membershipId)));
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              _influencerListModel!
                                                                      .response!
                                                                      .ilpInfluencerEntity![
                                                                          index]
                                                                      .joiningDate ??
                                                                  "",
                                                              style: TextStyles
                                                                  .formfieldLabelText)),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "Avg.Monthly Vol.:${_influencerListModel!.response!.ilpInfluencerEntity![index].monthlyPotentialVolMt == null ? "" : _influencerListModel!.response!.ilpInfluencerEntity![index].monthlyPotentialVolMt}MT",
                                                          style: TextStyles
                                                              .formfieldLabelText,
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Container(
                                                          padding:
                                                              new EdgeInsets
                                                                      .only(
                                                                  right: 5.0),
                                                          child: Text(
                                                            "${_influencerListModel!.response!.ilpInfluencerEntity![index].inflName == null ? " " : _influencerListModel!.response!.ilpInfluencerEntity![index].inflName}",
                                                            style: TextStyles
                                                                .mulliBold18,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Chip(
                                                          shape: StadiumBorder(
                                                              side: BorderSide(
                                                                  color: HexColor(
                                                                      "#6200EE"))),
                                                          backgroundColor:
                                                              HexColor(
                                                                      "#6200EE")
                                                                  .withOpacity(
                                                                      0.1),
                                                          label: Text(
                                                            "${_influencerListModel!.response!.ilpInfluencerEntity![index].inflTypeText == null ? "" : _influencerListModel!.response!.ilpInfluencerEntity![index].inflTypeText}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: HexColor(
                                                                    "#6200EE"),
                                                                fontSize: 11,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [

                                                      Text(
                                                          "${(_influencerListModel!.response!.ilpInfluencerEntity![index].baseCity == null || _influencerListModel!.response!.ilpInfluencerEntity![index].baseCity == "") ? "-" : _influencerListModel!.response!.ilpInfluencerEntity![index].baseCity}",
                                                          style: TextStyles
                                                              .formfieldLabelText),
                                                      Chip(
                                                        shape: StadiumBorder(
                                                            side: BorderSide(
                                                                color: HexColor(
                                                                    "#39B54A"))),
                                                        backgroundColor:
                                                            HexColor("#39B54A"),
                                                        label: Text(
                                                            "${_influencerListModel!.response!.ilpInfluencerEntity![index].membershipId == null ? "" : _influencerListModel!.response!.ilpInfluencerEntity![index].membershipId}",
                                                            style: TextStyles
                                                                .btnWhite),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.sp, right: 2.sp),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            Get.to(
                                                                () => InfluencerNameList(
                                                                    influencerID:
                                                                        '${_influencerListModel!.response!.ilpInfluencerEntity![index].membershipId}',
                                                                    influencerName: _influencerListModel!
                                                                        .response!
                                                                        .ilpInfluencerEntity![
                                                                            index]
                                                                        .inflName),
                                                                binding:
                                                                    InfBinding());
                                                          },
                                                          child: Chip(
                                                            shape: StadiumBorder(
                                                                side: BorderSide(
                                                                    color: HexColor(
                                                                        "#007CBF"))),
                                                            backgroundColor:
                                                                HexColor(
                                                                    "#007CBF"),
                                                            label: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "A. SITE - ${_influencerListModel!.response!.ilpInfluencerEntity![index].activeSitesCount == null ? "00" : _influencerListModel!.response!.ilpInfluencerEntity![index].activeSitesCount}",
                                                                    style: TextStyle(
                                                                        color: HexColor(
                                                                            "#FFFFFFDE"),
                                                                        fontSize: 11
                                                                            .sp,
                                                                        fontFamily:
                                                                            "Muli",
                                                                        fontWeight:
                                                                            FontWeight.bold
                                                                        ),
                                                                  ),
                                                                  Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: HexColor(
                                                                          "#FFFFFFDE"),
                                                                      size:
                                                                          11.sp)
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.dialog(showContactDialog(
                                                              'Info',
                                                              '${_influencerListModel!.response!.ilpInfluencerEntity![index].mobileNumber}',
                                                              '${_influencerListModel!.response!.ilpInfluencerEntity![index].giftAddress == null ? "-" : _influencerListModel!.response!.ilpInfluencerEntity![index].giftAddress}',
                                                              '${_influencerListModel!.response!.ilpInfluencerEntity![index].email == null ? "-" : _influencerListModel!.response!.ilpInfluencerEntity![index].email}',
                                                              context));
                                                        },
                                                        child: Text(
                                                            "Contact Info",

                                                            style: TextStyles
                                                                .contactTextStyle),
                                                      ),
                                                    ],
                                                  ),
                                                ),
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

  Widget showContactDialog(String respMsg, String contact, String address,
      String email, BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  respMsg,
                  style: TextStyles.mulliBold16,
                ),
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    })
              ],
            ),
            SizedBox(height: 8.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Contact No:",
                  style: TextStyles.formfieldLabelText,
                ),
                SizedBox(width: 0.sp),
                GestureDetector(
                  child: FittedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: HexColor("#8DC63F"),
                        ),
                        Text(
                          contact,
                          style: TextStyles.formfieldLabelTextDark,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    String num = contact;
                    launch('tel:$num');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address:",
                  style: TextStyles.formfieldLabelText,
                ),
                SizedBox(width: 40.sp),
                Expanded(
                    child: Text(
                  address,
                  maxLines: null,
                  textAlign: TextAlign.end,
                  style: TextStyles.formfieldLabelTextDark,
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(
                  "Email:",
                  style: TextStyles.formfieldLabelText,
                ),
                SizedBox(width: 40.sp),
                Expanded(
                    child: Text(
                  email,
                  maxLines: null,
                  textAlign: TextAlign.end,
                  style: TextStyles.formfieldLabelTextDark,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
