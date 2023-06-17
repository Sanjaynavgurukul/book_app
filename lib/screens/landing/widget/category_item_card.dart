import 'package:book_app/helper/navigate_helper.dart';
import 'package:book_app/model/category_model.dart';
import 'package:book_app/screens/book_list/book_listing.dart';
import 'package:book_app/screens/book_list/view_model/book_listing_view_model.dart';
import 'package:book_app/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItemCard extends StatelessWidget {
  final CategoryModel item;
  const CategoryItemCard({Key? key,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColor.scaffoldBackground,
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 2,
      color: Colors.white,
      // Adjust the elevation value as per your preference
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6), // Adjust the border radius value as per your preference
      ),
      child:  ListTile(
        onTap: (){
          NavigationHelper().navigatePush(context: context, viewModel: BookListingViewModel.argument(categoryModel: item), screen: const BookListing());
        },
        trailing: const Icon(
          Icons.arrow_forward,
          color: AppColor.primaryColor,
        ),
        minLeadingWidth: 8,
        title: Text(
          item.cat_name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        tileColor: Colors.transparent,
        leading: SvgPicture.asset(item.cat_image,width: 30,height: 30,),
      ),
    );
  }
}
