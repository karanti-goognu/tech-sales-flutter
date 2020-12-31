import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/datepicker.dart';
import 'package:flutter_tech_sales/widgets/image_upload.dart';

class RequestUpdateDetails extends StatefulWidget {
  ComplaintViewModel detailsModel;
  RequestUpdateDetails({this.detailsModel});
  @override
  _RequestUpdateDetailsState createState() => _RequestUpdateDetailsState();
}

class _RequestUpdateDetailsState extends State<RequestUpdateDetails> {

  TextEditingController _complaintID = TextEditingController();
  TextEditingController _allocatedToID = TextEditingController();
  TextEditingController _allocatedToName = TextEditingController();
  TextEditingController _dateOfComplaint = TextEditingController();
  TextEditingController _daysOpen = TextEditingController();
  TextEditingController _dpd = TextEditingController();
  TextEditingController _sitePotential = TextEditingController();

  TextEditingController _requestSubType = TextEditingController();
  TextEditingController _customerType = TextEditingController();
  TextEditingController _severity = TextEditingController();


  TextEditingController _state = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _taluk = TextEditingController();
  TextEditingController _pin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _complaintID,
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Complaint ID"),
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Allocated to ID"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Allocated to Name"),
          ),
          SizedBox(height: 16),
          TextFormField(
            style: FormFieldStyle.formFieldTextStyle,
            readOnly: true,
            onTap: ()=>PickDate.selectDate(context),
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Date of complaint",
                suffixIcon: Icon(Icons.calendar_today_outlined,
                    color: HexColor('#F9A61A'),),),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  style: FormFieldStyle.formFieldTextStyle,
                  decoration: FormFieldStyle.buildInputDecoration(
                      labelText: "Days open"),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  style: FormFieldStyle.formFieldTextStyle,
                  decoration:
                      FormFieldStyle.buildInputDecoration(labelText: "DPD"),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Site Potential"),
          ),
          SizedBox(height: 16),
          TextFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Department*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Request Type*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Request Sub-type*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Customer Type"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Severity"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Customer ID*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Requestor Contact*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Requestor Name"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            maxLines: 4,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Description"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Dealer Name*"),
          ),
          SizedBox(height: 16),
          Container(
              width: MediaQuery.of(context).size.width, child: ImageUpload()),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(labelText: "State"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "District"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(labelText: "Taluk"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Pincode"),
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
