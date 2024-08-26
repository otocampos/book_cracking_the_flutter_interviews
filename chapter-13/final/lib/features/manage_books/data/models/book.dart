import 'package:chapter_13_final/core/entity/mapper_entity.dart';
import 'package:chapter_13_final/features/manage_books/domain/entities/book.dart';

class Book extends DataMapper<BookEntity> {
  int? id;
  String? name;

  Book({this.id, this.name});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  BookEntity mapToEntity() {
    return BookEntity(id: this.id, name: this.name);
  }
}
