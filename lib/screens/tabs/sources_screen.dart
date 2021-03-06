import 'package:firstapp/bloc/get_sources_bloc.dart';
import 'package:firstapp/elements/error_element.dart';
import 'package:firstapp/elements/loader_element.dart';
import 'package:firstapp/model/source.dart';
import 'package:firstapp/model/source_response.dart';
import 'package:flutter/material.dart';

import '../sources_detail.dart';

class SourceScreen extends StatefulWidget {
  const SourceScreen({Key? key}) : super(key: key);

  @override
  _SourceScreenState createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  @override
  void initState() {
    super.initState();
    getSourcesBloc..getSources();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
      stream: getSourcesBloc.subject.stream,
      builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
        if (snapshot.hasData) {
          // ignore: unnecessary_null_comparison
          if (snapshot.data?.error == null && snapshot.data!.error.length > 0) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildSources(snapshot.data!);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildSources(SourceResponse data) {
    List<SourceModel> sources = data.sources;
    return GridView.builder(
        itemCount: sources.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 0.86),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
            child: GestureDetector(
              onTap: () {
               Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SourceDetail(source: sources[index])));

              },
              child: Container(
                width: 100.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[100]!,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(1.0, 1.0))
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(tag: sources[index].id!, child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logos/${sources[index].id}.png'),
                            fit: BoxFit.cover
                          )
                        ),
                      )),
                      Container(
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                          top: 15.0,
                          bottom: 15.0,
                        ),
                        child: Text(
                          sources[index].name!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      )
                    ],
                  ),
              ),
            ),
          );
        });
  }
}
