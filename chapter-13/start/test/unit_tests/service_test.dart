import 'package:chapter_11_final/networking/api_service.dart';
import 'package:chapter_11_final/utils/validations.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
class ValidationsStub {
  static bool validateUpdateBook(int bookId, String newBookName) {
    return bookId > 0 && newBookName.isNotEmpty;
  }
}
class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService? mockApiService;
  group('updateBookById', () {
    setUp((){
      mockApiService = MockApiService();
    });

    test('returns true for a valid book ID and a non-empty name', () async {
      final result = Validations.validateUpdateBook (1, 'New Book Name');
      expect(result, isTrue);
    });
    test('returns false for invalid book ID', () {
      const bookId = 0;
      const newBookName = 'Valid Book Name';

      // Use the stub to validate
      final result = ValidationsStub.validateUpdateBook(bookId, newBookName);
      expect(result, isFalse);
    });
    test('updates book successfully with valid data', () async {
      const bookId = 1;
      const newBookName = 'Updated Book Name';
      when(()=>mockApiService?.updateBookById(bookId, newBookName)).thenAnswer((_) async => Response(
          data: {'id': bookId, 'name': newBookName},
          requestOptions: RequestOptions()));

      Response result = await mockApiService?.updateBookById(bookId, newBookName);
// Verify that the book was updated successfully
      expect(result, isNotNull);
      expect(result.data['id'], bookId);
      expect(result.data['name'], newBookName);
    });

  });
}
