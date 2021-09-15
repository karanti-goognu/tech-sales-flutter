import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/update_sr_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:get/get.dart';

class RequestUpdateDetails extends StatefulWidget {
  final id;
  final ComplaintViewModel complaintViewModel;
  RequestUpdateDetails({this.id, this.complaintViewModel});

  @override
  _RequestUpdateDetailsState createState() => _RequestUpdateDetailsState();
}

class _RequestUpdateDetailsState extends State<RequestUpdateDetails> {
  UpdateServiceRequestController updateServiceRequestController=Get.find();



  setValues() {
    setState(() {
      updateServiceRequestController.complaintID.text = widget.complaintViewModel.id.toString();
      updateServiceRequestController. allocatedToID.text = widget.complaintViewModel.referenceId;
      updateServiceRequestController. allocatedToName.text = widget.complaintViewModel.allocatedToName;
      updateServiceRequestController. dateOfComplaint.text = widget.complaintViewModel.srComplaintDate;
      updateServiceRequestController.daysOpen.text = widget.complaintViewModel.dayOpen.toString();
      updateServiceRequestController.sitePotential.text = widget.complaintViewModel.sitePotentialMt;
      updateServiceRequestController.department.text = widget.complaintViewModel.deaprtmentText;
      updateServiceRequestController.requestType.text = widget.complaintViewModel.requestText;
      updateServiceRequestController.requestSubType.text = widget.complaintViewModel.srcSubtypeMappingModal==null || widget.complaintViewModel.srcSubtypeMappingModal.isEmpty?' ': widget.complaintViewModel.srcSubtypeMappingModal[0].requestTypeText;
      updateServiceRequestController.customerType.text = widget.complaintViewModel.creatorType;
      updateServiceRequestController.severity.text = widget.complaintViewModel.severity;
      updateServiceRequestController.customerID.text = widget.complaintViewModel.creatorId.toString();
      updateServiceRequestController.requestorName.text = widget.complaintViewModel.creatorName ?? ' ';
      updateServiceRequestController.requestorContact.text = widget.complaintViewModel.creatorContactNumber;
      updateServiceRequestController.description.text = widget.complaintViewModel.description;
      updateServiceRequestController.state.text = widget.complaintViewModel.state;
      updateServiceRequestController.state.text = widget.complaintViewModel.state;
      updateServiceRequestController.district.text = widget.complaintViewModel.district;
      updateServiceRequestController.taluk.text = widget.complaintViewModel.taluk;
      updateServiceRequestController.pin.text = widget.complaintViewModel.pincode;
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
            controller: updateServiceRequestController.complaintID,
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
            controller: updateServiceRequestController.allocatedToID,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Allocated to ID"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.allocatedToName,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Allocated to Name"),
          ),
          SizedBox(height: 16),
          TextFormField(
            style: FormFieldStyle.formFieldTextStyle,
            readOnly: true,
            controller: updateServiceRequestController.dateOfComplaint,
            decoration: FormFieldStyle.buildInputDecoration(
              labelText: "Date of complaint",
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: updateServiceRequestController.daysOpen,
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
            FormFieldStyle.buildInputDecoration(labelText: "Days open"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.sitePotential,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Site Potential"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.department,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
            FormFieldStyle.buildInputDecoration(labelText: "Department*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: updateServiceRequestController.requestType,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
            FormFieldStyle.buildInputDecoration(labelText: "Request Type*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.requestSubType,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Request Sub-type*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: updateServiceRequestController.customerType,
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
            FormFieldStyle.buildInputDecoration(labelText: "Customer Type"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: updateServiceRequestController.severity,
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
            FormFieldStyle.buildInputDecoration(labelText: "Severity"),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: updateServiceRequestController.customerID,
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
            FormFieldStyle.buildInputDecoration(labelText: "Customer ID*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.requestorContact,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Requestor Contact*"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.requestorName,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(
                labelText: "Requestor Name"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            style: FormFieldStyle.formFieldTextStyle,
            maxLines: 4,
            controller: updateServiceRequestController.description,
            decoration:
            FormFieldStyle.buildInputDecoration(labelText: "Description"),
          ),

          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.state,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(labelText: "State"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.district,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
            FormFieldStyle.buildInputDecoration(labelText: "District"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.taluk,
            style: FormFieldStyle.formFieldTextStyle,
            decoration: FormFieldStyle.buildInputDecoration(labelText: "Taluk"),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            controller: updateServiceRequestController.pin,
            style: FormFieldStyle.formFieldTextStyle,
            decoration:
            FormFieldStyle.buildInputDecoration(labelText: "Pincode"),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}