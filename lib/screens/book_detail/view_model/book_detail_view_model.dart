import 'dart:io';

import 'package:archive/archive.dart';
import 'package:book_app/helper/base_view_model.dart';
import 'package:book_app/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


class BookDetailViewModel extends BaseViewModel{

  Results? book;
  bool isLoading = false;

  //Default Constructor :D
  BookDetailViewModel();

  //Constructor With Argument :D
  BookDetailViewModel.argument({required this.book});

  @override
  void showToast({required String message, required BuildContext context}) {
    super.displayToastMessage(message: message, context: context);
  }

  void setLoading(bool loading){
    isLoading = loading;
    notifyListeners();
  }

  Future<String?> extractAndReturnHtmlFile({required String filePth}) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final String zipFilePath = '$tempPath/ebook.zip';
    final String extractedHtmlFilePath = '$tempPath/ebook.html';

    // Download the zip file
    final response = await http.get(Uri.parse(filePth));
    if (response.statusCode == 200) {
      // Save the downloaded zip file
      File(zipFilePath).writeAsBytesSync(response.bodyBytes);

      // Extract the zip file
      final bytes = File(zipFilePath).readAsBytesSync();
      final archive = ZipDecoder().decodeBytes(bytes);

      for (final file in archive) {
        final filePath = '$tempPath/${file.name}';
        if (file.isFile) {
          final data = file.content as List<int>;
          File(filePath)
            ..createSync(recursive: true)
            ..writeAsBytesSync(data);
          if (filePath.endsWith('.html') || filePath.endsWith('.htm')) {
            print('check got it ----');
            return filePath;
          }else{
            print('check got it ---- false');
          }
        } else {
          Directory(filePath).create(recursive: true);
        }
      }
    }

    return null;
  }
}