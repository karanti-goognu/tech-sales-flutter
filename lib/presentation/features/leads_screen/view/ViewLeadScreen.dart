import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/CommentDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/UpdateLeadRequestModel.dart'
    as updateRequest;
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
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
  final _formKeyForViewLeadScreen = GlobalKey();
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  String _myActivity;
  LocationResult _pickedLocation;
  var txt = TextEditingController();
  int initialImagelistLength;
  LeadStatusEntity _selectedValue;
  NextStageConstructionEntity _selectedNextStageConstructionEntity;
  DealerList _SelectedDealer;
  LeadStatusEntity _selectedValuedummy;
  var _contactName = TextEditingController();
  var _contactNumber = TextEditingController();
  String _comment;
  int initialInfluencerListLength;
  String labelText;
  int labelId;
  var _nextDateofConstruction = TextEditingController();
  var _siteAddress = TextEditingController();
  var _pincode = TextEditingController();
  var _state = TextEditingController();
  var _district = TextEditingController();
  var _taluk = TextEditingController();
  var _comments = TextEditingController();
  var _rera = TextEditingController();
  var _influencerNumber = TextEditingController();
  var _influencerName = TextEditingController();
  var _influencerType = TextEditingController();
  var _influencerCategory = TextEditingController();
  var geoTagType = TextEditingController();
  var leadCreatedBy;
  bool isEditable = false;
  DateTime nextStageConstructionPickedDate;
  var _totalBags = TextEditingController();
  var _totalMT = TextEditingController();
  List<File> _imageList = new List();
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

  final myController = TextEditingController();

  var _originalLeadID = TextEditingController();

  void _addComment() {
    if (myController.text.isNotEmpty) {
      // check if the comments text input is not empty
      setState(() {
        _items.add(myController.text); // add new commnet to the existing list
      });

      myController.clear(); // clear the text from the input
    }
  }

  List<Item> _data = generateItems(1);
  List<InfluencerDetail> _listInfluencerDetail = new List();
  List<InfluencerEntity> _listInfluencerEntity = new List();
  List<LeadInfluencerEntity> _listLeadInfluencerEntity = new List();
  Position _currentPosition;
  String _currentAddress;
  List<LeadStatusEntity> leadStatusEntity = new List();
  ViewLeadDataResponse viewLeadDataResponse = new ViewLeadDataResponse();

  // List<initmodel.SiteSubTypeEntity> siteSubTypeEntity = [
  //   new initmodel.SiteSubTypeEntity(siteSubId: 1, siteSubTypeDesc: "Ground"),
  //   new initmodel.SiteSubTypeEntity(siteSubId: 2, siteSubTypeDesc: "G+1"),
  //   new initmodel.SiteSubTypeEntity(siteSubId: 3, siteSubTypeDesc: "Multi-Storey"),
  // ];
  List<InfluencerTypeEntity> influencerTypeEntity;

  List<InfluencerCategoryEntity> influencerCategoryEntity;

  AddLeadsController _addLeadsController = Get.find();
  final db = BrandNameDBHelper();

  @override
  void initState() {
    super.initState();
    print("sumitdhawan");
    _addLeadsController = Get.find();
    // myFocusNode = FocusNode();
    _callGetAccessKeyAndGetLeadIdData();
  }

  @override
  void dispose() {
    super.dispose();
    _addLeadsController.dispose();
     myFocusNode.dispose();
  }

