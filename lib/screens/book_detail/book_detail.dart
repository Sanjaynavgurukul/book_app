import 'dart:io';

import 'package:archive/archive.dart';
import 'package:book_app/common_widget/custom_cached_image.dart';
import 'package:book_app/theme/theme_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'view_model/book_detail_view_model.dart';
import 'package:http/http.dart' as http;

class BookDetail extends StatefulWidget {
  const BookDetail({Key? key}) : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late var viewModel = BookDetailViewModel();

  @override
  void didChangeDependencies() {
    viewModel = context.watch<BookDetailViewModel>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              'Book Detail',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 60,
            width: double.infinity,
            child: InkWell(
              onTap: viewModel.isLoading
                  ? null
                  : () async {
                      String? htmlLink = viewModel.book!.formats!.textHtmlCharsetUtf8;
                      if (htmlLink != null && htmlLink.isNotEmpty) {
                        if (await canLaunch(htmlLink)) {
                          await launch(htmlLink);
                        } else {
                          viewModel.showToast(message: "Something Went Wrong", context: context);
                        }
                        return;
                      }

                      viewModel.setLoading(true);
                      viewModel.extractAndReturnHtmlFile(filePth: viewModel.book!.formats!.textHtml!).then((value) async {
                        if (value == null || value.isEmpty) {
                          viewModel.setLoading(false);
                          viewModel.showToast(message: 'Some Went Wrong', context: context);
                          return;
                        }
                        print('check path ---- ${value}');
                        viewModel.setLoading(false);

                        final result = await OpenFile.open(value);
                        if (result.type != ResultType.done) {
                          // Error handling if the file cannot be opened
                          viewModel.showToast(message: "Something Went Wrong", context: context);
                          print('Error opening file: ${result.message}');
                        }
                      });
                    },
              child: Container(
                margin: const EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.primaryColor),
                child: viewModel.isLoading
                    ? const CupertinoActivityIndicator()
                    : const Text('READ BOOK', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
          body: mainView(),
        );
      },
    );
  }

  Widget mainView() {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          children: [bookSection(), authorSection()],
        ),
      ),
    );
  }

  Widget bookSection() {
    if (viewModel.book!.authors == null || viewModel.book!.authors!.isEmpty) {
      return const SizedBox();
    }

    var author = viewModel.book!.authors![0];
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomCachedImage(
              imageUrl: viewModel.book!.formats!.imageJpeg,
              height: 150,
              width: 100,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${viewModel.book!.title!}',
                      style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  Text('Language : ${viewModel.book!.languages!.join(",")}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff5B5B5B),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      )),
                  Text('Total Download : ${viewModel.book!.downloadCount!}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff5B5B5B),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      )),
                  Text('Media Type : ${viewModel.book!.mediaType!}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff5B5B5B),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
    // return Container(
    //     margin: const EdgeInsets.only(top: 10),
    //     color: Colors.white,
    //     child: Column(
    //       children: [
    //         const ListTile(
    //           title: Text("Book Author", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    //         ),
    //         Container(
    //           margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xffF5F5F5)),
    //           child:  Padding(
    //             padding: const EdgeInsets.all(12),
    //             child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 CustomCachedImage(
    //                   imageUrl: "",
    //                   width: 78,
    //                   height: 78,
    //                   borderRadius: BorderRadius.circular(16),
    //                 ),
    //                 const SizedBox(
    //                   width: 16,
    //                 ),
    //                 Expanded(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       const Row(
    //                         children: [
    //                           Text('AUTHOR',
    //                               style: TextStyle(
    //                                 color: Color(0xff1ABED1),
    //                                 fontWeight: FontWeight.w600,
    //                               )),
    //                           Spacer(),
    //                           Icon(
    //                             Icons.arrow_right_alt_rounded,
    //                             color: Color(0xff1ABED1),
    //                           )
    //                         ],
    //                       ),
    //                       Text('${viewModel.book!.authors![0].name}',
    //                           maxLines: 2,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: const TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 18,
    //                           )),
    //                       const Text('Age : ${}',
    //                           maxLines: 2,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: TextStyle(
    //                             color: Color(0xff5B5B5B),
    //                             fontWeight: FontWeight.w400,
    //                             fontSize: 14,
    //                           ))
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ));
  }

  Widget authorSection() {
    if (viewModel.book!.authors == null || viewModel.book!.authors!.isEmpty) {
      return const SizedBox();
    }

    var author = viewModel.book!.authors![0];
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomCachedImage(
              imageUrl: "",
              width: 78,
              height: 78,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    children: [
                      Text('AUTHOR',
                          style: TextStyle(
                            color: AppColor.primaryColor,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                  Text('${viewModel.book!.authors![0].name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      )),
                  Text('Birth Year : ${author.birthYear!}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff5B5B5B),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      )),
                  Text('Death Year : ${author.deathYear!}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff5B5B5B),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
    // return Container(
    //     margin: const EdgeInsets.only(top: 10),
    //     color: Colors.white,
    //     child: Column(
    //       children: [
    //         const ListTile(
    //           title: Text("Book Author", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    //         ),
    //         Container(
    //           margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: const Color(0xffF5F5F5)),
    //           child:  Padding(
    //             padding: const EdgeInsets.all(12),
    //             child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 CustomCachedImage(
    //                   imageUrl: "",
    //                   width: 78,
    //                   height: 78,
    //                   borderRadius: BorderRadius.circular(16),
    //                 ),
    //                 const SizedBox(
    //                   width: 16,
    //                 ),
    //                 Expanded(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       const Row(
    //                         children: [
    //                           Text('AUTHOR',
    //                               style: TextStyle(
    //                                 color: Color(0xff1ABED1),
    //                                 fontWeight: FontWeight.w600,
    //                               )),
    //                           Spacer(),
    //                           Icon(
    //                             Icons.arrow_right_alt_rounded,
    //                             color: Color(0xff1ABED1),
    //                           )
    //                         ],
    //                       ),
    //                       Text('${viewModel.book!.authors![0].name}',
    //                           maxLines: 2,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: const TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 18,
    //                           )),
    //                       const Text('Age : ${}',
    //                           maxLines: 2,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: TextStyle(
    //                             color: Color(0xff5B5B5B),
    //                             fontWeight: FontWeight.w400,
    //                             fontSize: 14,
    //                           ))
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ));
  }
}
