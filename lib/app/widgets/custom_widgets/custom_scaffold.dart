import 'package:easybill_app/app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_text_style.dart';
import '../../constants/themes.dart';

class EBCustomScaffold extends StatelessWidget {
  const EBCustomScaffold(
      {super.key,
      this.body,
      this.bottomNavBar,
      this.bottomSheet,
      this.noDrawer,
      this.resizeToAvoidBottomInset = true,
      this.trailingIconNeeded = false,
      this.trailingIcon, 
      this.trailingIconOnPressed, 
      this.actionWidget,  this.actionWidgetList});

  final Widget? body, bottomNavBar, bottomSheet , actionWidget ;
  final List<Widget>? actionWidgetList;
  final bool? noDrawer, resizeToAvoidBottomInset, trailingIconNeeded;
  final IconData? trailingIcon;
  final VoidCallback? trailingIconOnPressed;

  @override
  Widget build(BuildContext context) {
    if (noDrawer == true) {
      return Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            iconTheme: const IconThemeData(
              color: EBTheme.kPrimaryWhiteColor, // Change the color here
            ),
            title: Text(
              'Easy Bill',
              style: EBAppTextStyle.appBarTxt,
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar colorrrr
              statusBarColor: EBTheme.kPrintBtnColor,
            ),
            centerTitle: true,
            backgroundColor: EBTheme.kPrintBtnColor,
            elevation: 0,
            actions:  
            [
             actionWidget ?? Container(),
             ...actionWidgetList?? [],
              // Visibility(
              //   visible: trailingIconNeeded!,
              //   child: IconButton(
              //     onPressed: trailingIconOnPressed,
              //     icon:  Icon(trailingIcon),
              //   ),
              // ),
            ],
          ),
        ),
        body: body,
        bottomNavigationBar: bottomNavBar,
        bottomSheet: bottomSheet,
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            iconTheme: const IconThemeData(
              color: EBTheme.kPrimaryWhiteColor, // Change the color here
            ),
            title: Text(
              'Easy Bill',
              style: EBAppTextStyle.appBarTxt,
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar colorrrr
              statusBarColor: EBTheme.kPrintBtnColor,
            ),
            actions:  
            [
             actionWidget ?? Container(),
             ...actionWidgetList?? [],
              // Visibility(
              //   visible: trailingIconNeeded!,
              //   child: IconButton(
              //     onPressed: trailingIconOnPressed,
              //     icon:  Icon(trailingIcon),
              //   ),
              // ),
            ],
            centerTitle: true,
            backgroundColor: EBTheme.kPrintBtnColor,
            elevation: 0,
          ),
        ),
        drawer: const EBAppDrawer(),
        body: body,
        bottomNavigationBar: bottomNavBar,
        bottomSheet: bottomSheet,
      );
    }
  }
}
