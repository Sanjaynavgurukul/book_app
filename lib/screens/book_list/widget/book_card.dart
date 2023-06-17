import 'package:book_app/common_widget/custom_cached_image.dart';
import 'package:book_app/model/book_model.dart';
import 'package:book_app/theme/theme_config.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Results item;

  const BookCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {}),
      child: Container(
        constraints: BoxConstraints(minHeight: 240),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            // Container(
            //   decoration: BoxDecoration,
            //   height: 150,
            //   color: Colors.grey,
            // ),
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
