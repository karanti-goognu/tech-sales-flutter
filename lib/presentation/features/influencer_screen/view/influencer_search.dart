import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/controller/inf_controller.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/view/influencer_detail_view.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class InfluencerSearch extends StatefulWidget {
  @override
  _InfluencerSearchState createState() => _InfluencerSearchState();
}

class _InfluencerSearchState extends State<InfluencerSearch> {
  TextEditingController controller = new TextEditingController();
  InfController _infController = Get.find();
  ScrollController _scrollController;

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
    return Scaffold(
        floatingActionButton: BackFloatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigatorWithoutDraftsAndSearch(),
        body: new SafeArea(
          child: Column(
            children: <Widget>[
              new Container(
                color: Colors.transparent,
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    elevation: 8,
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        controller: controller,
                        decoration: new InputDecoration(
                            hintText: 'Name, Mobile No, District , Site ID', border: InputBorder.none),
                        onChanged: onSearchTextChanged,
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          setState(() {
                          controller.clear();
                          onSearchTextChanged('');
                          // _infController.infListResponse.response.ilpInfluencerEntity == null;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              new Expanded(child: InfluencerDetailWidget()),
            ],
          ),
        ));
  }

  Widget InfluencerDetailWidget(){
    return Obx(()=>
   // _infController.infListResponse.response.ilpInfluencerEntity == null?Container():
    (_infController.infListResponse == null)
        ? Container(
      child: Center(
        child: Text("Influencer controller  is empty!!"),
      ),
    )
        : (_infController.infListResponse.response == null)
        ? Container(
      child: Center(
        child: Text("Sites list response  is empty!!"),
      ),
    )
        : (_infController.infListResponse.response.ilpInfluencerEntity == null)
        ? Container(
      child: Center(
        child: Text("Influencer list is empty!!"),
      ),
    )
        : (_infController.infListResponse.response.ilpInfluencerEntity.length ==
        0)
        ? Container(
      child: Center(
        child: Text("You don't have any Influencers..!!"),

      ),
    ):
        ListView.builder(
        controller: _scrollController,
        itemCount: _infController.infListResponse.response.ilpInfluencerEntity.length,
        padding: const EdgeInsets.only(
            left: 10.0, right: 10, bottom: 80),
        // itemExtent: 125.0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context, new CupertinoPageRoute(
                  builder: (BuildContext context) =>
                      InfluencerDetailView(_infController.infListResponse.response.ilpInfluencerEntity[index].membershipId))
              );
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
                                          child: Obx(()=>
                                          Text(
                                              _infController.infListResponse
                                                  .response
                                                  .ilpInfluencerEntity[
                                              index]
                                                  .joiningDate ??
                                                  "",
                                              style: TextStyles
                                                  .formfieldLabelText)),),
                                      Expanded(
                                        flex: 3,
                                        child:  Obx(()=>Text(
                                            "Avg.Monthly Vol.:${_infController.infListResponse.response.ilpInfluencerEntity[index].monthlyPotentialVolMt == null ? "" : _infController.infListResponse.response.ilpInfluencerEntity[index].monthlyPotentialVolMt}MT",
                                            style: TextStyles
                                                .formfieldLabelText),),
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
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment
                                    //         .baseline,
                                    children: [
                                      Text(
                                        "${_infController.infListResponse.response.ilpInfluencerEntity[index].inflName == null ? " " : _infController.infListResponse.response.ilpInfluencerEntity[index].inflName}",
                                        style: TextStyles
                                            .mulliBold18,
                                      ),
                                      Container(
                                        width: MediaQuery.of(
                                            context)
                                            .size
                                            .width /
                                            2 -
                                            10,
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
                                            "${_infController.infListResponse.response.ilpInfluencerEntity[index].inflTypeText == null ? "" : _infController.infListResponse.response.ilpInfluencerEntity[index].inflTypeText}",
                                            softWrap: true,
                                            style: TextStyle(
                                                color: HexColor(
                                                    "#6200EE"),
                                                fontSize: 11,
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
                                    // crossAxisAlignment:
                                    // CrossAxisAlignment
                                    //     .baseline,
                                    children: [
                                      //Expanded(
                                      // flex: 1,
                                      // child:

                                      Text(
                                          "${_infController.infListResponse.response.ilpInfluencerEntity[index].baseCity == null ? "-" : _infController.infListResponse.response.ilpInfluencerEntity[index].baseCity}" ,
                                          style: TextStyles
                                              .formfieldLabelText),
                                      // ),
                                      // Expanded(
                                      // flex: 2,
                                      // child:
                                      Chip(
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: HexColor(
                                                    "#39B54A"))),
                                        backgroundColor:
                                        HexColor("#39B54A"),
                                        label: Text(
                                            "${_infController.infListResponse.response.ilpInfluencerEntity[index].membershipId == null ? "" : _infController.infListResponse.response.ilpInfluencerEntity[index].membershipId}",
                                            style: TextStyles
                                                .btnWhite),
                                      ),
                                      // ),
                                    ],
                                  ),
                                ),
                                //  FittedBox(
                                //   child:
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 2.sp,
                                      right: 2.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Chip(
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: HexColor(
                                                    "#007CBF"))),
                                        backgroundColor:
                                        HexColor("#007CBF"),
                                        label: Container(
                                          width: MediaQuery.of(
                                              context)
                                              .size
                                              .width /
                                              3,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "A. SITE - ${_infController.infListResponse.response.ilpInfluencerEntity[index].activeSitesCount == null ? "00" : _infController.infListResponse.response.ilpInfluencerEntity[index].activeSitesCount}",
                                                style: TextStyle(
                                                    color: HexColor(
                                                        "#FFFFFFDE"),
                                                    fontSize: 11.sp,
                                                    fontFamily:
                                                    "Muli",
                                                    fontWeight:
                                                    FontWeight
                                                        .bold
                                                  //fontWeight: FontWeight.normal
                                                ),
                                              ),
                                              Icon(Icons.arrow_forward_ios, color: HexColor(
                                                  "#FFFFFFDE"),size: 11.sp,)
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.dialog(showContactDialog(
                                              'Info',
                                              '${_infController.infListResponse.response.ilpInfluencerEntity[index].mobileNumber}',
                                              '${_infController.infListResponse.response.ilpInfluencerEntity[index].giftAddress == null ? "-mobileNumbermobileNumbermobileNumber" : _infController.infListResponse.response.ilpInfluencerEntity[index].giftAddress}',
                                              '${_infController.infListResponse.response.ilpInfluencerEntity[index].email == null ? "-" : _infController.infListResponse.response.ilpInfluencerEntity[index].email}',
                                              context));
                                        },
                                        child: Text(
                                            "Contact Info",
                                            // " ${_siteController.sitesListResponse.sitesEntity[index].siteCreationDate}",

                                            style: TextStyles
                                                .contactTextStyle),
                                      ),
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
        }),
    );



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
                    String num = "";
                    // _leadsFilterController
                    //     .leadsListResponse
                    //     .leadsEntity[
                    // index]
                    //     .contactNumber;
                    launch('tel:$num');
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                // Expanded(
                //  child:
                Text(
                  "Address:",
                  style: TextStyles.formfieldLabelText,
                  //  )
                ),
                SizedBox(width: 40.sp,),
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
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                // Expanded(
                //     child:
                Text(
                  "Email:",
                  style: TextStyles.formfieldLabelText,
                  //  )
                ),
                SizedBox(width: 40.sp),
                Expanded(
                    child:
                    Text(email,
                      maxLines: null,
                      textAlign: TextAlign.end,
                      style: TextStyles.formfieldLabelTextDark,
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }



  @override
  void dispose() {
    // _infController.infListResponse.response.ilpInfluencerEntity == null;
    super.dispose();
  }

  onSearchTextChanged(String text) async {
   // if (controller.text.length >= 1) {
      _infController.infSearch(text);
   // }
  }
}