//   void disposeController(BuildContext context){
// //or what you wnat to dispose/clear
//     _addLeadsController.dispose();
//     myFocusNode.dispose();
 // }

  _callGetAccessKeyAndGetLeadIdData() async {
    print("sumitdhawan");
    AccessKeyModel accessKeyModel = new AccessKeyModel();
    await _addLeadsController.getAccessKeyOnly().then((data) async {
      accessKeyModel = data;
      print("AccessKey :: " + accessKeyModel.accessKey);

      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        String empId = prefs.getString(StringConstants.employeeId) ?? "empty";

        getLeadData(accessKeyModel.accessKey, empId);
      });
    });
  }

  getLeadData(String accessKey, String empId) async {
    // AddLeadInitialModel addLeadInitialModel = new AddLeadInitialModel();

    await _addLeadsController
        .getLeadData(accessKey, widget.leadId)
        .then((data) async {
      print("here");
      print(data);
      viewLeadDataResponse = data;

      // myFocusNode.requestFocus();
      counterListModel = viewLeadDataResponse.counterListModel;
      int listLength = counterListModel.length;
      if (listLength > 0)
        for (int i = 0; i < listLength; i++) {
          int id = await db.addDealer(DealerForDb(
              counterListModel[i].soldToParty,
              counterListModel[i].soldToPartyName));
          print("ADDED :  $id");
        }
      dealerEntityForDb = await db.fetchAllDistinctDealers();
      dealerEntityForDb.forEach((e) => print(e.toMapForDb().toString()));
      setState(() {
        leadStatusEntity = viewLeadDataResponse.leadStatusEntity;
        LeadStatusEntity list;
        print(viewLeadDataResponse.leadsEntity.leadStatusId);

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
//                    title: new Text("Waheguru"),
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

            print(labelText);
            // _selectedValue.id = leadStatusEntity[i].id;
            // _selectedValue.leadStatusDesc = leadStatusEntity[i].leadStatusDesc;

          }
        }

        leadCreatedBy = viewLeadDataResponse.leadsEntity.createdBy;
        leadStageEntity = viewLeadDataResponse.leadStageEntity;

        for (int i = 0; i < leadStageEntity.length; i++) {
          if (viewLeadDataResponse.leadsEntity.leadStageId.toString() ==
              leadStageEntity[i].id.toString()) {
            leadStageVal.id = leadStageEntity[i].id;
            leadStageVal.leadStageDesc = leadStageEntity[i].leadStageDesc;

            // _selectedValue.id = leadStatusEntity[i].id;
            // _selectedValue.leadStatusDesc = leadStatusEntity[i].leadStatusDesc;

          }
        }
        //siteSubTypeEntity = viewLeadDataResponse.siteSubTypeEntity;
        leadRejectReasonEntity = viewLeadDataResponse.leadRejectReasonEntity;
        gv.leadRejectReasonEntity = leadRejectReasonEntity;
        nextStageConstructionEntity =
            viewLeadDataResponse.nextStageConstructionEntity;
        gv.nextStageConstructionEntity = nextStageConstructionEntity;
        dealerList = viewLeadDataResponse.dealerList;
        print("Dealer List Length :: " + dealerList.length.toString());
        gv.dealerList = dealerList;
        influencerTypeEntity = viewLeadDataResponse.influencerTypeEntity;
        influencerCategoryEntity =
            viewLeadDataResponse.influencerCategoryEntity;
        _contactName.text = viewLeadDataResponse.leadsEntity.contactName;
        _contactNumber.text = viewLeadDataResponse.leadsEntity.contactNumber;
        geoTagType.text = viewLeadDataResponse.leadsEntity.geotagType;
        _siteAddress.text = viewLeadDataResponse.leadsEntity.leadAddress;
        _pincode.text = viewLeadDataResponse.leadsEntity.leadPincode;
        _state.text = viewLeadDataResponse.leadsEntity.leadStateName;
        _district.text = viewLeadDataResponse.leadsEntity.leadDistrictName;
        _taluk.text = viewLeadDataResponse.leadsEntity.leadTalukName;
        _currentPosition = new Position(
            latitude:
                double.parse(viewLeadDataResponse.leadsEntity.leadLatitude),
            longitude:
                double.parse(viewLeadDataResponse.leadsEntity.leadLongitude));
        listLeadImagePhoto = viewLeadDataResponse.leadphotosEntity;

        if (listLeadImagePhoto != null) {
          for (int i = 0; i < listLeadImagePhoto.length; i++) {
            File file = new File(UrlConstants.baseUrlforImages +
                "/" +
                listLeadImagePhoto[i].photoName);
            _imgDetails.add(new ImageDetails("Network", file));
          }
        }

        // for (int i = 0; i < listLeadImagePhoto.length; i++) {
        //   File file = new File(UrlConstants.baseUrlforImages +
        //       "/" +
        //       listLeadImagePhoto[i].photoName);
        //   _imageList.add(file);
        // }
        // initialImagelistLength = _imageList.length;
        influencerTypeEntity = viewLeadDataResponse.influencerTypeEntity;

        influencerCategoryEntity =
            viewLeadDataResponse.influencerCategoryEntity;

        _listInfluencerEntity = viewLeadDataResponse.influencerEntity;
        _listLeadInfluencerEntity = viewLeadDataResponse.leadInfluencerEntity;

        if (_listInfluencerEntity.length != null) {
          for (int i = 0; i < _listInfluencerEntity.length; i++) {
            int originalId;
            for (int j = 0; j < _listLeadInfluencerEntity.length; j++) {
              if (_listInfluencerEntity[i].id ==
                  _listLeadInfluencerEntity[j].inflId) {
                _listInfluencerEntity[i].isPrimary =
                    _listLeadInfluencerEntity[j].isPrimary;
                originalId = _listLeadInfluencerEntity[j].id;
                break;
              }
            }

            print(_listLeadInfluencerEntity[i].toJson());
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
              // inflTypeValue: new TextEditingController(text: influencerTypeEntity[_listInfluencerEntity[i].inflTypeId-1].inflTypeDesc),
              inflCatId: new TextEditingController(
                  text: _listInfluencerEntity[i].inflCatId.toString()),
              // inflCatValue:  new TextEditingController(text: influencerCategoryEntity[_listInfluencerEntity[i].inflCatId-1].inflCatDesc),
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

        // _totalBags.text = viewLeadDataResponse.

        //  print(influencerCategoryEntity[0].inflCatDesc);
      });
    });
    // Future.delayed(
    //     Duration.zero,
    //         () => Get.dialog(Center(),
    //         barrierDismissible: false));
    //  Get.back();
    //});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

//    if (labelId == 2 || labelId == 3 || labelId == 4 || labelId == 5) {
////              Get.back();
//      return Scaffold(
//        resizeToAvoidBottomInset: true,
//        // resizeToAvoidBottomPadding: false,
////         backgroundColor: Colors.transparent,
//        body: Container(
//          child: AlertDialog(
//            content: SingleChildScrollView(
//              child: ListBody(
//                children: <Widget>[
//                  Text(
//                    "Status of this lead is $labelText . You cannot edit or update it.",
//                    style: GoogleFonts.roboto(
//                        fontSize: 16,
//                        height: 1.4,
//                        letterSpacing: .25,
//                        fontStyle: FontStyle.normal,
//                        color: ColorConstants.inputBoxHintColorDark),
//                  ),
//                ],
//              ),
//            ),
//            actions: <Widget>[
//              TextButton(
//                child: Text(
//                  'OK',
//                  style: GoogleFonts.roboto(
//                      fontSize: 20,
//                      letterSpacing: 1.25,
//                      fontStyle: FontStyle.normal,
//                      color: ColorConstants.buttonNormalColor),
//                ),
//                onPressed: () {
//                  Get.back();
//                },
//              ),
//            ],
//          ),
//        ),
//      );
//    }
//    else {
    return Scaffold(
       resizeToAvoidBottomPadding: false,
      key: _formKeyForViewLeadScreen,
      backgroundColor: Colors.white,
      floatingActionButton: BackFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigator(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 200,
                right: 0,
                child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Container.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ))),
            Form(
              // key: _formKeyForViewLeadScreen,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 10, left: 5),
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
                      padding: const EdgeInsets.only(bottom: 20, left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "ID: " + widget.leadId.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                //color: HexColor("#006838"),
                                fontFamily: "Muli",
                              ),
                            ),
                          ),
                          SizedBox(width: 50),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 1.0, right: 1.0),
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
                                              padding: const EdgeInsets.only(
                                                  left: 2.0),
                                              child: SizedBox(
                                                width: 135,
                                                child: Text(
                                                  label.leadStatusDesc,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: ColorConstants
                                                          .inputBoxHintColor,
                                                      fontFamily: "Muli"),
                                                ),
                                              ),
                                            ),
                                            value: label,
                                          ))
                                      .toList(),
                                  //  elevation: 0,
                                  iconSize: 40,
                                  hint: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: (labelText != null)
                                        ? Text(labelText)
                                        : Text(""),
                                  ),

                                  // hint: Text('Rating'),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValuedummy = value;
                                      print(_selectedValuedummy.id);
                                      if ((viewLeadDataResponse
                                                  .leadsEntity.leadStageId ==
                                              2 ||
                                          viewLeadDataResponse
                                                  .leadsEntity.leadStageId ==
                                              3)) {
                                        if (_selectedValuedummy.id == 2) {
                                          Get.dialog(CustomDialogs()
                                              .showRejectionConfirmationDialog(
                                                  "Are you sure, You want to reject a site",
                                                  context,
                                                  viewLeadDataResponse));
                                        } else if (_selectedValuedummy.id ==
                                            3) {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  new ChangeLeadToSiteDialog(
                                                    selectedNextStageConstructionEntity:
                                                        _selectedNextStageConstructionEntity,
                                                    dealerEntityForDb:
                                                        dealerEntityForDb,
                                                    counterListModel:
                                                        counterListModel,
                                                    mListener: this,
                                                  ));

                                          /*  showDialog(
                                                context: context,
                                                builder: (BuildContext context) {

                                                  return StatefulBuilder(
                                                    builder: (BuildContext context, StateSetter setState) {
                                                    return   AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                        content: Container(
                                                          width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          child:
                                                          SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                DropdownButtonFormField<
                                                                    NextStageConstructionEntity>(
                                                                  value:
                                                                  _selectedNextStageConstructionEntity,
                                                                  items:
                                                                  nextStageConstructionEntity
                                                                      .map((label) =>
                                                                      DropdownMenuItem(
                                                                        child:
                                                                        Text(
                                                                          label.nexStageConsText,
                                                                          style: TextStyle(fontSize: 15, color: ColorConstants.inputBoxHintColor, fontFamily: "Muli"),
                                                                        ),
                                                                        value:
                                                                        label,
                                                                      ))
                                                                      .toList(),

                                                                  // hint: Text('Rating'),
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(() {
                                                                      _selectedNextStageConstructionEntity =
                                                                          value;
                                                                    });
                                                                  },
                                                                  decoration: FormFieldStyle
                                                                      .buildInputDecoration(
                                                                      labelText:
                                                                      "Next Stage of Construction"),
                                                                ),
                                                                SizedBox(
                                                                    height: MediaQuery.of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.02),
                                                                TextFormField(
                                                                  controller:
                                                                  _nextDateofConstruction,
                                                                  // validator: (value) {
                                                                  //   if (value.isEmpty) {
                                                                  //     return "Contact Name can't be empty";
                                                                  //   }
                                                                  //   //leagueSize = int.parse(value);
                                                                  //   return null;
                                                                  // },
                                                                  readOnly: true,
                                                                  onChanged:
                                                                      (data) {
                                                                    // setState(() {
                                                                    //   _contactName.text = data;
                                                                    // });
                                                                  },
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      color: ColorConstants
                                                                          .inputBoxHintColor,
                                                                      fontFamily:
                                                                      "Muli"),
                                                                  keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    focusedBorder:
                                                                    OutlineInputBorder(
                                                                      borderSide:
                                                                      BorderSide(
                                                                          color: ColorConstants
                                                                              .backgroundColorBlue,
                                                                          //color: HexColor("#0000001F"),
                                                                          width:
                                                                          1.0),
                                                                    ),
                                                                    disabledBorder:
                                                                    OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .black26,
                                                                          width:
                                                                          1.0),
                                                                    ),
                                                                    enabledBorder:
                                                                    OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .black26,
                                                                          width:
                                                                          1.0),
                                                                    ),
                                                                    errorBorder:
                                                                    OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .red,
                                                                          width:
                                                                          1.0),
                                                                    ),
                                                                    labelText:
                                                                    "Next date of construction",
                                                                    suffixIcon:
                                                                    IconButton(
                                                                      icon: Icon(
                                                                        Icons
                                                                            .date_range_rounded,
                                                                        size: 22,
                                                                        color: ColorConstants
                                                                            .clearAllTextColor,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        print(
                                                                            "here");
                                                                        final DateTime picked = await showDatePicker(
                                                                            context:
                                                                            context,
                                                                            initialDate:
                                                                            DateTime
                                                                                .now(),
                                                                            firstDate:
                                                                            DateTime
                                                                                .now(),
                                                                            lastDate:
                                                                            DateTime(2101));

                                                                        setState(
                                                                                () {
                                                                              final DateFormat
                                                                              formatter =
                                                                              DateFormat(
                                                                                  "yyyy-MM-dd");
                                                                              final String
                                                                              formattedDate =
                                                                              formatter
                                                                                  .format(picked);
                                                                              nextStageConstructionPickedDate =
                                                                                  picked;
                                                                              _nextDateofConstruction
                                                                                  .text =
                                                                                  formattedDate;
                                                                            });
                                                                      },
                                                                    ),
                                                                    filled: false,
                                                                    focusColor:
                                                                    Colors
                                                                        .black,
                                                                    isDense: false,
                                                                    labelStyle: TextStyle(
                                                                        fontFamily:
                                                                        "Muli",
                                                                        color: ColorConstants
                                                                            .inputBoxHintColorDark,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                        fontSize:
                                                                        16.0),
                                                                    fillColor:
                                                                    ColorConstants
                                                                        .backgroundColor,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height *
                                                                      0.02,
                                                                ),
                                                                */ /*DropDown for dealer*/ /*
                                                                DropdownButtonFormField(
                                                                  items: dealerEntityForDb
                                                                      .map((e) => DropdownMenuItem(
                                                                    value: e.id,
                                                                    child: SizedBox(
                                                                      width: MediaQuery.of(context).size.width - 100,
                                                                      child: Text('${e.dealerName} (${e.id})',
                                                                          style: TextStyle(fontSize: 14)),
                                                                    ),
                                                                  ))
                                                                      .toList(),
                                                                  onChanged: (value) {
                                                                    print(" Dealer Value");
                                                                    print(value);



                                                                    setState(() {
                                                                      selectedSubDealer = null;
                                                                    //  subDealerList = new List();
                                                                      subDealerList.clear();
                                                                      subDealerList = counterListModel
                                                                          .where((e) => e.soldToParty == leadDataDealer)
                                                                          .toList();
                                                                      leadDataDealer = value.toString();
                                                                      print("subDealerList   ${subDealerList.length}  $leadDataDealer  ");
                                                                      selectedSubDealer = subDealerList[0];
                                                                      leadDataSubDealer = subDealerList[0].shipToParty;

                                                                      // Future.delayed(const Duration(milliseconds: 500), () {
                                                                      //   setState(() {
                                                                      //     // Here you can write your code for open new view
                                                                      //
                                                                      //
                                                                      //     print("callll");
                                                                      //   });
                                                                      //
                                                                      // });

                                                                    });
                                                                  },
                                                                  style: FormFieldStyle.formFieldTextStyle,
                                                                  decoration:
                                                                  FormFieldStyle.buildInputDecoration(labelText: "Dealer"),
                                                                  validator: (value) =>
                                                                  value == null ? 'Please select Dealer' : null,
                                                                ),
                                                                SizedBox(
                                                                    height: MediaQuery.of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.02),
                                                                */ /*DropDown For SubDealer*/ /*
                                                                subDealerList.isEmpty
                                                                    ? Container()
                                                                    : DropdownButtonFormField(
                                                                  items: subDealerList.isNotEmpty
                                                                      ? subDealerList
                                                                      .map((e) => DropdownMenuItem(
                                                                    value: e,
                                                                    child: SizedBox(
                                                                      width:
                                                                      MediaQuery.of(context).size.width - 100,
                                                                      child: Text(
                                                                        '${e.shipToPartyName} (${e.shipToParty})',
                                                                        style: TextStyle(fontSize: 14),
                                                                      ),
                                                                    ),
                                                                  ))
                                                                      .toList()
                                                                      : [
                                                                    DropdownMenuItem(
                                                                        child: Text("No Sub Dealer"), value: "0")
                                                                  ],
                                                                  value: selectedSubDealer,
                                                                  validator: (value) => value == null || value.isEmpty
                                                                      ? 'Please select Sub-Dealer'
                                                                      : null,
                                                                  onChanged: (value) {
                                                                    // print("Sub Dealer Value");
                                                                    // print(value.shipToParty.toString());
                                                                    setState(() {
                                                                      leadDataSubDealer = value.shipToParty.toString();
                                                                    });
                                                                    print(leadDataSubDealer);
                                                                  },
                                                                  style: FormFieldStyle.formFieldTextStyle,
                                                                  decoration: FormFieldStyle.buildInputDecoration(
                                                                      labelText: "Sub-Dealer"),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: Text(
                                                              'Submit',
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                  fontSize: 17,
                                                                  letterSpacing:
                                                                  1.25,
                                                                  fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                                  // fontWeight: FontWeight.bold,
                                                                  color: ColorConstants
                                                                      .buttonNormalColor),
                                                            ),
                                                            onPressed: () {
                                                              if (!(_selectedNextStageConstructionEntity.nextStageConsId != null &&
                                                                  _selectedNextStageConstructionEntity
                                                                      .nextStageConsId !=
                                                                      "" &&
                                                                  _selectedNextStageConstructionEntity
                                                                      .nextStageConsId !=
                                                                      null &&
                                                                  _selectedNextStageConstructionEntity
                                                                      .nextStageConsId !=
                                                                      "")) {
                                                                Get.dialog(
                                                                    CustomDialogs()
                                                                        .errorDialog(
                                                                        "Please fill the details first"));
                                                              } else {
                                                                if (nextStageConstructionPickedDate
                                                                    .difference(
                                                                    DateTime
                                                                        .now())
                                                                    .inDays >
                                                                    31) {
                                                                  showDialog(
                                                                      context:
                                                                      context,
                                                                      builder:
                                                                          (BuildContext
                                                                      context) {
                                                                        return AlertDialog(
                                                                          content:
                                                                          SingleChildScrollView(
                                                                            child:
                                                                            ListBody(
                                                                              children: <
                                                                                  Widget>[
                                                                                Text(
                                                                                  "Next Construction date is more than 31 days from now, "
                                                                                      "So status will be changed to FUTURE "
                                                                                      "OPPORTUNITY . ",
                                                                                  style: GoogleFonts.roboto(fontSize: 16, height: 1.4, letterSpacing: .25, fontStyle: FontStyle.normal, color: ColorConstants.inputBoxHintColorDark),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          actions: <
                                                                              Widget>[
                                                                            TextButton(
                                                                              child:
                                                                              Text(
                                                                                'OK',
                                                                                style: GoogleFonts.roboto(
                                                                                    fontSize: 17,
                                                                                    letterSpacing: 1.25,
                                                                                    fontStyle: FontStyle.normal,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: ColorConstants.buttonNormalColor),
                                                                              ),
                                                                              onPressed:
                                                                                  () {
                                                                                updateStatusforNextStage(context,
                                                                                    5);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      });
                                                                } else {
                                                                  updateStatusforNextStage(
                                                                      context, 3);
                                                                }

                                                                //});
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },

                                                  );
                                                }).then((value) => setState(() {}));*/

                                        } else if (_selectedValuedummy.id ==
                                            4) {
                                          String empId;
                                          String mobileNumber;
                                          String name;
                                          Future<SharedPreferences> _prefs =
                                              SharedPreferences.getInstance();
                                          _prefs.then(
                                              (SharedPreferences prefs) async {
                                            empId = prefs.getString(
                                                    StringConstants
                                                        .employeeId) ??
                                                "empty";
                                            mobileNumber = prefs.getString(
                                                    StringConstants
                                                        .mobileNumber) ??
                                                "empty";
                                            name = prefs.getString(
                                                    StringConstants
                                                        .employeeName) ??
                                                "empty";

                                            print(_comments.text);
                                            if (_comments.text == "") {
                                              _comments.text = "Stage Changed";
                                            }

                                            List<CommentsDetail>
                                                commentsDetails = [
                                              new CommentsDetail(
                                                  createdBy: empId,
                                                  commentText: _comments.text,
                                                  // commentedAt: DateTime.now(),
                                                  creatorName: name)
                                            ];

                                            List<updateRequest.ListLeadcomments>
                                                commentsList = new List();

                                            for (int i = 0;
                                                i < commentsDetails.length;
                                                i++) {
                                              commentsList.add(new updateRequest
                                                  .ListLeadcomments(
                                                leadId: widget.leadId,
                                                commentText: commentsDetails[i]
                                                    .commentText,
                                                creatorName: name,
                                                createdBy: empId,
                                              ));
                                            }

                                            List<updateRequest.ListLeadImage>
                                                imageList = new List();
                                            for (int i = 0;
                                                i < listLeadImage.length;
                                                i++) {
                                              imageList.add(new updateRequest
                                                  .ListLeadImage(
                                                leadId: widget.leadId,
                                                photoName:
                                                    listLeadImage[i].photoName,
                                                createdBy: empId,
                                              ));
                                            }
                                            if (_listInfluencerDetail.length !=
                                                0) {
                                              if (_listInfluencerDetail[
                                                              _listInfluencerDetail.length -
                                                                  1]
                                                          .inflName ==
                                                      null ||
                                                  (_listInfluencerDetail[
                                                              _listInfluencerDetail
                                                                      .length -
                                                                  1]
                                                          .inflName ==
                                                      null) ||
                                                  (_listInfluencerDetail[
                                                          _listInfluencerDetail
                                                                  .length -
                                                              1]
                                                      .inflName
                                                      .text
                                                      .isNullOrBlank)) {
                                                print("here1234");
                                                _listInfluencerDetail.removeAt(
                                                    _listInfluencerDetail
                                                            .length -
                                                        1);
                                              }
                                            }
                                            List<
                                                    updateRequest
                                                        .LeadInfluencerEntity>
                                                listInfluencer = new List();

                                            print(_listInfluencerDetail.length);

                                            for (int i = 0;
                                                i <
                                                    _listInfluencerDetail
                                                        .length;
                                                i++) {
                                              print(_listInfluencerDetail[i]
                                                  .toJson());
                                              listInfluencer
                                                  .add(new updateRequest
                                                          .LeadInfluencerEntity(
                                                      leadId: widget.leadId,
                                                      isPrimary:
                                                          _listInfluencerDetail[
                                                                      i]
                                                                  .isPrimarybool
                                                              ? "Y"
                                                              : "N",
                                                      createdBy: empId,
                                                      inflId: int.parse(
                                                          _listInfluencerDetail[
                                                                  i]
                                                              .id
                                                              .text),
                                                      isDelete: "N"));
                                            }

                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
                                                    content: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                              children: [
                                                                TextFormField(
                                                                  controller:
                                                                      _originalLeadID,
                                                                  onChanged:
                                                                      (data) {
                                                                    // setState(() {
                                                                    //   _contactName.text = data;
                                                                    // });
                                                                  },
                                                                  maxLength: 6,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: ColorConstants
                                                                          .inputBoxHintColor,
                                                                      fontFamily:
                                                                          "Muli"),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .phone,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: ColorConstants.backgroundColorBlue,
                                                                          //color: HexColor("#0000001F"),
                                                                          width: 1.0),
                                                                    ),
                                                                    disabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .black26,
                                                                          width:
                                                                              1.0),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .black26,
                                                                          width:
                                                                              1.0),
                                                                    ),
                                                                    errorBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide: BorderSide(
                                                                          color: Colors
                                                                              .red,
                                                                          width:
                                                                              1.0),
                                                                    ),
                                                                    labelText:
                                                                        "Original Lead Id",
                                                                    filled:
                                                                        false,
                                                                    focusColor:
                                                                        Colors
                                                                            .black,
                                                                    isDense:
                                                                        false,
                                                                    labelStyle: TextStyle(
                                                                        fontFamily:
                                                                            "Muli",
                                                                        color: ColorConstants
                                                                            .inputBoxHintColorDark,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            16.0),
                                                                    fillColor:
                                                                        ColorConstants
                                                                            .backgroundColor,
                                                                  ),
                                                                ),
                                                              ]),
                                                        )),
                                                    actions: [
                                                      TextButton(
                                                          child: Text(
                                                            'Submit',
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        17,
                                                                    letterSpacing:
                                                                        1.25,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    // fontWeight: FontWeight.bold,
                                                                    color: ColorConstants
                                                                        .buttonNormalColor),
                                                          ),
                                                          onPressed: () {
                                                            if (_originalLeadID
                                                                        .text !=
                                                                    null &&
                                                                _originalLeadID
                                                                        .text !=
                                                                    "") {
                                                              var updateRequestModel =
                                                                  {
                                                                    'eventId': viewLeadDataResponse.leadsEntity.eventId,
                                                                    'leadId':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadId,
                                                                'leadSegment':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadSegment,
                                                                'assignedTo':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .assignedTo,
                                                                'leadStatusId':
                                                                    4,
                                                                'leadStage':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadStageId,
                                                                'contactName':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .contactName,
                                                                'contactNumber':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .contactNumber,
                                                                'geotagType':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .geotagType,
                                                                'leadLatitude':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadLatitude,
                                                                'leadLongitude':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadLongitude,
                                                                'leadAddress':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadAddress,
                                                                'leadPincode':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadPincode,
                                                                'leadStateName':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadStateName,
                                                                'leadDistrictName':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadDistrictName,
                                                                'leadTalukName':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadTalukName,
                                                                'leadSalesPotentialMt':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadSitePotentialMt,
                                                                'leadReraNumber':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .leadReraNumber,
                                                                'isStatus':
                                                                    "false",
                                                                'updatedBy':
                                                                    empId,
                                                                'leadIsDuplicate':
                                                                    "Y",
                                                                'leadOriginalId':
                                                                    _originalLeadID
                                                                        .text,
                                                                'rejectionComment':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .rejectionComment,
                                                                'nextDateCconstruction':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .nextDateCconstruction,
                                                                'nextStageConstruction':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .nextStageConstruction,
                                                                'siteDealerId':
                                                                    viewLeadDataResponse
                                                                        .leadsEntity
                                                                        .siteDealerId,
                                                                // 'listLeadcomments':
                                                                //     new List(),
                                                                // 'listLeadImage':
                                                                //     new List(),
                                                                // 'leadInfluencerEntity':
                                                                //   new List()

                                                                'listLeadcomments':
                                                                    viewLeadDataResponse
                                                                        .leadcommentsEnitiy,
                                                                'listLeadImage':
                                                                    viewLeadDataResponse
                                                                        .leadphotosEntity,
                                                                'leadInfluencerEntity':
                                                                    viewLeadDataResponse
                                                                        .leadInfluencerEntity
                                                              };

                                                              _addLeadsController.updateLeadData(
                                                                  updateRequestModel,
                                                                  new List<
                                                                      File>(),
                                                                  context,
                                                                  viewLeadDataResponse
                                                                      .leadsEntity
                                                                      .leadId,2);

                                                              Get.back();
                                                            }
                                                          })
                                                    ],
                                                  );
                                                });
                                          });
                                        } else if (_selectedValuedummy.id ==
                                            5) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0))),
                                                  content: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          DropdownButtonFormField<
                                                              NextStageConstructionEntity>(
                                                            value:
                                                                _selectedNextStageConstructionEntity,
                                                            items:
                                                                nextStageConstructionEntity
                                                                    .map((label) =>
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text(
                                                                            label.nexStageConsText,
                                                                            style: TextStyle(
                                                                                fontSize: 15,
                                                                                color: ColorConstants.inputBoxHintColor,
                                                                                fontFamily: "Muli"),
                                                                          ),
                                                                          value:
                                                                              label,
                                                                        ))
                                                                    .toList(),

                                                            // hint: Text('Rating'),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selectedNextStageConstructionEntity =
                                                                    value;
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: ColorConstants
                                                                            .backgroundColorBlue,
                                                                        //color: HexColor("#0000001F"),
                                                                        width:
                                                                            1.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black26,
                                                                    width: 1.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Colors
                                                                            .red,
                                                                        width:
                                                                            1.0),
                                                              ),
                                                              labelText:
                                                                  "Next Stage of Construction",
                                                              filled: false,
                                                              focusColor:
                                                                  Colors.black,
                                                              isDense: false,
                                                              labelStyle: TextStyle(
                                                                  fontFamily:
                                                                      "Muli",
                                                                  color: ColorConstants
                                                                      .inputBoxHintColorDark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      16.0),
                                                              fillColor:
                                                                  ColorConstants
                                                                      .backgroundColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02,
                                                          ),
                                                          TextFormField(
                                                            controller:
                                                                _nextDateofConstruction,
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
                                                                color: ColorConstants
                                                                    .inputBoxHintColor,
                                                                fontFamily:
                                                                    "Muli"),
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: ColorConstants
                                                                            .backgroundColorBlue,
                                                                        //color: HexColor("#0000001F"),
                                                                        width:
                                                                            1.0),
                                                              ),
                                                              disabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black26,
                                                                    width: 1.0),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black26,
                                                                    width: 1.0),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Colors
                                                                            .red,
                                                                        width:
                                                                            1.0),
                                                              ),
                                                              labelText:
                                                                  "Next date of construction",
                                                              suffixIcon:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .date_range_rounded,
                                                                  size: 22,
                                                                  color: ColorConstants
                                                                      .clearAllTextColor,
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  print("here");
                                                                  final DateTime picked = await showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          DateTime
                                                                              .now(),
                                                                      firstDate:
                                                                          DateTime
                                                                              .now(),
                                                                      lastDate:
                                                                          DateTime(
                                                                              2101));

                                                                  setState(() {
                                                                    final DateFormat
                                                                        formatter =
                                                                        DateFormat(
                                                                            "yyyy-MM-dd");
                                                                    final String
                                                                        formattedDate =
                                                                        formatter
                                                                            .format(picked);
                                                                    nextStageConstructionPickedDate =
                                                                        picked;
                                                                    _nextDateofConstruction
                                                                            .text =
                                                                        formattedDate;
                                                                  });
                                                                },
                                                              ),
                                                              filled: false,
                                                              focusColor:
                                                                  Colors.black,
                                                              isDense: false,
                                                              labelStyle: TextStyle(
                                                                  fontFamily:
                                                                      "Muli",
                                                                  color: ColorConstants
                                                                      .inputBoxHintColorDark,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      16.0),
                                                              fillColor:
                                                                  ColorConstants
                                                                      .backgroundColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                        'Submit',
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 17,
                                                                letterSpacing:
                                                                    1.25,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                // fontWeight: FontWeight.bold,
                                                                color: ColorConstants
                                                                    .buttonNormalColor),
                                                      ),
                                                      onPressed: () {
                                                        if (!(_selectedNextStageConstructionEntity.nextStageConsId != null &&
                                                            _selectedNextStageConstructionEntity
                                                                    .nextStageConsId !=
                                                                "" &&
                                                            _selectedNextStageConstructionEntity
                                                                    .nextStageConsId !=
                                                                null &&
                                                            _selectedNextStageConstructionEntity
                                                                    .nextStageConsId !=
                                                                "")) {
                                                          Get.dialog(CustomDialogs()
                                                              .errorDialog(
                                                                  "Please fill the details first"));
                                                        } else {
                                                          updateStatusForNextStage(
                                                              context, 5);
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        }
                                      } else {
                                        Get.dialog(CustomDialogs().errorDialog(
                                            "Lead Stage must be either phy-verified or Tele-verified"));
                                      }
                                      // Get.dialog(CustomDialogs()
                                      //     .errorDialog("Coming Soon !!"));
                                    });
                                  },

                                  //
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    TextFormField(
                      controller: _contactName,
                      readOnly: true,
                      //autofocus: true,
                      focusNode: myFocusNode,
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "Contact Name can't be empty";
                      //   }
                      //   //leagueSize = int.parse(value);
                      //   return null;
                      // },
                      onChanged: (data) {
                        // setState(() {
                        //   _contactName.text = data;
                        // });
                      },
                      style: TextStyle(
                          // fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Name"),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                        controller: _contactNumber,
                        readOnly: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter mobile number ';
                          }
                          if (value.length <= 9) {
                            return 'Mobile number is incorrect';
                          }
                          return null;
                        },
                        onChanged: (data) {
                          // setState(() {
                          //   _contactNumber.text = data;
                          // });
                        },
                        style: TextStyle(
                            fontSize: 18,
                            color: ColorConstants.inputBoxHintColor,
                            fontFamily: "Muli"),
                        keyboardType: TextInputType.phone,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 10,
                        decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Mobile Number",
                        )),
                    // SizedBox(height: 16),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
                      child: Text(
                        "Geo Tag",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    Row(
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
                            padding: const EdgeInsets.only(
                                right: 5, bottom: 8, top: 5),
                            child: Text(
                              "DETECT",
                              style: TextStyle(
                                  color: HexColor("#F9A61A"),
                                  fontWeight: FontWeight.bold,
                                  // letterSpacing: 2,
                                  fontSize: 17),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              geoTagType.text = "A";
                            });
                            Get.dialog(Center(
                              child: CircularProgressIndicator(),
                            ));

                            _getCurrentLocation();
                          },
                        ),
                        Text(
                          "Or",
                          style: TextStyle(
                              fontFamily: "Muli",
                              //color: HexColor("#F9A61A"),
                              // fontWeight: FontWeight.bold,
                              // letterSpacing: 2,
                              fontSize: 17),
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                              side: BorderSide(color: Colors.black26)),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 5, bottom: 8, top: 5),
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
                            setState(() {
                              geoTagType.text = "M";
                            });
                            LocationResult result = await showLocationPicker(
                              context,
                              StringConstants.API_Key,
                              initialCenter: LatLng(31.1975844, 29.9598339),
                              automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                              myLocationButtonEnabled: true,
                              // requiredGPS: true,
                              layersButtonEnabled: false,
                              // countries: ['AE', 'NG']

//                      resultCardAlignment: Alignment.bottomCenter,
                              // desiredAccuracy: LocationAccuracy.best,
                            );
                            print("result = $result");
                            setState(() {
                              _pickedLocation = result;
                              _currentPosition = new Position(
                                  latitude: _pickedLocation.latLng.latitude,
                                  longitude: _pickedLocation.latLng.longitude);
                              _getAddressFromLatLng();
                              //print(_pickedLocation.latLng.latitude);
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    TextFormField(
                      controller: _siteAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Address ';
                        }
                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Address"),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      //initialValue: _pincode.toString(),
                      controller: _pincode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Pincode ';
                        }
                        if (value.length <= 6) {
                          return 'Pincode is incorrect';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      //  maxLength: 6,
                      decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "Pincode",
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
                      controller: _state,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter State ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "State",
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
                      controller: _district,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter District ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: FormFieldStyle.buildInputDecoration(
                        labelText: "District",
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
                      controller: _taluk,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Taluk ';
                        }

                        return null;
                      },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "Taluk"),
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 10, top: 10),
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
                          if (_imgDetails.length < 5) {
                            _showPicker(context);
                          } else {
                            Get.dialog(CustomDialogs()
                                .errorDialog("You can add only upto 5 photos"));
                          }
                        },
                      ),
                    ),

                    _imgDetails != null
                        ? Row(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _imgDetails.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: new Container(
                                                    // width: 500,
                                                    // height: 500,
                                                    child: _imgDetails[index]
                                                                .from
                                                                .toLowerCase() ==
                                                            "network"
                                                        ? Image.network(
                                                            _imgDetails[index]
                                                                .file
                                                                .path)
                                                        : Image.file(
                                                            _imgDetails[index]
                                                                .file),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Picture ${(index + 1)}. ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Image_${(index + 1)}.jpg",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#007CBF"),
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            /* GestureDetector(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: HexColor("#FFCD00"),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    _imgDetails.removeAt(index);
                                                  });
                                                },
                                              )*/
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          )
                        : Container(),

                    SizedBox(height: 16),
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
                      child: Text(
                        "Influencer Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            // color: HexColor("#000000DE"),
                            fontFamily: "Muli"),
                      ),
                    ),
                    // Container(
                    //   child: _buildPanel(),
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _listInfluencerDetail.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (!_listInfluencerDetail[index].isExpanded) {
                                  return Column(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Influencer Details ${(index + 1)} ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
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
                                                    if (i == index) {
                                                      _listInfluencerDetail[i]
                                                              .isPrimarybool =
                                                          value;
                                                    } else {
                                                      _listInfluencerDetail[i]
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
                                            value: _listInfluencerDetail[index]
                                                .isPrimarybool,
                                            activeColor: HexColor("#009688"),
                                            activeTrackColor:
                                                HexColor("#009688")
                                                    .withOpacity(0.5),
                                            inactiveThumbColor:
                                                HexColor("#F1F1F1"),
                                            inactiveTrackColor: Colors.black26,
                                          ),
                                          _listInfluencerDetail[index]
                                                  .isExpanded
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
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
                                                                  index]
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
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Influencer Details ${(index + 1)} ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          _listInfluencerDetail[index]
                                                  .isExpanded
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
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
                                                                  index]
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
                                                        color:
                                                            HexColor("#F9A61A"),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        // letterSpacing: 2,
                                                        fontSize: 17),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .isExpanded =
                                                          !_listInfluencerDetail[
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
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Secondary",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
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
                                                    if (i == index) {
                                                      _listInfluencerDetail[i]
                                                              .isPrimarybool =
                                                          value;
                                                    } else {
                                                      _listInfluencerDetail[i]
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
                                            value: _listInfluencerDetail[index]
                                                .isPrimarybool,
                                            activeColor: HexColor("#009688"),
                                            activeTrackColor:
                                                HexColor("#009688")
                                                    .withOpacity(0.5),
                                            inactiveThumbColor:
                                                HexColor("#F1F1F1"),
                                            inactiveTrackColor: Colors.black26,
                                          ),
                                          Text(
                                            "Primary",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color:
                                                    _listInfluencerDetail[index]
                                                            .isPrimarybool
                                                        ? HexColor("#009688")
                                                        : Colors.black,
                                                // color: HexColor("#000000DE"),
                                                fontFamily: "Muli"),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _listInfluencerDetail[index]
                                            .inflContact,
                                        maxLength: 10,
                                        onChanged: (value) async {
                                          bool match = false;
                                          if (value.length < 10) {
                                            // _listInfluencerDetail[
                                            // index]
                                            //     .inflContact
                                            //     .clear();
                                            if (_listInfluencerDetail[index]
                                                    .inflName !=
                                                null) {
                                              _listInfluencerDetail[index]
                                                  .inflName
                                                  .clear();
                                              _listInfluencerDetail[index]
                                                  .inflTypeValue
                                                  .clear();
                                              _listInfluencerDetail[index]
                                                  .inflCatValue
                                                  .clear();
                                            }
                                          } else if (value.length == 10) {
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
                                                  _listInfluencerDetail[i]
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
                                              String empId;
                                              String mobileNumber;
                                              String name;
                                              Future<SharedPreferences> _prefs =
                                                  SharedPreferences
                                                      .getInstance();
                                              await _prefs.then(
                                                  (SharedPreferences prefs) {
                                                empId = prefs.getString(
                                                        StringConstants
                                                            .employeeId) ??
                                                    "empty";
                                                mobileNumber = prefs.getString(
                                                        StringConstants
                                                            .mobileNumber) ??
                                                    "empty";
                                                name = prefs.getString(
                                                        StringConstants
                                                            .employeeName) ??
                                                    "empty";
                                                print(_comments.text);
                                              });
                                              AddLeadsController
                                                  _addLeadsController =
                                                  Get.find();
                                              _addLeadsController.phoneNumber =
                                                  value;
                                              AccessKeyModel accessKeyModel =
                                                  new AccessKeyModel();
                                              await _addLeadsController
                                                  .getAccessKeyOnly()
                                                  .then((data) async {
                                                accessKeyModel = data;
                                                print("AccessKey :: " +
                                                    accessKeyModel.accessKey);
                                                await _addLeadsController
                                                    .getInflDetailsData(
                                                        accessKeyModel
                                                            .accessKey)
                                                    .then((data) {
                                                  InfluencerDetail inflDetail =
                                                      data;
                                                  print("print-->"+
                                                      inflDetail.inflName.text);

                                                  // setState(() {
                                                  if (inflDetail
                                                          .inflName.text !=
                                                      "null") {
                                                    setState(() {
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflContact =
                                                          new TextEditingController();
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflName =
                                                          new TextEditingController();
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      //  print(inflDetail.inflName.text);
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflTypeId =
                                                          new TextEditingController();
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflCatId =
                                                          new TextEditingController();
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflTypeValue =
                                                          new TextEditingController();
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflCatValue =
                                                          new TextEditingController();

                                                      print(
                                                          inflDetail.inflName);

                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflContact =
                                                          inflDetail
                                                              .inflContact;
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflName =
                                                          inflDetail.inflName;
                                                      _listInfluencerDetail[
                                                              index]
                                                          .id = inflDetail.id;
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .ilpIntrested =
                                                          inflDetail
                                                              .ilpIntrested;
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .createdOn =
                                                          inflDetail.createdOn;
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflTypeValue =
                                                          inflDetail
                                                              .inflTypeValue;
                                                      _listInfluencerDetail[
                                                                  index]
                                                              .inflCatValue =
                                                          inflDetail
                                                              .inflCatValue;
                                                      _listInfluencerDetail[
                                                              index]
                                                          .createdBy = empId;
                                                    });
                                                    print(_listInfluencerDetail[
                                                            index]
                                                        .inflName);

                                                    for (int i = 0;
                                                        i <
                                                            influencerTypeEntity
                                                                .length;
                                                        i++) {
                                                      if (influencerTypeEntity[
                                                                  i]
                                                              .inflTypeId
                                                              .toString() ==
                                                          inflDetail.inflTypeId
                                                              .text) {
                                                        setState(() {
                                                          _listInfluencerDetail[
                                                                      index]
                                                                  .inflTypeId =
                                                              inflDetail
                                                                  .inflTypeId;
                                                          //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                          _listInfluencerDetail[
                                                                  index]
                                                              .inflTypeValue
                                                              .text = influencerTypeEntity[
                                                                  influencerTypeEntity[
                                                                              i]
                                                                          .inflTypeId -
                                                                      1]
                                                              .inflTypeDesc;
                                                        });
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
                                                        setState(() {
                                                          _listInfluencerDetail[
                                                                  index]
                                                              .inflTypeId
                                                              .clear();
                                                          _listInfluencerDetail[
                                                                  index]
                                                              .inflTypeValue
                                                              .clear();
                                                        });
                                                      }
                                                    }
                                                    print(_listInfluencerDetail[
                                                            index]
                                                        .inflName);
                                                    // _influencerType.text = influencerTypeEntity[inflDetail.inflTypeId].inflTypeDesc;

                                                    for (int i = 0;
                                                        i <
                                                            influencerCategoryEntity
                                                                .length;
                                                        i++) {
                                                      if (influencerCategoryEntity[
                                                                  i]
                                                              .inflCatId
                                                              .toString() ==
                                                          inflDetail
                                                              .inflCatId.text) {
                                                        setState(() {
                                                          _listInfluencerDetail[
                                                                      index]
                                                                  .inflCatId =
                                                              inflDetail
                                                                  .inflCatId;
                                                          //   print(influencerTypeEntity[influencerTypeEntity[i].inflTypeId].inflTypeDesc);
                                                          _listInfluencerDetail[
                                                                  index]
                                                              .inflCatValue
                                                              .text = influencerCategoryEntity[
                                                                  influencerCategoryEntity[
                                                                              i]
                                                                          .inflCatId -
                                                                      1]
                                                              .inflCatDesc;
                                                        });
                                                        break;
                                                      } else {
                                                        _listInfluencerDetail[
                                                                index]
                                                            .inflCatId
                                                            .clear();
                                                        _listInfluencerDetail[
                                                                index]
                                                            .inflCatValue
                                                            .clear();
                                                      }
                                                    }
                                                  } else {
                                                    if (_listInfluencerDetail[
                                                                index]
                                                            .inflContact !=
                                                        null) {
                                                      setState(() {
                                                        _listInfluencerDetail[
                                                                index]
                                                            .inflContact
                                                            .clear();
                                                        _listInfluencerDetail[
                                                                index]
                                                            .inflName
                                                            .clear();
                                                      });
                                                    }

                                                    Get.back();
                                                    return Get.dialog(
                                                        CustomDialogs().errorDialog(
                                                            "No influencer registered with this number"));
                                                  }
                                                  // });
                                                  Get.back();
                                                });
                                                // Get.back();
                                              });

                                              print("Dhawan :: ");
                                            }
                                          }
                                          // setState(() {
                                          //   _totalBags = value as int;
                                          // });
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter Influencer Number ';
                                          }

                                          return null;
                                        },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
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
                                          labelText: "Infl. Contact",
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        //  initialValue: _listInfluencerDetail[index].inflName,
                                        controller: _listInfluencerDetail[index]
                                            .inflName,

                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Please enter Influencer Number ';
                                        //   }
                                        //
                                        //   return null;
                                        // },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
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
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          labelText: "Infl. Name",
                                          enabled: false,
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _listInfluencerDetail[index]
                                            .inflTypeValue,
                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Please enter Influencer Number ';
                                        //   }
                                        //
                                        //   return null;
                                        // },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
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
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          enabled: false,
                                          labelText: "Infl. Type",
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      TextFormField(
                                        controller: _listInfluencerDetail[index]
                                            .inflCatValue,
                                        // validator: (value) {
                                        //   if (value.isEmpty) {
                                        //     return 'Please enter Influencer Number ';
                                        //   }
                                        //
                                        //   return null;
                                        // },
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: ColorConstants
                                                .inputBoxHintColor,
                                            fontFamily: "Muli"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorConstants
                                                    .backgroundColorBlue,
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
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(0.4),
                                                width: 1.0),
                                          ),
                                          enabled: false,
                                          labelText: "Infl. Category",
                                          filled: false,
                                          focusColor: Colors.black,
                                          labelStyle: TextStyle(
                                              fontFamily: "Muli",
                                              color: ColorConstants
                                                  .inputBoxHintColorDark,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.0),
                                          fillColor:
                                              ColorConstants.backgroundColor,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    Center(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(color: Colors.black26)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 8, top: 5),
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
                          // //  print(_listInfluencerDetail[
                          //   _listInfluencerDetail.length - 1]
                          //       .inflName);

                          if (_listInfluencerDetail.length == 0) {
                            setState(() {
                              _listInfluencerDetail.add(new InfluencerDetail(
                                  isExpanded: true, isPrimarybool: true));
                            });
                          } else {
                            if (_listInfluencerDetail[
                                            _listInfluencerDetail.length - 1]
                                        .inflName !=
                                    null &&
                                _listInfluencerDetail[
                                            _listInfluencerDetail.length - 1]
                                        .inflName !=
                                    "null" &&
                                !_listInfluencerDetail[
                                        _listInfluencerDetail.length - 1]
                                    .inflName
                                    .text
                                    .isNullOrBlank) {
                              InfluencerDetail infl = new InfluencerDetail(
                                  isExpanded: true, isPrimarybool: false);

                              // Item item = new Item(
                              //     headerValue: "agx ", expandedValue: "dnxcx");
                              setState(() {
                                // _data.add(item);
                                _listInfluencerDetail[
                                        _listInfluencerDetail.length - 1]
                                    .isExpanded = false;
                                _listInfluencerDetail.add(infl);
                              });
                            } else {
                              print("Error : Please fill previous influencer first");
                              Get.dialog(CustomDialogs().errorDialog(
                                  "Please fill previous influencer first"));
                            }
                          }
                        },
                      ),
                    ),

                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, bottom: 20, left: 5),
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
                              controller: _totalBags,
                              onChanged: (value) {
                                setState(() {
                                  // _totalBags.text = value ;
                                  if (_totalBags.text == null ||
                                      _totalBags.text == "") {
                                    _totalMT.clear();
                                  } else {
                                    _totalMT.text =
                                        (int.parse(_totalBags.text) / 20)
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
                                      color: ColorConstants.backgroundColorBlue,
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
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.0),
                                ),
                                labelText: "Bags",
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
                                  if (_totalMT.text == null ||
                                      _totalMT.text == "") {
                                    _totalBags.clear();
                                  } else {
                                    _totalBags.text =
                                        (int.parse(_totalMT.text) * 20)
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
                                      color: ColorConstants.backgroundColorBlue,
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
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1.0),
                                ),
                                labelText: "MT",
                                filled: false,
                                //enabled: false,
                                focusColor: Colors.black,
                                labelStyle: TextStyle(
                                    fontFamily: "Muli",
                                    color: ColorConstants.inputBoxHintColorDark,
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
                    Divider(
                      color: Colors.black26,
                      thickness: 1,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _rera,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter RERA Number ';
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
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "RERA Number",
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
                    SizedBox(height: 16),

                    TextFormField(
                      maxLines: 4,
                      maxLength: 500,
                      // initialValue: _comments.text,
                      controller: _comments,

                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'Please enter RERA Number ';
                      //   }
                      //
                      //   return null;
                      // },
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        print(_comments.text);
                        // setState(() {
                        //   _comments.text = value;
                        // });
                      },
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
                          borderSide: BorderSide(color: Colors.red, width: 1.0),
                        ),
                        labelText: "Comment",
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
                    SizedBox(height: 16),

                    // Center(
                    //   child: FlatButton(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(0),
                    //         side: BorderSide(color: Colors.black26)),
                    //     color: Colors.transparent,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(
                    //           right: 5, bottom: 8, top: 5),
                    //       child: Text(
                    //         "ADD COMMENT",
                    //         style: TextStyle(
                    //             color: HexColor("#1C99D4"),
                    //             fontWeight: FontWeight.bold,
                    //             // letterSpacing: 2,
                    //             fontSize: 17),
                    //       ),
                    //     ),
                    //     onPressed: () async {
                    //       if (_comments.value.text != null &&
                    //           _comments.value.text != '') {
                    //         print("here");
                    //         setState(() {
                    //           _commentsList.add(
                    //             new CommentsDetail(
                    //                 commentedBy: "XYZNAME",
                    //                 comment: _comments.value.text,
                    //                 commentedAt: DateTime.now()),
                    //           );
                    //           _comments.clear();
                    //         });
                    //       }
                    //       SystemChannels.textInput
                    //           .invokeMethod('TextInput.hide');
                    //     },
                    //   ),
                    // ),
                    _commentsList != null && _commentsList.length != 0
                        ? viewMoreActive
                            ? Row(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        reverse: true,
                                        shrinkWrap: true,
                                        itemCount: _commentsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _commentsList[index]
                                                        .creatorName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                  Text(
                                                    _commentsList[index]
                                                        .commentText,
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 25),
                                                  ),
                                                  Text(
                                                    _commentsList[index]
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
                                          );
                                        }),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        _commentsList[_commentsList.length - 1]
                                            .creatorName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        _commentsList[_commentsList.length - 1]
                                            .commentText,
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 25),
                                      ),
                                      Text(
                                        _commentsList[_commentsList.length - 1]
                                            .commentedAt
                                            .toString(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
                    //   child: Text(
                    //     "XYZ Kumar",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 25,
                    //         // color: HexColor("#000000DE"),
                    //         fontFamily: "Muli"),
                    //   ),
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(top: 5.0, bottom: 20, left: 5),
                    //   child: Text(
                    //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    //     style: TextStyle(
                    //         //fontWeight: FontWeight.bold,
                    //         fontSize: 20,
                    //         // color: HexColor("#000000DE"),
                    //         fontFamily: "Muli"),
                    //   ),
                    // ),
                    _commentsList.length == 1
                        ? Container()
                        : Center(
                            child: FlatButton(
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(0),
                              //     side: BorderSide(color: Colors.black26)),
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 5, bottom: 8, top: 5),
                                child: !viewMoreActive
                                    ? Text(
                                        "VIEW MORE COMMENT (" +
                                            _commentsList.length.toString() +
                                            ")",
                                        style: TextStyle(
                                            color: HexColor("##F9A61A"),
                                            fontWeight: FontWeight.bold,
                                            // letterSpacing: 2,
                                            fontSize: 17),
                                      )
                                    : Text(
                                        "VIEW LESS COMMENT (" +
                                            _commentsList.length.toString() +
                                            ")",
                                        style: TextStyle(
                                            color: HexColor("##F9A61A"),
                                            fontWeight: FontWeight.bold,
                                            // letterSpacing: 2,
                                            fontSize: 17),
                                      ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  viewMoreActive = !viewMoreActive;
                                });
                                //     InfluencerDetail infl = new InfluencerDetail();
                                //
                                //     Item item = new Item(
                                //         headerValue: "agx ", expandedValue: "dnxcx");
                                //     setState(() {
                                //       _data.add(item);
                                //       _list.add(infl);
                                //     });
                              },
                            ),
                          ),

                    SizedBox(height: 35),

                    Center(
                      child: RaisedButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        color: HexColor("#1C99D4"),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 5, bottom: 10, top: 10),
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
                          nextStageModalBottomSheet(context);
                        },
                      ),
                    ),

                    SizedBox(height: 70),
                  ],
                ),
              ),
            ),
            Container(
              color: Color.fromRGBO(255, 255, 255, 0.7),
            ),
          ],
        ),
      ),
    );
