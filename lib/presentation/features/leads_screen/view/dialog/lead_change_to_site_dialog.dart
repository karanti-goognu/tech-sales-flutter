import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/controller/add_leads_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ChangeLeadToSiteDialog extends StatefulWidget {
  NextStageConstructionEntity selectedNextStageConstructionEntity;
  final List<DealerForDb> dealerEntityForDb;
  final List<CounterListModel> counterListModel;
  final List<SiteFloorsEntity> siteFloorsEntity;
  final ChangeLeadToSiteDialogListener mListener;

  ChangeLeadToSiteDialog(
      {Key key,
      this.selectedNextStageConstructionEntity,
      this.dealerEntityForDb,
      this.counterListModel,
      this.siteFloorsEntity,
      this.mListener})
      : super(key: key);

  @override
  _ChangeLeadToSiteDialogState createState() => _ChangeLeadToSiteDialogState();
}

class _ChangeLeadToSiteDialogState extends State<ChangeLeadToSiteDialog> {
  AddLeadsController _addLeadsController = Get.find();
  var _nextDateofConstruction = TextEditingController();
  DateTime nextStageConstructionPickedDate;
  CounterListModel selectedSubDealer = CounterListModel();
  List<CounterListModel> subDealerList = new List();
  String leadDataDealer;
  String leadDataSubDealer;
  NextStageConstructionEntity _selectedNextStageConstructionEntity;
  SiteFloorsEntity _selectedLeadFloorEntity;
  SiteFloorsEntity _selectedLeadFloorLevelEntity;
  var _noOfBagsSupplied = TextEditingController();
  TextEditingController _totalSitePotential = TextEditingController();
  TextEditingController _lapPotentialController = TextEditingController();
  TextEditingController _balancePotentialController = TextEditingController();

