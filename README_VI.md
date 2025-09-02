# Online Grocery - Ứng dụng Flutter

Ứng dụng mua sắm tạp hóa hiện đại, có khả năng mở rộng được xây dựng bằng Flutter sử dụng nguyên tắc Clean Architecture và mô hình BLoC để quản lý trạng thái.

## 🚀 Tính năng

- **Xác thực người dùng**: Hệ thống đăng nhập an toàn với xác thực dựa trên token
- **Hỗ trợ đa ngôn ngữ**: Bản địa hóa tiếng Anh và tiếng Việt
- **Trải nghiệm mua sắm**:
  - Duyệt sản phẩm trong phần Shop
  - Khám phá các danh mục khác nhau
  - Quản lý giỏ hàng
  - Quản lý sản phẩm yêu thích
  - Quản lý tài khoản người dùng
- **Lưu trữ ngoại tuyến**: Lưu trữ cục bộ an toàn cho dữ liệu và tùy chọn người dùng
- **Nhiều môi trường**: Cấu hình Development, Staging và Production
- **Clean Architecture**: Codebase được cấu trúc tốt tuân theo nguyên tắc SOLID

## 🏗️ Kiến trúc

Dự án này tuân theo nguyên tắc **Clean Architecture** với các lớp sau:

### 📁 Cấu trúc dự án

```
lib/
├── app.dart                    # Widget ứng dụng chính
├── main_dev.dart              # Điểm khởi đầu môi trường Development
├── main_stg.dart              # Điểm khởi đầu môi trường Staging
├── main_prod.dart             # Điểm khởi đầu môi trường Production
├── core/                      # Tiện ích và cấu hình cốt lõi
│   ├── constants/             # Hằng số ứng dụng
│   ├── enums/                 # Kiểu liệt kê
│   ├── env/                   # Cấu hình môi trường
│   ├── error/                 # Tiện ích xử lý lỗi
│   ├── extensions/            # Dart extensions
│   ├── l10n/                  # Tệp bản địa hóa
│   ├── logging/               # Tiện ích ghi log
│   └── utils/                 # Hàm tiện ích
├── data/                      # Lớp dữ liệu
│   ├── core/                  # Tiện ích lớp dữ liệu
│   ├── datasources/           # Nguồn dữ liệu cục bộ và từ xa
│   ├── mappers/               # Bộ ánh xạ dữ liệu (DTO ↔ Entity)
│   ├── models/                # Mô hình dữ liệu (DTOs)
│   └── repositories/          # Triển khai repository
├── domain/                    # Lớp domain (Logic nghiệp vụ)
│   ├── core/                  # Tiện ích domain
│   ├── entities/              # Thực thể nghiệp vụ
│   ├── repositories/          # Giao diện repository
│   └── usecase/               # Use cases (logic nghiệp vụ)
├── di/                        # Dependency Injection
│   ├── injector.dart          # Cấu hình DI
│   ├── env_module.dart        # Module môi trường
│   └── third_party_module.dart # Phụ thuộc bên thứ ba
└── presentation/              # Lớp trình bày
    ├── bloc/                  # Quản lý trạng thái BLoC
    ├── error/                 # Xử lý lỗi cho UI
    ├── routes/                # Định tuyến điều hướng
    ├── screens/               # Màn hình UI
    ├── shared/                # Thành phần UI chia sẻ
    └── theme/                 # Chủ đề ứng dụng
```

## 🛠️ Ngăn xếp công nghệ

### Công nghệ cốt lõi

- **Flutter SDK**: ^3.7.0
- **Dart**: Phiên bản ổn định mới nhất

### Quản lý trạng thái

- **flutter_bloc**: ^9.0.0 - Triển khai mô hình BLoC
- **equatable**: ^2.0.7 - Đẳng thức giá trị

### Dependency Injection

- **get_it**: ^8.0.1 - Service locator
- **injectable**: ^2.5.0 - Tạo code cho DI

### Mạng

- **dio**: ^5.7.0 - HTTP client
- **retrofit**: ^4.4.1 - HTTP client kiểu an toàn

### Lưu trữ cục bộ

- **shared_preferences**: ^2.3.3 - Lưu trữ dữ liệu đơn giản
- **flutter_secure_storage**: ^9.2.3 - Lưu trữ an toàn

### UI & UX

- **flutter_screenutil**: ^5.9.3 - Thích ứng màn hình
- **cached_network_image**: ^3.4.1 - Bộ nhớ đệm hình ảnh

### Điều hướng

- **go_router**: ^14.8.1 - Định tuyến khai báo

### Quốc tế hóa

- **intl**: ^0.19.0 - Hỗ trợ quốc tế hóa
- **flutter_localizations**: SDK - Bản địa hóa Flutter

