import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_0/model/todo.dart';
import 'package:flutter_application_0/platform_channel/platform_channel.dart';

class LocationFieldGroup extends StatefulWidget{

  const LocationFieldGroup({
    Key? key,
    required  this.child,
    required  this.onChange,
  }):super(key: key);


  final Function(Location) onChange;

  final Widget child;


  @override
  _LocationFiledGroupState createState() => _LocationFiledGroupState();


}

class _LocationFiledGroupState extends State<LocationFieldGroup>{
  bool  isLoading =false;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AbsorbPointer(
        child: Stack(
          children: <Widget>[
            isLoading? Center(
              child: CircularProgressIndicator(),
            ):Container(),
            Opacity(
              opacity: isLoading? 0.5:1.0,
              child: widget.child,)
          ],
        ),
      ),
      onTap: () async{
        setState(() {
          isLoading = true;
        });

        Location location = await PlatformChannel.getCurrentLocation();
        if(widget.onChange!=null){
          widget.onChange(location);
        }

        setState(() {
          isLoading = false;
        });
      },
    );
  }
}