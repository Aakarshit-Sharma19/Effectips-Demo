import 'package:flutter/material.dart';
import 'package:effectips/constants/colors.dart';

class HabitCard extends StatefulWidget {
  HabitCard(
      {@required this.habit, @required this.frequency, @required this.color});

  final String habit;
  final String frequency;
  final Color color;

  @override
  _HabitCardState createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF303038),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 150,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                widget.habit,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Expanded(child: Container()),
              Text(
                widget.frequency,
                style: TextStyle(
                    color: kTextColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal),
              ),
              Icon(
                Icons.notifications_none,
                color: widget.color,
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          WeekCalender(widget.color),
        ],
      ),
    );
  }
}

class WeekCalender extends StatefulWidget {
  WeekCalender(this.color);
  final Color color;

  @override
  _WeekCalenderState createState() => _WeekCalenderState();
}

class _WeekCalenderState extends State<WeekCalender> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        DayIncomplete(
          day: 'Tue',
          date: '21',
          color: widget.color,
        ),
        DayComplete(
          day: 'Mon',
          date: '20',
          color: widget.color,
        ),
        DayComplete(
          day: 'Sun',
          date: '19',
          color: widget.color,
        ),
        DayIncomplete(
          day: 'Sat',
          date: '18',
          color: widget.color,
        ),
        DayComplete(
          day: 'Fri',
          date: '17',
          color: widget.color,
        ),
        DayComplete(
          day: 'Thu',
          date: '16',
          color: widget.color,
        ),
        DayComplete(
          day: 'Wed',
          date: '15',
          color: widget.color,
        ),
      ],
    );
  }
}

class DayIncomplete extends StatefulWidget {
  DayIncomplete({this.day, this.date, this.color});
  final String day;
  final String date;
  final Color color;

  @override
  _DayIncompleteState createState() => _DayIncompleteState();
}

class _DayIncompleteState extends State<DayIncomplete> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          widget.day,
          style: TextStyle(color: kTextColor),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 40.0,
          width: 40.0,
          child: Center(
            child: Text(
              widget.date,
              style: TextStyle(
                color: widget.color,
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Color(0xFF303038),
            shape: BoxShape.circle,
            border: Border.all(color: this.widget.color, width: 2.0),
          ),
        ),
      ],
    );
  }
}

class DayComplete extends StatelessWidget {
  DayComplete({this.day, this.date, this.color});
  final String day;
  final String date;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          day,
          style: TextStyle(color: kTextColor),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 40.0,
          width: 40.0,
          child: Center(
            child: Text(
              date,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 100,
            child: Text('A card that can be tapped'),
          ),
        ),
      ),
    );
  }
}
