import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SiteVisitWidget extends StatefulWidget {
  int siteId;
  String siteDate;
  SiteOpportunityStatusEntity selectedOpportunitStatusEnity;
  List<SiteOpportunityStatusEntity> siteOpportunityStatusEntity;
  String visitRemarks;
  SiteVisitWidget(
      {this.siteId,
      this.siteDate,
      this.selectedOpportunitStatusEnity,
      this.siteOpportunityStatusEntity,
      this.visitRemarks});
  _SiteVisitWidgetState createState() => _SiteVisitWidgetState();
}

class _SiteVisitWidgetState extends State<SiteVisitWidget> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  String selectedDateStringNext = 'Next visit date',
      typeValue = "PHYSICAL",
      selectedDateString;
  SiteController _siteController = Get.find();
  TextEditingController _siteTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
   setData();
  }

  setData(){
    if(widget.selectedOpportunitStatusEnity != null){
      _siteTypeController.text = widget.selectedOpportunitStatusEnity.opportunityStatus;
    }else{
      _siteTypeController.text = "";
    }
    //_siteTypeController.text = "Retention site";
    selectedDateString = "${widget.siteDate}";
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _siteTypeController,
                        style: FormFieldStyle.formFieldTextStyle,
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        enableInteractiveSelection: false,
                        decoration: FormFieldStyle.buildInputDecoration(),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Site ID",style: TextStyles.formfieldLabelText),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text('${widget.siteId}', style: TextStyles.mulliBold16,),
                      ),
                      SizedBox(height: 16),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                              border: Border.all(
                                  color:
                                      ColorConstants.inputBoxBorderSideColor)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: typeValue,
                              onChanged: (String newValue) {
                                setState(() {
                                  typeValue = newValue;
                                });
                              },
                              items: <String>[
                                'PHYSICAL',
                                'VIRTUAL',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.roboto(
                                        color: ColorConstants
                                            .inputBoxHintColorDark,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.0),
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                      SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                            border: Border.all(
                                width: 1,
                                color: ColorConstants.lineColorFilter)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedDateString,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstants.blackColor,
                                      fontFamily: "Muli"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Icon(
                                    Icons.calendar_today_sharp,
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                          border: Border.all(
                              width: 1, color: ColorConstants.lineColorFilter),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedDateStringNext,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstants.blackColor,
                                      fontFamily: "Muli"),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _selectDateNextVisit(context);
                                  },
                                  child: Icon(
                                    Icons.calendar_today_sharp,
                                    color: Colors.orange,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          // key: Key(
                          //     _addEventController.visitRemarks),
                          initialValue: widget.visitRemarks == 'null'
                              ? ''
                              : widget.visitRemarks,
                          onSaved: (val) {
                            print('saved' + val);
                            widget.visitRemarks = val;
                          },
                          onChanged: (_) {
                            widget.visitRemarks = _.toString();
                          },
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.inputBoxHintColor,
                              fontFamily: "Muli"),
                          maxLines: 3,
                          decoration: _inputDecoration("Remarks", false)),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RaisedButton(
                            color: ColorConstants.buttonNormalColor,
                            highlightColor: ColorConstants.buttonPressedColor,
                            onPressed: () {
                              // Validate returns true if the form is valid, or false
                              // otherwise.
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Text(
                                'START',
                                style: ButtonStyles.buttonStyleBlue,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                )
              ],
            ))
        //  : Container()

        //  )
        );
  }

  InputDecoration _inputDecoration(String labelText, bool suffixStatus) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstants.inputBoxBorderSideColor, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstants.inputBoxBorderSideColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorConstants.inputBoxBorderSideColor, width: 1.0),
      ),
      labelText: labelText,
      filled: true,
      suffixIcon: (suffixStatus == true)
          ? GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: Icon(Icons.calendar_today_rounded,
                  color: Colors.deepOrangeAccent))
          : null,
      focusColor: Colors.black,
      labelStyle: GoogleFonts.roboto(
          color: ColorConstants.inputBoxHintColorDark,
          fontWeight: FontWeight.normal,
          fontSize: 16.0),
      fillColor: ColorConstants.backgroundColor,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        final DateFormat formatter = DateFormat("yyyy-MM-dd");
        final String formattedDate = formatter.format(picked);
        selectedDateString = formattedDate;
        //this._addEventController.visitDateTime = selectedDateString;
      });
  }

  Future<void> _selectDateNextVisit(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        final DateFormat formatter = DateFormat("yyyy-MM-dd");
        final String formattedDate = formatter.format(picked);
        selectedDateStringNext = formattedDate;
        // this._addEventController.nextVisitDate = selectedDateString;
        // print(this._addEventController.nextVisitDate);
      });
  }
}
