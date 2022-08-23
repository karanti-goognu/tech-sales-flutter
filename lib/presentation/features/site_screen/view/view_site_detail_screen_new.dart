import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/site_data_widget.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/site_influencer_widget.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/site_past_stagehistory_widget.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/site_progress_widget.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/site_visit_widget.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/updated_values.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/background_container_image.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:flutter_tech_sales/widgets/custom_simmer_widget.dart';


// ignore: must_be_immutable
class ViewSiteScreen extends StatefulWidget {
  int? siteId;
  final tabIndex;

  ViewSiteScreen({this.siteId, this.tabIndex});

  @override
  _ViewSiteScreenState createState() => _ViewSiteScreenState();
}

class _ViewSiteScreenState extends State<ViewSiteScreen>
    with SingleTickerProviderStateMixin {
  SiteController _siteController = Get.find();
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
  TabController? _tabController;
  int? selectedTabIndex, labelId;
  int _initialIndex = 0;
  double? siteScore = 0.0;
  SiteStageEntity? _siteStage;
  List<SiteStageEntity>? siteStageEntity = new List.empty(growable: true);
  TextEditingController closureReasonText = new TextEditingController();
  bool fromDropDown = false;
  TextEditingController _nextVisitDate = new TextEditingController();
  TextEditingController _inactiveReasonText = new TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? empCode, name, labelText;
  List<File> _imageList = new List.empty(growable: true);
  List<ProductListModel> prdduct = new List.empty(growable: true);
  List<CounterListModel> subDealerList = new List.empty(growable: true);
  Future<ViewSiteDataResponse>? _getSiteData;

  @override
  void initState() {
    super.initState();
    selectedTabIndex = 0;
    _tabController =
        TabController(vsync: this, length: 5, initialIndex: widget.tabIndex);
    _getSiteData = getSiteData();
    UpdatedValues.setSiteProgressData(null, null, null, null, null);
    UpdatedValues.setAddNextButtonDisable(false);
    UpdatedValues.setFromDropDown(fromDropDown);
    UpdatedValues.setImageList(_imageList);
    UpdatedValues.setSiteCommentsEntity(null);
    UpdatedValues.setProductDynamicList(prdduct);
    UpdatedValues.setSiteConstructionId(null);
    UpdatedValues.setNoOfFloors(null);
    UpdatedValues.setSiteBuiltArea(null);
    UpdatedValues.setBathroomCount(null);
    UpdatedValues.setKitchenCount(TextEditingController());
    UpdatedValues.setSiteTotalPotential(null);
    UpdatedValues.setTotalBalancePotential(null);
    UpdatedValues.setSiteSelectedDB(null);
    UpdatedValues.setProductEntityFromLocalDb(null);
    UpdatedValues.setDealerEntityForDb(null);
    UpdatedValues.setSelectedSubDealer(null);
    UpdatedValues.setSubDealerList(subDealerList);
    UpdatedValues.setConstructionTypeVisitNextStage(null);
    UpdatedValues.setSiteBrandFromLocalDBNextStage(null);
    UpdatedValues.setSiteInfluencerDetails(null);
  }

  /// api calling getSiteData */
  Future<ViewSiteDataResponse> getSiteData() async {
    await _prefs.then((SharedPreferences prefs) {
      empCode = prefs.getString(StringConstants.employeeId) ?? "empty";
      name = prefs.getString(StringConstants.employeeName) ?? "empty";
      UpdatedValues.setEmpCode(empCode);
      UpdatedValues.setEmpName(name);
    });

    AccessKeyModel accessKeyModel = await _siteController.getAccessKeyOnly();
    viewSiteDataResponse = await _siteController.getSitedetailsData(
        accessKeyModel.accessKey, widget.siteId);
    print('object');
    log(jsonEncode(viewSiteDataResponse));
    setState(
      () {
        siteScore = viewSiteDataResponse.sitesModal!.siteScore;
        siteStageEntity = viewSiteDataResponse.siteStageEntity;
        for (int i = 0; i < siteStageEntity!.length; i++) {
          if (viewSiteDataResponse.sitesModal!.siteStageId.toString() ==
              siteStageEntity![i].id.toString()) {
            labelText = siteStageEntity![i].siteStageDesc;
            labelId = siteStageEntity![i].id;
            UpdatedValues.setSiteStageId(labelId);
          }
        }
      },
    );
    return viewSiteDataResponse;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ScreenUtil.init(context, designSize: Size(360, 690), minTextAdapt: true);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          new FocusNode(),
        );
      },
      child: DefaultTabController(
        initialIndex: _initialIndex,
        length: 4,
        child: FutureBuilder(
            future: _getSiteData,
            builder: (context, AsyncSnapshot<ViewSiteDataResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(body: simmerWidget(context));
              } else {
                if (snapshot.hasError)
                  return Scaffold(
                      body: Center(child: Text('Error: ${snapshot.error}')));
                else
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      toolbarHeight: 180,
                      titleSpacing: 0,
                      title: Stack(
                        children: [
                          BackgroundContainerImage(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, bottom: 10, left: 10),
                                    child: Text(
                                      "Trade site details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 25,
                                          color: HexColor("#006838"),
                                          fontFamily: "Muli"),
                                    ),
                                  ),
                                  selectedTabIndex == 3 || selectedTabIndex == 4
                                      ? Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0, bottom: 10),
                                              child: Icon(
                                                Icons.edit_outlined,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0,
                                                  bottom: 10,
                                                  right: 15),
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 18,
                                                    color: Colors.amber,
                                                    fontFamily: "Muli"),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          "ID: " + widget.siteId.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontFamily: "Muli",
                                          ),
                                        ),
                                        siteScore != 0.0
                                            ? Text(
                                                StringConstants.siteScore +
                                                    siteScore.toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor("#002A64"),
                                                  fontFamily: "Muli",
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    SizedBox(width: 100),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 1.0, right: 1.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[500]!,
                                                  offset: Offset(5.0, 5.0),
                                                  blurRadius: 10.0,
                                                  spreadRadius: 4.0)
                                            ]),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            // elevation: 100,
                                            value: _siteStage,
                                            items: siteStageEntity!
                                                .map((label) =>
                                                    DropdownMenuItem(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 7.0),
                                                        child: Text(
                                                          label.siteStageDesc!,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: ColorConstants
                                                                  .inputBoxHintColor,
                                                              fontFamily:
                                                                  "Muli"),
                                                        ),
                                                      ),
                                                      value: label,
                                                    ))
                                                .toList(),
                                            iconSize: 30,
                                            hint: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 6.0),
                                              child: (labelText != null)
                                                  ? Text(labelText!)
                                                  : Text(""),
                                            ),

                                            onChanged: (dynamic value) {
                                              setState(
                                                () {
                                                  _siteStage = value;
                                                  UpdatedValues.setSiteStageId(
                                                      value.id);
                                                  if (value.id == 2) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5.0),
                                                              ),
                                                            ),
                                                            content: Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Stack(
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                                                ),
                                                                                Container(width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.12, child: Image.asset('assets/images/rejected.png')),
                                                                                Text("Closed", style: TextStyle(fontSize: 30, color: HexColor("#B00020"))),
                                                                                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                                                                Center(child: Text("Please add your comment to complete this rejection", maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontSize: 15))),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(10.0),
                                                                                  child: TextFormField(
                                                                                    controller: closureReasonText,
                                                                                    maxLength: 100,
                                                                                    onChanged: (value) async {},
                                                                                    style: TextStyle(fontSize: 18, color: ColorConstants.inputBoxHintColor, fontFamily: "Muli"),
                                                                                    keyboardType: TextInputType.text,
                                                                                    maxLines: 4,
                                                                                    decoration: FormFieldStyle.buildInputDecoration(labelText: "Comments"),
                                                                                  ),
                                                                                ),
                                                                                Center(
                                                                                    child: ElevatedButton(
                                                                                        style: ElevatedButton.styleFrom(
                                                                                          elevation: 5,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                                          ),
                                                                                          primary: HexColor("#1C99D4"),
                                                                                        ),
                                                                                        child: Padding(padding: const EdgeInsets.only(bottom: 10, top: 10), child: Text("SUBMIT", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 17))),
                                                                                        onPressed: () async {
                                                                                          if (closureReasonText.text != "") {
                                                                                            _siteStage = value;
                                                                                            labelId = _siteStage!.id;
                                                                                            labelText = _siteStage!.siteStageDesc;
                                                                                            setState(() {
                                                                                              fromDropDown = true;
                                                                                              UpdatedValues.setFromDropDown(fromDropDown);
                                                                                            });
                                                                                            UpdatedValues updateRequest = new UpdatedValues();
                                                                                            updateRequest.updateRequest(context);
                                                                                          } else {
                                                                                            Get.dialog(CustomDialogs.showMessage("Please fill all details !!!"));
                                                                                          }
                                                                                        })),
                                                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01)
                                                                              ]),
                                                                        ),
                                                                      )
                                                                    ]),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  } else if (value.id == 3) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  0.0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0))),
                                                          content: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Stack(
                                                                children: [
                                                                  Center(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                              height: MediaQuery.of(context).size.height * 0.03),
                                                                          Container(
                                                                              width: MediaQuery.of(context).size.width * 0.3,
                                                                              height: MediaQuery.of(context).size.height * 0.12,
                                                                              child: Image.asset('assets/images/rejected.png')),
                                                                          Text(
                                                                              "Inactive",
                                                                              style: TextStyle(fontSize: 30, color: HexColor("#B00020"))),
                                                                          SizedBox(
                                                                              height: MediaQuery.of(context).size.height * 0.03),
                                                                          Center(
                                                                              child: Text("Please add your comment to complete this Inactive", maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontSize: 15))),
                                                                          SizedBox(
                                                                              height: MediaQuery.of(context).size.height * 0.01),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10.0),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: _nextVisitDate,
                                                                              readOnly: true,
                                                                              onChanged: (data) {},
                                                                              style: TextStyle(fontSize: 18, color: ColorConstants.inputBoxHintColor, fontFamily: "Muli"),
                                                                              keyboardType: TextInputType.text,
                                                                              decoration: InputDecoration(
                                                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.backgroundColorBlue, width: 1.0)),
                                                                                disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 1.0)),
                                                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26, width: 1.0)),
                                                                                errorBorder: OutlineInputBorder(
                                                                                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                                                                                ),
                                                                                labelText: "Next Visit Date ",
                                                                                suffixIcon: IconButton(
                                                                                  icon: Icon(
                                                                                    Icons.date_range_rounded,
                                                                                    size: 22,
                                                                                    color: ColorConstants.clearAllTextColor,
                                                                                  ),
                                                                                  onPressed: () async {
                                                                                    final DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2101));
                                                                                    setState(
                                                                                      () {
                                                                                        final DateFormat formatter = DateFormat("yyyy-MM-dd");
                                                                                        if (picked != null) {
                                                                                          final String formattedDate = formatter.format(picked);
                                                                                          _nextVisitDate.text = formattedDate;
                                                                                        }
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                ),
                                                                                filled: false,
                                                                                focusColor: Colors.black,
                                                                                isDense: false,
                                                                                labelStyle: TextStyle(fontFamily: "Muli", color: ColorConstants.inputBoxHintColorDark, fontWeight: FontWeight.normal, fontSize: 16.0),
                                                                                fillColor: ColorConstants.backgroundColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.01,
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10.0),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: _inactiveReasonText,
                                                                              maxLength: 100,
                                                                              onChanged: (value) async {},
                                                                              style: TextStyle(fontSize: 18, color: ColorConstants.inputBoxHintColor, fontFamily: "Muli"),
                                                                              keyboardType: TextInputType.text,
                                                                              maxLines: 4,
                                                                              decoration: FormFieldStyle.buildInputDecoration(
                                                                                labelText: "Comments",
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Center(
                                                                            child:
                                                                                ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                elevation: 5,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                ),
                                                                                primary: HexColor("#1C99D4"),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(bottom: 10, top: 10),
                                                                                child: Text(
                                                                                  "SUBMIT",
                                                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 17),
                                                                                ),
                                                                              ),
                                                                              onPressed: () async {
                                                                                if (_inactiveReasonText.text != "") {
                                                                                  _siteStage = value;
                                                                                  labelId = _siteStage!.id;
                                                                                  labelText = _siteStage!.siteStageDesc;
                                                                                  setState(() {
                                                                                    fromDropDown = true;
                                                                                    UpdatedValues.setFromDropDown(fromDropDown);
                                                                                  });
                                                                                  UpdatedValues updateRequest = new UpdatedValues();
                                                                                  updateRequest.updateRequest(context);
                                                                                  // UpdateRequest();
                                                                                } else {
                                                                                  Get.dialog(CustomDialogs.showMessage("Please fill all details !!!"));
                                                                                }
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.01,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      elevation: 0,
                      bottom: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        unselectedLabelColor: Colors.black,
                        labelColor: HexColor("#007CBF"),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: HexColor("#007CBF").withOpacity(0.1)),
                        onTap: (value) {
                          setState(() {
                            selectedTabIndex = value;
                          });
                        },
                        tabs: [
                          Tab(text: StringConstants.tabSiteData),
                          Tab(text: StringConstants.tabSiteProgres),
                          Tab(text: StringConstants.tabInfluencer),
                          Tab(text: StringConstants.tabPastStageHistory),
                          Tab(text: StringConstants.tabSiteVisit),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        SiteDataWidget(
                            siteId: widget.siteId,
                            viewSiteDataResponse: snapshot.data),
                        SiteProgressWidget(
                            viewSiteDataResponse: snapshot.data,
                            tabController: _tabController,
                            tabIndex: selectedTabIndex),
                        SiteInfluencerWidget(
                            viewSiteDataResponse: snapshot.data),
                        SitePastStageHistoryWidget(
                            viewSiteDataResponse: snapshot.data),
                        SiteVisitWidget(siteId: widget.siteId)
                      ],
                    ),
                    floatingActionButton: BackFloatingButton(),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    bottomNavigationBar: BottomNavigator(),
                  );
              }
            }),
      ),
    );
  }

  Widget simmerWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Padding(
              padding: const EdgeInsets.all(2.0),
              child: CustomSimmerWidget.rectangular(
                height: 40,
              )),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomSimmerWidget.rectangular(
                    height: 40,
                  )),
              Expanded(child: Container(),),
              Expanded(
                  child: CustomSimmerWidget.rectangular(
                    height: 40,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(2.0),
              child: CustomSimmerWidget.rectangular(
                height: 40,
                width: double.infinity,
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(2.0),
              child: CustomSimmerWidget.rectangular(
                  height: 60, width: double.infinity)),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CustomSimmerWidget.rectangular(
              height: 60,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: const EdgeInsets.all(2.0),
              child: CustomSimmerWidget.rectangular(
                height: 60,
                width: double.infinity,
              )),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CustomSimmerWidget.rectangular(
              height: 60,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
}

