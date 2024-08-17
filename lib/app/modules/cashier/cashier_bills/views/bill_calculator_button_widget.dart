// import 'package:flutter/material.dart';

// class CalculatorButton extends StatelessWidget {
//   final String? text;
//   final Icon? icon;

//   const CalculatorButton({super.key, this.text, this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         // Handle button tap
//       },
//       child: text == null && icon == null
//           ? Container(
//               height: 200,
//               margin: const EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: const Center(
//                 child: Text(
//                   '''Add''',
//                   style: TextStyle(fontSize: 24.0),
//                 ),
//               ),
//             )
//           : Container(
//               margin: const EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Center(
//                 child: icon ??
//                     Text(
//                       text!,
//                       style: const TextStyle(fontSize: 24.0),
//                     ),
//               ),
//             ),
//     );
//   }
// }

import 'dart:ffi';

import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/constants/app_text_style.dart';
import 'package:easybill_app/app/constants/size_config.dart';
import 'package:easybill_app/app/constants/themes.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_container.dart';
import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String? btnText;
  final Icon? btnIcon;
  final Color? btnColor;
  final bool? isAddItemBtn;
  final GestureTapCallback? onButtonPressed;
  final double? aspectRatio;

  const CalculatorButton({
    super.key,
    this.btnText,
    this.btnIcon,
    this.isAddItemBtn,
    this.onButtonPressed,
    this.btnColor,
    this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    EBSizeConfig.init(context);
    return isAddItemBtn == true
        ? GestureDetector(
            onTap: onButtonPressed,
            child: AspectRatio(
              aspectRatio: 2 / 4.6,
              child: CustomContainer(
                noHeight: true,
                // height:   EBSizeConfig.screenWidth > 900 ? 162 : Responsive.isTablet(context) == true ?  348 : 210,
                color: EBTheme.kPrintBtnColor,
                child: Center(
                  child: Text(
                    EBAppString.addItems,
                    textAlign: TextAlign.center,
                    style: EBAppTextStyle.customeTextStyle(
                        color: EBTheme.kPrimaryWhiteColor,
                        fontSize: 17,),
                  ),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: onButtonPressed,
            child: AspectRatio(
              aspectRatio: aspectRatio ?? 1,
              child: CustomContainer(
                noHeight: true,
                //     height: EBSizeConfig.screenWidth > 900 ? 75 : Responsive.isTablet(context) == true ? 168: 100,
                color: btnColor ?? EBTheme.listColor,
                child: Center(
                  child: btnIcon ??
                      Text(
                        btnText!,
                        style: EBAppTextStyle.customeTextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeigh: FontWeight.w600),
                      ),
                ),
              ),
            ),
          );
  }
}
