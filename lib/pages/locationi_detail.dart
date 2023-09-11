import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_0/component/label_group.dart';
import 'package:flutter_application_0/component/platform_text.dart';
import 'package:flutter_application_0/const/route_argument.dart';

class LocationDetailPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    LocationDetailArgument argument = ModalRoute.of(context)!.settings.arguments as LocationDetailArgument;

    return Scaffold(
      appBar: AppBar(
        title: Text('地点详情'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LabelGroup(labelText: '经度', child: Text(argument.location.latitude.toString()),),
          LabelGroup(labelText: '维度', child: Text(argument.location.latitude.toString())),
          LabelGroup(labelText: '位置', 
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: 16),
            child: PlatformText(text:argument.location.description),))
        ],
      ),
    );

  }

}