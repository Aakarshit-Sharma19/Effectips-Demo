import 'dart:convert';
import 'package:effectips/components/home/blog_item_card.dart';
import 'package:effectips/models/blog_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

final blogListProvider = StateProvider<List<BlogListItem>>((ref) {
  return [];
});
final loadingProvider = StateProvider<bool>((ref) {
  return true;
});

class BlogListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final blogListState = watch(blogListProvider).state;
    bool isLoadingState = watch(loadingProvider).state;
    if (isLoadingState) _fetchBlogs(context);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      child: !isLoadingState
          ? ListView.builder(
              itemBuilder: (BuildContext context, int i) {
                // return Text('hello world');
                if (i == blogListState.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  );
                }
                return BlogItemCard(
                    title: blogListState[i].title,
                    thumbnailUrl: blogListState[i].thumbnailUrl,
                    publishedBy: blogListState[i].publishedBy);
              },
              itemCount: blogListState.length + 1,
            )
          : ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => Card(
                elevation: 11.0,
                child: Container(
                  height: 275,
                  child: Shimmer.fromColors(
                    highlightColor: Colors.grey[500],
                    baseColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 15,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 20,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
    );
  }

  void _fetchBlogs(BuildContext context) {
    http
        .get(Uri.parse('https://effectips.herokuapp.com/api/blog/list/'))
        .then((response) => json.decode(response.body))
        .then((blogs) => List<BlogListItem>.from(
            blogs.map((model) => BlogListItem.fromJson(model))))
        .then((blogList) {
      context.read(blogListProvider).state = blogList;
      context.read(loadingProvider).state = false;
    });
  }
}
