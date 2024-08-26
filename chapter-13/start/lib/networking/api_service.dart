import 'package:chapter_13_final/databases/book_database.dart';
import 'package:chapter_13_final/service_locators/service_locator.dart';
import 'package:chapter_13_final/shared_preferences/token_preferences.dart';
import 'package:chapter_13_final/utils/validations.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'dio_client.dart';

class ApiService {
  DataBaseBooks _databaseBooks;
  ApiService(this._databaseBooks);

  Future<dynamic> getBooks() async {

    List dataBooks = await _databaseBooks.getBooks();
    if (dataBooks.isEmpty) {
      Response response = await GetIt.instance<DioClient>().dio.get('/books');
      List<dynamic> books = response.data['books'];
      for (var book in books) {
        await DataBaseBooks().insertBook({'name': book['name']});
        print(book);
      }
      print('from remote');
      return books;
    }

    return dataBooks;
  }
  Future<Response> createBook(Map<String, dynamic> body) async {
    var dio = GetIt.instance<DioClient>().dio;
    //final SharedPreferences prefs = await  SharedPreferences.getInstance();
    //String? token = prefs.getString('token');
    String? token =await ServiceLocator.getService<TokenPreferences>('preferences').getToken();
    dio.options.headers['authorization'] = "bearer $token";
    Response response = await dio.post('/books', data:body);
    List<dynamic> books = response.data['books'];
    print(books);
    await _databaseBooks.insertBook({'name': books.last['name']});
    return response;
  }

  Future<Response> login(Map<String, dynamic> body) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await GetIt.instance<DioClient>().dio.post('/login', data: body);
   // await prefs.setString('token',response.data['token']);
    String? token =  await ServiceLocator.getService('preferences').saveToken(response.data['token']);
    print("Token is in SharePreferences: $token");
    return response;
  }
   updateBookById(int bookId, String newBookName) {
    if( Validations.validateUpdateBook(bookId, newBookName)){

    };
  }

}