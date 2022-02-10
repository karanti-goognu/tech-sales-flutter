import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/updated_values.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/constant_function.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SitePastStageHistoryWidget extends StatefulWidget {
  ViewSiteDataResponse viewSiteDataResponse;

  SitePastStageHistoryWidget({this.viewSiteDataResponse});

  _SitePastStageHistoryWidgetState createState() =>
      _SitePastStageHistoryWidgetState();
}

class _SitePastStageHistoryWidgetState
    extends State<SitePastStageHistoryWidget> {
  final db = BrandNameDBHelper();
  List<SiteStageHistory> siteStageHistories = new List.empty(growable: true);
  ViewSiteDataResponse viewSiteDataResponse = new ViewSiteDataResponse();
  List<CounterListModel> counterListModel = new List.empty(growable: true);
  List<DealerForDb> dealerEntityForDb = new List.empty(growable: true);
  List<SiteBrandEntity> siteBrandEntity = new List.empty(growable: true);
  List<SiteFloorsEntity> siteFloorsEntity = new List.empty(growable: true);
  List<ConstructionStageEntity> constructionStageEntity = new List.empty(growable: true);

  setSitePastStageHistoryData() async {
    setState(() {
      viewSiteDataResponse = widget.viewSiteDataResponse;
      if (viewSiteDataResponse.siteStageHistorys != null) {
        siteStageHistories = viewSiteDataResponse.siteStageHistorys;
      } else {
        siteStageHistories = [];
      }
      siteBrandEntity = viewSiteDataResponse != null
          ? viewSiteDataResponse.siteBrandEntity
          : new List.empty(growable: true);
      counterListModel = viewSiteDataResponse.counterListModel;
      siteFloorsEntity = viewSiteDataResponse.siteFloorsEntity;
      constructionStageEntity = viewSiteDataResponse.constructionStageEntity;
    });
    await db.clearTable();

    for (int i = 0; i < siteBrandEntity.length; i++) {
      await db.addBrandName(new BrandModelforDB(siteBrandEntity[i].id,
          siteBrandEntity[i].brandName, siteBrandEntity[i].productName));
    }

    for (int i = 0; i < counterListModel.length; i++) {
      int id = await db.addDealer(DealerForDb(
          counterListModel[i].soldToParty,
          counterListModel[i].soldToPartyName));
    }

    dealerEntityForDb = await db.fetchAllDistinctDealers();

  }

  @override
  void initState() {
    setSitePastStageHistoryData();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
    return pastStageHistoryView();
  }

  Widget pastStageHistoryView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: siteStageHistories != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: siteStageHistories.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DateFormat formatter =
                                DateFormat('dd-MMM-yyyy');
                            String selectedDateString = formatter.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    siteStageHistories[index].createdOn));

                            String constructionDateString = siteStageHistories[index].constructionDate;

                            if (!siteStageHistories[index].isExpanded) {
                              return Column(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Visit Date:" + selectedDateString,
                                        style: TextStyle(
                                            //      fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      siteStageHistories[index].isExpanded
                                          ? TextButton.icon(
                                              icon: Icon(
                                                Icons.remove,
                                                color: HexColor("#F9A61A"),
                                                size: 18,
                                              ),
                                              label: Text(
                                                "COLLAPSE",
                                                style: TextStyle(
                                                    color: HexColor("#F9A61A"),
                                                    fontWeight: FontWeight.bold,
                                                    // letterSpacing: 2,
                                                    fontSize: 17),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  siteStageHistories[index]
                                                          .isExpanded =
                                                      !siteStageHistories[index]
                                                          .isExpanded;
                                                });
                                                // _getCurrentLocation();
                                              },
                                            )
                                          : TextButton.icon(
                                              icon: Icon(
                                                Icons.add,
                                                color: HexColor("#F9A61A"),
                                                size: 18,
                                              ),
                                              label: Text(
                                                "EXPAND",
                                                style: TextStyle(
                                                    color: HexColor("#F9A61A"),
                                                    fontWeight: FontWeight.bold,
                                                    // letterSpacing: 2,
                                                    fontSize: 17),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  siteStageHistories[index]
                                                          .isExpanded =
                                                      !siteStageHistories[index]
                                                          .isExpanded;
                                                });
                                              },
                                            ),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Visit Date:" + selectedDateString,
                                        style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      siteStageHistories[index].isExpanded
                                          ? TextButton.icon(
                                              icon: Icon(
                                                Icons.remove,
                                                color: HexColor("#F9A61A"),
                                                size: 18,
                                              ),
                                              label: Text(
                                                "COLLAPSE",
                                                style: TextStyle(
                                                    color: HexColor("#F9A61A"),
                                                    fontWeight: FontWeight.bold,
                                                    // letterSpacing: 2,
                                                    fontSize: 17),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  siteStageHistories[index]
                                                          .isExpanded =
                                                      !siteStageHistories[index]
                                                          .isExpanded;
                                                });
                                                // _getCurrentLocation();
                                              },
                                            )
                                          : TextButton.icon(
                                              icon: Icon(
                                                Icons.add,
                                                color: HexColor("#F9A61A"),
                                                size: 18,
                                              ),
                                              label: Text(
                                                "EXPAND",
                                                style: TextStyle(
                                                    color: HexColor("#F9A61A"),
                                                    fontWeight: FontWeight.bold,
                                                    // letterSpacing: 2,
                                                    fontSize: 17),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  siteStageHistories[index]
                                                          .isExpanded =
                                                      !siteStageHistories[index]
                                                          .isExpanded;
                                                });
                                                // _getCurrentLocation();
                                              },
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        GlobalMethods.selectedFloorText(
                                            siteFloorsEntity,
                                            siteStageHistories[index].floorId),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "Floor",
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        GlobalMethods.constructionStageDesc(
                                            constructionStageEntity,
                                            siteStageHistories[index]
                                                .constructionStageId),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "Stage of construction",
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        siteStageHistories[index].stagePotential,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "Stage Potential (Bags)",
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue: (siteStageHistories[index]
                                                    .stageStatus !=
                                                null &&
                                            siteStageHistories[index]
                                                    .stageStatus !=
                                                "null")
                                        ? siteStageHistories[index].stageStatus
                                        : "",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "Stage Status",
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue:  (siteStageHistories[index]
                                .constructionDate !=
                            null &&
                            siteStageHistories[index]
                                .constructionDate !=
                            "null")
                            ? siteStageHistories[index].constructionDate
                                : "",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        FormFieldStyle.buildInputDecoration(
                                      labelText: "Date of construction",
                                    ),
                                  ),
                                  ..._getPastHistoryProductList(index),
                                ],
                              );
                            }
                          })
                      : Center(
                          child: Text("No Data Found."),
                        ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(
              color: Colors.black26,
              thickness: 1,
            ),
            SizedBox(height: 16),
            Center(
              child: RaisedButton(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: HexColor("#1C99D4"),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 10, top: 10),
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 17),
                  ),
                ),
                onPressed: () async {
                  UpdatedValues updateRequest = new UpdatedValues();
                  updateRequest.UpdateRequest(context);
                },
              ),
            ),
            SizedBox(height: 40),
          ],
        )),
      ),
    );
  }

  List<Widget> _getPastHistoryProductList(int index) {
    List<Widget> productAddedList = [];
    for (int i = 0;
        i < siteStageHistories[index].siteSupplyHistorys.length;
        i++) {
      productAddedList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Stack(
          children: [
            getPastHistoryProductDetails(
                siteStageHistories[index].siteSupplyHistorys[i], i),
          ],
        ),
      ));
    }
    return productAddedList;
  }

  Widget getPastHistoryProductDetails(
      SiteSupplyHistorys siteSupplyHistory, int index) {
    return ExpandablePanel(
      header: Text(
        "Product " + (index + 1).toString(),
        softWrap: true,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            // color: HexColor("#000000DE"),
            fontFamily: "Muli"),
      ),
      expanded: Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  initialValue: (siteSupplyHistory.receiptNumber != null &&
                          siteSupplyHistory.receiptNumber != "null")
                      ? siteSupplyHistory.receiptNumber
                      : "",
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.inputBoxHintColor,
                      fontFamily: "Muli"),
                  keyboardType: TextInputType.text,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Receipt Number",
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  initialValue:
                      siteSupplyHistory.isAuthorised.toLowerCase() == 'y'
                          ? "Yes"
                          : "No",
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.inputBoxHintColor,
                      fontFamily: "Muli"),
                  keyboardType: TextInputType.text,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Is Authorized",
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  initialValue: GlobalMethods.brandValue(
                      siteBrandEntity, siteSupplyHistory.brandId),
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.inputBoxHintColor,
                      fontFamily: "Muli"),
                  keyboardType: TextInputType.text,
                  decoration: FormFieldStyle.buildInputDecoration(
                      labelText: "Brand in use"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  initialValue: (siteSupplyHistory.brandPrice != null &&
                          siteSupplyHistory.brandPrice != "null")
                      ? siteSupplyHistory.brandPrice
                      : "",
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.inputBoxHintColor,
                      fontFamily: "Muli"),
                  keyboardType: TextInputType.text,
                  decoration: FormFieldStyle.buildInputDecoration(
                      labelText: "Brand Price"),
                ),
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  initialValue: GlobalMethods.brandProductValue(
                      siteBrandEntity, siteSupplyHistory.brandId),
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.inputBoxHintColor,
                      fontFamily: "Muli"),
                  keyboardType: TextInputType.text,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Product Sold",
                  ),
                ),
                SizedBox(height: 12),
                // TextFormField(
                //   readOnly: true,
                //   initialValue:GlobalMethods.dealerValue(
                //       counterListModel, siteSupplyHistory.soldToParty),
                //   style: TextStyle(
                //       fontSize: 18,
                //       color: ColorConstants.inputBoxHintColor,
                //       fontFamily: "Muli"),
                //   keyboardType: TextInputType.text,
                //   decoration: FormFieldStyle.buildInputDecoration(
                //     labelText: "Dealer",
                //   ),
                // ),
                SizedBox(height: 16),
                // TextFormField(
                //   readOnly: true,
                //   initialValue: GlobalMethods.subDealerValue(
                //       counterListModel, siteSupplyHistory.shipToParty),
                //   style: TextStyle(
                //       fontSize: 18,
                //       color: ColorConstants.inputBoxHintColor,
                //       fontFamily: "Muli"),
                //   keyboardType: TextInputType.text,
                //   decoration: FormFieldStyle.buildInputDecoration(
                //     labelText: "Sub-Dealer",
                //   ),
                  TextFormField(
                    readOnly: true,
                    initialValue: GlobalMethods.subDealerValue(
                        counterListModel, siteSupplyHistory.shipToParty),
                    style: TextStyle(
                        fontSize: 18,
                        color: ColorConstants.inputBoxHintColor,
                        fontFamily: "Muli"),
                    keyboardType: TextInputType.text,
                    decoration: FormFieldStyle.buildInputDecoration(
                      labelText: "Counter",
                    ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  initialValue: siteSupplyHistory.supplyQty,
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.inputBoxHintColor,
                      fontFamily: "Muli"),
                  keyboardType: TextInputType.text,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Supplied Quantity",
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  initialValue: siteSupplyHistory.supplyDate,
                  style: TextStyle(
                      fontSize: 18,
                      color: ColorConstants.inputBoxHintColor,
                      fontFamily: "Muli"),
                  keyboardType: TextInputType.text,
                  decoration: FormFieldStyle.buildInputDecoration(
                    labelText: "Supplied Date",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      collapsed: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                siteSupplyHistory.brandId == -1
                    ? "Fill product Details"
                    : GlobalMethods.brandProductValue(
                            siteBrandEntity, siteSupplyHistory.brandId) +
                        ",  Qty:" +
                        siteSupplyHistory.supplyQty +
                        ", Price:" +
                        siteSupplyHistory.brandPrice,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    // color: HexColor("#000000DE"),
                    fontFamily: "Muli"),
              )),
        ],
      ),
    );
  }

}
