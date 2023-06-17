class CategoryModel{
  final String cat_name;
  final String cat_image;
  final String cat_value;

  //Constructor :D
  CategoryModel({required this.cat_image,required this.cat_name,required this.cat_value});
}

List<CategoryModel> getCategoryDataList()=>[
  CategoryModel(cat_image: "assets/image/fiction.svg",cat_name: "Fiction",cat_value: "fiction"),
  CategoryModel(cat_image: "assets/image/drama.svg",cat_name: "Drama",cat_value: "drama"),
  CategoryModel(cat_image: "assets/image/humour.svg",cat_name: "Humor",cat_value: "humor"),
  CategoryModel(cat_image: "assets/image/politics.svg",cat_name: "Politics",cat_value: "politics"),
  CategoryModel(cat_image: "assets/image/philosophy.svg",cat_name: "Philosophy",cat_value: "philosophy"),
  CategoryModel(cat_image: "assets/image/history.svg",cat_name: "History",cat_value: "history"),
  CategoryModel(cat_image: "assets/image/adventure.svg",cat_name: "Adventure",cat_value: "adventure"),
];