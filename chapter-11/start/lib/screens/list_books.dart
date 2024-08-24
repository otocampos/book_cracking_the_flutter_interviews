import 'package:flutter/material.dart';
import 'package:starter/networking/api_service.dart';

class ListBooksScreen extends StatefulWidget {
  const ListBooksScreen({super.key});

  @override
  State<ListBooksScreen> createState() => _ListBooksScreenState();
}

class _ListBooksScreenState extends State<ListBooksScreen> {
  TextEditingController textEditingController = TextEditingController();
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

            future: ApiService().getBooks(),
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
                // Assuming your response data is a list of books
                final List<dynamic> books = snapshot.data!.data['books'];

                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(books[index]['name']),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('No data available'),
                );
              }
            },

          ),
        )
    );
  }
  Future<void> _showMyDialog() async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Book'),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Book Name'),
                TextField(controller:textEditingController),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  const Text('Save'),
              onPressed: () async{
                await ApiService().createBook({"book_name":textEditingController.text});
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
