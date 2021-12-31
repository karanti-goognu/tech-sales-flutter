import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/common_widgets/background_container_image.dart';
import 'package:flutter_tech_sales/presentation/common_widgets/upload_photo_bottomsheet.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/location/custom_map.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/CommentDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/UpdateLeadRequestModel.dart'
    as updateRequest;
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/widgets/site_data_widget.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/functions/get_current_location.dart';
import 'package:flutter_tech_sales/utils/functions/validation.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dialog/lead_change_to_site_dialog.dart';

class ViewLeadScreen extends StatefulWidget {
  int leadId;

  ViewLeadScreen(this.leadId);

  @override
  _ViewLeadScreenState createState() => _ViewLeadScreenState();
}

class _ViewLeadScreenState extends State<ViewLeadScreen>
    implements ChangeLeadToSiteDialogListener {


  @override
  void initState() {
    super.initState();
    UploadImageBottomSheet.image = null;
    myFocusNode = FocusNode();
    getData();
  }

//   void disposeController(BuildContext context){
// //or what you wnat to dispose/clear
//     _addLeadsController.dispose();
//     myFocusNode.dispose();
  // }

  getData() {
    internetChecking().then((result) => {
          if (result == true)
            {
              _addLeadsController.getLeadDataNew(widget.leadId).then((data) {
                setState(() {
                  if (data != null) {
                    viewLeadDataResponse = data;
                    setData();
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


  List<LeadInfluencerEntity> influencerListForConvertToSite = List.empty(growable: true);
  setData() {
    if (viewLeadDataResponse != null) {
      checkStatus();
      _contactName.text = viewLeadDataResponse.leadsEntity.contactName;
      _contactNumber.text = viewLeadDataResponse.leadsEntity.contactNumber;
      geoTagType.text = viewLeadDataResponse.leadsEntity.geotagType;
      _siteAddress.text = viewLeadDataResponse.leadsEntity.leadAddress;
      _pincode.text = viewLeadDataResponse.leadsEntity.leadPincode;
      _state.text = viewLeadDataResponse.leadsEntity.leadStateName;
      _district.text = viewLeadDataResponse.leadsEntity.leadDistrictName;
      _taluk.text = viewLeadDataResponse.leadsEntity.leadTalukName;

      _leadSource.text = viewLeadDataResponse.leadsEntity.leadSource;
      _leadSourceUser.text = viewLeadDataResponse.leadsEntity.leadSourceUser;


      leadCreatedBy = viewLeadDataResponse.leadsEntity.createdBy;
      leadStageEntity = viewLeadDataResponse.leadStageEntity;

      for (int i = 0; i < leadStageEntity.length; i++) {
        if (viewLeadDataResponse.leadsEntity.leadStageId.toString() ==
            leadStageEntity[i].id.toString()) {
          leadStageVal.id = leadStageEntity[i].id;
          leadStageVal.leadStageDesc = leadStageEntity[i].leadStageDesc;
        }
      }
      leadRejectReasonEntity = viewLeadDataResponse.leadRejectReasonEntity;
      gv.leadRejectReasonEntity = leadRejectReasonEntity;
      nextStageConstructionEntity =
          viewLeadDataResponse.nextStageConstructionEntity;
      gv.nextStageConstructionEntity = nextStageConstructionEntity;
      dealerList = viewLeadDataResponse.dealerList;

      _siteFloorsEntity = viewLeadDataResponse.siteFloorsEntity;
      gv.dealerList = dealerList;
      influencerTypeEntity = viewLeadDataResponse.influencerTypeEntity;
      influencerCategoryEntity = viewLeadDataResponse.influencerCategoryEntity;
      _currentPosition = new Position(
          latitude: double.parse(viewLeadDataResponse.leadsEntity.leadLatitude),
          longitude:
              double.parse(viewLeadDataResponse.leadsEntity.leadLongitude));
      listLeadImagePhoto = viewLeadDataResponse.leadphotosEntity;



      /*if (listLeadImagePhoto != null) {
        for (int i = 0; i < listLeadImagePhoto.length; i++) {
          *//* File file = new File(UrlConstants.baseUrlforImages +
              "/" + listLeadImagePhoto[i].photoName);*//*
          String imageUrl=UrlConstants.baseUrlforImages +
              "/" + listLeadImagePhoto[i].photoName;

          _addLeadsController.getFileFromUrl(imageUrl).then((imageFile){
            print("file   .....$imageFile");
            _imgDetails.add(new ImageDetails("Network", imageFile));

            _addLeadsController.imageList.add(imageFile);

          });

        }
      }*/

      /*.......................*/
      for (int i = 0; i < listLeadImagePhoto.length; i++) {
       /* File file = new File(UrlConstants.baseUrlforImages +
            "/" +
            listLeadImagePhoto[i].photoName);*/

        String imageUrl=UrlConstants.baseUrlforImages +
            "/" + listLeadImagePhoto[i].photoName;

        _addLeadsController.getFileFromUrl(imageUrl).then((imageFile){
          print("file   .....$imageFile");
          _imgDetails.add(new ImageDetails("Network", imageFile));


        //  _addLeadsController.imageList.add(imageFile);
          _addLeadsController.updateImageList(imageFile, serverImageStatus);

        });



        //_imageList.add(file);
      }
      //initialImagelistLength = _imageList.length;
      initialImagelistLength = _addLeadsController.imageList.length;
      influencerTypeEntity = viewLeadDataResponse.influencerTypeEntity;

      influencerCategoryEntity = viewLeadDataResponse.influencerCategoryEntity;

      _listInfluencerEntity = viewLeadDataResponse.influencerEntity;
      _listLeadInfluencerEntity = viewLeadDataResponse.leadInfluencerEntity;

      if (_listInfluencerEntity.length != null) {
        for (int i = 0; i < _listInfluencerEntity.length; i++) {
          int originalId;
          for (int j = 0; j < _listLeadInfluencerEntity.length; j++) {
            if (_listInfluencerEntity[i].id ==
                _listLeadInfluencerEntity[j].inflId) {
              influencerListForConvertToSite.add(_listLeadInfluencerEntity[j]);
              _listInfluencerEntity[i].isPrimary =
                  _listLeadInfluencerEntity[j].isPrimary;
              originalId = _listLeadInfluencerEntity[j].id;
              break;
            }
          }

          InfluencerDetail inflDetail = new InfluencerDetail(
            originalId: originalId,
            isPrimary: _listInfluencerEntity[i].isPrimary,
            isPrimarybool:
                _listInfluencerEntity[i].isPrimary == "Y" ? true : false,
            id: new TextEditingController(
                text: _listInfluencerEntity[i].id.toString()),
            inflName: new TextEditingController(
                text: _listInfluencerEntity[i].inflName.toString()),
            inflContact: new TextEditingController(
                text: _listInfluencerEntity[i].inflContact.toString()),
            inflTypeId: new TextEditingController(
                text: _listInfluencerEntity[i].inflTypeId.toString()),
            inflCatId: new TextEditingController(
                text: _listInfluencerEntity[i].inflCatId.toString()),
            ilpIntrested: new TextEditingController(
                text: _listInfluencerEntity[i].ilpIntrested.toString()),
            createdOn: new TextEditingController(
                text: _listInfluencerEntity[i].createdOn.toString()),
            isExpanded: false,
          );
          for (int j = 0; j < influencerTypeEntity.length; j++) {
            if (influencerTypeEntity[j].inflTypeId.toString() ==
                inflDetail.inflTypeId.text.toString()) {
              inflDetail.inflTypeValue = new TextEditingController(
                  text: influencerTypeEntity[j].inflTypeDesc);
              break;
            }
          }
          for (int j = 0; j < influencerCategoryEntity.length; j++) {
            if (influencerCategoryEntity[j].inflCatId.toString() ==
                inflDetail.inflCatId.text.toString()) {
              inflDetail.inflCatValue = new TextEditingController(
                  text: influencerCategoryEntity[j].inflCatDesc);
              break;
            }
          }

          _listInfluencerDetail.add(inflDetail);
        }
      } else {
        _listInfluencerDetail
            .add(new InfluencerDetail(isExpanded: true, isPrimarybool: true));
      }
      initialInfluencerListLength = _listInfluencerDetail.length;

      _commentsListEntity = viewLeadDataResponse.leadcommentsEnitiy;
      final DateFormat formatter = DateFormat('dd-MMM-yyyy hh:mm');
      for (int i = 0; i < _commentsListEntity.length; i++) {
        _commentsList.add(new CommentsDetail(
          creatorName: _commentsListEntity[i].creatorName,
          commentedAt: formatter.format(DateTime.fromMillisecondsSinceEpoch(
              _commentsListEntity[i].createdOn)),
          createdBy: _commentsListEntity[i].createdBy,
          commentText: _commentsListEntity[i].commentText,
        ));
      }
      _totalMT.text = viewLeadDataResponse.leadsEntity.leadSitePotentialMt;
      _rera.text = viewLeadDataResponse.leadsEntity.leadReraNumber;
      _totalBags.text = (double.parse(_totalMT.text) * 20).round().toString();
      myFocusNode = FocusNode();
      myFocusNode.requestFocus();
    }
  }


  updateStatusForNextStage(BuildContext context, int statusId,
      {String dealerId, String subDealerId,int floorId,
        String noOfBagSupplied, String isIhbCommercial}) {
    String empId;
    String mobileNumber;
    String name;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      name = prefs.getString(StringConstants.employeeName) ?? "empty";

      if (_comments.text == "") {
        _comments.text = "Stage Changed";
      }

      List<CommentsDetail> commentsDetails = [
        new CommentsDetail(
            createdBy: empId,
            commentText: _comments.text,
            // commentedAt: DateTime.now(),
            creatorName: name)
      ];

      List<updateRequest.ListLeadcomments> commentsList = new List();

      for (int i = 0; i < commentsDetails.length; i++) {
        commentsList.add(new updateRequest.ListLeadcomments(
          leadId: widget.leadId,
          commentText: commentsDetails[i].commentText,
          creatorName: name,
          createdBy: empId,
        ));
      }

      List<updateRequest.ListLeadImage> imageList = new List();

      for (int i = 0; i < listLeadImage.length; i++) {
        imageList.add(new updateRequest.ListLeadImage(
          leadId: widget.leadId,
          photoName: listLeadImage[i].photoName,
          createdBy: empId,
        ));
      }


      if (_listInfluencerDetail.length != 0) {
        if (_listInfluencerDetail[_listInfluencerDetail.length - 1].inflName ==
            null ||
            _listInfluencerDetail[_listInfluencerDetail.length - 1]
                .inflName
                .text ==
                "null" ||
            _listInfluencerDetail[_listInfluencerDetail.length - 1]
                .inflName
                .text
                .isNullOrBlank) {
          _listInfluencerDetail.removeAt(_listInfluencerDetail.length - 1);
        }
      }
      List<updateRequest.LeadInfluencerEntity> listInfluencer = new List();


      for (int i = 0; i < _listInfluencerDetail.length; i++) {
        listInfluencer.add(new updateRequest.LeadInfluencerEntity(
            id: _listInfluencerDetail[i].originalId,
            leadId: widget.leadId,
            isPrimary: _listInfluencerDetail[i].isPrimarybool ? "Y" : "N",
            createdBy: empId,
            inflId: int.parse(_listInfluencerDetail[i].id.text),
            isDelete: "N"));
      }



      if (_SelectedDealer == null) {
        _SelectedDealer = new DealerList();
      }
      print(influencerListForConvertToSite);
      var updateRequestModel = {
        'eventId': viewLeadDataResponse.leadsEntity.eventId,
        'leadId': viewLeadDataResponse.leadsEntity.leadId,
        'leadSegment': viewLeadDataResponse.leadsEntity.leadSegment,
        'assignedTo': viewLeadDataResponse.leadsEntity.assignedTo,
        'leadStatusId': statusId,
        'leadStage': viewLeadDataResponse.leadsEntity.leadStageId,
        'contactName': viewLeadDataResponse.leadsEntity.contactName,
        'contactNumber': viewLeadDataResponse.leadsEntity.contactNumber,
        'geotagType': viewLeadDataResponse.leadsEntity.geotagType,
        'leadLatitude': viewLeadDataResponse.leadsEntity.leadLatitude,
        'leadLongitude': viewLeadDataResponse.leadsEntity.leadLongitude,
        'leadAddress': viewLeadDataResponse.leadsEntity.leadAddress,
        'leadPincode': viewLeadDataResponse.leadsEntity.leadPincode,
        'leadStateName': viewLeadDataResponse.leadsEntity.leadStateName,
        'leadDistrictName': viewLeadDataResponse.leadsEntity.leadDistrictName,
        'leadTalukName': viewLeadDataResponse.leadsEntity.leadTalukName,
        'leadSalesPotentialMt': viewLeadDataResponse.leadsEntity.leadSitePotentialMt,
        'leadReraNumber': viewLeadDataResponse.leadsEntity.leadReraNumber,
        'isStatus': "false",
        'updatedBy': empId,
        'leadIsDuplicate': viewLeadDataResponse.leadsEntity.leadIsDuplicate,
        'rejectionComment': viewLeadDataResponse.leadsEntity.rejectionComment,
        'nextDateCconstruction': _nextDateofConstruction.text,
        'nextStageConstruction':
        _selectedNextStageConstructionEntity.nextStageConsId,
        /*_selectedNextStageConstructionEntity.nextStageConsId*/
        'siteDealerId': dealerId,
        "subdealerId": subDealerId, //need to pass selected value
        'listLeadcomments': commentsList,
        'listLeadImage': viewLeadDataResponse.leadphotosEntity,
        'leadInfluencerEntity': influencerListForConvertToSite,
        // 'leadInfluencerEntity': viewLeadDataResponse.leadInfluencerEntity,
        'leadSource':_leadSource.text,
        'leadSourceUser': _leadSourceUser.text,
        'leadSourcePlatform' : viewLeadDataResponse.leadsEntity.leadSourcePlatform,
        'nosFloors':_floorId,
        'totalFloorSqftArea':int.tryParse(_noOfBagSupplied),
        'isIhbCommercial': _isIhbCommercial
      };

      print("Update Data-->"+"$updateRequestModel");
      var body = jsonEncode(updateRequestModel);
      print("Update Data1-->"+body);

      _addLeadsController.updateLeadData(updateRequestModel, new List<File>(),
          context, viewLeadDataResponse.leadsEntity.leadId, 3);

      Get.back();
    });
  }

  @override
  void dispose() {
    _addLeadsController.imageList.clear();
    myFocusNode?.dispose();
    myFocusNode = null;
    super.dispose();
    //_addLeadsController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    double _height = ScreenUtil().setSp(15);

    final statusDropDown = Container(
      padding: const EdgeInsets.only(left: 1.0, right: 1.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          //border: Border.all()
          boxShadow: [
            BoxShadow(
                color: Colors.grey[500],
                offset: Offset(5.0, 5.0),
                blurRadius: 10.0,
                spreadRadius: 4.0)
          ]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          // elevation: 100,
          value: _selectedValue,
          items: leadStatusEntity
              .map((label) => DropdownMenuItem(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        child: Text(
                          label.leadStatusDesc,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(13),
                              color: ColorConstants.inputBoxHintColor,
                              fontFamily: "Muli"),
                        ),
                      ),
                    ),
                    value: label,
                  ))
              .toList(),
          //  elevation: 0,
          iconSize: 35,
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: (labelText != null) ? Text(labelText) : Text(""),
          ),
          // hint: Text('Rating'),
          onChanged: (value) {
            setState(() {
              _selectedValuedummy = value;
              if ((viewLeadDataResponse.leadsEntity.leadStageId == 2 ||
                  viewLeadDataResponse.leadsEntity.leadStageId == 3)) {
                if (_selectedValuedummy.id == 2) {
                  Get.dialog(CustomDialogs().showRejectionConfirmationDialog(
                      "Are you sure, You want to reject a site",
                      context,
                      viewLeadDataResponse));
                } else if (_selectedValuedummy.id == 3) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) =>
                          new ChangeLeadToSiteDialog(
                            selectedNextStageConstructionEntity:
                                _selectedNextStageConstructionEntity,
                            dealerEntityForDb: dealerEntityForDb,
                            counterListModel: counterListModel,
                            siteFloorsEntity:_siteFloorsEntity,
                            mListener: this,
                          ));
                } else if (_selectedValuedummy.id == 4) {
                  String empId;
                  String mobileNumber;
                  String name;
                  Future<SharedPreferences> _prefs =
                      SharedPreferences.getInstance();
                  _prefs.then((SharedPreferences prefs) async {
                    empId =
                        prefs.getString(StringConstants.employeeId) ?? "empty";
                    mobileNumber =
                        prefs.getString(StringConstants.mobileNumber) ??
                            "empty";
                    name = prefs.getString(StringConstants.employeeName) ??
                        "empty";

                    if (_comments.text == "") {
                      _comments.text = "Stage Changed";
                    }

                    List<CommentsDetail> commentsDetails = [
                      new CommentsDetail(
                          createdBy: empId,
                          commentText: _comments.text,
                          creatorName: name)
                    ];

                    List<updateRequest.ListLeadcomments> commentsList =
                        new List();

                    for (int i = 0; i < commentsDetails.length; i++) {
                      commentsList.add(new updateRequest.ListLeadcomments(
                        leadId: widget.leadId,
                        commentText: commentsDetails[i].commentText,
                        creatorName: name,
                        createdBy: empId,
                      ));
                    }

                    List<updateRequest.ListLeadImage> imageList = new List();
                    for (int i = 0; i < listLeadImage.length; i++) {
                      imageList.add(new updateRequest.ListLeadImage(
                        leadId: widget.leadId,
                        photoName: listLeadImage[i].photoName,
                        createdBy: empId,
                      ));
                    }
                    if (_listInfluencerDetail.length != 0) {
                      if (_listInfluencerDetail[
                                      _listInfluencerDetail.length - 1]
                                  .inflName ==
                              null ||
                          (_listInfluencerDetail[
                                      _listInfluencerDetail.length - 1]
                                  .inflName ==
                              null) ||
                          (_listInfluencerDetail[
                                  _listInfluencerDetail.length - 1]
                              .inflName
                              .text
                              .isNullOrBlank)) {
                        _listInfluencerDetail
                            .removeAt(_listInfluencerDetail.length - 1);
                      }
                    }
                    List<updateRequest.LeadInfluencerEntity> listInfluencer =
                        new List();

                    for (int i = 0; i < _listInfluencerDetail.length; i++) {
                      print(_listInfluencerDetail[i].toJson());
                      listInfluencer.add(new updateRequest.LeadInfluencerEntity(
                          leadId: widget.leadId,
                          isPrimary: _listInfluencerDetail[i].isPrimarybool
                              ? "Y"
                              : "N",
                          createdBy: empId,
                          inflId: int.parse(_listInfluencerDetail[i].id.text),
                          isDelete: "N"));
                    }
                    Get.dialog(showDuplicateDialog(context, empId));
                  });
                } else if (_selectedValuedummy.id == 5) {
                  Get.dialog(showFutureDialog(context));
                }
              } else {
                Get.dialog(CustomDialogs().errorDialog(
                    "Lead Stage must be either phy-verified or Tele-verified"));
              }
            });
          },

          //
        ),
      ),
    );

    final name = TextFormField(
      controller: _contactName,
      //autofocus: true,
      focusNode: myFocusNode,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Name"),
    );

    final contact = TextFormField(
        controller: _contactNumber,
        readOnly: true,
        style: FormFieldStyle.formFieldTextStyle,
        decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Mobile Number",
        ));

    final leadSource = TextFormField(
      controller: _leadSource,
      //autofocus: true,
      //focusNode: myFocusNode,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Lead Source"),
    );

    final leadSourceUser = TextFormField(
      controller: _leadSourceUser,
      //autofocus: true,
      focusNode: myFocusNode,
      readOnly: true,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Lead Source User"),
    );


    final btnGeo = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        FlatButton.icon(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: Colors.black26)),
          color: Colors.transparent,
          icon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.location_searching,
              color: HexColor("#F9A61A"),
              size: 18,
            ),
          ),
          label: Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
            child: Text(
              "DETECT",
              style: TextStyle(
                  color: HexColor("#F9A61A"),
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 2,
                  fontSize: 17),
            ),
          ),
          onPressed: () async {
            setState(() {
              geoTagType.text = "A";
            });
            Get.dialog(Center(
              child: CircularProgressIndicator(),
            ));
            List result;
            result = await GetCurrentLocation.getCurrentLocation();
            _currentPosition = result[1];
            List<String> loc = result[0];
            _siteAddress.text = "${loc[7]}, ${loc[6]}, ${loc[4]}";
            _district.text = "${loc[2]}";
            _state.text = "${loc[1]}";
            _pincode.text = "${loc[5]}";
            _taluk.text = "${loc[3]}";
            _currentAddress = "${loc[3]}, ${loc[5]}, ${loc[1]}";
          },
        ),
        Text(
          "Or",
          style: TextStyle(fontFamily: "Muli", fontSize: 17),
        ),
        FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: Colors.black26)),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
            child: Text(
              "MANUAL",
              style: TextStyle(
                  color: HexColor("#F9A61A"),
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 2,
                  fontSize: 17),
            ),
          ),
          onPressed: () async {
            var data = [];
            data = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => CustomMap()));
            setState(() {
              geoTagType.text = "M";
            });
            _currentPosition =
                new Position(latitude: data[0], longitude: data[1]);
            _getAddressFromLatLng();
          },
        ),
      ],
    );

    final siteAddress = TextFormField(
      controller: _siteAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Address ';
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Address"),
    );

    final pincode = TextFormField(
      controller: _pincode,
      validator: (value) {
        if (!value.isEmpty && !Validations.isValidPincode(value)) {
          return "Enter valid pincode";
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      maxLength: 6,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Pincode",
      ),
    );

    final txtMandatory = Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        "Mandatory",
        style: TextStyle(
          fontFamily: "Muli",
          color: ColorConstants.inputBoxHintColorDark,
          fontWeight: FontWeight.normal,
        ),
      ),
    );

    final state = TextFormField(
      controller: _state,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter State ';
        }

        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "State",
      ),
    );

    final district = TextFormField(
      controller: _district,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter District ';
        }

        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "District",
      ),
    );

    final taluka = TextFormField(
      controller: _taluk,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter Taluk ';
        }
        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      decoration: FormFieldStyle.buildInputDecoration(labelText: "Taluk"),
    );

    final btnUploadPhoto = Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: BorderSide(color: Colors.black26)),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(right: 5, bottom: 10, top: 10),
          child: Text(
            "UPLOAD PHOTOS",
            style: TextStyle(
                color: HexColor("#1C99D4"),
                fontWeight: FontWeight.bold,
                // letterSpacing: 2,
                fontSize: 17),
          ),
        ),
        onPressed: () async {
          if (_addLeadsController.imageList.length < 5) {
            _addLeadsController.updateImageList(
                await UploadImageBottomSheet.showPicker(context), userSelectedImageStatus);
          } else {
            Get.dialog(
                CustomDialogs().errorDialog("You can add only upto 5 photos"));
          }
        },
      ),
    );

    final btnAddMoreInf = Center(
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: Colors.black26)),
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(right: 5, bottom: 8, top: 5),
            child: Text(
              "ADD MORE INFLUENCER",
              style: TextStyle(
                  color: HexColor("#1C99D4"),
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 2,
                  fontSize: 17),
            ),
          ),
          onPressed: () async {
            btnAddMoreInfClicked();
          }),
    );

    final totalSitePotential = Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextFormField(
              // initialValue: _totalBags.toString(),
              controller: _totalBags,
              onChanged: (value) {
                setState(() {
                  // _totalBags.text = value ;
                  if (_totalBags.text == null || _totalBags.text == "") {
                    _totalMT.clear();
                  } else {
                    _totalMT.text =
                        (int.parse(_totalBags.text) / 20).toString();
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

              style: FormFieldStyle.formFieldTextStyle,
              decoration:
                  FormFieldStyle.buildInputDecoration(labelText: "Bags"),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              controller: _totalMT,
              onChanged: (value) {
                setState(() {
                  // _totalBags.text = value ;
                  if (_totalMT.text == null || _totalMT.text == "") {
                    _totalBags.clear();
                  } else {
                    _totalBags.text =
                        (double.parse(_totalMT.text) * 20).toInt().toString();
                  }
                });
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter MT ';
                }

                return null;
              },
              style: FormFieldStyle.formFieldTextStyle,
              decoration: FormFieldStyle.buildInputDecoration(labelText: "MT"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
        )
      ],
    );

    final rera = TextFormField(
      controller: _rera,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter RERA Number ';
        }

        return null;
      },
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "RERA Number",
      ),
    );

    final comment = TextFormField(
      maxLines: 4,
      maxLength: 500,
      controller: _comments,
      style: FormFieldStyle.formFieldTextStyle,
      keyboardType: TextInputType.text,
      decoration: FormFieldStyle.buildInputDecoration(
        labelText: "Comment",
      ),
    );

    final btnMoveToNextStage = Center(
      child: RaisedButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: HexColor("#1C99D4"),
        child: Padding(
          padding: const EdgeInsets.only(right: 5, bottom: 10, top: 10),
          child: Text(
            "MOVE TO NEXT STAGE",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 17),
          ),
        ),
        onPressed: () async {
         // print("_addLeadsController.imageList   ${_addLeadsController.imageList.length}");

          nextStageModalBottomSheet(context/*, _addLeadsController.imageList*/);

          //nextStageModalBottomSheet(context);
        },
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _formKeyForViewLeadScreen,
      backgroundColor: Colors.white,
      floatingActionButton: BackFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigator(),
      body: Stack(
        children: [
          BackgroundContainerImage(),
          Positioned.fill(
            child: (viewLeadDataResponse != null &&
                    viewLeadDataResponse.leadsEntity != null)
                ? GetBuilder<AddLeadsController>(builder: (controller) {
                    return ListView(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setSp(20),
                                  bottom: ScreenUtil().setSp(15),
                                  left: ScreenUtil().setSp(15)),
                              child: Text(
                                "Trade lead",
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
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setSp(20),
                                left: ScreenUtil().setSp(15),
                                right: ScreenUtil().setSp(15)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "ID: " + widget.leadId.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: "Muli",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 50),
                                  Expanded(
                                    flex: 4,
                                    child: statusDropDown,
                                  ),
                                ])),
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setSp(16)),
                          child: Form(
                            key: _addLeadFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                leadSource,
                                SizedBox(height: _height),
                                leadSourceUser,
                                SizedBox(height: _height),
                                name,
                                SizedBox(height: _height),
                                contact,
                                SizedBox(height: _height),
                                Divider(
                                  color: Colors.black26,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 20, left: 5),
                                  child: Text(
                                    "Geo Tag",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        // color: HexColor("#000000DE"),
                                        fontFamily: "Muli"),
                                  ),
                                ),
                                btnGeo,
                                SizedBox(height: _height),
                                siteAddress,
                                SizedBox(height: _height),
                                pincode,
                                txtMandatory,
                                SizedBox(height: _height),
                                state,
                                txtMandatory,
                                SizedBox(height: _height),
                                district,
                                txtMandatory,
                                SizedBox(height: _height),
                                taluka,
                                txtMandatory,
                                SizedBox(height: _height),
                                btnUploadPhoto,
                                SizedBox(height: _height),
                                controller.imageList != null
                                    //    _imageList != null
                                    ? Row(
                                        children: [
                                          Expanded(
                                            child: ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    //_imageList.length,
                                                    controller.imageList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      return showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            // return AlertDialog(
                                                            //   content:
                                                            //   new Container(
                                                            //     // width: 500,
                                                            //     // height: 500,
                                                            //     child: _imgDetails[
                                                            //     index]
                                                            //         .from
                                                            //         .toLowerCase() ==
                                                            //         "network"
                                                            //         ? Image.network(
                                                            //         _imgDetails[
                                                            //         index]
                                                            //             .file
                                                            //             .path)
                                                            //         : Image.file(
                                                            //         _imgDetails[
                                                            //         index]
                                                            //             .file),
                                                            //   ),
                                                            // );
                                                            print(controller
                                                                .imageList[
                                                            index].toString());
                                                            return AlertDialog(
                                                              content:
                                                                  new Container(
                                                                // width: 500,
                                                                // height: 500,
                                                                child: Image.file(
                                                                    controller.imageList[index]),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Picture ${(index + 1)}. ",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            Text(
                                                              "Image_${(index + 1)}.jpg",
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      "#007CBF"),
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                                   GestureDetector(
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: HexColor("#FFCD00"),
                                                          ),
                                                          onTap: () {
                                                           setState(() {
                                                                            //controller.imageList.removeAt(index);
                                                             controller. updateImageAfterDelete(index);
                                                             UploadImageBottomSheet.image = null;
                                                                          });
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                SizedBox(height: _height),
                                Divider(
                                  color: Colors.black26,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 20, left: 5),
                                  child: Text(
                                    "Influencer Details",
                                    style: TextStyles.muliBold25,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount:
                                              _listInfluencerDetail.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (!_listInfluencerDetail[index]
                                                .isExpanded) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Influencer Details ${(index + 1)} ",
                                                        style: TextStyles
                                                            .mulliBold18,
                                                      ),
                                                      Switch(
                                                        onChanged: (value) {
                                                          setState(() {
                                                            if (value) {
                                                              for (int i = 0;
                                                                  i <
                                                                      _listInfluencerDetail
                                                                          .length;
                                                                  i++) {
                                                                if (i ==
                                                                    index) {
                                                                  _listInfluencerDetail[
                                                                              i]
                                                                          .isPrimarybool =
                                                                      value;
                                                                } else {
                                                                  _listInfluencerDetail[
                                                                              i]
                                                                          .isPrimarybool =
                                                                      !value;
                                                                }
                                                              }
                                                            } else {
                                                              Get.dialog(CustomDialogs()
                                                                  .errorDialog(
                                                                      "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
                                                            }
                                                          });
                                                        },
                                                        value:
                                                            _listInfluencerDetail[
                                                                    index]
                                                                .isPrimarybool,
                                                        activeColor:
                                                            HexColor("#009688"),
                                                        activeTrackColor:
                                                            HexColor("#009688")
                                                                .withOpacity(
                                                                    0.5),
                                                        inactiveThumbColor:
                                                            HexColor("#F1F1F1"),
                                                        inactiveTrackColor:
                                                            Colors.black26,
                                                      ),
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded
                                                          ? FlatButton.icon(
                                                              // shape: RoundedRectangleBorder(
                                                              //     borderRadius: BorderRadius.circular(0),
                                                              //     side: BorderSide(color: Colors.black26)),
                                                              color: Colors
                                                                  .transparent,
                                                              icon: Icon(
                                                                Icons.remove,
                                                                color: ColorConstants
                                                                    .btnOrange,
                                                                size: 18,
                                                              ),
                                                              label: Text(
                                                                "COLLAPSE",
                                                                style: TextStyles
                                                                    .muliBoldOrange17,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  _listInfluencerDetail[
                                                                          index]
                                                                      .isExpanded = !_listInfluencerDetail[
                                                                          index]
                                                                      .isExpanded;
                                                                });
                                                              },
                                                            )
                                                          : FlatButton.icon(
                                                              color: Colors
                                                                  .transparent,
                                                              icon: Icon(
                                                                Icons.add,
                                                                color: ColorConstants
                                                                    .btnOrange,
                                                                size:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            16),
                                                              ),
                                                              label: Text(
                                                                "EXPAND",
                                                                style: TextStyles
                                                                    .muliBoldOrange17,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  _listInfluencerDetail[
                                                                          index]
                                                                      .isExpanded = !_listInfluencerDetail[
                                                                          index]
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "Influencer Details ${(index + 1)} ",
                                                          style: TextStyles
                                                              .mulliBold18),
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded
                                                          ? FlatButton.icon(
                                                              color: Colors
                                                                  .transparent,
                                                              icon: Icon(
                                                                Icons.remove,
                                                                color: ColorConstants
                                                                    .btnOrange,
                                                                size: 18,
                                                              ),
                                                              label: Text(
                                                                "COLLAPSE",
                                                                style: TextStyles
                                                                    .muliBoldOrange17,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  _listInfluencerDetail[
                                                                          index]
                                                                      .isExpanded = !_listInfluencerDetail[
                                                                          index]
                                                                      .isExpanded;
                                                                });
                                                                // _getCurrentLocation();
                                                              },
                                                            )
                                                          : FlatButton.icon(
                                                              color: Colors
                                                                  .transparent,
                                                              icon: Icon(
                                                                Icons.add,
                                                                color: ColorConstants
                                                                    .btnOrange,

                                                                size:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            16),
                                                              ),
                                                              label: Text(
                                                                "EXPAND",
                                                                style: TextStyles
                                                                    .muliBoldOrange17,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  _listInfluencerDetail[
                                                                          index]
                                                                      .isExpanded = !_listInfluencerDetail[
                                                                          index]
                                                                      .isExpanded;
                                                                });
                                                                // _getCurrentLocation();
                                                              },
                                                            ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 16),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Secondary",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            // color: HexColor("#000000DE"),
                                                            fontFamily: "Muli"),
                                                      ),
                                                      Switch(
                                                        onChanged: (value) {
                                                          setState(() {
                                                            if (value) {
                                                              for (int i = 0;
                                                                  i <
                                                                      _listInfluencerDetail
                                                                          .length;
                                                                  i++) {
                                                                if (i ==
                                                                    index) {
                                                                  _listInfluencerDetail[
                                                                              i]
                                                                          .isPrimarybool =
                                                                      value;
                                                                } else {
                                                                  _listInfluencerDetail[
                                                                              i]
                                                                          .isPrimarybool =
                                                                      !value;
                                                                }
                                                              }
                                                            } else {
                                                              Get.dialog(CustomDialogs()
                                                                  .errorDialog(
                                                                      "There should be one Primary Influencer . Please select other influencer to make this influencer secondary"));
                                                            }
                                                          });
                                                        },
                                                        value:
                                                            _listInfluencerDetail[
                                                                    index]
                                                                .isPrimarybool,
                                                        activeColor:
                                                            HexColor("#009688"),
                                                        activeTrackColor:
                                                            HexColor("#009688")
                                                                .withOpacity(
                                                                    0.5),
                                                        inactiveThumbColor:
                                                            HexColor("#F1F1F1"),
                                                        inactiveTrackColor:
                                                            Colors.black26,
                                                      ),
                                                      Text(
                                                        "Primary",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: _listInfluencerDetail[
                                                                        index]
                                                                    .isPrimarybool
                                                                ? HexColor(
                                                                    "#009688")
                                                                : Colors.black,
                                                            // color: HexColor("#000000DE"),
                                                            fontFamily: "Muli"),
                                                      ),
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    controller:
                                                        _listInfluencerDetail[
                                                                index]
                                                            .inflContact,
                                                    maxLength: 10,
                                                    onChanged: (value) async {
                                                      bool match = false;
                                                      if (value.length < 10) {
                                                        if (_listInfluencerDetail[
                                                                    index]
                                                                .inflName !=
                                                            null) {
                                                          _listInfluencerDetail[
                                                                  index]
                                                              .inflName
                                                              .clear();
                                                          _listInfluencerDetail[
                                                                  index]
                                                              .inflTypeValue
                                                              .clear();
                                                          _listInfluencerDetail[
                                                                  index]
                                                              .inflCatValue
                                                              .clear();
                                                        }
                                                      } else if (value.length ==
                                                          10) {
                                                        var bodyEncrypted = {
                                                          //"reference-id": "IqEAFdXco54HTrBkH+sWOw==",
                                                          "inflContact": value
                                                        };

                                                        for (int i = 0;
                                                            i <
                                                                _listInfluencerDetail
                                                                        .length -
                                                                    1;
                                                            i++) {
                                                          if (value ==
                                                              _listInfluencerDetail[
                                                                      i]
                                                                  .inflContact
                                                                  .text) {
                                                            match = true;
                                                            break;
                                                          }
                                                        }

                                                        if (match) {
                                                          Get.dialog(CustomDialogs()
                                                              .errorDialog(
                                                                  "Already added influencer : " +
                                                                      value));
                                                        } else {
                                                          apiCallForInfContact(
                                                              index,
                                                              value,
                                                              context);
                                                        }
                                                      }
                                                    },
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Please enter Influencer Number ';
                                                      } else if (value.length !=
                                                          10) {
                                                        return 'Mobile number must be of 10 digit';
                                                      }
                                                      if (!Validations
                                                          .isValidPhoneNumber(
                                                              value)) {
                                                        return 'Enter valid mobile number';
                                                      }

                                                      return null;
                                                    },
                                                    style: FormFieldStyle
                                                        .formFieldTextStyle,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    decoration: FormFieldStyle
                                                        .buildInputDecoration(
                                                            labelText:
                                                                "Infl. Contact"),
                                                  ),
                                                  SizedBox(height: _height),
                                                  TextFormField(
                                                    controller:
                                                        _listInfluencerDetail[
                                                                index]
                                                            .inflName,

                                                    // validator: (value) {
                                                    //   if (value.isEmpty) {
                                                    //     return 'Please enter Influencer Number ';
                                                    //   }
                                                    //
                                                    //   return null;
                                                    // },
                                                    style: FormFieldStyle
                                                        .formFieldTextStyle,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: FormFieldStyle
                                                        .buildInputDecoration(
                                                            labelText:
                                                                "Infl. Name"),
                                                  ),
                                                  SizedBox(height: 16),
                                                  TextFormField(
                                                    controller:
                                                        _listInfluencerDetail[
                                                                index]
                                                            .inflTypeValue,
                                                    // validator: (value) {
                                                    //   if (value.isEmpty) {
                                                    //     return 'Please enter Influencer Number ';
                                                    //   }
                                                    //
                                                    //   return null;
                                                    // },
                                                    style: FormFieldStyle
                                                        .formFieldTextStyle,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: FormFieldStyle
                                                        .buildInputDecoration(
                                                            labelText:
                                                                "Infl. Type"),
                                                  ),
                                                  SizedBox(height: 16),
                                                  TextFormField(
                                                    controller:
                                                        _listInfluencerDetail[
                                                                index]
                                                            .inflCatValue,
                                                    style: FormFieldStyle
                                                        .formFieldTextStyle,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: FormFieldStyle
                                                        .buildInputDecoration(
                                                            labelText:
                                                                "Infl. Category"),
                                                  ),
                                                ],
                                              );
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                                SizedBox(height: _height),
                                Visibility(
                                  visible: (_listInfluencerDetail.length == 0)?true:false,
                                    child: btnAddMoreInf),
                                SizedBox(height: _height),
                                Divider(
                                  color: Colors.black26,
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 20, left: 5),
                                  child: Text(
                                    "Total Site Potential",
                                    style: TextStyles.muliBold25,
                                  ),
                                ),
                                totalSitePotential,
                                SizedBox(height: _height),
                                rera,
                                SizedBox(height: _height),
                                comment,
                                SizedBox(height: _height),
                                _commentsList != null &&
                                        _commentsList.length != 0
                                    ? viewMoreActive
                                        ? Row(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    reverse: true,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        _commentsList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                _commentsList[
                                                                        index]
                                                                    .creatorName,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                              Text(
                                                                _commentsList[
                                                                        index]
                                                                    .commentText,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                              Text(
                                                                _commentsList[
                                                                        index]
                                                                    .commentedAt
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          )
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    _commentsList[_commentsList
                                                                .length -
                                                            1]
                                                        .creatorName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                  Text(
                                                    _commentsList[_commentsList
                                                                .length -
                                                            1]
                                                        .commentText,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 25),
                                                  ),
                                                  Text(
                                                    _commentsList[_commentsList
                                                                .length -
                                                            1]
                                                        .commentedAt
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          )
                                    : Container(),
                                _commentsList.length == 1
                                    ? Container()
                                    : Center(
                                        child: FlatButton(
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5, bottom: 8, top: 5),
                                            child: !viewMoreActive
                                                ? Text(
                                                    "VIEW MORE COMMENT (" +
                                                        _commentsList.length
                                                            .toString() +
                                                        ")",
                                                    style: TextStyle(
                                                        color: HexColor(
                                                            "##F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  )
                                                : Text(
                                                    "VIEW LESS COMMENT (" +
                                                        _commentsList.length
                                                            .toString() +
                                                        ")",
                                                    style: TextStyle(
                                                        color: HexColor(
                                                            "##F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                          ),
                                          onPressed: () async {
                                            setState(() {
                                              viewMoreActive = !viewMoreActive;
                                            });
                                          },
                                        ),
                                      ),
                                SizedBox(
                                  height: _height,
                                ),
                                SizedBox(
                                  height: _height,
                                ),
                                btnMoveToNextStage,
                                SizedBox(
                                  height: _height,
                                ),
                                SizedBox(
                                  height: _height,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  })
                : Center(
                    child: Text(""),
                  ),
          )
        ],
      ),
    );


  }


  final _addLeadFormKey = GlobalKey<FormState>();
  final _formKeyForViewLeadScreen = GlobalKey();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  int initialImagelistLength;
  LeadStatusEntity _selectedValue;
  NextStageConstructionEntity _selectedNextStageConstructionEntity;
  DealerList _SelectedDealer;
  LeadStatusEntity _selectedValuedummy;
  int initialInfluencerListLength;
  String labelText;
  int labelId;

  ///TextEditingControllers
  var _contactName = TextEditingController();
  var _contactNumber = TextEditingController();
  var txt = TextEditingController();
  var _nextDateofConstruction = TextEditingController();
  var _siteAddress = TextEditingController();
  var _pincode = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();
  var _taluk = TextEditingController();
  var _comments = TextEditingController();
  var _rera = TextEditingController();
  var geoTagType = TextEditingController();
  var _totalBags = TextEditingController();
  var _totalMT = TextEditingController();
  final myController = TextEditingController();
  var _originalLeadID = TextEditingController();
  var _leadSource = TextEditingController();
  var _leadSourceUser = TextEditingController();

  var leadCreatedBy;
  bool isEditable = false;
  DateTime nextStageConstructionPickedDate;

  /*List<File> _imageList = new List();*/
  List<ListLeadImage> listLeadImage = new List<ListLeadImage>();

  List<LeadphotosEntity> listLeadImagePhoto = new List<LeadphotosEntity>();
  List<CommentsDetail> _commentsList = new List();
  List<LeadcommentsEnitiy> _commentsListEntity = new List();
  List<CommentsDetail> _commentsListNew = new List();
  List<LeadStageEntity> leadStageEntity = new List();
  LeadStageEntity leadStageVal = new LeadStageEntity();
  List<LeadRejectReasonEntity> leadRejectReasonEntity = new List();
  List<NextStageConstructionEntity> nextStageConstructionEntity = new List();
  /*Work on dealer and subdelear*/
  List<CounterListModel> counterListModel = new List();
  List<CounterListModel> subDealerList = new List();
  CounterListModel selectedSubDealer = CounterListModel();
  List<DealerForDb> dealerEntityForDb = new List();

  List<DealerList> dealerList = new List();
  List<ImageDetails> _imgDetails = new List();
  String leadDataDealer;
  String leadDataSubDealer;

  FocusNode myFocusNode;
  bool viewMoreActive = false;

  List<String> _items = new List(); // to store comments

  List<Item> _data = generateItems(1);
  List<InfluencerDetail> _listInfluencerDetail = new List();
  List<InfluencerEntity> _listInfluencerEntity = new List();
  List<LeadInfluencerEntity> _listLeadInfluencerEntity = new List();
  Position _currentPosition;
  String _currentAddress;
  List<LeadStatusEntity> leadStatusEntity = new List();
  ViewLeadDataResponse viewLeadDataResponse = new ViewLeadDataResponse();

  List<InfluencerTypeEntity> influencerTypeEntity;

  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<SiteFloorsEntity> _siteFloorsEntity ;
  AddLeadsController _addLeadsController = Get.find();
  final db = BrandNameDBHelper();
  BuildContext _context;

  checkStatus() {
    leadStatusEntity = viewLeadDataResponse.leadStatusEntity;
    LeadStatusEntity list;
    // print(viewLeadDataResponse.leadsEntity.leadStatusId);

    for (int i = 0; i < leadStatusEntity.length; i++) {
      if (viewLeadDataResponse.leadsEntity.leadStatusId.toString() ==
          leadStatusEntity[i].id.toString()) {
        labelText = leadStatusEntity[i].leadStatusDesc;
        labelId = leadStatusEntity[i].id;
        if (labelId == 2 || labelId == 3 || labelId == 4 || labelId == 5) {
          showDialog(
            context: _formKeyForViewLeadScreen.currentState.context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  content: new Text(
                    "Status of this lead is $labelText . You cannot edit or update it.",
                  ),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
        list = new LeadStatusEntity(
            id: leadStatusEntity[i].id,
            leadStatusDesc: leadStatusEntity[i].leadStatusDesc);

      }
    }
  }


  apiCallForInfContact(int index, String value, BuildContext context) async {
    String empId;
    String mobileNumber;
    String name;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      name = prefs.getString(StringConstants.employeeName) ?? "empty";
    });
    AddLeadsController _addLeadsController = Get.find();
    _addLeadsController.phoneNumber = value;
    AccessKeyModel accessKeyModel = new AccessKeyModel();
    await _addLeadsController.getAccessKeyOnly().then((data) async {
      accessKeyModel = data;
      await _addLeadsController
          .getInfNewData(accessKeyModel.accessKey)
          .then((data) {
        InfluencerDetailModel _infDetailModel = data;
        if (_infDetailModel.respCode == "DM1002") {
          InfluencerModel inflDetail = _infDetailModel.influencerModel;

          if (inflDetail.inflName != "null") {
            setState(() {
              _listInfluencerDetail[index].inflContact =
                  new TextEditingController();
              _listInfluencerDetail[index].inflName =
                  new TextEditingController();
              FocusScope.of(context).unfocus();
              _listInfluencerDetail[index].inflTypeId =
                  new TextEditingController();
              _listInfluencerDetail[index].inflCatId =
                  new TextEditingController();
              _listInfluencerDetail[index].inflTypeValue =
                  new TextEditingController();
              _listInfluencerDetail[index].inflCatValue =
                  new TextEditingController();
              _listInfluencerDetail[index].id = new TextEditingController();
              _listInfluencerDetail[index].ilpIntrested =
                  new TextEditingController();


              _listInfluencerDetail[index].inflContact.text =
                  inflDetail.inflContact;
              _listInfluencerDetail[index].inflName.text = inflDetail.inflName;
              _listInfluencerDetail[index].id.text =
                  inflDetail.inflId.toString();
              _listInfluencerDetail[index].ilpIntrested.text =
                  inflDetail.ilpRegFlag;
              _listInfluencerDetail[index].inflTypeValue.text =
                  inflDetail.influencerTypeText;
              _listInfluencerDetail[index].inflCatValue.text =
                  inflDetail.influencerCategoryText;
              _listInfluencerDetail[index].createdBy = empId;

              for (int i = 0; i < influencerTypeEntity.length; i++) {
                if (influencerTypeEntity[i].inflTypeId.toString() ==
                    inflDetail.inflTypeId.toString()) {
                  _listInfluencerDetail[index].inflTypeId.text =
                      inflDetail.inflTypeId.toString();
                  _listInfluencerDetail[index].inflTypeValue.text =
                      influencerTypeEntity[
                              influencerTypeEntity[i].inflTypeId - 1]
                          .inflTypeDesc;
                  break;
                } else {
                  // _listInfluencerDetail[
                  // index]
                  //     .inflContact
                  //     .clear();
                  // _listInfluencerDetail[
                  // index]
                  //     .inflName
                  //     .clear();
                  _listInfluencerDetail[index].inflTypeId.clear();
                  _listInfluencerDetail[index].inflTypeValue.clear();
                }
              }

              for (int i = 0; i < influencerCategoryEntity.length; i++) {
                if (influencerCategoryEntity[i].inflCatId.toString() ==
                    inflDetail.inflCatId.toString()) {
                  _listInfluencerDetail[index].inflCatId.text =
                      inflDetail.inflCatId.toString();
                  //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                  _listInfluencerDetail[index].inflCatValue.text =
                      influencerCategoryEntity[
                              influencerCategoryEntity[i].inflCatId - 1]
                          .inflCatDesc;
                  break;
                } else {
                  _listInfluencerDetail[index].inflCatId.clear();
                  _listInfluencerDetail[index].inflCatValue.clear();
                }
              }
            });
          } else {
            if (_listInfluencerDetail[index].inflContact != null) {
              setState(() {
                _listInfluencerDetail[index].inflContact.clear();
                _listInfluencerDetail[index].inflName.clear();
              });
            }
            return Get.dialog(CustomDialogs()
                .showDialog("No influencer registered with this number"));
          }
        } else {
          if (_listInfluencerDetail[index].inflContact != null) {
            _listInfluencerDetail[index].inflContact.clear();
            _listInfluencerDetail[index].inflName.clear();
          }
          return Get.dialog(
              CustomDialogs()
                  .showDialogRestrictSystemBack(_infDetailModel.respMsg),
              barrierDismissible: false);
        }
        // });
        Get.back();
      });
      // Get.back();
    });
  }

  btnAddMoreInfClicked() {
    if (_listInfluencerDetail.length == 0) {
      setState(() {
        _listInfluencerDetail
            .add(new InfluencerDetail(isExpanded: true, isPrimarybool: true));
      });
    } else {
      if (_listInfluencerDetail[_listInfluencerDetail.length - 1].inflName !=
              null &&
          _listInfluencerDetail[_listInfluencerDetail.length - 1].inflName !=
              "null" &&
          !_listInfluencerDetail[_listInfluencerDetail.length - 1]
              .inflName
              .text
              .isNullOrBlank) {
        InfluencerDetail infl =
            new InfluencerDetail(isExpanded: true, isPrimarybool: false);
        setState(() {
          _listInfluencerDetail[_listInfluencerDetail.length - 1].isExpanded =
              false;
          _listInfluencerDetail.add(infl);
        });
      } else {
        // print("Error : Please fill previous influencer first");
        Get.dialog(CustomDialogs()
            .errorDialog("Please fill previous influencer first"));
      }
    }
  }



  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];
      setState(() {
        _siteAddress.text =
            place.name + "," + place.thoroughfare + place.subLocality;
        _district.text = place.subAdministrativeArea;
        _state.text = place.administrativeArea;
        _pincode.text = place.postalCode;
        _taluk.text = place.locality;
        //txt.text = place.postalCode;
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";

        // print("${place.name}, ${place.isoCountryCode}, ${place.country},${place.postalCode}, ${place.administrativeArea}, ${place.subAdministrativeArea},${place.locality}, ${place.subLocality}, ${place.thoroughfare}, ${place.subThoroughfare}, ${place.position}");
      });
    } catch (e) {
      print(e);
    }
  }

  void nextStageModalBottomSheet(context/*, List<File> _imageListFromController*/) {
    //void nextStageModalBottomSheet(context) {
// print(_imageListFromController);
    showModalBottomSheet(
        backgroundColor: ColorConstants.lightGeyColor,
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Stages",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: leadStageEntity.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                  side: BorderSide(color: Colors.black26)),
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      leadStageEntity[index].leadStageDesc,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    (leadStageVal.id ==
                                            leadStageEntity[index].id)
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          )
                                        : Icon(Icons.check_circle_outline)
                                  ],
                                ),
                              ),
                              onPressed: () async {
                                print("Step 1");
                                if (leadStageVal.id !=
                                    leadStageEntity[index].id) {
                                  print("Step 2");

                                  if (!(leadStageEntity[index].id == 2 ||
                                      (leadStageEntity[index].id == 3 &&
                                          _siteAddress.text != null &&
                                          _siteAddress.text != "" &&
                                          _pincode.text != null &&
                                          _pincode.text != "" &&
                                          _state.text != null &&
                                          _state.text != "" &&
                                          _district.text != null &&
                                          _district.text != "" &&
                                          _taluk.text != null &&
                                          _taluk.text != ""))) {
                                    if (leadStageEntity[index].id != 1) {
                                      Get.dialog(CustomDialogs().showDialog(
                                          "Please Fill Geo tag Details "));
                                    }
                                  } else {
                                    print("Step 3");

                                    String empId;
                                    String mobileNumber;
                                    String name;
                                    Future<SharedPreferences> _prefs =
                                        SharedPreferences.getInstance();
                                    _prefs
                                        .then((SharedPreferences prefs) async {
                                      empId = prefs.getString(
                                              StringConstants.employeeId) ??
                                          "empty";
                                      mobileNumber = prefs.getString(
                                              StringConstants.mobileNumber) ??
                                          "empty";
                                      name = prefs.getString(
                                              StringConstants.employeeName) ??
                                          "empty";

                                      if (_comments.text == "") {
                                        _comments.text = "Stage Changed";
                                      }

                                      List<CommentsDetail> commentsDetails = [
                                        new CommentsDetail(
                                            createdBy: empId,
                                            commentText: _comments.text,
                                            // commentedAt: DateTime.now(),
                                            creatorName: name)
                                      ];
                                      print("Step 4");


                                      List<updateRequest.ListLeadcomments>
                                          commentsList = new List();

                                      for (int i = 0;
                                          i < commentsDetails.length;
                                          i++) {
                                        commentsList.add(
                                            new updateRequest.ListLeadcomments(
                                          leadId: widget.leadId,
                                          commentText:
                                              commentsDetails[i].commentText,
                                          creatorName: name,
                                          createdBy: empId,
                                        ));
                                      }

                                      List<updateRequest.ListLeadImage> selectedImageListDetails = new List();
                                      List<File> userSelectedImageFile=new List();
                                      print("addLeadsController.selectedImageNameList    ${_addLeadsController.selectedImageNameList.length}");

                                      _addLeadsController.selectedImageNameList.forEach((leadModel) {
                                        if(leadModel.imageStatus==userSelectedImageStatus){
                                          selectedImageListDetails.add(
                                              new updateRequest.ListLeadImage(
                                                leadId: widget.leadId,
                                                photoName: leadModel.photoName,
                                                createdBy: empId,
                                              ));

                                          userSelectedImageFile.add(leadModel.imageFilePath);
                                        }


                                      });


                                     /* for (int i = 0;
                                          i < listLeadImage.length;
                                          i++) {
                                        selectedImageListDetails.add(
                                            new updateRequest.ListLeadImage(
                                          leadId: widget.leadId,
                                          photoName: listLeadImage[i].photoName,
                                          createdBy: empId,
                                        ));
                                      }*/

                                      print("Image List: $selectedImageListDetails");
                                      if (_listInfluencerDetail.length != 0) {
                                        if (_listInfluencerDetail[
                                                        _listInfluencerDetail
                                                                .length -
                                                            1]
                                                    .inflName ==
                                                null ||
                                            _listInfluencerDetail[
                                                        _listInfluencerDetail
                                                                .length -
                                                            1]
                                                    .inflName
                                                    .text ==
                                                "null" ||
                                            _listInfluencerDetail[
                                                    _listInfluencerDetail
                                                            .length -
                                                        1]
                                                .inflName
                                                .text
                                                .isNullOrBlank) {
                                          _listInfluencerDetail.removeAt(
                                              _listInfluencerDetail.length - 1);
                                        }
                                      }
                                      List<updateRequest.LeadInfluencerEntity>
                                          listInfluencer = new List();

//                                      print(_listInfluencerDetail.length);

                                      for (int i = 0;
                                          i < _listInfluencerDetail.length;
                                          i++) {
//                                        print(_listInfluencerDetail[i].toJson());
                                        listInfluencer.add(new updateRequest
                                                .LeadInfluencerEntity(
                                            id: _listInfluencerDetail[i]
                                                .originalId,
                                            leadId: widget.leadId,
                                            isPrimary: _listInfluencerDetail[i]
                                                    .isPrimarybool
                                                ? "Y"
                                                : "N",
                                            createdBy: empId,
                                            inflId: int.parse(
                                                _listInfluencerDetail[i]
                                                    .id
                                                    .text),
                                            isDelete: "N"));
                                      }
                                      print("Step 5");


                                      var updateRequestModel = {
                                        'leadId': viewLeadDataResponse
                                            .leadsEntity.leadId,
                                        'eventId': viewLeadDataResponse
                                            .leadsEntity.eventId,
                                        'leadSegment': viewLeadDataResponse
                                            .leadsEntity.leadSegment,
                                        'assignedTo': viewLeadDataResponse
                                            .leadsEntity.assignedTo,
                                        'leadStatusId': viewLeadDataResponse
                                            .leadsEntity.leadStatusId,
                                        'leadStage': leadStageEntity[index].id,
                                        'contactName': _contactName.text,
                                        'contactNumber': _contactNumber.text,
                                        'geotagType': geoTagType.text,
                                        'leadLatitude': _currentPosition
                                            .latitude
                                            .toString(),
                                        'leadLongitude': _currentPosition
                                            .longitude
                                            .toString(),
                                        'leadAddress': _siteAddress.text,
                                        'leadPincode': _pincode.text,
                                        'leadStateName': _state.text,
                                        'leadDistrictName': _district.text,
                                        'leadTalukName': _taluk.text,
                                        'leadSalesPotentialMt': _totalMT.text,
                                        'leadReraNumber': _rera.text,
                                        'isStatus': "false",
                                        'updatedBy': empId,
                                        'leadIsDuplicate': viewLeadDataResponse
                                            .leadsEntity.leadIsDuplicate,
                                        'rejectionComment': viewLeadDataResponse
                                            .leadsEntity.rejectionComment,
                                        'nextDateCconstruction':
                                            viewLeadDataResponse.leadsEntity
                                                .nextDateCconstruction,
                                        'nextStageConstruction':
                                            viewLeadDataResponse.leadsEntity
                                                .nextStageConstruction,
                                        'siteDealerId': viewLeadDataResponse
                                            .leadsEntity.siteDealerId,
                                        'listLeadcomments': commentsList,
                                        'listLeadImage': selectedImageListDetails,
                                        'leadInfluencerEntity': listInfluencer,
                                        'leadSource':_leadSource.text,
                                        'leadSourceUser': _leadSourceUser.text,
                                        'leadSourcePlatform' : viewLeadDataResponse.leadsEntity.leadSourcePlatform
                                      };

                                      print("Step 6");


                                      leadStageVal.id =
                                          leadStageEntity[index].id;
                                      viewLeadDataResponse
                                              .leadsEntity.leadStageId =
                                          leadStageEntity[index].id;

                                      _addLeadsController.updateLeadData(
                                          updateRequestModel,
                                        //  _imageList,
                                        //  _imageListFromController,
                                          userSelectedImageFile,
                                          context,
                                          viewLeadDataResponse
                                              .leadsEntity.leadId,
                                          4);
                                    });
                                  }
                                } else {
                                  Get.back();
                                }
                              },
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget showDuplicateDialog(BuildContext context, String empId) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      content: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              TextFormField(
                controller: _originalLeadID,
                onChanged: (data) {
                  // setState(() {
                  //   _contactName.text = data;
                  // });
                },
                maxLength: 6,
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.backgroundColorBlue,
                        //color: HexColor("#0000001F"),
                        width: 1.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  labelText: "Original Lead Id",
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
            ]),
          )),
      actions: [
        TextButton(
            child: Text(
              'Submit',
              style: GoogleFonts.roboto(
                  fontSize: 17,
                  letterSpacing: 1.25,
                  fontStyle: FontStyle.normal,
                  color: ColorConstants.buttonNormalColor),
            ),
            onPressed: () {
              if (_originalLeadID.text != null && _originalLeadID.text != "") {
                var updateRequestModel = {
                  'eventId': viewLeadDataResponse.leadsEntity.eventId,
                  'leadId': viewLeadDataResponse.leadsEntity.leadId,
                  'leadSegment': viewLeadDataResponse.leadsEntity.leadSegment,
                  'assignedTo': viewLeadDataResponse.leadsEntity.assignedTo,
                  'leadStatusId': 4,
                  'leadStage': viewLeadDataResponse.leadsEntity.leadStageId,
                  'contactName': viewLeadDataResponse.leadsEntity.contactName,
                  'contactNumber':
                      viewLeadDataResponse.leadsEntity.contactNumber,
                  'geotagType': viewLeadDataResponse.leadsEntity.geotagType,
                  'leadLatitude': viewLeadDataResponse.leadsEntity.leadLatitude,
                  'leadLongitude':
                      viewLeadDataResponse.leadsEntity.leadLongitude,
                  'leadAddress': viewLeadDataResponse.leadsEntity.leadAddress,
                  'leadPincode': viewLeadDataResponse.leadsEntity.leadPincode,
                  'leadStateName':
                      viewLeadDataResponse.leadsEntity.leadStateName,
                  'leadDistrictName':
                      viewLeadDataResponse.leadsEntity.leadDistrictName,
                  'leadTalukName':
                      viewLeadDataResponse.leadsEntity.leadTalukName,
                  'leadSalesPotentialMt':
                      viewLeadDataResponse.leadsEntity.leadSitePotentialMt,
                  'leadReraNumber':
                      viewLeadDataResponse.leadsEntity.leadReraNumber,
                  'isStatus': "false",
                  'updatedBy': empId,
                  'leadIsDuplicate': "Y",
                  'leadOriginalId': _originalLeadID.text,
                  'rejectionComment':
                      viewLeadDataResponse.leadsEntity.rejectionComment,
                  'nextDateCconstruction':
                      viewLeadDataResponse.leadsEntity.nextDateCconstruction,
                  'nextStageConstruction':
                      viewLeadDataResponse.leadsEntity.nextStageConstruction,
                  'siteDealerId': viewLeadDataResponse.leadsEntity.siteDealerId,
                  // 'listLeadcomments':
                  //     new List(),
                  // 'listLeadImage':
                  //     new List(),
                  // 'leadInfluencerEntity':
                  //   new List()

                  'listLeadcomments': viewLeadDataResponse.leadcommentsEnitiy,
                  'listLeadImage': viewLeadDataResponse.leadphotosEntity,
                  'leadInfluencerEntity':
                      viewLeadDataResponse.leadInfluencerEntity,
                  'leadSource':_leadSource.text,
                  'leadSourceUser': _leadSourceUser.text,
                  'leadSourcePlatform' : viewLeadDataResponse.leadsEntity.leadSourcePlatform
                };

                _addLeadsController.updateLeadData(
                    updateRequestModel,
                    new List<File>(),
                    context,
                    viewLeadDataResponse.leadsEntity.leadId,
                    2);

                Get.back();
              }
            })
      ],
    );
  }

  Widget showFutureDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<NextStageConstructionEntity>(
                value: _selectedNextStageConstructionEntity,
                items: nextStageConstructionEntity
                    .map((label) => DropdownMenuItem(
                          child: Text(
                            label.nexStageConsText,
                            style: TextStyle(
                                fontSize: 15,
                                color: ColorConstants.inputBoxHintColor,
                                fontFamily: "Muli"),
                          ),
                          value: label,
                        ))
                    .toList(),

                // hint: Text('Rating'),
                onChanged: (value) {
                  setState(() {
                    _selectedNextStageConstructionEntity = value;
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
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  labelText: "Next Stage of Construction",
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextFormField(
                controller: _nextDateofConstruction,
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return "Contact Name can't be empty";
                //   }
                //   //leagueSize = int.parse(value);
                //   return null;
                // },
                readOnly: true,
                onChanged: (data) {
                  // setState(() {
                  //   _contactName.text = data;
                  // });
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
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black26, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  labelText: "Next date of construction",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.date_range_rounded,
                      size: 22,
                      color: ColorConstants.clearAllTextColor,
                    ),
                    onPressed: () async {
                      final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101));

                      setState(() {
                        final DateFormat formatter = DateFormat("yyyy-MM-dd");
                        final String formattedDate = formatter.format(picked);
                        nextStageConstructionPickedDate = picked;
                        _nextDateofConstruction.text = formattedDate;
                      });
                    },
                  ),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Submit',
            style: GoogleFonts.roboto(
                fontSize: 17,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                // fontWeight: FontWeight.bold,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            if (!(_selectedNextStageConstructionEntity.nextStageConsId !=
                    null &&
                _selectedNextStageConstructionEntity.nextStageConsId != "" &&
                _selectedNextStageConstructionEntity.nextStageConsId != null &&
                _selectedNextStageConstructionEntity.nextStageConsId != "")) {
              Get.dialog(
                  CustomDialogs().errorDialog("Please fill the details first"));
            } else {
              updateStatusForNextStage(context, 5);
            }
          },
        ),
      ],
    );
  }
