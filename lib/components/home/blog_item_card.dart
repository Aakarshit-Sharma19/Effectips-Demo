import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BlogItemCard extends StatelessWidget {
  BlogItemCard(
      {@required this.title, @required this.publishedBy, this.thumbnailUrl});
  final String title;
  final String publishedBy;
  final String thumbnailUrl;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 11.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: CachedNetworkImage(
        imageUrl: thumbnailUrl,
        fadeInDuration: Duration(milliseconds: 500),
        fadeOutDuration: Duration(milliseconds: 1),
        fit: BoxFit.cover,
        errorWidget: (context, string, dynam) => Stack(children: [
          BlogCardContainer(
            publishedBy: publishedBy,
            title: title,
            boxDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(
            height: 250,
            child: Center(child: Icon(Icons.broken_image_rounded, size: 40)),
          )
        ]),
        placeholder: (context, url) => Container(
          height: 275,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 1,
                )),
              ],
            ),
          ),
        ),
        fadeInCurve: Curves.bounceInOut,
        fadeOutCurve: Curves.bounceIn,
        imageBuilder: (context, imageProvider) => BlogCardContainer(
          publishedBy: publishedBy,
          title: title,
          boxDecoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class BlogCardContainer extends StatelessWidget {
  const BlogCardContainer(
      {Key key,
      @required this.publishedBy,
      @required this.title,
      this.boxDecoration});

  final String publishedBy;
  final String title;
  final BoxDecoration boxDecoration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        width: double.maxFinite,
        height: 275,
        decoration: boxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    20.0,
                  ),
                  bottomRight: Radius.circular(
                    20.0,
                  ),
                  topLeft: Radius.circular(
                    10,
                  ),
                  topRight: Radius.circular(
                    10,
                  ),
                ),
                color: Colors.white.withOpacity(0.7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      publishedBy,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      title,
                      style: TextStyle(fontSize: 15.0, fontFamily: "Roboto"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
