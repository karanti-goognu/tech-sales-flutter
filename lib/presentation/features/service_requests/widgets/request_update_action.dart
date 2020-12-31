import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/datepicker.dart';
import 'package:flutter_tech_sales/widgets/image_upload.dart';

class RequestUpdateAction extends StatefulWidget {
  @override
  _RequestUpdateActionState createState() => _RequestUpdateActionState();
}

class _RequestUpdateActionState extends State<RequestUpdateAction> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          DropdownButtonFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Request Nature*"),
          ),
          SizedBox(height: 16),
          TextFormField(
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
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "TechVan Required"),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Product Type"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            onTap: () => PickDate.selectDate(context),
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: 'Date and time',
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: HexColor('#F9A61A'),
                ),),
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
            style: FormFieldStyle.formFieldTextStyle,
            keyboardType: TextInputType.text,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "No. of Bags"),
          ),
          SizedBox(height: 16),
          TextFormField(
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
          ),
          SizedBox(height: 16),
          TextFormField(
            maxLines: 4,
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
