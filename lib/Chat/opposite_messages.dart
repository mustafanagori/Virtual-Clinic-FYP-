import 'package:flutter/material.dart';

import '../core/size_configuration.dart';

// import '../../helper/size_configuration.dart';

class OppositeMessages extends StatelessWidget {
  const OppositeMessages({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 123, 178, 214),
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Text(
            overflow: TextOverflow.visible,
            softWrap: true,
            text,
            style: TextStyle(
              fontSize: setHeight(5 / 2),
            ),
          ),
        ),
      ],
    );
  }
}
