import 'package:book_app/model/api_response.dart';
import 'package:book_app/services/api_urls.dart';
import 'package:book_app/services/network_utils.dart';

class Provider {
  final _networkUtils = NetworkUtil();

  Future<ApiResponse> getBooks({required String search,required String topic, required int pageCount, required String language}) =>
      _networkUtils.get(url: ApiUrls.getBooks(search:search,language: language,pageCount: pageCount,topic: topic));
}
