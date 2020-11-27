import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/DraftLeadListScreen.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/Model/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;


class ViewSiteScreen extends StatefulWidget {
  int siteId;

  ViewSiteScreen(this.siteId);

  @override
  _ViewSiteScreenState createState() => _ViewSiteScreenState();
}

class _ViewSiteScreenState extends State<ViewSiteScreen> {
  bool isSwitchedsiteProductDemo = false;
  bool isSwitchedsiteProductOralBriefing= false;

  ConstructionStageEntity _selectedConstructionType;
  SiteFloorsEntity _selectedSiteFloor;
  var _siteBuiltupArea = new TextEditingController();
  var _siteProductDemo = new TextEditingController();
  var _siteProductOralBriefing = new TextEditingController();
  var _siteTotalBags = new TextEditingController();
  var _siteTotalPt = new TextEditingController();

  SitesModal sitesModal;
  List<SiteFloorsEntity> siteFloorsEntity = new List();
  List<SitephotosEntity> sitephotosEntity;
  List<SiteVisitHistoryEntity> siteVisitHistoryEntity;
  List<ConstructionStageEntity> constructionStageEntity = new List();
  List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity;
  List<SiteCompetitionStatusEntity> siteCompetitionStatusEntity;
  List<SiteBrandEntity> siteBrandEntity;
  List<SiteInfluencerEntity> siteInfluencerEntity;
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity;

