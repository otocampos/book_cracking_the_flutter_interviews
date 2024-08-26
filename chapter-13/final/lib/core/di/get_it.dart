
import 'package:chapter_13_final/core/databases/book_database.dart';
import 'package:chapter_13_final/core/networking/api_service.dart';
import 'package:chapter_13_final/core/networking/dio_client.dart';
import 'package:chapter_13_final/core/shared_preferences/token_preferences.dart';
import 'package:chapter_13_final/features/manage_books/data/repositories/get_books_repository_impl.dart';
import 'package:chapter_13_final/features/manage_books/domain/repositories/books_repository.dart';
import 'package:chapter_13_final/features/manage_books/domain/use_cases/get_books_use_case.dart';
import 'package:get_it/get_it.dart';

final instance = GetIt.instance;

Future<GetIt> initAppModule() async {
  DataBaseBooks databaseBooks =   GetIt.I.registerSingleton<DataBaseBooks>(DataBaseBooks());
  GetIt.I.registerSingleton<DioClient>(DioClient());
  GetIt.I.registerSingleton<TokenPreferences>(TokenPreferences());

  GetIt.I.registerSingleton<ApiService>(ApiService(databaseBooks));
  BooksRepository booksRepository =BooksRepositoryImpl();
  GetIt.I.registerSingleton<GetBooksUseCase>(GetBooksUseCase(booksRepository));

  return instance;
}
