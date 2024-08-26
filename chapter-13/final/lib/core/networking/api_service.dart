import 'package:chapter_13_final/core/databases/book_database.dart';
import 'package:chapter_13_final/core/service_locators/service_locator.dart';
import 'package:chapter_13_final/core/shared_preferences/token_preferences.dart';
import 'package:chapter_13_final/core/utils/validations.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'dio_client.dart';

class ApiService {
  DataBaseBooks _databaseBooks;
  ApiService(this._databaseBooks);


    Future<Response> getBooks() async {
      Response response = await GetIt.instance<DioClient>().dio.get('/books');
      return response;
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