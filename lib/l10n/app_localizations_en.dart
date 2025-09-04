// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Online Grocery';

  @override
  String get english => 'English';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get login => 'Login';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get sign_in => 'Sign in';

  @override
  String welcome(Object name) {
    return 'Welcome';
  }

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get error => 'Error';

  @override
  String get error_network => 'Network error, please try again.';

  @override
  String get error_no_internet => 'No internet connection.';

  @override
  String get error_unauthorized =>
      'Your session has expired. Please sign in again.';

  @override
  String get error_forbidden => 'You don\'t have permission to do that.';

  @override
  String get error_server => 'Server error. Please try later.';

  @override
  String get error_cache => 'Data error.';

  @override
  String get error_unknown => 'Something went wrong.';

  @override
  String get orders => 'Orders';

  @override
  String get myDetails => 'My Details';

  @override
  String get deliveryAddress => 'Delivery Address';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get promoCard => 'Promo Card';

  @override
  String get notifications => 'Notifications';

  @override
  String get help => 'Help';

  @override
  String get about => 'About';

  @override
  String get languges => 'Languages';
}
