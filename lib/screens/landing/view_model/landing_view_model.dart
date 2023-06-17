import 'package:book_app/helper/base_view_model.dart';
import 'package:book_app/services/repository.dart';
import 'package:flutter/material.dart';

class LandingViewModel extends BaseViewModel{
  final Repository _repository = Repository();

  @override
  void showToast({required String message, required BuildContext context}) {
    super.displayToastMessage(message: message, context: context);
  }

}