import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final bool showBorder;
  final Color? color;
  final BoxFit fit;

   const CustomCachedImage({
    Key? key,
    required this.imageUrl,
    this.height = double.infinity,
    this.width=double.infinity,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
    this.borderRadius =  const BorderRadius.all(Radius.circular(6)),
    this.border,
    this.color,
    this.fit = BoxFit.cover,
    this.showBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: imageUrl??'',
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        margin: margin,
        padding:padding,

        decoration: BoxDecoration(
          borderRadius:
          borderRadius ?? BorderRadius.circular(8),
          border: showBorder ? border : null,
          color: color??Colors.grey[100],
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          border: showBorder ? border : null,
          borderRadius:
          borderRadius ?? BorderRadius.circular(8),
          color: color ?? Colors.grey[100],
        ),
        child: const Center(
          child:
          CircularProgressIndicator(strokeWidth: 0.2, color: Colors.black),
        ),
      ),
      errorWidget: (context, url, error){
        return Container(
          width: width,
          height: height,
          margin: margin,
          padding:padding,

          decoration: BoxDecoration(
            borderRadius:
            borderRadius ?? BorderRadius.circular(8),
            border: showBorder ? border : null,
            color: color??Colors.grey[100],
            image: DecorationImage(
              image: AssetImage("assets/image/img.png"),
              fit: fit,
            ),
          ),
          // child: Center(child: Text("NO Image"),),
        );
      },
    );
  }
}
