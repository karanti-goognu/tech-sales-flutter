import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/AddSrComplaintModel.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:get/get.dart';

class SRRequestSubTypeBottomSheet extends StatefulWidget {
  final srComplaintModel, customFunction, isComplaint;
  SRRequestSubTypeBottomSheet({this.srComplaintModel, this.customFunction, this.isComplaint});
  @override
  _SRRequestSubTypeBottomSheetState createState() =>
      _SRRequestSubTypeBottomSheetState();
}

class _SRRequestSubTypeBottomSheetState
    extends State<SRRequestSubTypeBottomSheet> {
  List<bool> checkedValues;
  // List<ServiceRequestComplaintTypeEntity> dataToBeSentBack = List<ServiceRequestComplaintTypeEntity>();
  ServiceRequestComplaintTypeEntity dataToBeSentBack ;

  @override
  void initState() {
    setState(() {
      checkedValues=List.generate(widget.srComplaintModel.serviceRequestComplaintTypeEntity.length, (index) => false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight / 1.5,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Request Sub-type*',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: () => Get.back(), icon: Icon(Icons.clear))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: FormFieldStyle.buildInputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  labelText: 'Search'),
            ),
          ),
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    activeColor: Colors.black,
                    dense: true,
                    title: Text(widget
                        .srComplaintModel
                        .serviceRequestComplaintTypeEntity[index]
                        .serviceRequestTypeText),
                    value: checkedValues[index],

                    onChanged: (newValue) {
                      // if (widget.isComplaint==false) {
                        if (!checkedValues.contains(true) ||
                            checkedValues[index] == true) {
                          setState(() {
                            checkedValues[index] = newValue;
                            // dataToBeSentBack.add(widget.srComplaintModel.serviceRequestComplaintTypeEntity[index]);
                            dataToBeSentBack=widget.srComplaintModel.serviceRequestComplaintTypeEntity[index];
                          });
                        } else {
                          Get.snackbar(
                            'Please uncheck the previous option',
                            '',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      // }
                      // else{
                      //   setState(() {
                      //     checkedValues[index] = newValue;
                      //     // dataToBeSentBack.add(widget.srComplaintModel.serviceRequestComplaintTypeEntity[index]);
                      //     dataToBeSentBack=widget.srComplaintModel.serviceRequestComplaintTypeEntity[index];
                      //   });
                      // }
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(),
                  );
                },
                itemCount: widget
                    .srComplaintModel.serviceRequestComplaintTypeEntity.length),
          ),
          Container(
            decoration:
            BoxDecoration(border: Border(top: BorderSide(width: 0.2))),
            padding: EdgeInsets.only(top: 24, bottom: 9, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Clear All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#F6A902'),
                  ),
                ),
                MaterialButton(
                  color: HexColor('#1C99D4'),
                  onPressed: () {
                    dataToBeSentBack != null
                        ? widget.customFunction(dataToBeSentBack)
                        : null;
                    Get.back();
                    // dataToBeSentBack.isEmpty
                    //     ? widget.customFunction(dataToBeSentBack)
                    //     : null;
                    // print(dataToBeSentBack);

                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
