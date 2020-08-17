import 'package:flutter/material.dart';
import 'advices.dart';
import 'who_topic.dart';

class TopicDetailWidget extends StatelessWidget {
  final WHOTopic topic;

  TopicDetailWidget({this.topic});

  @override
  Widget build(BuildContext context) {
    var children = List<Widget>();

    topic.questions.forEach((element) {
      children.add(SectionCardWidget(
        title: element.title,
        description: element.subtitle,
      ));
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.deepOrange),
          title: Text(topic.title,style: TextStyle(color: Colors.deepOrange),),
        ),
        body: Center(
            child: Container(
                constraints: BoxConstraints(maxWidth: 768),
                child: ListView(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    children: children))));
  }
}
