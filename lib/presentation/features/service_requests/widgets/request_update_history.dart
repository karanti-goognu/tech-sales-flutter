import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/styles/formfield_style.dart';
import 'package:flutter_tech_sales/widgets/datepicker.dart';

class RequestUpdateHistory extends StatefulWidget {
  @override
  _RequestUpdateHistoryState createState() => _RequestUpdateHistoryState();
}

class _RequestUpdateHistoryState extends State<RequestUpdateHistory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
              accentColor: Colors.black
          ),
          child: ExpansionTile(
            // onExpansionChanged: ,
            tilePadding: EdgeInsets.zero,
            title: Text('Visit Date 10-Nov-2020'),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  Icon(Icons.add, color: HexColor('#F9A61A')),
                  SizedBox(width: 2,),
                  Text(
                    'EXPAND',
                    style: TextStyle(color: HexColor('#F9A61A')),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              TextFormField(
                maxLines: 4,
                maxLength: 500,
              style: FormFieldStyle.formFieldTextStyle,
                keyboardType: TextInputType.text,
                decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Comment*"),
              ),
              TextFormField(
                readOnly: true,
                onTap: () => PickDate.selectDate(context),
                decoration: FormFieldStyle.buildInputDecoration(
                    labelText: 'Date and time',
                    suffixIcon: Icon(Icons.calendar_today_outlined, color: HexColor('#F6A902'),),),
              ),
              SizedBox(height: 16,)
            ],
          ),
        ),
        Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
            accentColor: Colors.black
          ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text('Visit Date 08-Nov-2020'),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  Icon(Icons.remove, color: HexColor('#F9A61A')),
                  SizedBox(width: 2,),
                  Text(
                    'COLLAPSE',
                    style: TextStyle(color: HexColor('#F9A61A')),
                  ),
                ],
              ),
            ),
            children: <Widget>[
              TextFormField(
                maxLines: 4,
                maxLength: 500,
                style: FormFieldStyle.formFieldTextStyle,
                keyboardType: TextInputType.text,
                decoration:
                FormFieldStyle.buildInputDecoration(labelText: "Comment*"),
              ),
              TextFormField(
                readOnly: true,
                onTap: () => PickDate.selectDate(context),
                decoration: FormFieldStyle.buildInputDecoration(
                    labelText: 'Date and time',
                    suffixIcon: Icon(Icons.calendar_today_outlined, color: HexColor('#F6A902'),),),
              ),
              SizedBox(height: 16,)
            ],
          ),
        ),
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
    );
  }

}
