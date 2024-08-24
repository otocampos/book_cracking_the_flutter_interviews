import 'package:chapter_11_final/databases/book_database.dart';
import 'package:chapter_11_final/networking/api_service.dart';
import 'package:chapter_11_final/networking/dio_client.dart';
import 'package:chapter_11_final/shared_preferences/token_preferences.dart';
import 'package:get_it/get_it.dart';

final instance = GetIt.instance;

Future<GetIt> initAppModule() async {
  DataBaseBooks databaseBooks =   GetIt.I.registerSingleton<DataBaseBooks>(DataBaseBooks());
  GetIt.I.registerSingleton<DioClient>(DioClient());
  GetIt.I.registerSingleton<TokenPreferences>(TokenPreferences());

  GetIt.I.registerSingleton<ApiService>(ApiService(databaseBooks));

  return instance;
}