/*
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      //print(image.path);
      if (image != null) {
        // print(basename(image.path));

        listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
        _imageList.add(image);
      }
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      // print(image.path);
      if (image != null) {
        listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
        _imageList.add(image);
      }
      // _imageList.insert(0,image);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

 */

  @override
  userChangeDealerId() {
    // TODO: implement userChangeDealerId
    if (mounted) setState(() {});
  }

  String selectedDealerId = "";
  String selectedDealerSubId = "";
  String selectedDate = "";
  int _floorId;
  String _noOfBagSupplied = "";
  String _isIhbCommercial = "";

  @override
  updateStatusForNextStageAllow(
      BuildContext context,
      int statusId,
      NextStageConstructionEntity selectedNextStageConstructionEntity,
      String nextStageConstructionPicked,
      String dealerId,
      String subDealerId,
      int selectedFloorId,
      String noOfBagsSupplied,
      String isIhbCommercial) {
    // TODO: implement updateStatusForNextStageAllow
    selectedDealerId = dealerId;
    selectedDealerSubId = subDealerId;
    _selectedNextStageConstructionEntity = selectedNextStageConstructionEntity;
    selectedDate = nextStageConstructionPicked;
    // print("_selectedNextStageConstructionEntity  $nextStageConstructionPicked    ${_selectedNextStageConstructionEntity.nextStageConsId}");
    // nextStageConstructionPickedDate=nextStageConstructionPicked;
    _nextDateofConstruction.text = nextStageConstructionPicked;
    _floorId = selectedFloorId;
    _noOfBagSupplied = noOfBagsSupplied;
    _isIhbCommercial = isIhbCommercial;


    updateStatusForNextStage(context, statusId,
        dealerId: selectedDealerId, subDealerId: selectedDealerSubId,floorId:selectedFloorId,
        noOfBagSupplied:noOfBagsSupplied);
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Influencer Details 1',
      expandedValue: 'This is item number $index',
    );
  });
}
