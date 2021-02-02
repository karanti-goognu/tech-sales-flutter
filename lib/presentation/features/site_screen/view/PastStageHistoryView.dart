import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class PastStageHistoryView extends StatefulWidget {
  @override
  _PastStageHistoryViewState createState() => _PastStageHistoryViewState();
}

class _PastStageHistoryViewState extends State<PastStageHistoryView> {
  List<SiteVisitHistoryEntity> siteVisitHistoryEntity = new List();
  List<SiteBrandEntity> siteBrandEntity = new List();
  List<ConstructionStageEntity> constructionStageEntity = new List();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: siteVisitHistoryEntity.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DateFormat formatter = DateFormat('dd-MMM-yyyy');
                            String selectedDateString = formatter.format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    siteVisitHistoryEntity[index].createdOn));

                            String constructionDateString =
                                siteVisitHistoryEntity[index].constructionDate;

                            if (!siteVisitHistoryEntity[index].isExpanded) {
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
                                      siteVisitHistoryEntity[index].isExpanded
                                          ? FlatButton.icon(
                                        // shape: RoundedRectangleBorder(
                                        //     borderRadius: BorderRadius.circular(0),
                                        //     side: BorderSide(color: Colors.black26)),
                                        color: Colors.transparent,
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
                                            siteVisitHistoryEntity[index]
                                                .isExpanded =
                                            !siteVisitHistoryEntity[index]
                                                .isExpanded;
                                          });
                                          // _getCurrentLocation();
                                        },
                                      )
                                          : FlatButton.icon(
                                        // shape: RoundedRectangleBorder(
                                        //     borderRadius: BorderRadius.circular(0),
                                        //     side: BorderSide(color: Colors.black26)),
                                        color: Colors.transparent,
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
                                            siteVisitHistoryEntity[index]
                                                .isExpanded =
                                            !siteVisitHistoryEntity[index]
                                                .isExpanded;
                                          });
                                          // _getCurrentLocation();
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
                                      siteVisitHistoryEntity[index].isExpanded
                                          ? FlatButton.icon(
                                        // shape: RoundedRectangleBorder(
                                        //     borderRadius: BorderRadius.circular(0),
                                        //     side: BorderSide(color: Colors.black26)),
                                        color: Colors.transparent,
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
                                            siteVisitHistoryEntity[index]
                                                .isExpanded =
                                            !siteVisitHistoryEntity[index]
                                                .isExpanded;
                                          });
                                          // _getCurrentLocation();
                                        },
                                      )
                                          : FlatButton.icon(
                                        // shape: RoundedRectangleBorder(
                                        //     borderRadius: BorderRadius.circular(0),
                                        //     side: BorderSide(color: Colors.black26)),
                                        color: Colors.transparent,
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
                                            siteVisitHistoryEntity[index]
                                                .isExpanded =
                                            !siteVisitHistoryEntity[index]
                                                .isExpanded;
                                          });
                                          // _getCurrentLocation();
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: siteVisitHistoryEntity[index]
                                        .floorId
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration: FormFieldStyle.buildInputDecoration(labelText: "Floor",),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: constructionStageDesc(
                                        siteVisitHistoryEntity[index]
                                            .constructionStageId),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration: FormFieldStyle.buildInputDecoration(labelText: "Stage of construction",),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: siteVisitHistoryEntity[index]
                                        .stagePotential,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration: FormFieldStyle.buildInputDecoration(labelText: "Stage Potential",),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: brandValue(
                                        siteVisitHistoryEntity[index].brandId),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration: FormFieldStyle.buildInputDecoration(labelText: "Brand in use"),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue:
                                    siteVisitHistoryEntity[index].brandPrice,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration: FormFieldStyle.buildInputDecoration(labelText:"Brand Price"),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: brandProductValue(
                                        siteVisitHistoryEntity[index].brandId),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration: FormFieldStyle.buildInputDecoration(labelText: "Product Sold",),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue:
                                    siteVisitHistoryEntity[index].stageStatus,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration: FormFieldStyle.buildInputDecoration(labelText: "Stage Status",),
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    initialValue: constructionDateString,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorConstants.inputBoxHintColor,
                                        fontFamily: "Muli"),
                                    keyboardType: TextInputType.text,
                                    decoration: FormFieldStyle.buildInputDecoration(labelText: "Date of construction",),
                                  ),
                                ],
                              );
                            }
                          }),
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
                      // UpdateRequest();
                    },
                  ),
                ),
                SizedBox(height: 40),
              ],
            )),
      ),
    );

  }

  constructionStageDesc(int constructionStageId) {
    for (int i = 0; i < constructionStageEntity.length; i++) {
      if (constructionStageEntity[i].id == constructionStageId) {
        return constructionStageEntity[i].constructionStageText;
      }
    }
  }

  brandValue(int brandId) {
    for (int i = 0; i < siteBrandEntity.length; i++) {
      if (siteBrandEntity[i].id == brandId) {
        return siteBrandEntity[i].brandName;
      }
    }
  }

  brandProductValue(int brandId) {
    for (int i = 0; i < siteBrandEntity.length; i++) {
      if (siteBrandEntity[i].id == brandId) {
        return siteBrandEntity[i].productName;
      }
    }
  }
  // Future<void> UpdateRequest() async {
  //   if (_siteBuiltupArea.text == "" ||
  //       _siteBuiltupArea.text == null ||
  //       _siteBuiltupArea.text == "null") {
  //     Get.dialog(CustomDialogs()
  //         .errorDialog("Please fill mandatory fields in \"Site Data\" TAb"));
  //   } else if (_selectedConstructionTypeVisit == null ||
  //       _stagePotentialVisit.text == null ||
  //       _stagePotentialVisit.text == "" ||
  //       _siteProductFromLocalDB == null ||
  //       _selectedSiteVisitFloor == null ||
  //       _brandPriceVisit.text == "" ||
  //       _brandPriceVisit.text == null
  //       // && _dateofConstruction.text == "" && _dateofConstruction.text == null
  //       ||
  //       _dateOfBagSupplied.text == "" ||
  //       _dateOfBagSupplied.text == null ||
  //       _stagePotentialVisit.text == "" ||
  //       _stagePotentialVisit.text == null ||
  //       _stageStatus.text == "" ||
  //       _stageStatus.text == null ||
  //       _siteCompetitionStatusEntity == null ||
  //       _siteOpportunitStatusEnity == null ||
  //       _siteProbabilityWinningEntity == null) {
  //     Get.dialog(CustomDialogs()
  //         .errorDialog("Please fill mandatory fields in \"Visit Data\" Tab"));
  //   } else if (addNextButtonDisable &&
  //       (_selectedConstructionTypeVisitNextStage == null ||
  //           _stagePotentialVisitNextStage.text == null ||
  //           _stagePotentialVisitNextStage.text == "" ||
  //           _siteProductFromLocalDBNextStage == null ||
  //           _selectedSiteVisitFloorNextStage == null ||
  //           _brandPriceVisitNextStage.text == "" ||
  //           _brandPriceVisitNextStage.text == null
  //           // && _dateofConstruction.text == "" && _dateofConstruction.text == null
  //           ||
  //           _dateOfBagSuppliedNextStage.text == "" ||
  //           _dateOfBagSuppliedNextStage.text == null ||
  //           _stagePotentialVisitNextStage.text == "" ||
  //           _stagePotentialVisitNextStage.text == null ||
  //           _stageStatusNextStage.text == "" ||
  //           _stageStatusNextStage.text == null)) {
  //     Get.dialog(CustomDialogs().errorDialog(
  //         "Please fill mandatory fields in \"Add Next Stage\" or hide next stage"));
  //   } else {
  //     String empId;
  //     String mobileNumber;
  //     String name;
  //     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //     await _prefs.then((SharedPreferences prefs) {
  //       empId = prefs.getString(StringConstants.employeeId) ?? "empty";
  //       mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
  //       name = prefs.getString(StringConstants.employeeName) ?? "empty";
  //
  //       if (_comments.text == null ||
  //           _comments.text == "null" ||
  //           _comments.text == "") {
  //         _comments.text = "Site updated";
  //       }
  //
  //       List<SiteCommentsEntity> newSiteCommentsEntity = new List();
  //       newSiteCommentsEntity.add(new SiteCommentsEntity(
  //           siteId: widget.siteId,
  //           siteCommentText: _comments.text,
  //           creatorName: name,
  //           createdBy: empId));
  //
  //       if (_selectedConstructionTypeVisit != null) {
  //         siteVisitHistoryEntity.add(new SiteVisitHistoryEntity(
  //           totalBalancePotential: _siteTotalBalancePt.text,
  //           constructionStageId: _selectedConstructionTypeVisit.id ?? 1,
  //           floorId: _selectedSiteVisitFloor.id.toString(),
  //           stagePotential: _stagePotentialVisit.text,
  //           brandId: _siteProductFromLocalDB.id,
  //           brandPrice: _brandPriceVisit.text,
  //           constructionDate: _dateofConstruction.text,
  //           siteId: widget.siteId.toString(),
  //           supplyDate: _dateOfBagSupplied.text,
  //           supplyQty: _stagePotentialVisit.text,
  //           stageStatus: _stageStatus.text,
  //           createdBy: empId,
  //         ));
  //       }
  //
  //       if (_selectedConstructionTypeVisitNextStage != null) {
  //         siteNextStageEntity.add(new SiteNextStageEntity(
  //           siteId: widget.siteId,
  //           constructionStageId:
  //           _selectedConstructionTypeVisitNextStage.id ?? 1,
  //           stagePotential: _stagePotentialVisitNextStage.text,
  //           brandId: _siteProductFromLocalDBNextStage.id,
  //           brandPrice: _brandPriceVisitNextStage.text,
  //           stageStatus: _stageStatusNextStage.text,
  //           constructionStartDt: _dateofConstructionNextStage.text,
  //           nextStageSupplyDate: _dateOfBagSuppliedNextStage.text,
  //           nextStageSupplyQty: _siteCurrentTotalBagsNextStage.text,
  //           createdBy: empId,
  //         ));
  //       }
  //
  //       List<updateResponse.SitePhotosEntity> newSitePhotoEntity = new List();
  //       // sitephotosEntity.clear();
  //       for (int i = 0; i < _imageList.length; i++) {
  //         newSitePhotoEntity.add(new updateResponse.SitePhotosEntity(
  //             photoName: path.basename(_imageList[i].path),
  //             siteId: widget.siteId,
  //             createdBy: empId));
  //       }
  //
  //       print("Sumit Length :: " + newSitePhotoEntity.length.toString());
  //
  //       //print(sitephotosEntity.)
  //
  //       if (_listInfluencerDetail.length != 0) {
  //         if (_listInfluencerDetail[_listInfluencerDetail.length - 1].inflName == null ||
  //             _listInfluencerDetail[_listInfluencerDetail.length - 1].inflName ==null ||
  //             _listInfluencerDetail[_listInfluencerDetail.length - 1].inflName.text.isNullOrBlank) {
  //           print("here1234");
  //           _listInfluencerDetail.removeAt(_listInfluencerDetail.length - 1);
  //         }
  //       }
  //
  //       List<updateResponse.SiteInfluencerEntityNew> newInfluencerEntity =
  //       new List();
  //
  //       for (int i = 0; i < _listInfluencerDetail.length; i++) {
  //         newInfluencerEntity.add(new updateResponse.SiteInfluencerEntityNew(
  //             id: _listInfluencerDetail[i].originalId,
  //             inflId: int.parse(_listInfluencerDetail[i].id.text),
  //             siteId: widget.siteId,
  //             isDelete: "N",
  //             isPrimary: _listInfluencerDetail[i].isPrimarybool ? "Y" : "N",
  //             createdBy: empId));
  //       }
  //
  //       if (_selectedSiteFloor == null) {
  //         _selectedSiteFloor = new SiteFloorsEntity(id: 1, siteFloorTxt: "0");
  //       }
  //
  //       var updateDataRequest = {
  //         "siteId": widget.siteId,
  //         "siteSegment": "TRADE",
  //         "assignedTo": viewSiteDataResponse.sitesModal.assignedTo,
  //         "siteStatusId": viewSiteDataResponse.sitesModal.siteStatusId,
  //         "siteStageId": labelId,
  //         "contactName": _ownerName.text,
  //         "contactNumber": _contactNumber.text,
  //         "siteGeotag": geoTagType,
  //         "siteGeotagLat": _currentPosition.latitude.toString(),
  //         "siteGeotagLong": _currentPosition.longitude.toString(),
  //         "plotNumber": _plotNumber.text,
  //         "siteAddress": _siteAddress.text,
  //         "sitePincode": _pincode.text,
  //         "siteState": _state.text,
  //         "siteDistrict": _district.text,
  //         "siteTaluk": _taluk.text,
  //         "sitePotentialMt": _siteTotalPt.text,
  //         "reraNumber": _rera.text,
  //         "siteCreationDate": viewSiteDataResponse.sitesModal.siteCreationDate,
  //         "dealerId": viewSiteDataResponse.sitesModal.siteDealerId,
  //         "siteBuiltArea": _siteBuiltupArea.text,
  //         "noOfFloors": _selectedSiteFloor.id,
  //         "productDemo": _siteProductDemo.text,
  //         "productOralBriefing": _siteProductOralBriefing.text,
  //         "soCode": viewSiteDataResponse.sitesModal.siteSoId,
  //         "inactiveReasonText": (_inactiveReasonText.text != "")
  //             ? _inactiveReasonText.text
  //             : null,
  //         "nextVisitDate":
  //         (_nextVisitDate.text != "") ? _nextVisitDate.text : null,
  //         "closureReasonText":
  //         (closureReasonText.text != "") ? closureReasonText.text : null,
  //         "createdBy": "",
  //         "siteCommentsEntity": newSiteCommentsEntity,
  //         "siteVisitHistoryEntity": siteVisitHistoryEntity,
  //         "siteNextStageEntity": siteNextStageEntity,
  //         "sitePhotosEntity": newSitePhotoEntity,
  //         "siteInfluencerEntity": newInfluencerEntity,
  //         "siteConstructionId": _selectedConstructionType.id,
  //         "siteCompetitionId": _siteCompetitionStatusEntity != null
  //             ? _siteCompetitionStatusEntity.id
  //             : null,
  //         "siteOppertunityId": _siteOpportunitStatusEnity != null
  //             ? _siteOpportunitStatusEnity.id
  //             : null,
  //         "siteProbabilityWinningId": _siteProbabilityWinningEntity != null
  //             ? _siteProbabilityWinningEntity.id
  //             : null
  //       };
  //       _siteController.updateLeadData(
  //           updateDataRequest, _imageList, context, widget.siteId);
  //
  //       Get.back();
  //     });
  //   }
  // }
}
