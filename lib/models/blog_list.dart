import 'package:flutter/material.dart';

class BlogListItem {
  final String title;
  final String slug;
  final String publishedBy;
  final String publishedDate;
  final String thumbnailUrl;
  BlogListItem(this.title, this.slug, this.publishedBy, this.publishedDate,
      this.thumbnailUrl);

  BlogListItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        slug = json['slug'],
        publishedBy = json['published_by']['full_name'],
        publishedDate = json['published_date'],
        thumbnailUrl = json['thumbnail'];

  Map<String, dynamic> toJson() => {
        "published_by": {
          "full_name": this.publishedBy,
        },
        "title": title,
        "slug": slug,
        "thumbnail": thumbnailUrl,
        "published_date": publishedDate
      };
}
