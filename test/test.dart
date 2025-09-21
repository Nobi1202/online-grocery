import 'package:flutter_test/flutter_test.dart';

// Ví dụ: hàm đơn giản
int add(int a, int b) => a + b;

void main() {
  test('Cộng 2 số nguyên', () {
    final result = add(2, 3);
    expect(result, 5); // Kiểm tra kết quả mong đợi
  });
}
