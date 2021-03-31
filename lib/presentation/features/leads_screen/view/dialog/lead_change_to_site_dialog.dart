import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// ignore: must_be_immutable
class ChangeLeadToSiteDialog extends StatefulWidget {
  NextStageConstructionEntity selectedNextStageConstructionEntity;
  final  List<DealerForDb> dealerEntityForDb;
final List<CounterListModel> counterListModel;
final ChangeLeadToSiteDialogListener mListener;

  ChangeLeadToSiteDialog({Key key, this.selectedNextStageConstructionEntity, this.dealerEntityForDb, this.counterListModel, this.mListener}) : super(key: key);@override
  _ChangeLeadToSiteDialogState createState() => _ChangeLeadToSiteDialogState();
}

class _ChangeLeadToSiteDialogState extends State<ChangeLeadToSiteDialog> {
  var _nextDateofConstruction = TextEditingController();
  DateTime nextStageConstructionPickedDate;
  CounterListModel selectedSubDealer = CounterListModel();
  List<CounterListModel> subDealerList = new List();
  String leadDataDealer;
  String leadDataSubDealer;
  NextStageConstructionEntity _selectedNextStageConstructionEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("delearIdListLength     ${widget.dealerEntityForDb.length}");
  }

  @override
  Widget build(BuildContext context) {
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
                  DropdownButtonFormField<
                      NextStageConstructionEntity>(
                    value:
                    _selectedNextStageConstructionEntity,
                    items: nextStageConstructionEntity
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
                        _selectedNextStageConstructionEntity = value;
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
                  /*DropDown for dealer*/
                  DropdownButtonFormField(
                    items: widget.dealerEntityForDb
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
                      print(" Dealer Value ${widget.counterListModel.length}");
                      print(value);
                      widget.mListener.userChangeDealerId();

                      setState(() {
                        selectedSubDealer = null;
                        leadDataDealer = value.toString();

                        //  subDealerList = new List();
                        subDealerList.clear();
                        subDealerList = widget.counterListModel
                            .where((e) => e.soldToParty == leadDataDealer)
                            .toList();
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
                  /*DropDown For SubDealer*/
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


                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
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
                        //print("widget.selectedNextStageConstructionEntity.nextStageConsId    ${_selectedNextStageConstructionEntity}");
                        if (_selectedNextStageConstructionEntity==null || nextStageConstructionPickedDate==null) {
                          Get.dialog(
                              CustomDialogs()
                                  .errorDialog(
                                  "Please fill the details first"));
                        } else {
                          if (nextStageConstructionPickedDate.difference(DateTime.now()).inDays > 31) {
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
                                        onPressed: () {
                                          //  updateStatusforNextStage(context,5);

                                          widget.mListener.updateStatusForNextStageAllow(context,5, _selectedNextStageConstructionEntity, _nextDateofConstruction.text,
                                              leadDataDealer, leadDataSubDealer
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            //updateStatusforNextStage(context, 3);
                           widget.mListener.updateStatusForNextStageAllow(context,3, _selectedNextStageConstructionEntity, _nextDateofConstruction.text,
                           leadDataDealer, leadDataSubDealer
                           );
                          }

                          //});
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


abstract class ChangeLeadToSiteDialogListener{
  userChangeDealerId();
  updateStatusForNextStageAllow(BuildContext context,int statusId, NextStageConstructionEntity selectedNextStageConstructionEntity,
      String nextStageConstructionPickedDate, String dealerId, String subDealerId );
}