import 'package:book_app/screens/book_list/view_model/book_listing_view_model.dart';
import 'package:book_app/screens/book_list/widget/book_card.dart';
import 'package:book_app/theme/theme_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BookListing extends StatefulWidget {
  const BookListing({Key? key}) : super(key: key);

  @override
  State<BookListing> createState() => _BookListingState();
}

class _BookListingState extends State<BookListing> {
  //View Model
  late var viewModel = BookListingViewModel();
  bool dataCalled = false;
  ScrollController _scrollController = ScrollController();
  TextEditingController _controller =TextEditingController();

  @override
  void didChangeDependencies() {
    viewModel = context.watch<BookListingViewModel>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    viewModel.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Add a listener to the scroll controller to check for scroll events
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // User has scrolled to the bottom, load more data
      if (viewModel.isLoading) {
        return;
      }

      viewModel.isLoading = true;
      // Simulate an asynchronous data loading delay
      await Future.delayed(const Duration(seconds: 2));
      getData(fromDirect: true, fromPagination: true);
    }
  }

  void getData({bool fromDirect = false, bool fromPagination = false}) {
    if (dataCalled && !fromDirect) {
      return;
    }

    dataCalled = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getBookByCategory(fromPagination: fromPagination);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookListingViewModel>(
      builder: (context, viewModel, child) {
        //check category Model
        if (viewModel.categoryModel == null) {
          return Material(
            color: AppColor.scaffoldBackground,
            child: const Center(
              child: Text(
                'No Category Found',
                style: TextStyle(color: AppColor.primaryColor),
              ),
            ),
          );
        }

        //Get Data
        getData();

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset('assets/image/back.svg'),
            ),
            title: Text(
              viewModel.categoryModel!.cat_name,
              style: const TextStyle(
                fontSize: 24,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                child: CupertinoSearchTextField(
                  controller: _controller,
                  onChanged: (String value) {
                    // Future.delayed(Duration(milliseconds: 400),((){
                    // }));
                    // print('The text has changed to: $value');
                  },
                  prefixIcon: const Icon(CupertinoIcons.search,color: AppColor.grey,),
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.lightGrey,
                  ),
                    placeholder: "Search",
                  suffixIcon: const Icon(Icons.close),
                  onSuffixTap: (){
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                    viewModel.searchQuarry = '';
                    viewModel.pageCount = 1;
                    getData(fromDirect: true);
                  },
                  onSubmitted: (String value) {
                    viewModel.searchQuarry = _controller.text;
                    viewModel.pageCount = 1;
                    getData(fromDirect: true);
                  },
                ),
              ),
              Expanded(
                child: mainList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget mainList() {
    if (viewModel.bookModel == null) {
      return Container(
        child: const Text("Loading..."),
      );
    }

    if (viewModel.bookModel!.results == null || viewModel.bookModel!.results!.isEmpty) {
      return Container(
        child: const Text("No Data Found"),
      );
    }

    return MasonryGridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      addAutomaticKeepAlives: true,
      controller: _scrollController,
      addRepaintBoundaries: false,
      itemCount: viewModel.bookModel!.results!.length + 1,
      itemBuilder: (context, index) {
        if (index == viewModel.bookModel!.results!.length) {
          // Show the loading indicator at the last position
          return viewModel.isLoading ? const Center(child: CupertinoActivityIndicator()) : const SizedBox();
        } else {
          var item = viewModel.bookModel!.results![index];
          return BookCard(item: item);
        }

      },
      crossAxisCount: 3,
    );
  }
}

// class BookListing extends StatefulWidget {
//   const BookListing({Key? key}) : super(key: key);
//
//   @override
//   State<BookListing> createState() => _BookListingState();
// }
//
// class _BookListingState extends State<BookListing> {
//   //View Model
//   late var viewModel = BookListingViewModel();
//   bool dataCalled = false;
//
//   @override
//   void didChangeDependencies() {
//     viewModel = context.watch<BookListingViewModel>();
//     super.didChangeDependencies();
//   }
//
//   void getData({bool fromDirect = false}){
//     if(dataCalled && !fromDirect){
//       return;
//     }
//
//     dataCalled = true;
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       viewModel.getBookByCategory();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BookListingViewModel>(
//       builder: (context, viewModel, child) {
//         //check category Model
//         if (viewModel.categoryModel == null) {
//           return Material(
//             color: AppColor.scaffoldBackground,
//             child: const Center(
//               child: Text(
//                 'No Category Found',
//                 style: TextStyle(color: AppColor.primaryColor),
//               ),
//             ),
//           );
//         }
//
//         //Get Data
//         getData();
//
//         return Scaffold(
//           floatingActionButton: FloatingActionButton(onPressed: (){
//             viewModel.getBookByCategory();
//           },child: Icon(Icons.add),),
//           appBar: AppBar(
//             elevation: 0,
//             leading: IconButton(
//               onPressed: () => Navigator.pop(context),
//               icon: SvgPicture.asset('assets/image/back.svg'),
//             ),
//             title:  Text(
//               viewModel.categoryModel!.cat_name,
//               style: const TextStyle(
//                 fontSize: 24,
//                 color: AppColor.primaryColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           body: Column(
//             children: [
//               Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.lightGrey),
//                 ),
//               ),
//               Expanded(
//                 child: mainList(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget mainList(){
//     if(viewModel.bookModel == null){
//       return Container(
//         child: Text("Loading..."),
//       );
//     }
//
//     if(viewModel.bookModel!.results == null || viewModel.bookModel!.results!.isEmpty){
//       return Container(
//         child: Text("No Data Found"),
//       );
//     }
//
//     return AlignedGridView.count(
//       shrinkWrap: true,
//       mainAxisSpacing: 4,
//       crossAxisSpacing: 4,
//       addAutomaticKeepAlives: true,
//       itemCount: viewModel.bookModel!.results!.length,
//       itemBuilder: (context, index) {
//         var item = viewModel.bookModel!.results![index];
//         return  BookCard(item:item);
//       },
//       crossAxisCount: 3,
//     );
//   }
//
// }
