import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:hypervolt_ble/models/arguments.dart';

class DetailsPage extends StatelessWidget {
  final Arguments routeArgument;
  DetailsPage({@required this.routeArgument});

  @override
  Widget build(BuildContext context) {
    ScanResult sr = routeArgument.param1 as ScanResult;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        centerTitle: Platform.isIOS ? true : false,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (sr.device.name != null && sr.device.name != '')
                Text(
                  '-- Name --',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              if (sr.device.name == null || sr.device.name == '')
                Text(
                  '-- Id --',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              Center(
                child: Hero(
                  tag: sr.device.name != null && sr.device.name != ''
                      ? sr.device.name.toString()
                      : sr.device.id.toString(),
                  child: Text(
                    sr.device.name != null && sr.device.name != ''
                        ? sr.device.name.toString()
                        : sr.device.id.toString(),
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              if (sr.device.name != null && sr.device.name != '')
                Center(
                  child: Text(
                    '-- Id --',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              if (sr.device.name != null && sr.device.name != '')
                Center(
                  child: Text(
                    sr.device.id.toString(),
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
