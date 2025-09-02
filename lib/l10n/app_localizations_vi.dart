// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get app_name => 'Cửa hàng thực phẩm';

  @override
  String get english => 'Tiếng Anh';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get login => 'Đăng nhập';

  @override
  String get username => 'Tên đăng nhập';

  @override
  String get password => 'Mật khẩu';

  @override
  String get sign_in => 'Đăng nhập';

  @override
  String welcome(Object name) {
    return 'Xin chào $name';
  }

  @override
  String get ok => 'Đồng ý';

  @override
  String get cancel => 'Huỷ';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get error => 'Lỗi';

  @override
  String get error_network => 'Lỗi mạng, vui lòng thử lại.';

  @override
  String get error_no_internet => 'Không có kết nối internet.';

  @override
  String get error_unauthorized =>
      'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';

  @override
  String get error_forbidden => 'Bạn không có quyền thao tác.';

  @override
  String get error_server => 'Lỗi máy chủ. Vui lòng thử sau.';

  @override
  String get error_cache => 'Lỗi dữ liệu.';

  @override
  String get error_unknown => 'Đã xảy ra lỗi.';
}
