import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/helper/siteListDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/pending_supply_list.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/site_list_screen.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/site_filter.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SiteScreen extends StatefulWidget {
  @override
  _SiteScreenState createState() => _SiteScreenState();
}

class _SiteScreenState extends State<SiteScreen> {
  // String formatter = new DateFormat("yyyy-mm-dd");
  // Instantiate your class using Get.put() to make it available for all "child" routes there.
  SiteController _siteController = Get.find();
  AppController _appController = Get.find();
  SplashController _splashController = Get.find();
  DateTime selectedDate = DateTime.now();
  String selectedDateString;
  int selectedPosition = 0;
  int currentTab = 0;
  int _tabNumber = 0;
  double toolbarHeight;

  ScrollController _scrollController;

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print('hello');
      _siteController.offset += 10;
      print(_siteController.offset);
      //_siteController.getAccessKey(RequestIds.GET_SITES_LIST);

    _appController.getAccessKey(RequestIds.GET_SITES_LIST);
       // _siteController.getSitesData(this._appController.accessKeyResponse.accessKey);
      // _siteController.getAccessKey(RequestIds.GET_LEADS_LIST);
    }
  }

  Future<bool> internetChecking() async {
    // do something here
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }

  storeOfflineSiteData() async {
    final db = SiteListDBHelper();
    await db.clearTable();
    _appController.getAccessKey(RequestIds.GET_SITES_LIST);
    if (_siteController.sitesListResponse.sitesEntity != null) {

      for (int i = 0; i < _siteController.sitesListResponse.sitesEntity.length; i++) {
        SitesEntity siteEntity = new SitesEntity(
            siteId: _siteController.sitesListResponse.sitesEntity[i].siteId,
            leadId: _siteController.sitesListResponse.sitesEntity[i].leadId,
            siteDistrict:
                _siteController.sitesListResponse.sitesEntity[i].siteDistrict,
            siteStageId:
                _siteController.sitesListResponse.sitesEntity[i].siteStageId,
            siteCreationDate: _siteController
                .sitesListResponse.sitesEntity[i].siteCreationDate,
            sitePotentialMt: _siteController
                .sitesListResponse.sitesEntity[i].sitePotentialMt,
            siteOppertunityId: _siteController
                .sitesListResponse.sitesEntity[i].siteOppertunityId,
            siteScore:
                _siteController.sitesListResponse.sitesEntity[i].siteScore,
            contactNumber:
                _siteController.sitesListResponse.sitesEntity[i].contactNumber,
            siteProbabilityWinningId: _siteController
                .sitesListResponse.sitesEntity[i].siteProbabilityWinningId);
        // SiteListModelForDB siteListModelForDb = new SiteListModelForDB(null, json.encode(siteEntity));
        // await db.addSiteEntityInDraftList(siteListModelForDb);
        await db.insertSiteEntityInTable(siteEntity);

      }
    }
  }

  @override
  void initState() {
    super.initState();
    toolbarHeight = SizeConfig.screenHeight*.18;
    _siteController.sitesListResponse.sitesEntity = null;
    clearFilterSelection();
    internetChecking().then((result) => {
      if (result == true)
        {
          _appController.getAccessKey(RequestIds.GET_SITES_LIST),
        //_siteController.getAccessKey(RequestIds.GET_SITES_LIST),

    _siteController.offset = 0,
          // storeOfflineSiteData()
        }
      else
        {
          Get.snackbar(
              "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM),
          // fetchSiteList()
        }
    });
    _scrollController = ScrollController();
    _scrollController..addListener(_scrollListener);

  }

  clearFilterSelection(){
    _siteController.selectedFilterCount = 0;
    _siteController.selectedSiteStage = StringConstants.empty;
    _siteController.selectedSiteStageValue = StringConstants.empty;
    _siteController.selectedSiteStatus = StringConstants.empty;
    _siteController.selectedSiteStatusValue = StringConstants.empty;
    _siteController.selectedSiteInfluencerCat = StringConstants.empty;
    _siteController.selectedSiteInfluencerCatValue = StringConstants.empty;
    _siteController.assignToDate = StringConstants.empty;
    _siteController.assignFromDate = StringConstants.empty;
    _siteController.selectedSitePincode = StringConstants.empty;
  }

  @override
  void dispose() {
    super.dispose();
    //_appController?.dispose();
    _siteController?.dispose();
    _siteController.offset = 0;
  }

  void disposeController(BuildContext context){
//or what you wnat to dispose/clear
    _siteController?.dispose();
    _siteController.offset = 0;
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    selectedDateString = formatter.format(selectedDate);
    print(selectedDateString); // something like 20-04-2020
    return WillPopScope(
        onWillPop: () async {
         // disposeController(context);
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBody: true,
          backgroundColor: ColorConstants.backgroundColorGrey,
          appBar: AppBar(
            backgroundColor: ColorConstants.appBarColor,
            toolbarHeight: toolbarHeight,
            centerTitle: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _tabNumber==0? "OPEN SITES":"PENDING SUPPLY",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: "Muli"),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    _tabNumber==1?Container(): FlatButton(
                      onPressed: () {
                        _settingModalBottomSheet(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            //  Icon(Icons.exposure_zero_outlined),
                            Container(
                                height: 18,
                                width: 18,
                                // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 0.0),
                                  borderRadius:
                                      new BorderRadius.all(Radius.circular(3)),
                                ),
                                child: Center(
                                    child: Obx(() => Text(
                                        "${_siteController.selectedFilterCount}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            //fontFamily: 'Raleway',
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal))))),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'FILTER',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _tabNumber==1?Container():IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => Get.toNamed(Routes.SEARCH_SITES_SCREEN),
                    )
                  ],
                ),
                _tabNumber==1?Container():SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => (_siteController.assignToDate ==
                                StringConstants.empty)
                            ? Container()
                            : FilterChip(
                                label: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                        "${_siteController.assignFromDate} to ${_siteController.assignToDate}")
                                  ],
                                ),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(side: BorderSide()),
                                onSelected: (bool value) {
                                  print("selected");
                                },
                              )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => (_siteController.selectedSiteStatus ==
                                StringConstants.empty)
                            ? Container()
                            : FilterChip(
                                label: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                        "${_siteController.selectedSiteStatus}")
                                  ],
                                ),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(side: BorderSide()),
                                onSelected: (bool value) {
                                  print("selected");
                                },
                              )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => (_siteController.selectedSiteStage ==
                                StringConstants.empty)
                            ? Container()
                            : FilterChip(
                                label: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text("${_siteController.selectedSiteStage}")
                                  ],
                                ),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(side: BorderSide()),
                                onSelected: (bool value) {
                                  print("selected");
                                },
                              )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => (_siteController.selectedSitePincode ==
                                StringConstants.empty)
                            ? Container()
                            : FilterChip(
                                label: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                        "${_siteController.selectedSitePincode}")
                                  ],
                                ),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(side: BorderSide()),
                                onSelected: (bool value) {
                                  print("selected");
                                },
                              )),
                        SizedBox(
                          width: 8,
                        ),
                        Obx(() => (_siteController.selectedSiteInfluencerCat ==
                                StringConstants.empty)
                            ? Container()
                            : FilterChip(
                                label: Row(
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                        "${_siteController.selectedSiteInfluencerCat}")
                                  ],
                                ),
                                backgroundColor: Colors.transparent,
                                shape: StadiumBorder(side: BorderSide()),
                                onSelected: (bool value) {
                                  print("selected");
                                },
                              )),
                      ],
                    ))
              ],
            ),
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Color(0xFF004280),
                      labelColor:Color(0xFF004280),
                      unselectedLabelColor: Colors.grey,
                      labelStyle: TextStyle(fontSize: 14.0,fontFamily: 'Muli',fontWeight: FontWeight.w600),  //For Selected tab
                      unselectedLabelStyle: TextStyle(fontSize: 14.0,fontFamily: 'Muli',fontWeight: FontWeight.w600),
                      tabs: [
                        Tab(
                          text: "ALL SITES",
                        ),
                        Tab(
                          text: "PENDING SUPPLY",
                        ),
                      ],
                      onTap: (i) {
                        setState(() {
                          _tabNumber = i;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton:
              SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigator(),
          body: TabBarView(
            children: [
              SiteListScreen(),
              PendingSupplyListScreen(),
            ],
          ),
        )
        ));
  }



  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return SiteFilterWidget();
        })
        .whenComplete(() {
          setState(() {
            toolbarHeight =_siteController.selectedFilterCount==0? SizeConfig.screenHeight*.18:SizeConfig.screenHeight*.24;
          });
           print("ItemCount-->"+_siteController.selectedFilterCount.toString());
    });
  }


  Widget SiteFilter (){

  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        border: Border.all(color: ColorConstants.dateBorderColor),
        color: Colors.white);
  }

}
