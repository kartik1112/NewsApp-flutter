// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

class NewsDataModel {
  final String? imageUrl;
  final String? author;
  final String? title;
  final String? description;
  final String? publisher;
  NewsDataModel({
    this.imageUrl,
    this.author,
    this.title,
    this.description,
    this.publisher,
  });

  // NewsDataModel(
  //     {this.imageUrl,
  //     this.author,
  //     this.title,
  //     this.description,
  //     this.publisher});

  NewsDataModel copyWith({
    String? imageUrl,
    String? author,
    String? title,
    String? description,
    String? publisher,
  }) {
    return NewsDataModel(
      imageUrl: imageUrl ?? this.imageUrl,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      publisher: publisher ?? this.publisher,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'author': author,
      'title': title,
      'description': description,
      'publisher': publisher,
    };
  }

/*
String imageuri = (result[index]['urlToImage'] != null)
              ? result[index]['urlToImage']
              : "https//:static.toiimg.com/thumb/msid-107676957,width-1070,height-580,imgsize-30480,resizemode-75,overlay-toi_sw,pt-32,y_pad-40/photo.jpg";
          String publisher = (result[index]['source']['name'] != null)
              ? result[index]['source']['name']
              : "null piublisher";
          String author = (result[index]['author'] != null)
              ? result[index]['author']
              : "null author";
          String title = (result[index]['title'] != null)
              ? result[index]['title']
              : "null title";

*/

  factory NewsDataModel.fromMap(Map<String, dynamic> map) {
    // map.printInfo();
    return NewsDataModel(
      imageUrl: map['urlToImage'] ?? "https://images.unsplash.com/photo-1682685797898-6d7587974771?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8",
      author:
          map['author'] != null ? map['author'] as String : "author",
      title: map['title'] != null ? map['title'] as String : "title",
      description: map['description'] != null
          ? map['description'] as String
          : "description",
      publisher: map['source']['name'] != null
          ? map['source']['name'] as String
          : "publisher",
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsDataModel.fromJson(String source) =>
      NewsDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsDataModel(imageUrl: $imageUrl, author: $author, title: $title, description: $description, publisher: $publisher)';
  }

  @override
  bool operator ==(covariant NewsDataModel other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl &&
        other.author == author &&
        other.title == title &&
        other.description == description &&
        other.publisher == publisher;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        author.hashCode ^
        title.hashCode ^
        description.hashCode ^
        publisher.hashCode;
  }
}
