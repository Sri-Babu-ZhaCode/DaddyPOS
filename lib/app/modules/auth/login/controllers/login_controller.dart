// ignore_for_file: unnecessary_overrides, avoid_print
import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/widgets/set_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../constants/bools.dart';
import '../../../../constants/utils.dart';
import '../../../../data/api/local_storage.dart';
import '../../../../data/models/login.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_widgets/custom_snackbar.dart';

class LoginController extends GetxController {
  TextEditingController mobileController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController staffMobileController = TextEditingController();
  TextEditingController staffPwdController = TextEditingController();

  final AuthRepo _authRepo = AuthRepo();
  List<Login>? loginList;

  bool isStaffTabTapped = false;
  bool pwdVisibility = false;
  bool aMobileFlag = false;
  bool aPwdFlag = false;
  bool sMobileFlag = false;
  bool sPwdFlag = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int? tappedIndex;

  @override
  void onInit() {
    print('Login init called --------------->>');
    super.onInit();
    EBBools.isLoading = false;
    getDeviceInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    //   mobileController.dispose();
    // pwdController.dispose();
    // staffPwdController.dispose();
    // staffMobileController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      EBBools.isLoading = true;
      update();
      final login = Login(
        loginmobilenumber: isStaffTabTapped
            ? staffMobileController.text.trim()
            : mobileController.text.trim(),
        userpassword: isStaffTabTapped
            ? staffPwdController.text.trim()
            : pwdController.text.trim(),
        userrole: isStaffTabTapped ? 'Staff' : 'Admin',
        loggedindeviceid: deviceID,
        loggedindevicename: deviceName,
      );
      final res = await _authRepo.login(login);
      loginList = res;

      int? userRegiserId = loginList?[0].userregistrationid;
      int? usercredentialsid = loginList?[0].usercredentialsid;
      if (userRegiserId != null) {
        LocalStorage.writeUserLoginId(usercredentialsid.toString());
        print(
            "user credentials Id --------->> : ${await LocalStorage.getUserLoginId()}");
        LocalStorage.writeUserId(userRegiserId.toString());
        print(
            "User register id -------->> : ${await LocalStorage.getUserId()}");
      }

      if (res != null) {
        if (res[0].gst != null) {
          EBBools.isTaxNeeded = res[0].gst!;

          EBAppString.loginmobilenumber = mobileController.text;
        }
        for (var element in res) {
          // common fileds
          EBAppString.productlanguage = element.productlanguage;
          EBAppString.businessName = element.businessname;
          EBAppString.businessMobile = element.loginmobilenumber;
          EBAppString.businessEmail = element.email;
          EBAppString.businessEmail = element.email;
          EBAppString.userRole = element.userrole;

          if (element.userrole == 'Staff') {
            print('staff login --------->>  ');
            print(element.userrole);
            print(element.username);
            print(element.userpassword);
            print(element.loginmobilenumber);
            if (element.screenaccess != null) {
              EBAppString.screenAccessList = [...element.screenaccess!];
              for (var screens in element.screenaccess!) {
                print('screens ------->> $screens');
              }
            }

            print(
                "product language ------------------------------------------------------------------>>  ${element.productlanguage}");
          } else {
            print('Admin login --------->>  ');
            print(element.userrole);
            print(element.username);
            print(element.userpassword);
            print(element.loginmobilenumber);
            print(element.businessname);
            print(element.email);
            print(element.gst);
            print(element.gstnumber);
            print(element.loggedindevicename);
            if (element.screenaccess != null) {
              EBAppString.screenAccessList = [...element.screenaccess!];
              for (var screens in element.screenaccess!) {
                print('screens ------->> $screens');
              }
            }
            print(
                "product language ------------------------------------------------------------------>>  ${element.productlanguage}");
          }
        }
        routingForLogin(res);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      aPwdFlag = false;
      sPwdFlag = false;
      aMobileFlag = false;
      sMobileFlag = false;
      update();
      debugPrint(
          ' finally executed ------------------>>  ${EBBools.isLoading}');
    }
  }

