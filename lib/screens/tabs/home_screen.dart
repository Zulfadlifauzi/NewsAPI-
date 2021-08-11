import 'package:firstapp/widgets/headline_slider.dart';
import 'package:firstapp/widgets/hot_news.dart';
import 'package:firstapp/widgets/top_channels.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSliderWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Top channels', style:TextStyle(color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 17.0
          ),
          ),
        ),
        TopChannels(),
        Padding(padding:EdgeInsets.all(10.0),
        child: Text('Hot news',style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 17.0
        ),
        ),
        ),
        HotNews()
      ],
    );
  }
}
