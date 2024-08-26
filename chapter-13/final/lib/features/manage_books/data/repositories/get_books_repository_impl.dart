import 'package:chapter_13_final/core/databases/book_database.dart';
import 'package:chapter_13_final/core/networking/api_service.dart';
import 'package:chapter_13_final/features/manage_books/data/models/book.dart';
import 'package:chapter_13_final/features/manage_books/domain/entities/book.dart';
import 'package:chapter_13_final/features/manage_books/domain/repositories/books_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class BooksRepositoryImpl implements BooksRepository {
  @override
  Future getBooks() async {
    dynamic dataBooks = await GetIt.instance<DataBaseBooks>().getBooks();
    List<BookEntity> books = [];

    if (dataBooks!.isEmpty) {
      Response response = await GetIt.instance<ApiService>().getBooks();
      response.data['books'].forEach((v) {
        books.add(Book.fromJson(v).mapToEntity());
      });
      books.forEach((element) async {
        await GetIt.instance<DataBaseBooks>()
            .insertBook({'name': element.name});
      });
      return books;
    }
    dataBooks.forEach((dbBook) async {
      books.add(BookEntity(name: dbBook['name']));
    });
    return books;
  }
}