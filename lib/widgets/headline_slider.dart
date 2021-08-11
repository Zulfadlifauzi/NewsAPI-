import 'package:carousel_slider/carousel_slider.dart';
import 'package:firstapp/bloc/get_top_headlines_bloc.dart';
import 'package:firstapp/elements/error_element.dart';
import 'package:firstapp/elements/loader_element.dart';
import 'package:firstapp/model/article.dart';
import 'package:firstapp/model/article_response.dart';
import 'package:firstapp/screens/news_detail.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HeadlineSliderWidget extends StatefulWidget {
  const HeadlineSliderWidget({Key? key}) : super(key: key);

  @override
  _HeadlineSliderWidgetState createState() => _HeadlineSliderWidgetState();
}

class _HeadlineSliderWidgetState extends State<HeadlineSliderWidget> {
  @override
  void initState() {
    super.initState();
    getTopHeadlinesBloc..getHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ArticleResponse>(
      stream: getTopHeadlinesBloc.subject.stream,
      builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
        if (snapshot.hasData) {
        if (snapshot.data?.error == null &&
        snapshot.data!.error.length > 0) {
        return buildErrorWidget(snapshot.data!.error);
        }
         return _buildHeadlineSliderWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }
  //   ignore: unrelated_type_equality_checks
  //   if (snapshot.hasError !=  snapshot.data!.error.length > 0) {
  //     return buildErrorWidget(snapshot.data!.error);
  //   }
  //   var data = snapshot.data!;
  //   return _buildHeadlineSliderWidget(data);
  // } else if (snapshot.hasError) {
  //   return buildErrorWidget(snapshot.data!.error);
  // } else {
  //   return buildLoadingWidget();

  Widget _buildHeadlineSliderWidget(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
            enlargeCenterPage: false, height: 200.0, viewportFraction: 0.9),
        items: getExpenseSliders(articles),
      ),
    );
  }

  getExpenseSliders(List<ArticleModel> articles) {
    return articles
        .map(
          (article) => GestureDetector(
            onTap: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewsDetail(article: article)));
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 10.0, bottom: 10.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          // ignore: unrelated_type_equality_checks
                          image: article.img == null
                              ? AssetImage("assets/img/placeholder.jpg")
                              : NetworkImage(article.img!)
                                  as ImageProvider),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [
                            0.1,
                            0.9
                          ],
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.white.withOpacity(0.0)
                          ]),
                    ),
                  ),
                  Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250.0,
                        child: Column(
                          children: <Widget>[
                            Text(
                              article.title!,
                              style: TextStyle(
                                  height: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      child: Text(
                        article.source.name!,
                        style: TextStyle(color: Colors.white54, fontSize: 9.0),
                      )),
                  Positioned(
                      bottom: 10.0,
                      right: 10.0,
                      child: Text(
                        timeAgo(DateTime.parse(article.date!)),
                        style: TextStyle(color: Colors.white54, fontSize: 9.0),
                      )),
                ],
              ),
            ),
          ),
        )
        .toList();
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
