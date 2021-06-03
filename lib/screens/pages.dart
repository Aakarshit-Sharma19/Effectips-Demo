import "package:flutter/material.dart";
import 'package:effectips/components/habit_card.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: HabitCard(
        color: Colors.blue[500],
        frequency: "Daily",
        habit: "Programming",
      ),
    );
  }
}
