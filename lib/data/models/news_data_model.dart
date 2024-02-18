// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewsDataModel {
  final String? imageUrl;
  final String? author;
  final String? title;
  final String? description;
  final String? publisher;
  final String? url;
  NewsDataModel({
    this.imageUrl,
    this.author,
    this.title,
    this.description,
    this.publisher,
    this.url,
  });

  NewsDataModel copyWith({
    String? imageUrl,
    String? author,
    String? title,
    String? description,
    String? publisher,
    String? url,
  }) {
    return NewsDataModel(
      imageUrl: imageUrl ?? this.imageUrl,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      publisher: publisher ?? this.publisher,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'author': author,
      'title': title,
      'description': description,
      'publisher': publisher,
      'url': url,
    };
  }

  factory NewsDataModel.fromMap(Map<String, dynamic> map) {
    return NewsDataModel(
      imageUrl: map['urlToImage'] ,
      author:
          map['author'] != null ? map['author'] as String : "Anonymous!",
      title: map['title'] != null ? map['title'] as String : "Untitled!",
      description: map['description'] != null
          ? map['description'] as String
          : "No Description Found..",
      publisher: map['source']['name'] != null
          ? map['source']['name'] as String
          : "Not Found..",
      url: map['url'] != null
          ? map['url'] as String
          : "",
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsDataModel.fromJson(String source) =>
      NewsDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsDataModel(imageUrl: $imageUrl, author: $author, title: $title, description: $description, publisher: $publisher, url: $url)';
  }

  @override
  bool operator ==(covariant NewsDataModel other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl &&
        other.author == author &&
        other.title == title &&
        other.description == description &&
        other.publisher == publisher &&
        other.url == url;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        author.hashCode ^
        title.hashCode ^
        description.hashCode ^
        publisher.hashCode ^
        url.hashCode;
  }
}
