import 'package:chapter_13_final/features/manage_books/domain/entities/book.dart';
import 'package:chapter_13_final/features/manage_books/domain/repositories/books_repository.dart';

class GetBooksUseCase {
  BooksRepository booksRepository;
  GetBooksUseCase(this.booksRepository);
  Future<List<BookEntity>> execute() async {
    List<BookEntity>  result = await booksRepository.getBooks();
    return result;
  }
}
