import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/datepicker.dart';
import 'package:flutter_tech_sales/widgets/image_upload.dart';

class RequestUpdateAction extends StatefulWidget {
  final dept;
  RequestUpdateAction({this.dept});
  @override
  _RequestUpdateActionState createState() => _RequestUpdateActionState();
}

class _RequestUpdateActionState extends State<RequestUpdateAction> {
  TextEditingController _location = TextEditingController();
  TextEditingController _noOfBags = TextEditingController();
  TextEditingController _comment = TextEditingController();
  String _productComplaint;
  String _techVan;
  String _productType;
  String _resolutionStatus;
 String requestNature;

  // String _productComplaint;

  

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          DropdownButtonFormField(
            onChanged: (value) {
              setState(() {
                requestNature = value;
              });
            },
            items: [
              'geniune',
              'not geniune'
            ]
                .map((e) => DropdownMenuItem(
                      child: Text(
                        e.toUpperCase(),
                      ),
                      value: e,
                    ))
                .toList(),
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Request Nature*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _location,
            style: FormFieldStyle.formFieldTextStyle,
            keyboardType: TextInputType.text,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Location*"),
          ),
          SizedBox(height: 16),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ImageUpload(),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Product Complaint"),
            items: ['YES', 'NO']
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (val) {
              setState(() {
                _productComplaint=val;
              });
            },
          ),
          SizedBox(height: 16),
          widget.dept=='TECHNICAL SERVICES'?
          DropdownButtonFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "TechVan Required"),
            items: ['YES', 'NO']
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (val) {
              print(widget.dept);
            },
          ): Container(),
          widget.dept=='TECHNICAL SERVICES'?
          SizedBox(height: 16): Container(),
          DropdownButtonFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Product Type"),
            items: ['GENIUNE', 'NOT GENIUNE']
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (val) {
              print('test');
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            onTap: () => PickDate.selectDate(context),
            decoration: FormFieldStyle.buildInputDecoration(
              labelText: 'Date of Purchase',
              suffixIcon: Icon(
                Icons.calendar_today_outlined,
                color: HexColor('#F9A61A'),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            style: FormFieldStyle.formFieldTextStyle,
            keyboardType: TextInputType.text,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Source Plant"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _noOfBags,
            style: FormFieldStyle.formFieldTextStyle,
            keyboardType: TextInputType.text,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "No. of Bags"),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Resolution Status*"),
            items: ['GENIUNE', 'NOT GENIUNE']
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (val) {
              print('test');
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            maxLines: 4,
            controller: _comment,
            maxLength: 500,
            style: FormFieldStyle.formFieldTextStyle,
            keyboardType: TextInputType.text,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Comment*"),
          ),
          TextFormField(
            style: FormFieldStyle.formFieldTextStyle,
            readOnly: true,
            onTap: () => PickDate.selectDate(context),
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Next visit date*",
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: HexColor('#F9A61A'),
                )),
          ),
          SizedBox(height: 16),
          RaisedButton(
            onPressed: () {},
            color: HexColor("#1C99D4"),
            child: Text(
              "UPDATE",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  // letterSpacing: 2,
                  fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
