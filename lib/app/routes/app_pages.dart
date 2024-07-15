import 'package:get/get.dart';

import '../modules/admin/admin_help/bindings/admin_help_binding.dart';
import '../modules/admin/admin_help/views/admin_help_view.dart';
import '../modules/admin/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin/admin_home/views/admin_home_view.dart';
import '../modules/admin/admin_profile/bindings/admin_profile_binding.dart';
import '../modules/admin/admin_profile/views/admin_profile_view.dart';
import '../modules/admin/admin_report/bindings/admin_report_binding.dart';
import '../modules/admin/admin_report/views/admin_report_view.dart';
import '../modules/admin/admin_settings/bindings/admin_settings_binding.dart';
import '../modules/admin/admin_settings/views/admin_settings_view.dart';
import '../modules/admin/bill_wise_report/bindings/bill_wise_report_binding.dart';
import '../modules/admin/bill_wise_report/views/bill_wise_report_view.dart';
import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/cashier_management/bindings/cashier_management_binding.dart';
import '../modules/admin/cashier_management/views/cashier_management_view.dart';
import '../modules/admin/cashier_register/bindings/cashier_register_binding.dart';
import '../modules/admin/cashier_register/views/cashier_register_view.dart';
import '../modules/admin/cashiers/bindings/cashiers_binding.dart';
import '../modules/admin/cashiers/views/cashiers_view.dart';
import '../modules/admin/choose_printer/bindings/choose_printer_binding.dart';
import '../modules/admin/choose_printer/views/choose_printer_view.dart';
import '../modules/admin/day_end_report/bindings/day_end_report_binding.dart';
import '../modules/admin/day_end_report/views/day_end_report_view.dart';
import '../modules/admin/inventory/bindings/inventory_binding.dart';
import '../modules/admin/inventory/views/inventory_view.dart';
import '../modules/admin/product_management/bindings/product_management_binding.dart';
import '../modules/admin/product_management/views/product_management_view.dart';
import '../modules/admin/qr_scanner/bindings/qr_scanner_binding.dart';
import '../modules/admin/qr_scanner/views/qr_scanner_view.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/create_password/bindings/create_password_binding.dart';
import '../modules/auth/create_password/views/create_password_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view2.dart';
import '../modules/auth/logout/bindings/logout_binding.dart';
import '../modules/auth/logout/views/logout_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/auth/subscription/bindings/subscription_binding.dart';
import '../modules/auth/subscription/views/subscription_view.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/cashier/bill_details/bindings/bill_details_binding.dart';
import '../modules/cashier/bill_details/views/bill_details_view.dart';
import '../modules/cashier/bindings/cashier_binding.dart';
import '../modules/cashier/cashier_bills/bindings/cashier_bills_binding.dart';
import '../modules/cashier/cashier_bills/views/cashier_bills_view.dart';
import '../modules/cashier/cashier_profile/bindings/cashier_profile_binding.dart';
import '../modules/cashier/cashier_profile/views/cashier_profile_view.dart';
import '../modules/cashier/cashier_reports/bindings/cashier_reports_binding.dart';
import '../modules/cashier/cashier_reports/views/cashier_reports_view.dart';
import '../modules/cashier/cashier_settings/bindings/cashier_settings_binding.dart';
import '../modules/cashier/cashier_settings/views/cashier_settings_view.dart';
import '../modules/cashier/casier_help/bindings/casier_help_binding.dart';
import '../modules/cashier/casier_help/views/casier_help_view.dart';
import '../modules/cashier/qunatity_bill_calculator/bindings/qunatity_bill_calculator_binding.dart';
import '../modules/cashier/qunatity_bill_calculator/views/qunatity_bill_calculator_view.dart';
import '../modules/cashier/views/cashier_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => const AdminView(),
      binding: AdminBinding(),
      children: [
        GetPage(
          name: _Paths.ADMIN_HOME,
          page: () => const AdminHomeView(),
          binding: AdminHomeBinding(),
        ),
        GetPage(
          name: _Paths.INVENTORY,
          page: () => const InventoryView(),
          binding: InventoryBinding(),
        ),
        GetPage(
          name: _Paths.CASHIER_MANAGEMENT,
          page: () => const CashierManagementView(),
          binding: CashierManagementBinding(),
        ),
        GetPage(
          name: _Paths.ADMIN_PROFILE,
          page: () => const AdminProfileView(),
          binding: AdminProfileBinding(),
        ),
        GetPage(
          name: _Paths.ADMIN_SETTINGS,
          page: () => const AdminSettingsView(),
          binding: AdminSettingsBinding(),
        ),
        GetPage(
          name: _Paths.ADMIN_REPORT,
          page: () => const AdminReportView(),
          binding: AdminReportBinding(),
        ),
        GetPage(
          name: _Paths.PRODUCT_MANAGEMENT,
          page: () => const ProductManagementView(),
          binding: ProductManagementBinding(),
        ),
        GetPage(
          name: _Paths.ADMIN_HELP,
          page: () => const AdminHelpView(),
          binding: AdminHelpBinding(),
        ),
        GetPage(
          name: _Paths.CHOOSE_PRINTER,
          page: () => const ChoosePrinterView(),
          binding: ChoosePrinterBinding(),
        ),
        GetPage(
          name: _Paths.QR_SCANNER,
          page: () => const QrScannerView(),
          binding: QrScannerBinding(),
        ),
        GetPage(
          name: _Paths.DAY_END_REPORT,
          page: () => const DayEndReportView(),
          binding: DayEndReportBinding(),
        ),
        GetPage(
          name: _Paths.BILL_WISE_REPORT,
          page: () => const BillWiseReportView(),
          binding: BillWiseReportBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CASHIER,
      page: () => const CashierView(),
      binding: CashierBinding(),
      children: [
        GetPage(
          name: _Paths.CASHIER_SETTINGS,
          page: () => const CashierSettingsView(),
          binding: CashierSettingsBinding(),
        ),
        GetPage(
          name: _Paths.CASHIER_REPORTS,
          page: () => const CashierReportsView(),
          binding: CashierReportsBinding(),
        ),
        GetPage(
          name: _Paths.CASHIER_PROFILE,
          page: () => const CashierProfileView(),
          binding: CashierProfileBinding(),
        ),
        GetPage(
          name: _Paths.CASHIER_BILLS,
          page: () => const CashierBillsView(),
          binding: CashierBillsBinding(),
        ),
        GetPage(
          name: _Paths.CASIER_HELP,
          page: () => const CasierHelpView(),
          binding: CasierHelpBinding(),
        ),
        GetPage(
          name: _Paths.BILL_DETAILS,
          page: () => const BillDetailsView(),
          binding: BillDetailsBinding(),
        ),
        GetPage(
          name: _Paths.QUNATITY_BILL_CALCULATOR,
          page: () => QunatityBillCalculatorView(),
          binding: QunatityBillCalculatorBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
      children: [
        GetPage(
          name: _Paths.REGISTER,
          page: () => const RegisterView(),
          binding: RegisterBinding(),
        ),
        GetPage(
          name: _Paths.SUBSCRIPTION,
          page: () => const SubscriptionView(),
          binding: SubscriptionBinding(),
          children: [
            GetPage(
              name: _Paths.SUBSCRIPTION,
              page: () => const SubscriptionView(),
              binding: SubscriptionBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.CREATE_PASSWORD,
          page: () => const CreatePasswordView(),
          binding: CreatePasswordBinding(),
        ),
        GetPage(
          name: _Paths.LOGIN,
          page: () => const LoginView2(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: _Paths.CASHIER_REGISTER,
          page: () => const CashierRegisterView(),
          binding: CashierRegisterBinding(),
        ),
        GetPage(
          name: _Paths.CASHIERS,
          page: () => const CashiersView(),
          binding: CashiersBinding(),
        ),
        // GetPage(
        //   name: _Paths.STAFF_LOGIN,
        //   page: () => const StaffLoginView(),
        //   binding: StaffLoginBinding(),
        // ),
        GetPage(
          name: _Paths.LOGOUT,
          page: () => const LogoutView(),
          binding: LogoutBinding(),
        ),
      ],
    ),
  ];
}