  String _selectedRadioValue = 'I';
  double _totalPotential;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("delearIdListLength     ${widget.dealerEntityForDb.length}");
  }

  @override
  Widget build(BuildContext context) {
    final ihbRadio = Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Radio(
                value: 'I',
                groupValue: _selectedRadioValue,
                onChanged: (value) {
                  setState(() {
                    _selectedRadioValue = value;
                  });
                },
              ),
              Text("IHB")
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Radio(
                value: 'C',
                groupValue: _selectedRadioValue,
                onChanged: (value) {
                  setState(() {
                    _selectedRadioValue = value;
                  });
                },
              ),
              Text("Commercial")
            ],
          ),
        )
      ],
    );

    final nextStageOfConstuction =
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
      decoration: FormFieldStyle.buildInputDecoration(
          labelText: "Next Stage of Construction"),
    );

    final nxtDtOfConstuction = TextFormField(
      controller: _nextDateofConstruction,
      readOnly: true,
      onChanged: (data) {},
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
    );

    final totalNoOfFloors = DropdownButtonFormField<SiteFloorsEntity>(
      value: _selectedLeadFloorEntity,
      items: widget.siteFloorsEntity
          .map((label) => DropdownMenuItem(
                child: Text(
                  label.siteFloorTxt,
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
          _selectedLeadFloorEntity = value;
        });
      },
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Total No. of Floors"),
    );

    final nxtFloorLevel = DropdownButtonFormField<SiteFloorsEntity>(
      value: _selectedLeadFloorLevelEntity,
      items: widget.siteFloorsEntity
          .map((label) => DropdownMenuItem(
                child: Text(
                  label.siteFloorTxt,
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
          // if(_selectedLeadFloorEntity.id < value.id){
          //   Get.dialog(CustomDialogs().errorDialog(
          //       "Next Floor Level can’t be greater than Total No. of Floors."));
          // }else {
            _selectedLeadFloorLevelEntity = value;
         // }
        });
      },
      decoration:
          FormFieldStyle.buildInputDecoration(labelText: "Next Floor Level"),
    //   validator: (value){
    //     if(_selectedLeadFloorEntity.id < value.id){
    //       return "Next Floor Level can’t be greater than Total No. of Floors.";
    //     }
    //       return null;
    // },
    );

    final noOfBagsSupplied = TextFormField(
        controller: _noOfBagsSupplied,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter no of bags supplied';
          }
          return null;
        },
        style: TextStyle(
            fontSize: 18,
            color: ColorConstants.inputBoxHintColor,
            fontFamily: "Muli"),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          TextInputFormatter.withFunction((oldValue, newValue) {
            try {
              final text = newValue.text;
              if (text.isNotEmpty) double.parse(text);
              return newValue;
            } catch (e) {}
            return oldValue;
          }),
        ],
        decoration: FormFieldStyle.buildInputDecoration(
            labelText: "Site Built Up Area (sqft)"));

    final btnProceed = Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          'PROCEED',
          style: GoogleFonts.roboto(
              fontSize: 17,
              letterSpacing: 1.25,
              fontStyle: FontStyle.normal,
              // fontWeight: FontWeight.bold,
              color: ColorConstants.buttonNormalColor),
        ),
        onPressed: () {
          //print("widget.selectedNextStageConstructionEntity.nextStageConsId    ${_selectedNextStageConstructionEntity}");
          if (_selectedNextStageConstructionEntity == null ||
              nextStageConstructionPickedDate == null ||
              _selectedLeadFloorEntity == null ||
              _noOfBagsSupplied.text.isEmpty ||
              _selectedLeadFloorLevelEntity == null) {
            Get.dialog(
                CustomDialogs().errorDialog("Please fill the details first"));
          } else
            if(_selectedLeadFloorEntity.id < _selectedLeadFloorLevelEntity.id){
              Get.dialog(CustomDialogs().errorDialog(
                  "Next Floor Level can’t be greater than Total No. of Floors."));

          }
          else {
            if (nextStageConstructionPickedDate
                    .difference(DateTime.now())
                    .inDays >
                31) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              "Next Construction date is more than 31 days from now, "
                              "So status will be changed to FUTURE "
                              "OPPORTUNITY . ",
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  height: 1.4,
                                  letterSpacing: .25,
                                  fontStyle: FontStyle.normal,
                                  color: ColorConstants.inputBoxHintColorDark),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'OK',
                            style: GoogleFonts.roboto(
                                fontSize: 17,
                                letterSpacing: 1.25,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.buttonNormalColor),
                          ),
                          onPressed: () {
                            //  updateStatusforNextStage(context,5);

                            widget.mListener.updateStatusForNextStageAllow(
                                context,
                                5,
                                _selectedNextStageConstructionEntity,
                                _nextDateofConstruction.text,
                                leadDataDealer,
                                leadDataSubDealer,
                                _selectedLeadFloorEntity.id,
                                _noOfBagsSupplied.text,
                                _selectedRadioValue,
                                _selectedLeadFloorLevelEntity.id,
                                int.parse(_lapPotentialController.text),
                                _totalPotential
                            );
                          },
                        ),
                      ],
                    );
                  });
            } else {
              apiCallForProcced();
            }

            //});
          }
        },
      ),
    );

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ihbRadio,
                  totalNoOfFloors,
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  noOfBagsSupplied,
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  nextStageOfConstuction,
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  nxtFloorLevel,
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  nxtDtOfConstuction,
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  btnProceed
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  apiCallForProcced() {
    var updateRequestModel = {
      'noOfFloors': _selectedLeadFloorEntity.id,
      'totalFloorSqftArea': _noOfBagsSupplied.text
    };

    print('${updateRequestModel}');
    internetChecking().then((result) => {
          if (result == true)
            {
              _addLeadsController
                  .getTotalSitePotential(updateRequestModel)
                  .then((data) {
                if (data != null) {
                  if (data.respCode == 'DM1002') {
                    //Get.back();
                    _totalSitePotential.text = '${data.totalSitePotential}';
                    _totalPotential = data.totalSitePotential;
                    Get.dialog(
                      successDialog(),
                      // barrierDismissible: false
                    );
                  } else {
                    Get.back();
                    Get.dialog(
                        CustomDialogs()
                            .messageDialogMWP(data.respMsg.toString()),
                        barrierDismissible: false);
                  }
                }
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

  Widget successDialog() {
    return
        //AlertDialog(
        //   content:
        Material(
            color: Colors.transparent,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.height * 0.02),
                          TextFormField(
                            controller: _totalSitePotential,
                            style: FormFieldStyle.formFieldTextStyle,
                            readOnly: true,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Total Site Potential (No of Bags)",
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          TextFormField(
                            controller: _lapPotentialController,
                            keyboardType:
                                TextInputType.numberWithOptions(signed: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              if (value.length > 0) {
                                  String balance = '';
                                  double bal = double.tryParse(
                                          _totalSitePotential.text) -
                                      int.tryParse(value);
                                  balance = bal.toString();
                                  if(bal < 0){
                                    _lapPotentialController.text = "";
                                    Get.dialog(errorDialogLaps(
                                        "Laps Potential can’t be greater than Total Site Potential"));
                                  }else {
                                    _balancePotentialController.text = balance;
                                  }

                              } else {

                                  _balancePotentialController.text = "";


                              }

                            },
                            style: FormFieldStyle.formFieldTextStyle,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Lapse Potential (No of Bags)",
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          TextFormField(
                            controller: _balancePotentialController,
                            style: FormFieldStyle.formFieldTextStyle,
                            readOnly: true,
                            decoration: FormFieldStyle.buildInputDecoration(
                              labelText: "Total Site Potential (No of Bags)",
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Container(
                            alignment: Alignment.centerRight,
                            child: TextButton(
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

                                    //updateStatusforNextStage(context, 3);
                                    widget.mListener
                                        .updateStatusForNextStageAllow(
                                            context,
                                            3,
                                            _selectedNextStageConstructionEntity,
                                            _nextDateofConstruction.text,
                                            leadDataDealer,
                                            leadDataSubDealer,
                                            _selectedLeadFloorEntity.id,
                                            _noOfBagsSupplied.text,
                                            _selectedRadioValue,
                                            _selectedLeadFloorLevelEntity.id,
                                            int.parse(_lapPotentialController.text),
                                            _totalPotential,
                                    );

                                }
                             // },
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ));
  }

  Widget errorDialogLaps(String message) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              message,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  height: 1.4,
                  letterSpacing: .25,
                  fontStyle: FontStyle.normal,
                  color: ColorConstants.inputBoxHintColorDark),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'OK',
            style: GoogleFonts.roboto(
                fontSize: 20,
                letterSpacing: 1.25,
                fontStyle: FontStyle.normal,
                color: ColorConstants.buttonNormalColor),
          ),
          onPressed: () {
            // Get.back();
            _lapPotentialController.text = "";
            Get.back();
          },
        ),
      ],
    );
  }

}

abstract class ChangeLeadToSiteDialogListener {
  userChangeDealerId();

  updateStatusForNextStageAllow(
      BuildContext context,
      int statusId,
      NextStageConstructionEntity selectedNextStageConstructionEntity,
      String nextStageConstructionPickedDate,
      String dealerId,
      String subDealerId,
      int siteFloorId,
      String numOfBagsSupplied,
      String isIhbCommercial,
      int siteFloorLevelId,
      int lapsePotential,
      double totalSitePotential);
}
