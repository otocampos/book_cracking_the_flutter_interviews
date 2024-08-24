import 'package:chapter_11_final/databases/book_database.dart';
import 'package:chapter_11_final/networking/api_service.dart';
import 'package:chapter_11_final/screens/list_books.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  DataBaseBooks? databaseBooks;

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
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/books.png',
                  width: 200,
                  height: 100,
                ),
                TextFormField(
                    decoration: InputDecoration(
                  hintText: 'e-mail',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none, // Remove a borda padrão),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                )),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
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
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed:()async {
                      try{
                        await ApiService(databaseBooks!).login({"email":"oto@mail.com","password":"123456"});
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  ListBooksScreen(),
                          ),
                        );
                      }on Exception catch(e){
                        print(e);
                        print('Something went wrong');
                      }
                    },
                    child: Text('Send')
                )

              ],
            ),
          )),
        ),
      ),
    );
  }
}
