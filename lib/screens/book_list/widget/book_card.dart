import 'package:book_app/common_widget/custom_cached_image.dart';
import 'package:book_app/helper/navigate_helper.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/screens/book_detail/book_detail.dart';
import 'package:book_app/screens/book_detail/view_model/book_detail_view_model.dart';
import 'package:book_app/theme/theme_config.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Results item;

  const BookCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        NavigationHelper().navigatePush(context: context, viewModel: BookDetailViewModel.argument(book: item), screen: const BookDetail());
      }),
      child: Container(
        constraints: const BoxConstraints(minHeight: 240),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            CustomCachedImage(
              imageUrl: item.formats!.imageJpeg,
              height: 150,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${item.title}".toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${item.authors != null && item.authors!.isNotEmpty ? item.authors![0].name : ''}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColor.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
