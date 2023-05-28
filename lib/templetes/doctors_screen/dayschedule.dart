import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../core/size_configuration.dart';

class DaysSchedule extends StatefulWidget {
  const DaysSchedule({super.key});

  @override
  State<DaysSchedule> createState() => _DaysScheduleState();
}

class _DaysScheduleState extends State<DaysSchedule> {
  List DropDownListData = [
    {"title": "Monday", "value": "1"},
    {"title": "Tuesday", "value": "2"},
    {"title": "Wednesday", "value": "3"},
    {"title": "Thursday", "value": "4"},
    {"title": "Friday", "value": "5"},
    {"title": "Saturday", "value": "6"},
    {"title": "Sunday", "value": "7"},
  ];
  String defaultValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              InputDecorator(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    contentPadding: EdgeInsets.all(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isDense: true,
                    isExpanded: true,
                    value: defaultValue,
                    items: [
                      DropdownMenuItem(
                        child: Text('Select Category'),
                        value: "",
                      ),
                      ...DropDownListData.map<DropdownMenuItem<String>>((data) {
                        return DropdownMenuItem(
                            child: Text(data['title']), value: data['value']);
                      }).toList(),
                    ],
                    onChanged: (value) {
                      print("selected Value $value");

                      setState(() {
                        defaultValue = value!;
                      });
                    },
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
