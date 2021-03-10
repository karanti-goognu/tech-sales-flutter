
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/helper/database/sitelist_db_helper.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/controller/home_controller.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SiteRefreshDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/push_campaign.dart';
//import 'package:moengage_flutter/moengage_flutter.dart';
//import 'package:moengage_flutter/push_campaign.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppController _appController = Get.find();
  HomeController _homeController = Get.find();
  SplashController _splashController = Get.find();
  SiteController _siteController = Get.find();

  List<MenuDetailsModel> list = [
    new MenuDetailsModel("Leads", "assets/images/img2.png"),
    new MenuDetailsModel("Sites", "assets/images/img3.png"),
    new MenuDetailsModel("Influencers", "assets/images/img4.png"),
    new MenuDetailsModel("MWP", "assets/images/mwp.png"),
    new MenuDetailsModel("SR &\nComplaint", "assets/images/sr.png"),
    new MenuDetailsModel("Video\nTutorial", "assets/images/tutorial.png"),
  ];
 final MoEngageFlutter _moengagePlugin = MoEngageFlutter();
  String employeeName = "empty";

  Future<void> initPlatformState() async {
    if (!mounted) return;
    //Push.getTokenStream.listen(_onTokenEvent, onError: _onTokenError);
  }
  void _onPushClick(PushCampaign message) {
    print("This is a push click callback from native to flutter. Payload " +
        message.toString());
  }

  Future<bool> internetChecking() async {
    // do something here
    bool result = await DataConnectionChecker().hasConnection;
    return result;
  }

  Future<void> getSiteRefreshData(SitesDBProvider provider) async {


    provider.clearRefreshTable();
    SiteRefreshDataResponse viewSiteDataResponse = new SiteRefreshDataResponse();
    List<SitephotosEntity> sitephotosList = new List();
    List<SitesModal> sitesModal = new List();
    List<SiteFloorsEntity> siteFloorsEntity = new List();
    List<SiteVisitHistoryEntity> siteVisitHistoryEntity = new List();
    List<ConstructionStageEntity> constructionStageEntity = new List();
    List<SiteProbabilityWinningEntity> siteProbabilityWinningEntity = new List();
    List<SiteCompetitionStatusEntity> siteCompetitionStatusEntity = new List();
    List<SiteBrandEntity> siteBrandEntity = new List();
    List<SiteNextStageEntity> siteNextStageEntity = new List();
    List<SiteCommentsEntity> siteCommentsEntity = new List();
    List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity = new List();
    List<CounterListModel> counterListModel = new List();

    AccessKeyModel accessKeyModel = new AccessKeyModel();
    await _siteController.getAccessKeyOnly().then((data) async {
      accessKeyModel = data;
      // print("AccessKey :: " + accessKeyModel.accessKey);
      await _siteController.getSiteRefreshData(accessKeyModel.accessKey)
          .then((data) async {
        viewSiteDataResponse = data;

        sitephotosList = viewSiteDataResponse.sitePhotosEntity;
        if (sitephotosList != null) {
          for (int i = 0; i < sitephotosList.length; i++) {
            print("SiteRefresh--->"+sitephotosList[0].photoName);
            provider.createSitePhotoEntity(new SitephotosEntity(id: sitephotosList[i].id, siteId: sitephotosList[i].siteId, photoName: sitephotosList[i].photoName, createdBy: sitephotosList[i].createdBy, createdOn: sitephotosList[i].createdOn));
          }
        }

        siteFloorsEntity = viewSiteDataResponse.siteFloorsEntity;
        if (siteFloorsEntity != null) {
          for (int i = 0; i < siteFloorsEntity.length; i++) {
            provider.createSiteFloorsEntity(new SiteFloorsEntity(id: siteFloorsEntity[i].id,siteFloorTxt: siteFloorsEntity[i].siteFloorTxt));
          }
        }

        siteVisitHistoryEntity = viewSiteDataResponse.siteVisitHistoryEntity;
        if (siteVisitHistoryEntity != null) {
          for (int i = 0; i < siteVisitHistoryEntity.length; i++) {
            provider.createSiteVisitHistoryEntity(new SiteVisitHistoryEntity(id: siteVisitHistoryEntity[i].id,totalBalancePotential: siteVisitHistoryEntity[i].totalBalancePotential,
            constructionStageId:siteVisitHistoryEntity[i].constructionStageId,floorId: siteVisitHistoryEntity[i].floorId,stagePotential: siteVisitHistoryEntity[i].stagePotential,brandId: siteVisitHistoryEntity[i].brandId,brandPrice: siteVisitHistoryEntity[i].brandPrice,
            constructionDate: siteVisitHistoryEntity[i].constructionDate,siteId: siteVisitHistoryEntity[i].siteId,supplyDate: siteVisitHistoryEntity[i].supplyDate,supplyQty: siteVisitHistoryEntity[i].supplyQty,
            stageStatus: siteVisitHistoryEntity[i].stageStatus,createdOn: siteVisitHistoryEntity[i].createdOn,createdBy: siteVisitHistoryEntity[i].createdBy,soldToParty: siteVisitHistoryEntity[i].soldToParty,
              soCode: siteVisitHistoryEntity[i].soCode,isAuthorised: siteVisitHistoryEntity[i].isAuthorised,receiptNumber: siteVisitHistoryEntity[i].receiptNumber,isExpanded:siteVisitHistoryEntity[i].isExpanded
            ));
          }
        }

        constructionStageEntity = viewSiteDataResponse.constructionStageEntity;
        if (constructionStageEntity != null) {
          for (int i = 0; i < constructionStageEntity.length; i++) {
            provider.createConstructionStageEntity(new ConstructionStageEntity(id: constructionStageEntity[i].id,constructionStageText: constructionStageEntity[i].constructionStageText));
          }
        }

        siteProbabilityWinningEntity = viewSiteDataResponse.siteProbabilityWinningEntity;
        if (siteProbabilityWinningEntity != null) {
          for (int i = 0; i < siteProbabilityWinningEntity.length; i++) {
            provider.createSiteProbabilityWinningEntity(new SiteProbabilityWinningEntity(id: siteProbabilityWinningEntity[i].id,siteProbabilityStatus: siteProbabilityWinningEntity[i].siteProbabilityStatus));
          }
        }

        siteCompetitionStatusEntity = viewSiteDataResponse.siteCompetitionStatusEntity;
        if (siteCompetitionStatusEntity != null) {
          for (int i = 0; i < siteCompetitionStatusEntity.length; i++) {
            provider.createSiteCompetitionStatusEntity(new SiteCompetitionStatusEntity(id: siteCompetitionStatusEntity[i].id,competitionStatus: siteCompetitionStatusEntity[i].competitionStatus));
          }
        }

        siteBrandEntity = viewSiteDataResponse.siteBrandEntity;
        if (siteBrandEntity != null) {
          for (int i = 0; i < siteBrandEntity.length; i++) {
            provider.createSiteBrandEntity(new SiteBrandEntity(id: siteBrandEntity[i].id,brandName: siteBrandEntity[i].brandName,productName: siteBrandEntity[i].productName));
          }
        }

        siteNextStageEntity = viewSiteDataResponse.siteNextStageEntity;
        if (siteNextStageEntity != null) {

          for (int i = 0; i < siteNextStageEntity.length; i++) {
            provider.createSiteNextStageEntity(new SiteNextStageEntity(id: siteNextStageEntity[i].id,siteId: siteNextStageEntity[i].siteId,constructionStageId: siteNextStageEntity[i].constructionStageId,stagePotential: siteNextStageEntity[i].stagePotential,
            brandId: siteNextStageEntity[i].brandId,brandPrice: siteNextStageEntity[i].brandPrice,stageStatus: siteNextStageEntity[i].stageStatus,
            constructionStartDt: siteNextStageEntity[i].constructionStartDt,nextStageSupplyDate: siteNextStageEntity[i].nextStageSupplyDate,
            nextStageSupplyQty: siteNextStageEntity[i].nextStageSupplyQty,createdBy: siteNextStageEntity[i].createdBy,createdOn: siteNextStageEntity[i].createdOn));
          }

        }

        siteCommentsEntity = viewSiteDataResponse.siteCommentsEntity;
        if (siteCommentsEntity != null) {
          for (int i = 0; i < siteCommentsEntity.length; i++) {
            provider.createSiteCommentEntity(new SiteCommentsEntity(id: siteCommentsEntity[i].id,siteId: siteCommentsEntity[i].siteId,siteCommentText: siteCommentsEntity[i].siteCommentText,
            creatorName: siteCommentsEntity[i].creatorName,createdBy: siteCommentsEntity[i].createdBy,createdOn:siteCommentsEntity[i].createdOn));
          }
        }

        siteOpportunityStatusEntity = viewSiteDataResponse.siteOpportunityStatusEntity;
        if (siteOpportunityStatusEntity != null) {
          for (int i = 0; i < siteOpportunityStatusEntity.length; i++) {
            provider.createSiteOpportunityStatusEntity(new SiteOpportunityStatusEntity(id: siteOpportunityStatusEntity[i].id,opportunityStatus: siteOpportunityStatusEntity[i].opportunityStatus));
          }
        }

        counterListModel = viewSiteDataResponse.counterListModel;
        if (counterListModel != null) {
          for (int i = 0; i < counterListModel.length; i++) {
            provider.createCounterListModel(new CounterListModel(soldToParty: counterListModel[i].soldToParty,soldToPartyName: counterListModel[i].soldToPartyName,shipToParty: counterListModel[i].shipToParty,
              shipToPartyName: counterListModel[i].shipToPartyName
            ));
          }
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    _moengagePlugin.initialise();
    _moengagePlugin.enableSDKLogs();
    _moengagePlugin.setUpPushCallbacks(_onPushClick);
    _appController.getAccessKey(RequestIds.GET_SITES_LIST);
    if (_splashController.splashDataModel.journeyDetails.journeyDate == null) {
      print('Check In');
      _homeController.checkInStatus = StringConstants.checkIn;
    } else {
      if (_splashController.splashDataModel.journeyDetails.journeyEndTime ==
          null) {
        print('Check Out');
        _homeController.checkInStatus = StringConstants.checkOut;
      } else {
        print('Journey Ended');
        _homeController.checkInStatus = StringConstants.journeyEnded;
      }
    }
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      _homeController.employeeName =
          prefs.getString(StringConstants.employeeName);

      // MoEngage implementation done here ....
      _moengagePlugin.setUniqueId(prefs.getString(StringConstants.employeeId));
      _moengagePlugin.setFirstName(prefs.getString(StringConstants.employeeName));
      _moengagePlugin.setPhoneNumber(prefs.getString(StringConstants.mobileNumber));

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _homeController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    // return
    //   WillPopScope(
    //   onWillPop: () async {
    //     // You can do some work here.
    //     // Returning true allows the pop to happen, returning false prevents it.
    //     Get.dialog(CustomDialogs().appExitDialog("Do you want to exit?"));
    //     return true;
    //   },
    //   child: Scaffold(
    //       backgroundColor: ColorConstants.backgroundColorGrey,
    //       appBar: AppBar(
    //         // titleSpacing: 50,
    //         backgroundColor: ColorConstants.appBarColor,
    //         toolbarHeight: 100,
    //         title: Image.asset(
    //           "assets/images/Logo(Bluebg).png",
    //           height: 48,
    //         ),
    //         automaticallyImplyLeading: false,
    //         actions: [
    //           Padding(
    //             padding: const EdgeInsets.only(right: 25.0, top: 20),
    //             child: Column(
    //               children: [
    //                 GestureDetector(
    //                   onTap: () {
    //                     Get.toNamed(Routes.ADD_CALENDER_SCREEN);
    //                   },
    //                   child: Container(
    //                     height: 40,
    //                     width: 40,
    //                     padding: EdgeInsets.all(4),
    //                     // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
    //                     decoration: new BoxDecoration(
    //                       color: Colors.white,
    //                       border: Border.all(color: Colors.black, width: 0.0),
    //                       borderRadius:

                          return ScopedModelDescendant<SitesDBProvider>(builder: (context, child, model) {
            return Stack(children: <Widget>[
        WillPopScope(
          onWillPop: () async {
            // You can do some work here.
            // Returning true allows the pop to happen, returning false prevents it.
            Get.dialog(CustomDialogs().appExitDialog("Do you want to exit?"));
            return true;
          },
          child: Scaffold(
              backgroundColor: ColorConstants.backgroundColorGrey,
              appBar: AppBar(
                // titleSpacing: 50,
                backgroundColor: ColorConstants.appBarColor,
                toolbarHeight: 100,
                title: Image.asset(
                  "assets/images/Logo(Bluebg).png",
                  height: 48,
                ),
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, top: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.ADD_CALENDER_SCREEN);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(4),
                            // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 0.0),
                              borderRadius:

                              new BorderRadius.all(Radius.circular(70)),
                            ),
                            child: Icon(
                              Icons.calendar_today_sharp,
                              color: HexColor("#FFCD00"),
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "My Calendar",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, top: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // SitesDBProvider model = ScopedModel.of(this.context);
                            // model.fetchAllComm().then((value) => {
                            //   print("SiteRefresh--->"+value.toString())
                            // });
                            Get.dialog(CustomDialogs()
                                .errorDialog("Page Coming Soon .... "));
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 0.0),
                              borderRadius:
                              new BorderRadius.all(Radius.circular(70)),
                            ),
                            child: Icon(
                              Icons.notifications_none_outlined,
                              color: HexColor("#FFCD00"),
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Notifications",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25.0, top: 20),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            internetChecking().then((result) => {
                              if (result == true)
                                {
                                  Get.snackbar(
                                      "Internet connection Available.", "Fetching from API.",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.green,
                                      snackPosition: SnackPosition.BOTTOM),
                                      getSiteRefreshData(model)
                                }
                              else
                                {
                                  Get.snackbar(
                                      "No internet connection.", "Fetching data from Database.",
                                      colorText: Colors.white,
                                      backgroundColor: Colors.red,
                                      snackPosition: SnackPosition.BOTTOM),
                                  // fetchSiteList()
                                }
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 0.0),
                              borderRadius:
                              new BorderRadius.all(Radius.circular(70)),
                            ),
                            child: Icon(
                              Icons.sync,
                              color: HexColor("#FFCD00"),
                              size: 30,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 8,
                        ),

                        Text(
                          "Sync Data",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                              () => Text(
                            "Hello , ${_homeController.employeeName}",
                            style: TextStyle(
                              // color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                fontFamily: "Muli"),
                          ),
                        ),
                        Text("Here are today's",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              //  color: Colors.white.withOpacity(0.7),
                                fontSize: 15,
                                fontFamily: "Muli")),
                        Text("recommended actions for you",
                            style: TextStyle(
                              // color: Colors.white.withOpacity(0.7),
                                fontSize: 15,
                                fontFamily: "Muli")),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() {
                    if (_homeController.disableSlider != true) {
                      return (_homeController.checkInStatus ==
                          StringConstants.checkIn)
                          ? checkInSliderButton()
                          : (_homeController.checkInStatus ==
                          StringConstants.checkOut)
                          ? checkOutSliderButton()
                          : journeyEnded();
                    } else {
                      return disabledSliderButton();
                    }
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: userMenuWidget(),
                      ))
                ],
              ),
              floatingActionButton:
              SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomNavigator()),
        )
      ]);

                          });
  }

  Widget disabledSliderButton() {
    return SliderButton(
      ///Put label over here
      label: Text(
        "Disabled ",
        style: TextStyle(
            color: Color(0xff4a4a4a),
            fontWeight: FontWeight.w500,
            fontSize: 17),
      ),
      icon: Center(
          child: Icon(
        Icons.play_disabled,
        color: Colors.white,
        size: 40.0,
        //  semanticLabel: 'Text to announce in accessibility modes',
      )),

      ///Change All the color and size from here.
      alignLabel: Alignment.center,
      width: MediaQuery.of(context).size.width,
      radius: 10,
      buttonColor: ColorConstants.buttonDisableColor,
      backgroundColor: ColorConstants.buttonDisableColor,
      highlightedColor: Colors.grey,
      baseColor: Colors.white,
      vibrationFlag: true,
      dismissible: false,
    );
  }

  Widget checkInSliderButton() {
    return SliderButton(
      action: () async {
        if (await Permission.location.request().isGranted) {
          _homeController.getAccessKey(RequestIds.CHECK_IN);
        } else {
          print('permission denied');
        }
      },

      ///Put label over here
      label: Text(
        "Swipe to start your day ",
        style: TextStyle(
            color: Color(0xff4a4a4a),
            fontWeight: FontWeight.w500,
            fontSize: 17),
      ),
      icon: Center(
          child: Icon(
        Icons.play_circle_filled_outlined,
        color: Colors.white,
        size: 40.0,
        //  semanticLabel: 'Text to announce in accessibility modes',
      )),

      ///Change All the color and size from here.
      alignLabel: Alignment.center,
      width: MediaQuery.of(context).size.width,
      radius: 10,
      buttonColor: ColorConstants.checkinColor,
      backgroundColor: ColorConstants.checkinColor,
      highlightedColor: Colors.grey,
      baseColor: Colors.white,
      vibrationFlag: true,
      dismissible: false,
    );
  }

  Widget checkOutSliderButton() {
    return SliderButton(
      action: () async {
        if (await Permission.location.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          _homeController.getAccessKey(RequestIds.CHECK_OUT);
        } else {
          print('permission not granted');
        }

        ///Do something here OnSlide
      },

      ///Put label over here
      label: Text(
        "Slide to Check-Out!",
        style: TextStyle(
            color: Color(0xff4a4a4a),
            fontWeight: FontWeight.w500,
            fontSize: 17),
      ),
      icon: Center(
          child: Icon(
        Icons.arrow_forward_outlined,
        color: Colors.white,
        size: 40.0,
        //  semanticLabel: 'Text to announce in accessibility modes',
      )),

      ///Change All the color and size from here.
      alignLabel: Alignment.center,
      width: MediaQuery.of(context).size.width,
      radius: 10,
      buttonColor: HexColor("#F9A61A"),
      backgroundColor: HexColor("#F9A61A"),
      highlightedColor: Colors.grey,
      baseColor: Colors.white,
      vibrationFlag: true,
      dismissible: false,
    );
  }

  Widget journeyEnded() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 70,
        alignment: Alignment.center,
        color: Colors.grey,
        child: Text("Journey-Ended",
            style: TextStyle(
                color: Colors.white, fontFamily: "Muli", fontSize: 18)),
      ),
    );
  }

  Widget userMenuWidget() {
    return GridView.builder(
        itemCount: list.length,
        // childAspectRatio: ( 2),
        //  padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.9,
            crossAxisSpacing: 1,
            mainAxisSpacing: 2),
        // itemExtent: 125.0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              switch (index) {
                case 0:
                  Get.toNamed(Routes.LEADS_SCREEN);
                  break;
                case 1:
                  // storeOfflineSiteData();
                  Get.toNamed(
                    Routes.SITES_SCREEN,
                  );
                  break;
                case 2:
                  Get.dialog(
                      CustomDialogs().errorDialog(" Page Coming Soon .... "));
                  break;
                case 3:
                  Get.toNamed(Routes.ADD_MWP_SCREEN);
                  break;
                case 4:
                  Get.toNamed(Routes.SERVICE_REQUESTS);
                  break;
                case 5:
                  Get.toNamed(Routes.VIDEO_TUTORIAL);
                  break;
              }
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              borderOnForeground: true,
              //shadowColor: colornew,
              elevation: 20,
              margin: EdgeInsets.all(8.0),
              color: ((index == 0) ||
                      (index == 1) ||
                      (index == 3) ||
                      (index == 4) ||
                      (index == 5))
                  ? Colors.white
                  : Colors.white60,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.black, width: 0.0),
                        // borderRadius: new BorderRadius.all(Radius.circular(70)),
                      ),
                      child: Image.asset(
                        list[index].imgURL,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    // Icon(
                    //   Icons.no_photography_outlined,
                    //   size: 90,
                    //   color: Colors.black12,
                    // ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list[index].value,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal*3.5,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.bold
                              //fontWeight: FontWeight.normal
                              ),
                        ),
                        (index == 2)
                            ? Text(
                                "Coming Soon",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: ColorConstants.inputBoxHintColor,
                                    fontSize: SizeConfig.safeBlockHorizontal*3.3,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.bold
                                    //fontWeight: FontWeight.normal
                                    ),
                              )
                            : Container(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }


}

class MenuDetailsModel {
  String value;
  String imgURL;

  MenuDetailsModel(this.value, this.imgURL);
}