  SiteController _siteController = Get.find();
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.siteId);
    getSiteData();
  }

  Future<void> getSiteData() async {
    AccessKeyModel accessKeyModel = new AccessKeyModel();
    await _siteController.getAccessKeyOnly().then((data) async {
      accessKeyModel = data;
      print("AccessKey :: " + accessKeyModel.accessKey);
      await _siteController
          .getSiteData(accessKeyModel.accessKey, widget.siteId)
          .then((data) {
        print("here");
        print(data);
        viewSiteDataResponse = data;

        print(viewSiteDataResponse);

        setState(() {
          constructionStageEntity =
              viewSiteDataResponse.constructionStageEntity;
          siteFloorsEntity = viewSiteDataResponse.siteFloorsEntity;

          sitesModal = viewSiteDataResponse.sitesModal;
          _siteBuiltupArea.text = sitesModal.siteBuiltArea;
          _siteProductDemo.text = sitesModal.siteProductDemo;
          if (_siteProductDemo.text == 'N') {
            isSwitchedsiteProductDemo = false;
          } else {
            isSwitchedsiteProductDemo = true;
          }

          _siteProductOralBriefing.text = sitesModal.siteProductOralBriefing;

          if (_siteProductOralBriefing.text == 'N') {
            isSwitchedsiteProductOralBriefing = false;
          } else {
            isSwitchedsiteProductOralBriefing = true;
          }

          _siteTotalPt.text = sitesModal.siteTotalSitePotential;
          _siteTotalBags.text =
              (int.parse(sitesModal.siteTotalSitePotential) * 20).toString();
        });
      });
      // Future.delayed(
      //     Duration.zero,
      //         () => Get.dialog(Center(),
      //         barrierDismissible: false));
      //  Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    //gv.selectedClass = widget.classroomId;
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(

            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: 180,
            title: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 210,
                    right: 0,
                    child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/Container.png',
                              fit: BoxFit.fill,
                            ),
                          ],
                        ))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 10, left: 5),
                          child: Text(
                            "Trade site details",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 25,
                                color: HexColor("#006838"),
                                fontFamily: "Muli"),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 6.0, bottom: 8.0),
                                child: Text(
                                  "Site Score: " + "08",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: HexColor("#002A64"),
                                    fontFamily: "Muli",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            elevation: 0,
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                //  indicatorColor: Colors.black,
                labelColor: HexColor("#007CBF"),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: HexColor("#007CBF").withOpacity(0.1)),
                tabs: [
                  Tab(
                    text: "Site Data",
                  ),
                  Tab(
                    text: "Visit Data",
                  ),
                  Tab(
                    text: "Influencer",
                  ),
                  Tab(
                    text: "Past Stage History",
                  ),
                ]),
          ),
          body: TabBarView(
            children: <Widget>[
              siteDataView(),
              visitDataView(),
              influencerView(),
              pastStageHistoryview(),
            ],
          ),
            floatingActionButton:
            Container(
              height: 68.0,
              width: 68.0,
              child: FittedBox(
                child: FloatingActionButton(

                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    gv.fromLead=false;
                    Get.toNamed(Routes.ADD_LEADS_SCREEN);
                  },
                ),
              ),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: ColorConstants.appBarColor,
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              // currentScreen =
                              //     Dashboard(); // if user taps on this dashboard tab will be active
                              // currentTab = 0;
                              Get.toNamed(Routes.HOME_SCREEN);
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.white60,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Right Tab bar icons

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            Navigator.push(
                                context,
                                new CupertinoPageRoute(
                                    builder: (BuildContext context) => DraftLeadListScreen()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.drafts,
                                color: Colors.white60,
                              ),
                              Text(
                                'Drafts',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            Get.toNamed(Routes.SEARCH_SCREEN);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                color: Colors.white60,
                              ),
                              Text(
                                'Search',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          //child:Text("classroomName")
        ));
  }

  Widget siteDataView() {
    return SingleChildScrollView(
      child: Container(
          child: Form(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<ConstructionStageEntity>(
                          value: _selectedConstructionType,
                          items: constructionStageEntity
                              .map((label) => DropdownMenuItem(
                                    child: Text(
                                      label.constructionStageText,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ColorConstants.inputBoxHintColor,
                                          fontFamily: "Muli"),
                                    ),
                                    value: label,
                                  ))
                              .toList(),

                          // hint: Text('Rating'),
                          onChanged: (value) {
                            setState(() {
                              _selectedConstructionType = value;
                            });
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.backgroundColorBlue,
                                  //color: HexColor("#0000001F"),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black26, width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelText: "Type of Construction",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Mandatory",
                            style: TextStyle(
                              fontFamily: "Muli",
                              color: ColorConstants.inputBoxHintColorDark,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _siteBuiltupArea,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Site Built-Up Area ';
                            }

                            return null;
                          },
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.inputBoxHintColor,
                              fontFamily: "Muli"),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorConstants.backgroundColorBlue,
                                  //color: HexColor("#0000001F"),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color(0xFF000000).withOpacity(0.4),
                                  width: 1.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0),
                            ),
                            labelText: "Site Built-up area",
                            filled: false,
                            focusColor: Colors.black,
                            labelStyle: TextStyle(
                                fontFamily: "Muli",
                                color: ColorConstants.inputBoxHintColorDark,
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0),
                            fillColor: ColorConstants.backgroundColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Mandatory",
                            style: TextStyle(
                              fontFamily: "Muli",
                              color: ColorConstants.inputBoxHintColorDark,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 5),
                          child: Text(
                            "No. of Floors",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                // color: HexColor("#000000DE"),
                                fontFamily: "Muli"),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextFormField(
                                  enabled: false,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.inputBoxHintColor,
                                      fontFamily: "Muli"),
                                  // keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.backgroundColorBlue,
                                          //color: HexColor("#0000001F"),
                                          width: 1.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.4),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.4),
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    labelText: "Ground",
                                    filled: false,
                                    focusColor: Colors.black,
                                    labelStyle: TextStyle(
                                        fontFamily: "Muli",
                                        color:
                                            ColorConstants.inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0),
                                    fillColor: ColorConstants.backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: DropdownButtonFormField<SiteFloorsEntity>(
                                  value: _selectedSiteFloor,
                                  items: siteFloorsEntity
                                      .map((label) => DropdownMenuItem(
                                            child: Text(
                                              label.siteFloorTxt,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: ColorConstants
                                                      .inputBoxHintColor,
                                                  fontFamily: "Muli"),
                                            ),
                                            value: label,
                                          ))
                                      .toList(),

                                  // hint: Text('Rating'),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSiteFloor = value;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.backgroundColorBlue,
                                          //color: HexColor("#0000001F"),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black26, width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    labelText: "+ Floors",
                                    filled: false,
                                    focusColor: Colors.black,
                                    isDense: false,
                                    labelStyle: TextStyle(
                                        fontFamily: "Muli",
                                        color:
                                            ColorConstants.inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0),
                                    fillColor: ColorConstants.backgroundColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "Site Demo conducted",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                // color: HexColor("#000000DE"),
                                fontFamily: "Muli"),
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product demo",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    // color: HexColor("#000000DE"),
                                    fontFamily: "Muli"),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                  Switch(
                                    onChanged: toggleSwitchForProductDemo,
                                    value: isSwitchedsiteProductDemo,
                                    activeColor: HexColor("#009688"),
                                    activeTrackColor:
                                        HexColor("#009688").withOpacity(0.5),
                                    inactiveThumbColor: HexColor("#F1F1F1"),
                                    inactiveTrackColor: Colors.black26,
                                  ),
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: isSwitchedsiteProductDemo
                                            ? HexColor("#009688")
                                            : Colors.black,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product oral briefing",
                                style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    // color: HexColor("#000000DE"),
                                    fontFamily: "Muli"),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "No",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                  Switch(
                                    onChanged: toggleSwitchForOralBriefing,
                                    value: isSwitchedsiteProductOralBriefing,
                                    activeColor: HexColor("#009688"),
                                    activeTrackColor:
                                        HexColor("#009688").withOpacity(0.5),
                                    inactiveThumbColor: HexColor("#F1F1F1"),
                                    inactiveTrackColor: Colors.black26,
                                  ),
                                  Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: isSwitchedsiteProductOralBriefing
                                            ? HexColor("#009688")
                                            : Colors.black,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20, left: 5),
                          child: Text(
                            "Total Site Potential",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                // color: HexColor("#000000DE"),
                                fontFamily: "Muli"),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: TextFormField(
                                  // initialValue: _totalBags.toString(),
                                  controller: _siteTotalBags,
                                  onChanged: (value) {
                                    setState(() {
                                      // _totalBags.text = value ;
                                      if (_siteTotalBags.text == null ||
                                          _siteTotalBags.text == "") {
                                        _siteTotalPt.clear();
                                      } else {
                                        _siteTotalPt.text =
                                            (int.parse(_siteTotalBags.text) / 20)
                                                .toString();
                                      }
                                    });
                                  },
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Bags ';
                                    }

                                    return null;
                                  },

                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.inputBoxHintColor,
                                      fontFamily: "Muli"),
                                  // keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.backgroundColorBlue,
                                          //color: HexColor("#0000001F"),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.4),
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    labelText: "Bags",
                                    filled: false,
                                    focusColor: Colors.black,
                                    labelStyle: TextStyle(
                                        fontFamily: "Muli",
                                        color:
                                            ColorConstants.inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0),
                                    fillColor: ColorConstants.backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: TextFormField(
                                  controller: _siteTotalPt,
                                  onChanged: (value) {
                                    setState(() {
                                      // _totalBags.text = value ;
                                      if (_siteTotalPt.text == null ||
                                          _siteTotalPt.text == "") {
                                        _siteTotalBags.clear();
                                      } else {
                                        _siteTotalBags.text =
                                            (int.parse(_siteTotalPt.text) * 20)
                                                .toString();
                                      }
                                    });
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter MT ';
                                    }

                                    return null;
                                  },
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorConstants.inputBoxHintColor,
                                      fontFamily: "Muli"),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              ColorConstants.backgroundColorBlue,
                                          //color: HexColor("#0000001F"),
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.4),
                                          width: 1.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFF000000)
                                              .withOpacity(0.4),
                                          width: 1.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.0),
                                    ),
                                    labelText: "MT",
                                    filled: false,
                                    //enabled: false,
                                    focusColor: Colors.black,
                                    labelStyle: TextStyle(
                                        fontFamily: "Muli",
                                        color:
                                            ColorConstants.inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0),
                                    fillColor: ColorConstants.backgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ])))),
    );
  }

  Widget visitDataView() {
    return Container(
      child: Text("visitDataView"),
    );
  }

  Widget influencerView() {
    return Container(
      child: Text("influencerView"),
    );
  }

  Widget pastStageHistoryview() {
    return Container(
      child: Text("pastStageHistoryview"),
    );
  }

  void toggleSwitchForProductDemo(bool value) {
    if (isSwitchedsiteProductDemo == false) {
      setState(() {
        isSwitchedsiteProductDemo = true;
        _siteProductDemo.text = "Y";
        // textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isSwitchedsiteProductDemo = false;
        _siteProductDemo.text = "N";
        // textValue = 'Switch Button is OFF';
      });
    }
  }

  void toggleSwitchForOralBriefing(bool value) {
    if (isSwitchedsiteProductOralBriefing == false) {
      setState(() {
        isSwitchedsiteProductOralBriefing = true;
        _siteProductOralBriefing.text = "Y";
        // textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isSwitchedsiteProductOralBriefing = false;
        _siteProductOralBriefing.text = "N";
        // textValue = 'Switch Button is OFF';
      });
    }
  }
}
