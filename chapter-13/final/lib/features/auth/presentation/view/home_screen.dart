import 'package:chapter_13_final/core/databases/book_database.dart';
import 'package:chapter_13_final/core/networking/api_service.dart';
import 'package:chapter_13_final/features/manage_books/presentation/view/list_books.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  DataBaseBooks? databaseBooks;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    databaseBooks = DataBaseBooks();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/books.png',
                      width: 200,
                      height: 100,
                    ),
                    TextFormField(
                        key: const Key('emailField'),
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'e-mail',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide
                                .none, // Remove a borda padrão),
                          ),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        )),
                    Gap(16),
                    TextFormField(
                      key: Key('passwordField'),
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none, // Remove a borda padrão
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                      obscureText: true,
                    ),
                    Gap(32),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ElevatedButton(
                          key: const Key('sendButton'),
                          onPressed: () async {
                            try {
                              await GetIt.instance<ApiService>().login({
                                "email": emailController.text,
                                "password": passwordController.text
                              });
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ListBooksScreen(),
                                ),
                              );
                            } on Exception  {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Email or Password is wrong')));
                            }
                          },
                          child: Text('Login')
                      ),
                    )

                  ],
                ),
              )),
        ),
      ),
    );
  }
}
