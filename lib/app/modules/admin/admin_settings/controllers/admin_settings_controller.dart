// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:easybill_app/app/constants/app_string.dart';
import 'package:easybill_app/app/data/repositories/setting_repo.dart';
import 'package:easybill_app/app/widgets/custom_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../constants/bools.dart';
import '../../../../data/models/setting.dart';

class AdminSettingsController extends GetxController {
  File? imageFile;
  Uint8List? compressedBytes;
  String? imageInBytes;
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController mobilController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController currenctSymbleContoller = TextEditingController();
  TextEditingController footerController = TextEditingController();

  final _settingsRepo = SettingsRepo();
  List<Setting>? settingsList;

  List<String> printerSizeList = ['80MM (3 inch)', '52MM (2 inch)'];
  List<String> languageList = ['English', 'Others'];
  List<int> timeinterval = [];
  late String selectedPrinterSize;
  late String selectedLanguage;
  late String settimeinterval;
  bool? isEmail,
      isMobile,
      isGst,
      isFooter,
      isWhatsapp,
      isBusinessName,
      isAddress;

  bool readOnly = true, gstFlag = true;

  String printVia = 'bluetooth';

  @override
  void onInit() {
    super.onInit();
    selectedLanguage = languageList[0];
    selectedPrinterSize = printerSizeList[0];
    getSetting();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> imgPickerFromGallery() async {
    try {
      final ImagePicker imgPicker = ImagePicker();
      final XFile? pickedFile = await imgPicker.pickImage(
        source: ImageSource.gallery, // Start with the highest quality
      );

      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        imageInBytes = null;
        EBBools.isImageSelected = true;
        update();

        Uint8List imageBytes = await imageFile!.readAsBytes();
        debugPrint('image bytes --------->>  ');
        debugPrint(imageBytes.toString());

        // Decode the image
        img.Image originalImage = img.decodeImage(imageBytes)!;

        // Resize the image to 512x512 pixels
        img.Image resizedImage =
            img.copyResize(originalImage, width: 512, height: 512);

        // Compress the image to under 100KB
        int quality = 100;
        Uint8List compressedBytes =
            Uint8List.fromList(img.encodeJpg(resizedImage, quality: quality));

        while (compressedBytes.lengthInBytes > 100 * 1024 && quality > 10) {
          quality -= 10;
          compressedBytes =
              Uint8List.fromList(img.encodeJpg(resizedImage, quality: quality));
        }

        // Save the compressed image to the temporary directory
        final tempDir = await getTemporaryDirectory();
        final compressedImagePath = '${tempDir.path}/${getPathName()}.jpg';
        File compressedImageFile = File(compressedImagePath);
        debugPrint('Compressed image file : $compressedImageFile');
        imageInBytes = base64Encode(compressedBytes);
        imageFile = await compressedImageFile.writeAsBytes(compressedBytes);

        debugPrint('Compressed image saved at: $compressedImagePath');
        debugPrint('image saved at: $imageFile');
      }
    } catch (e) {
      var status = await Permission.photos.status;
      if (status.isDenied || status.isPermanentlyDenied) {
        openAppSettings();
      } else {
        debugPrint('<<---------- erroe occured -------->> $e');
      }
    } finally {
      EBBools.isImageSelected = false;
      update();
    }

    // final Directory tempDir = await getTemporaryDirectory();

    // FlutterImageCompress.compressAndGetFile(
    //     tempDir.path, '${DateTime.now().millisecondsSinceEpoch}.jpg',
    //     quality: 10 * 1024, minWidth: 512, minHeight: 512);
  }

  Future<void> getSetting() async {
    try {
      EBBools.isLoading = true;
      final settings = await _settingsRepo.getSettings();
      storeSettingsData(settings);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }

  Future<void> updateSetings() async {
    try {
      Setting setting = Setting(
          // image tod
          businesslogo: imageInBytes,
          businessname: businessNameController.text,
          businessaddress: businessAddressController.text,
          businessmobile: mobilController.text,
          businessemail: emailController.text,
          footer: footerController.text,
          //--------------->> todo choosed
          // printername: '',
          // printeraddress: '',
          printersize: selectedPrinterSize,
          language: selectedLanguage,
          emailenable: isEmail,
          mobileenable: isMobile,
          gstenable: isGst,
          footerenable: isFooter,
          addressenable: isAddress,
          nameenable: isBusinessName,
          usb: printVia == EBAppString.bluetooth.toLowerCase() ? false : true,
          bluetooth:
              printVia == EBAppString.bluetooth.toLowerCase() ? true : false,
          whatsappenable: isWhatsapp,
          settimeinterval: settimeinterval);
      EBBools.isLoading = true;
      readOnly = true;
      update();
      final settings = await _settingsRepo.editSettings(setting);
      storeSettingsData(settings);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      EBBools.isLoading = false;
      update();
    }
  }

  String getPathName() {
    const characters =
        'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      9,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }

  void onUpdatePressed() {
    updateSetings();
  }

  void onTapOfUnEditable() {
    debugPrint('onTapOfUnEditable method called ------>. ');

    ebCustomTtoastMsg(message: 'This Field Can\'t be edited');
  }

  void storeSettingsData(List<Setting>? settings) {
    if (settings != null) {
      for (var data in settings) {
        imageInBytes = data.businesslogo;
        businessNameController.text = data.businessname ?? "";
        businessAddressController.text = data.businessaddress ?? "";
        mobilController.text = data.businessmobile ?? "";
        emailController.text = data.businessemail ?? "";
        gstController.text = data.gst ?? "";
        gstFlag = data.gst == null || data.gst!.isEmpty ? false : true;
        footerController.text = data.footer ?? "";
        selectedPrinterSize =
            data.printersize == null || data.printersize!.isEmpty
                ? selectedPrinterSize
                : data.printersize!;
        selectedLanguage = data.language == null || data.language!.isEmpty
            ? selectedLanguage
            : data.language!;
        timeinterval = data.timeinterval!;
        // todp part -------------------------->>
        settimeinterval =
            data.settimeinterval == null || data.settimeinterval!.isEmpty
                ? data.timeinterval![0].toString()
                : data.settimeinterval!;

        isGst = data.gstenable ?? false;
        isMobile = data.mobileenable ?? false;
        isEmail = data.emailenable ?? false;
        isFooter = data.footerenable ?? false;
        isWhatsapp = data.whatsappenable ?? false;
        isBusinessName = data.nameenable ?? false;
        isAddress = data.addressenable ?? false;
        printVia = data.bluetooth == true
            ? EBAppString.bluetooth.toLowerCase()
            : EBAppString.usb.toLowerCase();

        // updating product language to show it on Product list
        EBAppString.productlanguage = data.language;
        // storing set time intervel globally
        EBAppString.settimeinterval =
            data.settimeinterval == null || data.settimeinterval == ''
                ? '1'
                : data.settimeinterval;
      }
    }
  }
}