### Tiện ích

- **dartz**: ^0.10.1 - Tiện ích lập trình hàm
- **freezed**: ^2.5.8 - Tạo code cho lớp bất biến
- **json_annotation**: ^4.9.0 - Tuần tự hóa JSON

### Công cụ phát triển

- **build_runner**: ^2.4.14 - Tạo code
- **flutter_lints**: ^5.0.0 - Quy tắc linting
- **logger**: ^2.5.0 - Tiện ích ghi log

## 🚦 Bắt đầu

### Yêu cầu tiên quyết

- Flutter SDK (^3.7.0)
- Dart SDK
- Android Studio / VS Code
- Thiết lập phát triển iOS (cho bản dựng iOS)

### Cài đặt

1. **Sao chép repository**

   ```bash
   git clone <repository-url>
   cd online_grocery
   ```

2. **Cài đặt dependencies**

   ```bash
   flutter pub get
   ```

3. **Tạo code**

   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Chạy ứng dụng**

   Cho môi trường development:

   ```bash
   flutter run --target lib/main_dev.dart
   ```

   Cho môi trường staging:

   ```bash
   flutter run --target lib/main_stg.dart
   ```

   Cho môi trường production:

   ```bash
   flutter run --target lib/main_prod.dart
   ```

## 🌍 Quốc tế hóa

Ứng dụng hỗ trợ nhiều ngôn ngữ:

- Tiếng Anh (en)
- Tiếng Việt (vi)

Các tệp ngôn ngữ được đặt trong `lib/core/l10n/` và `lib/l10n/`.

Để thêm ngôn ngữ mới:

1. Tạo tệp `.arb` mới trong cả hai thư mục
2. Chạy tạo code
3. Cập nhật các ngôn ngữ được hỗ trợ trong `app.dart`

## 🏛️ Triển khai Clean Architecture

### Lớp Domain

- **Entities**: Mô hình nghiệp vụ cốt lõi
- **Repositories**: Giao diện trừu tượng cho truy cập dữ liệu
- **Use Cases**: Triển khai logic nghiệp vụ

### Lớp Data

- **Models**: Đối tượng truyền dữ liệu (DTOs)
- **Mappers**: Chuyển đổi giữa DTOs và Entities
- **Data Sources**: API từ xa và lưu trữ cục bộ
- **Repository Implementations**: Triển khai repository cụ thể

### Lớp Presentation

- **BLoC**: Quản lý trạng thái sử dụng mô hình BLoC
- **Screens**: Thành phần UI
- **Routes**: Cấu hình điều hướng

## 🔧 Cấu hình

### Thiết lập môi trường

Ứng dụng hỗ trợ ba môi trường:

- **Development** (`main_dev.dart`)
- **Staging** (`main_stg.dart`)
- **Production** (`main_prod.dart`)

Mỗi môi trường có cấu hình riêng trong `lib/core/env/`.

### Dependency Injection

Dependencies được cấu hình sử dụng `get_it` và `injectable`:

- Singletons cho services và repositories
- Factories cho use cases
- Lazy singletons cho BLoC controllers

## 🧪 Kiểm thử

Chạy test sử dụng:

```bash
flutter test
```

## 📱 Màn hình

1. **Splash Screen**: Khởi tạo ứng dụng
2. **Get Started**: Màn hình chào mừng
3. **Login**: Xác thực người dùng
4. **Bottom Tab Navigation**:
   - Shop: Duyệt sản phẩm
   - Explore: Khám phá danh mục
   - Cart: Quản lý giỏ hàng
   - Favorites: Sản phẩm yêu thích
   - Account: Hồ sơ người dùng

## 🔐 Bảo mật

- Lưu trữ token an toàn sử dụng `flutter_secure_storage`
- Xác thực API với JWT tokens
- Yêu cầu HTTP an toàn với interceptors thích hợp

## 📝 Tạo code

Dự án sử dụng một số công cụ tạo code:

- **Injectable**: Dependency injection
- **Retrofit**: Tạo API client
- **Freezed**: Lớp bất biến
- **JSON Serializable**: Tuần tự hóa JSON

Chạy tạo code:

```bash
flutter packages pub run build_runner build
```

## 🤝 Đóng góp

1. Fork repository
2. Tạo feature branch
3. Thực hiện thay đổi
4. Tuân theo tiêu chuẩn coding
5. Gửi pull request

## 📄 Giấy phép

Dự án này được cấp phép theo Giấy phép MIT - xem tệp LICENSE để biết chi tiết.

## 📞 Hỗ trợ

Để được hỗ trợ và đặt câu hỏi, vui lòng mở một issue trong repository GitHub.

---

Được xây dựng với ❤️ sử dụng Flutter và nguyên tắc Clean Architecture.
