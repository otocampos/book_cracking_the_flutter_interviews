import 'package:chapter_13_final/core/databases/book_database.dart';
import 'package:chapter_13_final/core/networking/api_service.dart';
import 'package:chapter_13_final/features/manage_books/domain/entities/book.dart';
import 'package:chapter_13_final/features/manage_books/presentation/cubit/books_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBooksScreen extends StatefulWidget {
  const ListBooksScreen({super.key});

  @override
  State<ListBooksScreen> createState() => _ListBooksScreenState();
}

class _ListBooksScreenState extends State<ListBooksScreen> {
  TextEditingController textEditingController = TextEditingController();
  DataBaseBooks? dataBaseBooks;

  @override
  void initState() {
    super.initState();
    dataBaseBooks = DataBaseBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Books',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showMyDialog();
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'Welcome to Books App',
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
            Container(
              child: BlocBuilder<BooksCubit, List<BookEntity>>(
                  builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8.0),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                leading: ClipOval(
                                  child: Container(
                                    color: Colors.grey.shade50,
                                    width: 25.0, // Width of the circle
                                    height: 25.0, // Height of the circle
                                    child: Center(
                                      child: Text((index + 1).toString()),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  state[index].name ?? '',
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ),
                          )),
                );
              }),
            ),
          ],
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Book'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Book Name'),
                TextField(controller: textEditingController),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                await ApiService(dataBaseBooks!)
                    .createBook({"book_name": textEditingController.text});
                print(textEditingController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
