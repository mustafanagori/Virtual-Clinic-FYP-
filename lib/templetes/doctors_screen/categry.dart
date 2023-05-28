import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../core/size_configuration.dart';

class CategryScreen extends StatefulWidget {
  const CategryScreen({super.key});

  @override
  State<CategryScreen> createState() => _CategryScreenState();
}

class _CategryScreenState extends State<CategryScreen> {
  List DropDownListData = [
    {"title": "Categry", "value": "1"},
    {"title": "Categry", "value": "2"},
    {"title": "Categry", "value": "3"},
    {"title": "Categry", "value": "4"},
    {"title": "Categry", "value": "5"},
  ];
  String defaultValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
                        child: Text('Select CAtegry'),
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
