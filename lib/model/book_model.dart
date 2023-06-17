import 'package:book_app/helper/variable_converter.dart';

class BookModel {
  num? count;
  String? next;
  String? previous;
  List<Results>? results;

  BookModel({this.count, this.next, this.previous, this.results});

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        count: VariableConverter.convertVariable(data: json['count'], variableType: 'int'),
        next: VariableConverter.convertVariable(data: json['next'], variableType: 'String'),
        results: json.containsKey('results') && json['results'] != null ? List<Results>.from(json["results"].map((x) => Results.fromJson(x))) : [],
      );
}

class Results {
  num? id;
  num? downloadCount;
  Formats? formats;
  String? mediaType;
  String? title;

  List<String>? languages;
  List<Authors>? authors;
  List<String>? bookshelves;
  List<String>? subjects;

  Results({this.id, this.authors, this.bookshelves, this.downloadCount, this.formats, this.languages, this.mediaType, this.subjects, this.title});

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        id: VariableConverter.convertVariable(data: json['id'], variableType: 'int'),
        downloadCount: VariableConverter.convertVariable(data: json['download_count'], variableType: 'int'),
        mediaType: VariableConverter.convertVariable(data: json['media_type'], variableType: 'String'),
        title: VariableConverter.convertVariable(data: json['title'], variableType: 'String'),
        formats: json['formats'] != null ? Formats.fromJson(json['formats']) : null,
        languages: json.containsKey('languages') && json['languages'] != null ? List<String>.from(json["languages"].map((x) => x)) : [],
        bookshelves: json.containsKey('bookshelves') && json['bookshelves'] != null ? List<String>.from(json["bookshelves"].map((x) => x)) : [],
        subjects: json.containsKey('subjects') && json['subjects'] != null ? List<String>.from(json["subjects"].map((x) => x)) : [],
        authors: json.containsKey('authors') && json['authors'] != null ? List<Authors>.from(json["authors"].map((x) => Authors.fromJson(x))) : [],
      );
}

class Authors {
  num? birthYear;
  num? deathYear;
  String? name;

  Authors({this.birthYear, this.deathYear, this.name});

  factory Authors.fromJson(Map<String, dynamic> json) => Authors(
      birthYear: VariableConverter.convertVariable(variableType: "int", data: json['birth_year']),
      deathYear: VariableConverter.convertVariable(variableType: "int", data: json['deathYear']),
      name: VariableConverter.convertVariable(variableType: "String", data: json['name']));
}

class Formats {
  String? applicationXMobipocketEbook;
  String? applicationPdf;
  String? textPlainCharsetUsAscii;
  String? textPlainCharsetUtf8;
  String? applicationRdfXml;
  String? applicationZip;
  String? applicationEpubZip;
  String? textHtmlCharsetUtf8;
  String? textPlainCharsetIso88591;
  String? imageJpeg;
  String? textPlain;
  String? textHtmlCharsetUsAscii;
  String? textHtml;
  String? textRtf;
  String? textHtmlCharsetIso88591;
  String? applicationPrsTex;

  Formats(
      {this.applicationXMobipocketEbook,
      this.applicationPdf,
      this.textPlainCharsetUsAscii,
      this.textPlainCharsetUtf8,
      this.applicationRdfXml,
      this.applicationZip,
      this.applicationEpubZip,
      this.textHtmlCharsetUtf8,
      this.textPlainCharsetIso88591,
      this.imageJpeg,
      this.textPlain,
      this.textHtmlCharsetUsAscii,
      this.textHtml,
      this.textRtf,
      this.textHtmlCharsetIso88591,
      this.applicationPrsTex});

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        applicationXMobipocketEbook: VariableConverter.convertVariable(variableType: "String", data: json['application/x-mobipocket-ebook']),
        applicationPdf: VariableConverter.convertVariable(variableType: "String", data: json['application/pdf']),
        textPlainCharsetUsAscii: VariableConverter.convertVariable(variableType: "String", data: json['text/plain; charset=us-ascii']),
        textPlainCharsetUtf8: VariableConverter.convertVariable(variableType: "String", data: json['text/plain; charset=utf-8']),
        applicationRdfXml: VariableConverter.convertVariable(variableType: "String", data: json['application/rdf+xml']),
        applicationZip: VariableConverter.convertVariable(variableType: "String", data: json['application/zip']),
        applicationEpubZip: VariableConverter.convertVariable(variableType: "String", data: json['application/epub+zip']),
        textHtmlCharsetUtf8: VariableConverter.convertVariable(variableType: "String", data: json['text/html; charset=utf-8']),
        textPlainCharsetIso88591: VariableConverter.convertVariable(variableType: "String", data: json['text/plain; charset=iso-8859-1']),
        imageJpeg: VariableConverter.convertVariable(variableType: "String", data: json['image/jpeg']),
        textPlain: VariableConverter.convertVariable(variableType: "String", data: json['text/plain']),
        textHtmlCharsetUsAscii: VariableConverter.convertVariable(variableType: "String", data: json['text/html; charset=us-ascii']),
        textHtml: VariableConverter.convertVariable(variableType: "String", data: json['text/html']),
        textRtf: VariableConverter.convertVariable(variableType: "String", data: json['text/rtf']),
        textHtmlCharsetIso88591: VariableConverter.convertVariable(variableType: "String", data: json['text/html; charset=iso-8859-1']),
        applicationPrsTex: VariableConverter.convertVariable(variableType: "String", data: json['application/prs.tex']),
      );
}
