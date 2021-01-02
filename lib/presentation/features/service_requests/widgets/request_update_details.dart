import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/image_upload.dart';

class RequestUpdateDetails extends StatefulWidget {
  final id;
  final ComplaintViewModel complaintViewModel;
  RequestUpdateDetails({this.id, this.complaintViewModel});

  @override
  _RequestUpdateDetailsState createState() => _RequestUpdateDetailsState();
}

class _RequestUpdateDetailsState extends State<RequestUpdateDetails> {
  TextEditingController _complaintID = TextEditingController();
  TextEditingController _allocatedToID = TextEditingController();
  TextEditingController _allocatedToName = TextEditingController();
  TextEditingController _dateOfComplaint = TextEditingController();
  TextEditingController _daysOpen = TextEditingController();
  TextEditingController _sitePotential = TextEditingController();
  TextEditingController _department = TextEditingController();
  TextEditingController _requestType = TextEditingController();
  TextEditingController _requestSubType = TextEditingController();
  TextEditingController _customerType = TextEditingController();
  TextEditingController _severity = TextEditingController();
  TextEditingController _customerID = TextEditingController();
  TextEditingController _requestorContact = TextEditingController();
  TextEditingController _requestorName = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _district = TextEditingController();
  TextEditingController _taluk = TextEditingController();
  TextEditingController _pin = TextEditingController();

  // SRListController srListController= Get.find();
  // ComplaintViewModel complaintViewModel;
  //
  // var data;
  // getComplaintViewData() async {
  //   await srListController.getAccessKey().then((value) async {
  //     // print("id"+ widget.id.toString());
  //     await srListController
  //         .getComplaintViewData(value.accessKey, widget.id.toString()).then((value){
  //       setState(() {
  //         complaintViewModel = value;
  //       });}
  //     );
  //
  //   });
  // }

  setValues() {
    setState(() {
      _complaintID.text = widget.complaintViewModel.id.toString();
      _allocatedToID.text = widget.complaintViewModel.referenceId;
      _allocatedToName.text = widget.complaintViewModel.allocatedToName;
      _dateOfComplaint.text = widget.complaintViewModel.srComplaintDate;
      _daysOpen.text = widget.complaintViewModel.dayOpen.toString();
      _sitePotential.text = widget.complaintViewModel.sitePotentialMt;
      _department.text = widget.complaintViewModel.deaprtmentText;
      _requestType.text = widget.complaintViewModel.requestText;
      _requestSubType.text =
          widget.complaintViewModel.srcSubtypeMappingModal[0].requestTypeText;
      _customerType.text = widget.complaintViewModel.creatorType;
      _severity.text = widget.complaintViewModel.severity;
      _customerID.text = widget.complaintViewModel.creatorId.toString();
      _requestorName.text = widget.complaintViewModel.creatorName ?? ' ';
      _requestorContact.text = widget.complaintViewModel.creatorContactNumber;
      _description.text = widget.complaintViewModel.description;
      _state.text = widget.complaintViewModel.state;
      _state.text = widget.complaintViewModel.state;
      _district.text = widget.complaintViewModel.district;
      _taluk.text = widget.complaintViewModel.taluk;
      _pin.text = widget.complaintViewModel.pincode;
    });
  }

  @override
  void initState() {
    setValues();
    super.initState();
  }

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
            controller: _allocatedToID,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Allocated to ID"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _allocatedToName,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Allocated to Name"),
          ),
          SizedBox(height: 16),
          TextFormField(
            style: FormFieldStyle.formFieldTextStyle,
            readOnly: true,
            controller: _dateOfComplaint,
            decoration: FormFieldStyle.buildInputDecoration(
              labelText: "Date of complaint",
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _daysOpen,
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Days open"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _sitePotential,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Site Potential"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _department,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Department*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _requestType,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Request Type*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _requestSubType,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Request Sub-type*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _customerType,
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Customer Type"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _severity,
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Severity"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _customerID,
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Customer ID*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _requestorContact,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Requestor Contact*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _requestorName,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Requestor Name"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            maxLines: 4,
            controller: _description,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Description"),
          ),
          SizedBox(height: 16),
          Container(
              width: MediaQuery.of(context).size.width, child: ImageUpload()),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _state,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(labelText: "State"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _district,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
                FormFieldStyle.buildInputDecoration(labelText: "District"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _taluk,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(labelText: "Taluk"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: _pin,
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
