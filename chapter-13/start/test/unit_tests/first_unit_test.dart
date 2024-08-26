import 'package:chapter_11_final/calculator.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Calculator', () {
    test('should return the sum of two numbers', () {
      // Arrange
      final calculator = Calculator();
      int a = 2;
      int b = 3;
      // Act
      int result = calculator.sumNumbers(a, b);
      // Assert
      expect(result, 5);
    });
  });
}
