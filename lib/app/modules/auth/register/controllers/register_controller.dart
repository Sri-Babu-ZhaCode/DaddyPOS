import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/data/repositories/auth_repository.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/utils.dart';
import '../../../../data/api/local_storage.dart';
import '../../../../data/models/user.dart';

class RegisterController extends GetxController {
  final businessController = TextEditingController();
  final addressController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final gstController = TextEditingController();

  final AuthRepo _authRepo = AuthRepo();
  List<User>? userList;

  int? userRegiserId;
  var isGstApplicable = false;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onRegisterButtonPressed() {
    if (formKey.currentState?.validate() == true) {
      userRegister();
      update();
    }
  }

  Future<void> userRegister() async {
    try {
      final user = User(
        businessname: businessController.text,
        devicename: deviceName,
        deviceuniqueid: deviceID,
        businessaddress: addressController.text,
        loginmobilenumber: mobileController.text,
        email: emailController.text,
        gst: isGstApplicable,
        gstnumber: gstController.text,
      );
      final res = await _authRepo.register(user);
      userList = res;
      print('user list ------->> $userList');
      userRegiserId = userList![0].userregistrationid;
      EBAppString.loginmobilenumber = userList![0].loginmobilenumber;
      print(
                'login mobile number  ---------------- >> ${EBAppString.loginmobilenumber}');
      print('userregister id-------------->>  $userRegiserId');
      LocalStorage.writeUserId(userRegiserId.toString());
      String? userId = await LocalStorage.getUserId();
      print('user id ------------>>  $userId');

      debugPrint(
          'Local storage User register id -------------->>  ${LocalStorage.registeredUserId}');
      navigationForRegister(userList);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void navigationForRegister(List<User>? userList) {
    if (userList == null) return;
    int decisionKey = userList[0].decisionkey!;
    switch (decisionKey) {
      case 1:
        EBCustomSnackbar.show('Registeration Success');
        Get.toNamed(Routes.SUBSCRIPTION);
        break;
      case 2:
        debugPrint('decision key --------------->>  $decisionKey');
        EBCustomSnackbar.show('Already registered login to continue');
        Get.offAllNamed(Routes.LOGIN);
        break;
      case 3:
        EBCustomSnackbar.show('Missing required fields');
        break;
      default:
        print('Something went Wrong No decision key matches');
        break;
    }
  }
}
