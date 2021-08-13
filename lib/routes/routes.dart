import 'package:dictionaryapp/frontend/map.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String map = 'map_page';

  Map<String, WidgetBuilder> routes() {
    return {map: (context) => MapPage()};
  }
}
