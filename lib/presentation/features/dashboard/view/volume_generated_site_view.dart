import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';

class VolumeGeneratedSiteList extends StatefulWidget {
  @override
  _VolumeGeneratedSiteListState createState() => _VolumeGeneratedSiteListState();
}

class _VolumeGeneratedSiteListState extends State<VolumeGeneratedSiteList> {
  DashboardController _dashboardController= Get.find();
  @override
  void initState() {
    _dashboardController.getDashboardMtdGeneratedVolumeSiteList();
    print("Inside initstate");
    print(_dashboardController.mtdGeneratedVolumeSiteList.totalSiteCount);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarColor,
        toolbarHeight: 120,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Volume Generated".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Muli"),
                  ),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: BackFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('MTD Vol. Generated',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Count- ${_dashboardController.mtdGeneratedVolumeSiteList.totalSiteCount}'),
              Text('Total Potential-${_dashboardController.mtdGeneratedVolumeSiteList.totalSitePotential} MT'),
            ],
          ),
          Obx(()=>
              Expanded(
                  child:
                  _dashboardController.mtdGeneratedVolumeSiteList.sitesEntity==null||_dashboardController.mtdGeneratedVolumeSiteList.sitesEntity.isEmpty?
                  Center(child: Text("Nothing to show"),):
                  ListView.builder(
                      itemCount: 10,
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, bottom: 10),
                      // itemExtent: 125.0,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () { },
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
                                                const EdgeInsets.all(2.0),
                                                child: Obx(
                                                      ()=>Text(
                                                    "Site ID - ${_dashboardController.mtdGeneratedVolumeSiteList.sitesEntity.siteId}",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                        FontWeight.bold
                                                      //fontWeight: FontWeight.normal
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(2.0),
                                                child: Text(
                                                  "District: Delhi",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                      FontWeight.bold
                                                    //fontWeight: FontWeight.normal
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        left: 1.0),
                                                    child: Chip(
                                                      shape: StadiumBorder(
                                                          side: BorderSide(
                                                              color: HexColor(
                                                                  "#39B54A"))),
                                                      backgroundColor:
                                                      HexColor("#39B54A")
                                                          .withOpacity(
                                                          0.1),
                                                      label: Text(
                                                        'test',
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                "#39B54A"),
                                                            fontSize: 12,
                                                            fontFamily:
                                                            "Muli",
                                                            fontWeight:
                                                            FontWeight
                                                                .bold
                                                          //fontWeight: FontWeight.normal
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: Text(
                                                      " Today",
                                                      //  textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                        FontWeight.bold,

                                                        //fontWeight: FontWeight.normal
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0, bottom: 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                    Text(
                                                      "Site-Pt: ",
                                                      style: TextStyle(
                                                          color:
                                                          Colors.black38,
                                                          fontSize: 15,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                          FontWeight.bold
                                                        //fontWeight: FontWeight.normal
                                                      ),
                                                    ),
                                                    Text(
                                                      "20 MT",
                                                      style: TextStyle(
                                                        // color: Colors.black38,
                                                          fontSize: 15,
                                                          fontFamily:
                                                          "Muli",
                                                          fontWeight:
                                                          FontWeight
                                                              .bold
                                                        //fontWeight: FontWeight.normal
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text("",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 10,
                                                    fontFamily: "Muli",
                                                    fontWeight:
                                                    FontWeight.bold
                                                  //fontWeight: FontWeight.normal
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "Site Score - ",
                                                style: TextStyles
                                                    .robotoRegular14,
                                                textAlign: TextAlign.right,
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(),
                                                  ),
                                                  Icon(
                                                    Icons.call,
                                                    color:
                                                    HexColor("#8DC63F"),
                                                  ),
                                                  GestureDetector(
                                                    child: Text(
                                                      "099999999",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontStyle:
                                                          FontStyle.italic
                                                        //fontWeight: FontWeight.normal
                                                      ),
                                                    ),
                                                    onTap: () {
//                                                String num =
//                                                    siteList[index]
//                                                        .contactNumber;
//                                                launch('tel:$num');
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(8, 4, 8, 0),
                                    child: Container(
                                      color: Colors.grey,
                                      width: double.infinity,
                                      height: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.bold
                                            //fontWeight: FontWeight.normal
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
              ))

        ],
      ),
    );
  }
  @override
  void dispose() {
    _dashboardController.dispose();
    super.dispose();
  }
}
