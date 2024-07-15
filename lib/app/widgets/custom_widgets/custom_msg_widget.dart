import 'package:flutter/material.dart';

import '../../constants/app_text_style.dart';

Widget customMessageWidget({String? msg}) {
  return Expanded(
    child: Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            msg ?? 'No Reports Found',
            style: EBAppTextStyle.bodyText,
          ),
        ],
      ),
    ),
  );
}
