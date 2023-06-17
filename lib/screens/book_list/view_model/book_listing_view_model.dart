import 'package:book_app/helper/base_view_model.dart';
import 'package:book_app/model/api_response.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/model/category_model.dart';
import 'package:book_app/services/repository.dart';
import 'package:flutter/material.dart';

class BookListingViewModel extends BaseViewModel {
  final Repository _repository = Repository();
  CategoryModel? categoryModel;
  BookModel? bookModel;
  bool isLoading = false;
  int pageCount = 1;
  String searchQuarry="";
  //Default Constructor :D
  BookListingViewModel();

  //Argument Constructor :D
  BookListingViewModel.argument({required this.categoryModel});

  @override
  void showToast({required String message, required BuildContext context}) {
    super.displayToastMessage(message: message, context: context);
  }

  void setLoader({bool loading = false}) {
    isLoading = loading;
    notifyListeners();
  }

  void getBookByCategory({String? url, bool fromPagination = false}) async {
    if (fromPagination) {
      pageCount++;
    }

    String language = 'en';
    String replacedString = searchQuarry.replaceAll(' ', '%20');
    ApiResponse apiResponse =
        await _repository.getBooks(search: replacedString, language: language, pageCount: pageCount, topic: categoryModel!.cat_value);
    if (fromPagination) {
      var book = BookModel.fromJson(apiResponse.data);
      bookModel!.results!.addAll(book.results!);
    } else {
      bookModel = BookModel.fromJson(apiResponse.data);
    }
    isLoading = false;
    notifyListeners();
  }
}
