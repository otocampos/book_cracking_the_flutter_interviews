import 'package:chapter_13_final/core/databases/book_database.dart';
import 'package:chapter_13_final/core/di/get_it.dart';
import 'package:chapter_13_final/core/service_locators/service_locator.dart';
import 'package:chapter_13_final/core/shared_preferences/token_preferences.dart';
import 'package:chapter_13_final/core/utils/themes/main_theme.dart';
import 'package:chapter_13_final/features/manage_books/presentation/cubit/books_cubit.dart';
import 'package:chapter_13_final/features/auth/presentation/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseBooks().initDB();
  ServiceLocator.registerService('preferences', TokenPreferences());
  await initAppModule();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BooksCubit>(
            create: (BuildContext context) =>    BooksCubit(),
          ),
        ],
      child:  MaterialApp(home:  HomeScreen(),theme: mainTheme,),


    );
  }
}


