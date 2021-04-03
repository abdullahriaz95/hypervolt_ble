import 'package:flutter/material.dart';
import 'package:hypervolt_ble/screens/detailsPage.dart';
import 'package:hypervolt_ble/screens/scanPage.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/scan':
        return MaterialPageRoute(builder: (_) => ScanPage());
      case '/details':
        return MaterialPageRoute(
            builder: (_) => DetailsPage(routeArgument: args));
      default:
        return null;
    }
  }
}
