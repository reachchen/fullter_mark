import 'package:flutter/services.dart';
import 'package:flutter_application_0/model/todo.dart';

class PlatformChannel {

  static const MethodChannel _channel = const MethodChannel('com.funny_flutter.todo_list.channel');

  static Future<Location> getCurrentLocation() async {

    Map? locationMap = await _channel.invokeMethod<Map>('getCurrentLocation');

    return Location(
      latitude: double.parse(locationMap!['latitude']),
      longitude: double.parse(locationMap['longitude']),
      description: locationMap['description']
    );
  }

}
