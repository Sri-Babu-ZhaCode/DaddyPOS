part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const ADMIN = _Paths.ADMIN;
  static const CASHIER = _Paths.CASHIER;
  static const ADMIN_HOME = _Paths.ADMIN + _Paths.ADMIN_HOME;
  static const INVENTORY = _Paths.ADMIN + _Paths.INVENTORY;
  static const CASHIER_MANAGEMENT = _Paths.ADMIN + _Paths.CASHIER_MANAGEMENT;

  static const ADMIN_PROFILE = _Paths.ADMIN + _Paths.ADMIN_PROFILE;
  static const ADMIN_SETTINGS = _Paths.ADMIN + _Paths.ADMIN_SETTINGS;
  static const ADMIN_REPORT = _Paths.ADMIN + _Paths.ADMIN_REPORT;

  static const CASHIER_SETTINGS = _Paths.CASHIER + _Paths.CASHIER_SETTINGS;
  static const CASHIER_REPORTS = _Paths.CASHIER + _Paths.CASHIER_REPORTS;
  static const CASHIER_PROFILE = _Paths.CASHIER + _Paths.CASHIER_PROFILE;
  static const CASHIER_BILLS = _Paths.CASHIER + _Paths.CASHIER_BILLS;
  static const AUTH = _Paths.AUTH;
  static const REGISTER = _Paths.AUTH + _Paths.REGISTER;
  static const SUBSCRIPTION = _Paths.AUTH + _Paths.SUBSCRIPTION;
  static const CREATE_PASSWORD = _Paths.AUTH + _Paths.CREATE_PASSWORD;
  static const LOGIN = _Paths.AUTH + _Paths.LOGIN;
  static const PRODUCT_MANAGEMENT = _Paths.ADMIN + _Paths.PRODUCT_MANAGEMENT;
  static const CASHIER_REGISTER = _Paths.AUTH + _Paths.CASHIER_REGISTER;
  static const CASHIERS = _Paths.AUTH + _Paths.CASHIERS;
  static const STAFF_LOGIN = _Paths.AUTH + _Paths.STAFF_LOGIN;
  static const ADMIN_HELP = _Paths.ADMIN + _Paths.ADMIN_HELP;
  static const CASIER_HELP = _Paths.CASHIER + _Paths.CASIER_HELP;
  static const BILL_DETAILS = _Paths.CASHIER + _Paths.BILL_DETAILS;
  static const CHOOSE_PRINTER = _Paths.ADMIN + _Paths.CHOOSE_PRINTER;
  static const QR_SCANNER = _Paths.ADMIN + _Paths.QR_SCANNER;
  static const QUNATITY_BILL_CALCULATOR =
      _Paths.CASHIER + _Paths.QUNATITY_BILL_CALCULATOR;
  static const DAY_END_REPORT = _Paths.ADMIN + _Paths.DAY_END_REPORT;
  static const BILL_WISE_REPORT = _Paths.ADMIN + _Paths.BILL_WISE_REPORT;
  static const LOGOUT = _Paths.AUTH + _Paths.LOGOUT;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const ADMIN = '/admin';
  static const CASHIER = '/cashier';
  //Cashier
  static const CASHIER_BILLS = '/cashier-bills';
  static const CASHIER_SETTINGS = '/cashier-settings';
  static const CASHIER_REPORTS = '/cashier-reports';
  static const CASHIER_PROFILE = '/cashier-profile';
  //Admin

  static const ADMIN_HOME = '/admin-home';
  static const INVENTORY = '/inventory';
  static const CASHIER_MANAGEMENT = '/cashier-management';
  static const ADMIN_PROFILE = '/admin-profile';
  static const ADMIN_SETTINGS = '/admin-settings';
  static const ADMIN_REPORT = '/admin-report';
  static const AUTH = '/auth';
  static const REGISTER = '/register';
  static const SUBSCRIPTION = '/subscription';
  static const CREATE_PASSWORD = '/create-password';
  static const LOGIN = '/login';
  static const PRODUCT_MANAGEMENT = '/product-management';
  static const CASHIER_REGISTER = '/cashier-register';
  static const CASHIERS = '/cashiers';
  static const STAFF_LOGIN = '/staff-login';
  static const ADMIN_HELP = '/admin-help';
  static const CASIER_HELP = '/casier-help';
  static const BILL_DETAILS = '/bill-details';
  static const CHOOSE_PRINTER = '/choose-printer';
  static const QR_SCANNER = '/qr-scanner';
  static const QUNATITY_BILL_CALCULATOR = '/qunatity-bill-calculator';
  static const DAY_END_REPORT = '/day-end-report';
  static const BILL_WISE_REPORT = '/bill-wise-report';
  static const LOGOUT = '/logout';
}
