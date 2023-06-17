class ApiUrls {
  static String baseUrl = "http://skunkworks.ignitesol.com:8000/";

  static String getBooks({required String topic, required int pageCount, required String language,required String search}) =>
      "books/?page=$pageCount&topic=$topic&languages=$language&search=$search";
}
