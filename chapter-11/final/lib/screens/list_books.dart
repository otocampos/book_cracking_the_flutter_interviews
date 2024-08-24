import 'package:chapter_11_final/databases/book_database.dart';
import 'package:chapter_11_final/networking/api_service.dart';
import 'package:flutter/material.dart';

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
        body: Container(
          child: FutureBuilder(
            future: ApiService(dataBaseBooks!).getBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Something went wrong!'),
                );
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index][
                          'name']), // Supondo que os dados são uma lista de livros.
                    );
                  },
                  itemCount: snapshot.data?.length,
                );
              } else {
                return Center(
                  child: Text('No data available'),
                );
              }
            },
          ),
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
