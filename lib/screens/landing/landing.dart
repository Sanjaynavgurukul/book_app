import 'package:book_app/model/category_model.dart';
import 'package:book_app/theme/theme_config.dart';
import 'package:flutter/material.dart';

import 'widget/category_item_card.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: headingSection()),
          SliverToBoxAdapter(child: categoryList()),
        ],
      ),
    );
  }

  Widget headingSection() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image/background.png'),
        fit: BoxFit.cover, // Adjust this value to fit your requirements
      )),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 80, bottom: 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gutenberg\nProject",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColor.primaryColor),
          ),
          SizedBox(height: 12),
          Text(
            "A social cataloging website that allows you to freely search its database of books, annotations, and reviews.",
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget categoryList() {
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
      child: Column(
        children: List.generate(getCategoryDataList().length, (index) {
          CategoryModel item = getCategoryDataList()[index];
          return  CategoryItemCard(item: item,);
        }),
      ),
    );
  }
}
