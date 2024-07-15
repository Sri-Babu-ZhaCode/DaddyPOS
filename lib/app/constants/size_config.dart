import 'package:flutter/material.dart';

class EBSizeConfig {
  // variable declaration
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenWidthForEle;
  static late double screenHeight;
  static late double screenHeight6;
  static late double screenHeight5;
  static late double screenHeight3;
  static late double screenHeight10;
  static late double safeAreaHorizontal;
  static late double safeAreaVertical;
  static late Orientation orientation;

  static  MediaQueryData? mediaQueryData;


  // static late double safeBlockHorizontal;
//  static late double safeBlockVertical;
  // static late double _safeAreaHorizontal;
  // static late double _safeAreaVertical;

  // init method is static so no object creation is required
  static void init(BuildContext context) {
    //instantiate variables here
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    screenHeight6 = _mediaQueryData.size.height * 0.5 / 2;
    screenHeight3 = _mediaQueryData.size.height / 3.2;
    screenHeight10 = _mediaQueryData.size.height / 10;
    safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    screenWidthForEle = EBSizeConfig.screenWidth * 0.6;
    // safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    // safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  // Get the proportionate height as per screen size
  double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = EBSizeConfig.screenHeight;
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }

// Get the proportionate height as per screen size
  double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = EBSizeConfig.screenWidth;
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  }

  static const double logoHeight = 55.0;
  static const double logoWidth = 60.0;

  static const Size textButtonSize = Size(double.infinity, 40);

  static const sizedBox = SizedBox();

  static const sizedBoxH02 = SizedBox(height: 2);
  static const sizedBoxW02 = SizedBox(width: 2);
  static const sizedBoxH04 = SizedBox(height: 4);
  static const sizedBoxH06 = SizedBox(height: 6);
  static const sizedBoxW06 = SizedBox(width: 6);
  static const sizedBoxW04 = SizedBox(width: 4);
  static const sizedBoxH08 = SizedBox(height: 8);
  static const sizedBoxW08 = SizedBox(width: 8);
  static const sizedBoxH10 = SizedBox(height: 10);
  static const sizedBoxW10 = SizedBox(width: 10);
  static const sizedBoxH15 = SizedBox(height: 15);
  static const sizedBoxW15 = SizedBox(width: 15);
  static const sizedBoxH20 = SizedBox(height: 20);
  static const sizedBoxH30 = SizedBox(height: 30);
  static const sizedBoxW30 = SizedBox(width: 30);
  static const sizedBoxW20 = SizedBox(width: 20);
  static const sizedBoxH100 = SizedBox(height: 100);
  static const sizedBoxH200 = SizedBox(height: 200);
  static const sizedBoxW100 = SizedBox(width: 100);
  static const textFormConstrain = BoxConstraints(minHeight: 40, maxHeight: 40);
  static const textContentPadding =
      EdgeInsets.symmetric(vertical: 6, horizontal: 8);
  static const alertDialogContentPadding =
      EdgeInsets.symmetric(vertical: 20, horizontal: 12);

  static const sliverToBoxAdapSH10 = SliverToBoxAdapter(child: sizedBoxH10);
  static const sliverToBoxAdap = SliverToBoxAdapter(child: sizedBox);

  static const spacer = Spacer();
  static const divider = Divider();
  static const dividerTH2 = Divider(thickness: 2);
  static const sliverdividerTH2 =
      SliverToBoxAdapter(child: Divider(thickness: 2));

  static const sliverToBoxAdapterH08 =
      SliverToBoxAdapter(child: EBSizeConfig.sizedBoxH08);
  static const sliverToBoxAdapterH10 =
      SliverToBoxAdapter(child: EBSizeConfig.sizedBoxH10);
  static const sliverToBoxAdapterH20 =
      SliverToBoxAdapter(child: EBSizeConfig.sizedBoxH20);
  static SizedBox sizeBoxH({required double height}) {
    return SizedBox(height: height);
  }

  static SizedBox sizeBoxW({required double width}) {
    return SizedBox(width: width);
  }

  static SizedBox sizeBoxHW({required double height, required double width}) {
    return SizedBox(width: width, height: height);
  }

  //
  static const double defaultPadding = 16.0;

  static const edgeInsetsZero = EdgeInsets.zero;
  static const edgeInsetsAll02 = EdgeInsets.all(02);
  static const edgeInsetsCard =
      EdgeInsets.symmetric(horizontal: 20, vertical: 14);
  static const edgeInsetsActivities =
      EdgeInsets.symmetric(horizontal: 10, vertical: 4);
  static const edgeInsetsActivitiesDouble =
      EdgeInsets.symmetric(horizontal: 20, vertical: 8);
  static const edgeInsetsProfile =
      EdgeInsets.symmetric(horizontal: 10, vertical: 15);
  static const edgeInsetsAppBar =
      EdgeInsets.symmetric(vertical: 10, horizontal: 8);
  static const edgeInsetsAll04 = EdgeInsets.all(04);
  static const edgeInsetsAll06 = EdgeInsets.all(06);
  static const edgeInsetsAll08 = EdgeInsets.all(08);
  static const edgeInsetsAll10 = EdgeInsets.all(10);
  static const edgeInsetsAll15 = EdgeInsets.all(15);
  static const edgeInsetsAll18 = EdgeInsets.all(18);
  static const edgeInsetsAll20 = EdgeInsets.all(20);
  static const edgeInsetsAll25 = EdgeInsets.all(25);
  static const edgeInsetsAll30 = EdgeInsets.all(30);
  static const edgeInsetsAll35 = EdgeInsets.all(35);

  // Padding Vertical
  static const edgeInsetsOnlyH02 = EdgeInsets.symmetric(vertical: 02);
  static const edgeInsetsOnlyH04 = EdgeInsets.symmetric(vertical: 04);
  static const edgeInsetsOnlyH06 = EdgeInsets.symmetric(vertical: 06);
  static const edgeInsetsOnlyH08 = EdgeInsets.symmetric(vertical: 08);
  static const edgeInsetsOnlyH10 = EdgeInsets.symmetric(vertical: 10);
  static const edgeInsetsOnlyH15 = EdgeInsets.symmetric(vertical: 15);
  static const edgeInsetsOnlyH20 = EdgeInsets.symmetric(vertical: 20);
  static const edgeInsetsOnlyH30 = EdgeInsets.symmetric(vertical: 30);
  static const edgeInsetsOnlyH40 = EdgeInsets.symmetric(vertical: 40);
  static const edgeInsetsOnlyH50 = EdgeInsets.symmetric(vertical: 50);
  static const edgeInsetsOnlyH70 = EdgeInsets.symmetric(vertical: 70);
  static const edgeInsetsOnlyH100 = EdgeInsets.symmetric(vertical: 100);
  static const edgeInsetsOnlyH250 = EdgeInsets.symmetric(vertical: 250);

  // Padding Horizontal
  static const edgeInsetsOnlyW04 = EdgeInsets.symmetric(horizontal: 04);
  static const edgeInsetsOnlyW06 = EdgeInsets.symmetric(horizontal: 06);
  static const edgeInsetsOnlyW08 = EdgeInsets.symmetric(horizontal: 08);
  static const edgeInsetsOnlyW10 = EdgeInsets.symmetric(horizontal: 10);
  static const edgeInsetsOnlyW15 = EdgeInsets.symmetric(horizontal: 15);
  static const edgeInsetsOnlyW20 = EdgeInsets.symmetric(horizontal: 20);
  static const edgeInsetsOnlyW30 = EdgeInsets.symmetric(horizontal: 30);
  static const edgeInsetsOnlyW40 = EdgeInsets.symmetric(horizontal: 40);
  static const edgeInsetsOnlyW50 = EdgeInsets.symmetric(horizontal: 50);

  // Border Radius
  static final borderRadiusCircular04 = BorderRadius.circular(04);
  static final borderRadiusCircular05 = BorderRadius.circular(05);
  static final borderRadiusCircular08 = BorderRadius.circular(08);
  static final borderRadiusCircular10 = BorderRadius.circular(10);
  static final borderRadiusCircular12 = BorderRadius.circular(12);
  static final borderRadiusCircular15 = BorderRadius.circular(15);
  static final borderRadiusCircular20 = BorderRadius.circular(20);
  static final borderRadiusCircular25 = BorderRadius.circular(25);
  static final borderRadiusCircular30 = BorderRadius.circular(30);
  static final borderRadiusCircular40 = BorderRadius.circular(40);
  static final borderRadiusCircular50 = BorderRadius.circular(50);
  static final borderRadiusCircular200 = BorderRadius.circular(200);
  static const radiusCircular04 = Radius.circular(04);
  static const radiusCircular05 = Radius.circular(05);
  static const radiusCircular08 = Radius.circular(08);
  static const radiusCircular10 = Radius.circular(10);
  static const radiusCircular12 = Radius.circular(12);
  static const radiusCircular20 = Radius.circular(20);
  static const visualCardBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(20), topRight: Radius.circular(20));

  // Decoration Underline input border

  static final shapeBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));

  // static const edgeInsetsCircular04 = EdgeInsets.(04);
  // static const edgeInsetsCircular08 = EdgeInsets.Circular(08);
  // static const edgeInsetsCircular10 = EdgeInsets.Circular(10);
  // static const edgeInsetsCircular15 = EdgeInsets.Circular(15);
  // static const edgeInsetsCircular20 = EdgeInsets.Circular(20);
}
