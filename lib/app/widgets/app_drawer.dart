import 'package:easybill_app/app/constants/bools.dart';
import 'package:easybill_app/app/data/api/local_storage.dart';
import 'package:easybill_app/app/data/models/login.dart';
import 'package:easybill_app/app/data/repositories/auth_repository.dart';
import 'package:easybill_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_string.dart';
import '../constants/app_text_style.dart';
import '../constants/size_config.dart';
import '../constants/themes.dart';
import 'custom_widgets/custom_elevated_button.dart';
import 'custom_widgets/custom_list_tile.dart';

class EBAppDrawer extends StatelessWidget {
  const EBAppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    final authRepo = AuthRepo();
    Login login =
        Login(usercredentialsid: int.tryParse(LocalStorage.usercredentialsid!));
    return EBBools.triggeredFromStaff
        // Cashier Drawer
        ? Drawer(
            backgroundColor: EBTheme.kPrimaryWhiteColor,
            child: ListView(
              padding: EBSizeConfig.edgeInsetsOnlyH70,
              children: [
                EBCustomListTile(
                  leading: const Icon(
                    Icons.menu,
                    size: 40,
                  ),
                  titleName: EBAppString.orderPlace,
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.CASHIER_BILLS);
                  },
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.cancel_presentation,
                    size: 40,
                  ),
                  titleName: EBAppString.billWiseReport,
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      Routes.BILL_WISE_REPORT,
                      arguments: {"billWiseDecisionKey": 0},
                    );
                  },
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.cancel_presentation,
                    size: 40,
                  ),
                  titleName: EBAppString.changePaymentMode,
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      Routes.BILL_WISE_REPORT,
                      arguments: {"billWiseDecisionKey": -1},
                    );
                  },
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.cancel_outlined,
                    size: 40,
                  ),
                  titleName: EBAppString.cancleBill,
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      Routes.BILL_WISE_REPORT,
                      arguments: {"billWiseDecisionKey": 4},
                    );
                  },
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.person_outline_sharp,
                    size: 40,
                  ),
                  // Image.asset(
                  //   color: Colors.black54,
                  //   EBAppString.profileImg,
                  // ),
                  titleName: EBAppString.profile,
                  onTap: () {
                    Get.toNamed(Routes.CASHIER_PROFILE);
                  },
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.help_outline_outlined,
                    size: 40,
                  ),
                  titleName: EBAppString.help,
                  onTap: () {
                    Get.toNamed(Routes.CASIER_HELP);
                  },
                ),
                EBSizeConfig.sizeBoxH(height: 80),
                Padding(
                  padding: EBSizeConfig.edgeInsetsOnlyW50,
                  child: CustomElevatedButton(
                    isDefaultWidth: true,
                    btnColor: EBTheme.kCancelBtnColor,
                    onPressed: () async {
                      await authRepo.logOut(login);
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: Text(
                      EBAppString.signOut,
                      style: EBAppTextStyle.button,
                    ),
                  ),
                )
              ],
            ),
          )
        // Admin Drawer
        : Drawer(
            backgroundColor: EBTheme.kPrimaryWhiteColor,
            child: ListView(
              padding: EBSizeConfig.edgeInsetsOnlyH70,
              children: [
                EBCustomListTile(
                  leading: const Icon(
                    Icons.file_copy_outlined,
                    size: 40,
                  ),
                  titleName: EBAppString.dayEndReport,
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.DAY_END_REPORT);
                  },
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.factory_outlined,
                    size: 40,
                  ),
                  titleName: EBAppString.inventoryStocks,
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.INVENTORY);
                  },
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.person_add,
                    size: 40,
                  ),
                  titleName: EBAppString.staff,
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.CASHIERS);
                  },
                ),
                ExpansionTile(
                  leading: const Icon(
                    Icons.report_gmailerrorred,
                    size: 40,
                  ),
                  title: Text(
                    EBAppString.report,
                    style: EBAppTextStyle.bodyText,
                  ),
                  children: [
                    EBCustomListTile(
                      leading: const Icon(
                        Icons.cancel_presentation,
                        size: 40,
                      ),
                      titleName: EBAppString.billWiseReport,
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                          Routes.BILL_WISE_REPORT,
                          arguments: {"billWiseDecisionKey": 0},
                        );
                      },
                    ),
                    EBCustomListTile(
                      leading: const Icon(
                        Icons.cancel_presentation,
                        size: 40,
                      ),
                      titleName: EBAppString.changePaymentMode,
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                          Routes.BILL_WISE_REPORT,
                          arguments: {"billWiseDecisionKey": -1},
                        );
                      },
                    ),
                    EBCustomListTile(
                      leading: const Icon(
                        Icons.cancel_presentation,
                        size: 40,
                      ),
                      titleName: EBAppString.productWiseReport,
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                          Routes.ADMIN_REPORT,
                          arguments: {"otherReportsDecisionKey": 1},
                        );
                      },
                    ),
                    EBCustomListTile(
                      leading: const Icon(
                        Icons.cancel_presentation,
                        size: 40,
                      ),
                      titleName: EBAppString.staffWiseReport,
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                          Routes.ADMIN_REPORT,
                          arguments: {"otherReportsDecisionKey": 2},
                        );
                      },
                    ),
                    EBCustomListTile(
                      leading: const Icon(
                        Icons.cancel_outlined,
                        size: 40,
                      ),
                      titleName: EBAppString.cancleBill,
                      onTap: () {
                        Get.back();
                        Get.toNamed(
                          Routes.BILL_WISE_REPORT,
                          arguments: {"billWiseDecisionKey": 4},
                        );
                      },
                    ),
                    // EBCustomListTile(
                    //   leading: const Icon(
                    //     Icons.cancel_outlined,
                    //     size: 40,
                    //   ),
                    //   titleName: EBAppString.cancleBill,
                    //   onTap: () {
                    //     Get.back();
                    //     Get.toNamed(
                    //       Routes.ADMIN_REPORT,
                    //       arguments: {"otherReportsDecisionKey": 3},
                    //     );
                    //   },
                    // ),
                  ],
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.settings,
                    size: 40,
                  ),
                  titleName: EBAppString.setting,
                  onTap: () {
                    Get.back();
                    Get.toNamed(Routes.ADMIN_SETTINGS);
                  },
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.person_outline_sharp,
                    size: 40,
                  ),
                  // Image.asset(
                  //   color: Colors.black54,
                  //   EBAppString.profileImg,
                  // ),
                  titleName: EBAppString.profile,
                  onTap: () {
                    Get.toNamed(Routes.ADMIN_PROFILE);
                  },
                ),
                EBCustomListTile(
                  leading: const Icon(
                    Icons.help_outline_outlined,
                    size: 40,
                  ),
                  titleName: EBAppString.help,
                  onTap: () {
                    Get.toNamed(Routes.ADMIN_HELP);
                  },
                ),
                EBSizeConfig.sizeBoxH(height: 80),
                Padding(
                  padding: EBSizeConfig.edgeInsetsOnlyW50,
                  child: CustomElevatedButton(
                    isDefaultWidth: true,
                    btnColor: EBTheme.kCancelBtnColor,
                    onPressed: () async {
                      await authRepo.logOut(login);
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: Text(
                      EBAppString.signOut,
                      style: EBAppTextStyle.button,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}



// Drawer(
//             backgroundColor: const Color.fromARGB(255, 226, 39, 39),
//             child: ListView(
//               padding: EBSizeConfig.edgeInsetsOnlyH70,
//               children: [
//                 EBCustomListTile(
//                   leading: const Icon(
//                     Icons.factory_outlined,
//                     size: 40,
//                   ),
//                   titleName: EBAppString.inventoryStocks,
//                   onTap: () {
//                     Get.back();
//                     Get.toNamed(Routes.INVENTORY);
//                   },
//                 ),
//                 EBCustomListTile(
//                   leading: const Icon(
//                     Icons.menu,
//                     size: 40,
//                   ),
//                   titleName: EBAppString.orderPlace,
//                   onTap: () {
//                     Get.back();
//                     Get.toNamed(Routes.CASHIER_BILLS);
//                   },
//                 ),
//                 EBCustomListTile(
//                   leading: const Icon(
//                     Icons.person_add,
//                     size: 40,
//                   ),
//                   titleName: EBAppString.staff,
//                   onTap: () {
//                     Get.back();
//                     Get.toNamed(Routes.CASHIERS);
//                   },
//                 ),
//                 ExpansionTile(
//                   leading: const Icon(
//                     Icons.report_gmailerrorred,
//                     size: 40,
//                   ),
//                   title: Text(
//                     EBAppString.report,
//                     style: EBAppTextStyle.bodyText,
//                   ),
//                   children: [
//                     EBCustomListTile(
//                       leading: const Icon(
//                         Icons.content_paste_search_rounded,
//                         size: 40,
//                       ),
//                       titleName: EBAppString.overView,
//                       onTap: () {
//                         // Get.to(() => const OverViewScreen());
//                       },
//                     ),
//                     EBCustomListTile(
//                       leading: const Icon(
//                         Icons.cancel_presentation,
//                         size: 40,
//                       ),
//                       titleName: EBAppString.cancleReport,
//                       onTap: () {
//                         // Get.to(() => const CancleReportScreen());
//                       },
//                     ),
//                     EBCustomListTile(
//                       leading: const Icon(
//                         Icons.cancel_presentation,
//                         size: 40,
//                       ),
//                       titleName: EBAppString.billWiseReport,
//                       onTap: () {
//                         //  Get.toNamed(Routes.ADMIN_SETTINGS);
//                       },
//                     ),
//                     EBCustomListTile(
//                       leading: const Icon(
//                         Icons.cancel_presentation,
//                         size: 40,
//                       ),
//                       titleName: EBAppString.productWiseReport,
//                       onTap: () {
//                         //  Get.toNamed(Routes.ADMIN_SETTINGS);
//                       },
//                     ),
//                     EBCustomListTile(
//                       leading: const Icon(
//                         Icons.cancel_presentation,
//                         size: 40,
//                       ),
//                       titleName: EBAppString.staffWiseReport,
//                       onTap: () {
//                         // Get.toNamed(Routes.ADMIN_SETTINGS);
//                       },
//                     ),
//                   ],
//                 ),
//                 EBCustomListTile(
//                   leading: const Icon(
//                     Icons.cancel_outlined,
//                     size: 40,
//                   ),
//                   titleName: EBAppString.cancleBill,
//                   onTap: () {
//                     // Get.toNamed(Routes.ADMIN_SETTINGS);
//                   },
//                 ),
//                 EBCustomListTile(
//                   leading: const Icon(
//                     Icons.settings,
//                     size: 40,
//                   ),
//                   titleName: EBAppString.setting,
//                   onTap: () {
//                     Get.back();
//                     Get.toNamed(Routes.ADMIN_SETTINGS);
//                   },
//                 ),
//                 EBCustomListTile(
//                   leading: const Icon(
//                     Icons.person_outline_sharp,
//                     size: 40,
//                   ),
//                   // Image.asset(
//                   //   color: Colors.black54,
//                   //   EBAppString.profileImg,
//                   // ),
//                   titleName: EBAppString.profile,
//                   onTap: () {
//                     // Get.toNamed(Routes.ADMIN_SETTINGS);
//                   },
//                 ),
//                 EBCustomListTile(
//                   leading: const Icon(
//                     Icons.help_outline_outlined,
//                     size: 40,
//                   ),
//                   titleName: EBAppString.help,
//                   onTap: () {
//                     //  Get.toNamed(Routes.ADMIN_SETTINGS);
//                   },
//                 ),
//                 EBSizeConfig.sizeBoxH(height: 80),
//                 Padding(
//                   padding: EBSizeConfig.edgeInsetsOnlyW50,
//                   child: CustomElevatedButton(
//                     isDefaultWidth: true,
//                     btnColor: EBTheme.kCancelBtnColor,
//                     onPressed: () {},
//                     child: Text(
//                       EBAppString.signOut,
//                       style: EBAppTextStyle.button,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )




