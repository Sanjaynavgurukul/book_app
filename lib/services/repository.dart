import 'package:book_app/model/api_response.dart';
import 'package:book_app/services/provider.dart';

class Repository {
  final Provider _provider = Provider();

  Future<ApiResponse> getBooks({required String search,required String topic, required int pageCount, required String language}) =>
      _provider.getBooks(search:search,topic: topic, pageCount: pageCount, language: language);
}