//    }
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      //print(image.path);
      if (image != null) {
        // print(basename(image.path));

        listLeadImage.add(new ListLeadImage(photoName: basename(image.path)));
        _imageList.add(image);
        _imgDetails.add(new ImageDetails("asset", image));
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
        _imgDetails.add(new ImageDetails("asset", image));
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

  _getCurrentLocation() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      Get.back();
      Get.dialog(CustomDialogs().errorDialog(
          "Please enable your location service from device settings"));
    } else {
      geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
        });

        _getAddressFromLatLng();
        Get.back();
      }).catchError((e) {
        Get.back();
        Get.dialog(CustomDialogs().errorDialog(
            "Access to location data denied "));
        print(e);
      });
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

        print(
            "${place.name}, ${place.isoCountryCode}, ${place.country},${place.postalCode}, ${place.administrativeArea}, ${place.subAdministrativeArea},${place.locality}, ${place.subLocality}, ${place.thoroughfare}, ${place.subThoroughfare}, ${place.position}");
      });
    } catch (e) {
      print(e);
    }
  }

  updateStatusForNextStage(BuildContext context, int statusId,
      {String dealerId, String subDealerId}) {
    String empId;
    String mobileNumber;
    String name;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      name = prefs.getString(StringConstants.employeeName) ?? "empty";

      print(_comments.text);
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
            _listInfluencerDetail[_listInfluencerDetail.length - 1].inflName ==
                "null" ||
            _listInfluencerDetail[_listInfluencerDetail.length - 1]
                .inflName
                .text
                .isNullOrBlank) {
          print("here1234");
          _listInfluencerDetail.removeAt(_listInfluencerDetail.length - 1);
        }
      }
      List<updateRequest.LeadInfluencerEntity> listInfluencer = new List();

      print(_listInfluencerDetail.length);

      for (int i = 0; i < _listInfluencerDetail.length; i++) {
        print(_listInfluencerDetail[i].toJson());
        listInfluencer.add(new updateRequest.LeadInfluencerEntity(
            id: _listInfluencerDetail[i].originalId,
            leadId: widget.leadId,
            isPrimary: _listInfluencerDetail[i].isPrimarybool ? "Y" : "N",
            createdBy: empId,
            inflId: int.parse(_listInfluencerDetail[i].id.text),
            isDelete: "N"));
      }

      for (int i = 0; i < listInfluencer.length; i++) {
        print(listInfluencer[i].toJson());
      }

      if (_SelectedDealer == null) {
        _SelectedDealer = new DealerList();
      }
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
        'leadSalesPotentialMt':
            viewLeadDataResponse.leadsEntity.leadSitePotentialMt,
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
        // 'listLeadcomments':
        //     new List(),
        // 'listLeadImage':
        //     new List(),
        // 'leadInfluencerEntity':
        //     new List()
        'listLeadcomments': commentsList,
        'listLeadImage': viewLeadDataResponse.leadphotosEntity,
        'leadInfluencerEntity': viewLeadDataResponse.leadInfluencerEntity
      };

      print("$updateRequestModel");

      _addLeadsController.updateLeadData(updateRequestModel, new List<File>(),
          context, viewLeadDataResponse.leadsEntity.leadId,3);

      Get.back();
    });
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              subtitle: Text('To delete this panel, tap the trash can icon'),
              trailing: Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  void nextStageModalBottomSheet(context) {
    print(leadStageEntity.length);

    print(leadStageVal.leadStageDesc);
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
                                          //color: HexColor("#1C99D4"),
                                          fontWeight: FontWeight.bold,
                                          // letterSpacing: 2,
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
                                if (leadStageVal.id !=
                                    leadStageEntity[index].id) {
                                  // print(leadStageVal.id);
                                  // print(leadStageEntity[index].id);

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

                                      print(_comments.text);
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

                                      List<updateRequest.ListLeadImage>
                                          imageList = new List();
                                      for (int i = 0;
                                          i < listLeadImage.length;
                                          i++) {
                                        imageList.add(
                                            new updateRequest.ListLeadImage(
                                          leadId: widget.leadId,
                                          photoName: listLeadImage[i].photoName,
                                          createdBy: empId,
                                        ));
                                      }
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
                                                    .inflName ==
                                                "null" ||
                                            _listInfluencerDetail[
                                                    _listInfluencerDetail
                                                            .length -
                                                        1]
                                                .inflName
                                                .text
                                                .isNullOrBlank) {
                                          print("here1234");
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

//                                      print("Dhawannnnn ::" + listInfluencer.length.toString());
                                      for (int i = 0;
                                          i < listInfluencer.length;
                                          i++) {
//                                        print(listInfluencer[i].toJson());
                                      }

                                      var updateRequestModel = {
                                        'leadId': viewLeadDataResponse
                                            .leadsEntity.leadId,
                                        'eventId': viewLeadDataResponse.leadsEntity.eventId,
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
                                        'listLeadImage': imageList,
                                        'leadInfluencerEntity': listInfluencer
                                      };

//                                      print(commentsList.length);

                                      leadStageVal.id =
                                          leadStageEntity[index].id;
                                      viewLeadDataResponse
                                              .leadsEntity.leadStageId =
                                          leadStageEntity[index].id;

                                      _addLeadsController.updateLeadData(
                                          updateRequestModel,
                                          _imageList,
                                          context,
                                          viewLeadDataResponse
                                              .leadsEntity.leadId,4);

//                                      Get.back();
                                    }).whenComplete(() => Get.back());
                                  }
                                } else {
                                  Get.back();
                                  // print(leadStageVal.id);
                                  // print(leadStageEntity[index].id);
                                }
                                //  Get.dialog(
                                // CustomDialogs().errorDialog("Coming Soon !!"));
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

  /*Show dialog for lead to site*/

  _getLeadToSiteConvertDialog() {}

  @override
  userChangeDealerId() {
    // TODO: implement userChangeDealerId
    if (mounted) setState(() {});
  }

  String selectedDealerId = "";
  String selectedDealerSubId = "";
  String selectedDate = "";

  @override
  updateStatusForNextStageAllow(
      BuildContext context,
      int statusId,
      NextStageConstructionEntity selectedNextStageConstructionEntity,
      String nextStageConstructionPicked,
      String dealerId,
      String subDealerId) {
    // TODO: implement updateStatusForNextStageAllow
    selectedDealerId = dealerId;
    selectedDealerSubId = subDealerId;
    _selectedNextStageConstructionEntity = selectedNextStageConstructionEntity;
    selectedDate = nextStageConstructionPicked;
    // print("_selectedNextStageConstructionEntity  $nextStageConstructionPicked    ${_selectedNextStageConstructionEntity.nextStageConsId}");
    // nextStageConstructionPickedDate=nextStageConstructionPicked;
    _nextDateofConstruction.text = nextStageConstructionPicked;
    print(
        "_selectedNextStageConstructionEntity    ${nextStageConstructionPickedDate}");

    updateStatusForNextStage(context, statusId,
        dealerId: selectedDealerId, subDealerId: selectedDealerSubId);
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
//
// List<Item> addItems(Item item){
//   _data.add
//   return List.
// }
