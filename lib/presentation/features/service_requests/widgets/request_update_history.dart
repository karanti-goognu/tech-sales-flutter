

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:intl/intl.dart';

class RequestUpdateHistory extends StatefulWidget {
  final List<SrComplaintActionList>? srComplaintActionList;
  final updatedOn, requestStatus;
  RequestUpdateHistory({this.srComplaintActionList, this.updatedOn, this.requestStatus});
  @override
  _RequestUpdateHistoryState createState() => _RequestUpdateHistoryState();
}

class _RequestUpdateHistoryState extends State<RequestUpdateHistory> {
  List<bool> isExpanded = [false, false];

  @override
  Widget build(BuildContext context) {
    return
      widget.srComplaintActionList==null?
      Center(child: Text('No Data available'),):
      Column(
      children: [
        Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.srComplaintActionList!.length,
              itemBuilder: (context, index) {
                final DateFormat formatter = DateFormat('dd-MMM-yyyy');
                String selectedDateString = formatter.format(
                    DateTime.fromMillisecondsSinceEpoch(
                        widget.srComplaintActionList![index].createdOn!));
                List<TextEditingController> _commentList = List.generate(widget.srComplaintActionList!.length,
                    (index) => TextEditingController(text: widget.srComplaintActionList![index].comment));
                List<dynamic> _nextVisitDate = List.generate(
                    widget.srComplaintActionList!.length,
                    (index) => widget.srComplaintActionList![index].nextVisitDate);
                String visitDate = formatter.format(
                    DateTime.fromMillisecondsSinceEpoch(_nextVisitDate[index]));
                TextEditingController _visitDate =
                    TextEditingController(text: visitDate);
                return Theme(
                  data: ThemeData(splashColor: Colors.transparent,).copyWith(colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.black)),
                  child: ExpansionTile(
                    onExpansionChanged: (val) {
                      setState(() {
                        isExpanded[index] = val;
                      });
                    },
                    tilePadding: EdgeInsets.zero,
                    title: Text('Visit Date $selectedDateString'),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(
                            isExpanded[index] ? Icons.remove : Icons.add,
                            color: HexColor('#F9A61A'),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            isExpanded[index] == true ? 'COLLAPSE' : 'EXPAND',
                            style: TextStyle(
                              color: HexColor('#F9A61A'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      TextFormField(
                        maxLines: 4,
                        controller: _commentList[index],
                        readOnly: true,
                        maxLength: 500,
                        style: FormFieldStyle.formFieldTextStyle,
                        keyboardType: TextInputType.text,
                        decoration: FormFieldStyle.buildInputDecoration(
                            labelText: "Comment*"),
                      ),
                      TextFormField(
                        controller: _visitDate,
                        readOnly: true,
                        decoration: FormFieldStyle.buildInputDecoration(
                          labelText: 'Next Visit Date',
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