  void routingForLogin(List<Login>? userList) {
    if (userList == null) return;
    int decisionKey = userList[0].decisionkey!;
    switch (decisionKey) {
      case 0:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('Not Registered');
        Get.toNamed(Routes.REGISTER);
        break;
      case 1:
        debugPrint('decision key --------------->>  $decisionKey');

        if (isStaffTabTapped) {
          EBBools.triggeredFromStaff = isStaffTabTapped;
          Get.offAllNamed(Routes.CASHIER_BILLS);
        } else {
          EBBools.triggeredFromStaff = isStaffTabTapped;
          Get.offAllNamed(Routes.DAY_END_REPORT);
        }
        break;
      case 2:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('No subscription');
        Get.toNamed(Routes.SUBSCRIPTION);

        break;
      case 3:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('Invalid credentials');
        break;
      case 4:
        debugPrint('decision key --------------->>  $decisionKey');
        SetPasswordAlertDialog.setPasswordAlertDialof(
            formKey: GlobalKey<FormState>(),
            loginMobileNum: mobileController.text,
            triggeredFromLogin: true);
        EBCustomSnackbar.show('Create password');
        break;
      case 5:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('Subscription expired');
        break;
      case 6:
        debugPrint('decision key --------------->>  $decisionKey');
        debugPrint(
            'credencials id--------------->>  ${userList[0].usercredentialsid}');
        debugPrint(
            'registeration id--------------->>  ${userList[0].userregistrationid}');
        debugPrint('decision key --------------->>  $decisionKey');
        // logout form all devices in here

        Get.toNamed(Routes.LOGOUT);
        // EBCustomSnackbar.show('${EBAppString.responseMsg}');
        break;
      case 7:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('Contact adminstrator');
        break;
      default:
        debugPrint('decision key --------------->>  $decisionKey');
        print('Something went Wrong No decision key matches');
        break;
    }
  }

// ------------------------------------------------------------------
  void loginPressed({String? pwd}) {
    print(
        'Local storage User register id -------------->>  ${LocalStorage.registeredUserId}');
    if ((aMobileFlag && aPwdFlag) || (sMobileFlag && sPwdFlag)) {
      if (pwd != null) {
        setPassword(pwd);
      } else {
        login();
      }
    }
  }

  String? validateMobile(String value) {
    if (value.trim().length != 10) {
      return 'Mobile number must be of 10 digit';
    }
    aMobileFlag = true;
    sMobileFlag = true;
    return null;
  }

  String? validateIsEmpty(String value) {
    if (value.trim().isEmpty) {
      return 'This field is required';
    }
    aPwdFlag = true;
    sPwdFlag = true;
    return null;
  }

  Future<void> setPassword(String pwd) async {
    print('setPassword api called--------->>  ');
    try {
      final login = Login(
        userpassword: pwd,
      );
      final res = await _authRepo.setPassword(login);

      print('------------------------->> result  : $res');
      print('setPassword mehtod ended--------->>  ');
      navigationForSettingPwd(res);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void navigationForSettingPwd(List<Login>? login) {
    if (login == null) return;
    int decisionKey = login[0].decisionkey!;
    switch (decisionKey) {
      case 0:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('Not Registered');
        Get.toNamed(Routes.REGISTER);
        break;
      case 1:
        debugPrint('decision key --------------->>  $decisionKey');
        Get.offAllNamed(Routes.LOGIN);
        break;
      case 2:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('No subscription');
        Get.toNamed(Routes.SUBSCRIPTION);
        break;
      case 3:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('Password already created');
        break;
      default:
        debugPrint('decision key --------------->>  $decisionKey');
        debugPrint('Some this went wrong  ------------------??  ');
        // Handle unexpected values
        break;
    }
  }

  void onTabChanged(int index) {
    // if(tappedIndex != index){
    print('form key updated ====================>>  ');

    // }
    //formKey = GlobalKey<FormState>();

    if (index == 1) {
      mobileController.clear();
      pwdController.clear();
      // formKey.currentState?.reset();

      isStaffTabTapped = true;
    }

    if (index == 0) {
      staffMobileController.clear();
      staffPwdController.clear();
      //formKey.currentState?.reset();
      //  formKey.currentState?.reset();
      isStaffTabTapped = false;
    }
    //  formKey.currentState?.reset();
  }

  changePwdVisibility() {
    pwdVisibility = !pwdVisibility;
    update();
  }
}
