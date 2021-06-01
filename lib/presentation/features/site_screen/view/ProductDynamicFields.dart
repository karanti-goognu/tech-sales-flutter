
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/helper/brandNameDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/ViewSiteDataResponse.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ProductDynamicFields extends StatefulWidget {
  final int index;
  final BrandModelforDB _siteProductFromLocalDB;
  final List<BrandModelforDB> siteProductEntityfromLoaclDB;
  List<SitesModal> productDynamicList;
  ProductDynamicFields(this.index,this._siteProductFromLocalDB,this.siteProductEntityfromLoaclDB,this.productDynamicList);
  @override
  _ProductDynamicFieldsState createState() => _ProductDynamicFieldsState();
}

class _ProductDynamicFieldsState extends State<ProductDynamicFields> {
  TextEditingController _nameController;
  var _brandPriceVisit = new TextEditingController();
  var _dateOfBagSupplied = new TextEditingController();
  var _siteCurrentTotalBags = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    
    return  ExpandablePanel(
      header: Text("Product details "+(widget.index+1).toString(),softWrap: true,style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          // color: HexColor("#000000DE"),
          fontFamily: "Muli"),),
      collapsed: Row(
        children: [
          Expanded(
            flex: 7,
            child:Text("sdsadasdsadfaf", softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          // color: HexColor("#000000DE"),
          fontFamily: "Muli"),)),Expanded(
            flex: 1,
              child:
          GestureDetector(
              onTap: () {
                setState(() {});
              },
            child: Icon(Icons.delete, color: Colors.black54),
              ),
            ),
        ],
      ),
      expanded: dialogContent(context),
    );

    // return dialogContent(context);

  }
  Widget dialogContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0,right: 0.0),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.only(right: 0,top: 15),
                child: DropdownButtonFormField<BrandModelforDB>(
                  value: widget._siteProductFromLocalDB,
                  items: widget.siteProductEntityfromLoaclDB
                      .map((label) => DropdownMenuItem(
                    child: Text(
                      label.productName,
                      style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.inputBoxHintColor,
                          fontFamily: "Muli"),
                    ),
                    value: label,
                  ))
                      .toList(),

                  // hint: Text('Rating'),
                  onChanged: (value) {
                    print("Product Value");
                    print(value);
                    setState(() {

                    });
                  },
                  decoration: FormFieldStyle.buildInputDecoration(
                      labelText: "Product Sold")),),
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
              TextFormField(
                controller: _brandPriceVisit,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Site Built-Up Area ';
                  }

                  return null;
                },
                style: TextStyle(
                    fontSize: 18,
                    color: ColorConstants.inputBoxHintColor,
                    fontFamily: "Muli"),
                keyboardType: TextInputType.number,
                decoration: FormFieldStyle.buildInputDecoration(labelText: "Brand Price"),

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

              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10, left: 5),
                child: Text(
                  "No. of Bags Supplied",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
                        controller: _dateOfBagSupplied,
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
                            borderSide:
                            BorderSide(color: Colors.black26, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.black26, width: 1.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                          ),
                          labelText: "Date ",
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.date_range_rounded,
                              size: 22,
                              color: ColorConstants.clearAllTextColor,
                            ),
                            onPressed: () async {
                              print("here");
                              final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime.now(),
                              );

                              setState(() {
                                final DateFormat formatter = DateFormat("yyyy-MM-dd");
                                if(picked!=null) {
                                  final String formattedDate = formatter.format(picked);
                                  _dateOfBagSupplied.text = formattedDate;
                                }
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
                    ),
                  ),
                  // Text(_siteCurrentTotalBags.text),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: _siteCurrentTotalBags,
                        onChanged: (v) {
                          print(v);
                        },
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
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                        decoration: FormFieldStyle.buildInputDecoration(
                          labelText: "No. Of Bags",
                        ),
                      ),
                    ),
                  ),
                ],
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
            ],
          ),
          // Positioned(
          //   right: 0.0,
          //   child: GestureDetector(
          //     onTap: (){
          //
          //     },
          //     child: Align(
          //       alignment: Alignment.topRight,
          //       child: CircleAvatar(
          //         radius: 14.0,
          //         backgroundColor: Colors.redAccent,
          //         child: Icon(Icons.close, color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
