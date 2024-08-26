import 'package:chapter_13_final/features/manage_books/domain/entities/book.dart';
import 'package:chapter_13_final/features/manage_books/domain/use_cases/get_books_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BooksCubit extends Cubit<List<BookEntity>> {
  BooksCubit() : super([]) {
    getBooks();
  }

  getBooks() async {
    try {
      List<BookEntity> books = await GetIt.instance<GetBooksUseCase>()
          .execute();
      emit(books);
    }
    catch (e, s) {
      print('Error fetching books: $e');
      print(s);
    }
  }
}