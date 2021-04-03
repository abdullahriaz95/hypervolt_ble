import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:hypervolt_ble/models/arguments.dart';
import 'package:hypervolt_ble/providers/themeChanger.dart';
import 'package:hypervolt_ble/widgets/drawer.dart';
import 'package:hypervolt_ble/widgets/loadingList.dart';
import 'package:hypervolt_ble/providers/ble.dart';

import 'package:provider/provider.dart';

class ScanPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      endDrawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
        centerTitle: Platform.isIOS ? true : false,
        actions: [
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
            child: Icon(
              Icons.menu_rounded,
            ),
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      body: _mainLayout(context),
    );
  }

  Widget _mainLayout(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Provider.of<BLENotifier>(context, listen: false).scan();
      },
      child: Consumer<BLENotifier>(
        builder: (context, ble, _) => ble.isLoading
            ? LoadingListPage()
            : Container(
                child: StreamBuilder<List<ScanResult>>(
                  stream: Provider.of<BLENotifier>(context, listen: false)
                      .bluetoothDevicesStream,
                  initialData: null,
                  builder: (c, AsyncSnapshot<List<ScanResult>> snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.active) {
                      List<ScanResult> listResult = snapshot.data;
                      if (listResult.length == 0) {
                        return _noDeviceFoundLayout(context);
                      }
                      return _devicesFoundLayout(listResult, context);
                    } else if (snapshot.connectionState ==
                            ConnectionState.active &&
                        snapshot.data == null)
                      return _noDeviceFoundLayout(context);
                    else
                      return Container();
                  },
                ),
              ),
      ),
    );
  }

  Widget _devicesFoundLayout(
      List<ScanResult> listResult, BuildContext context) {
    ThemeMode themeModeNow =
        Provider.of<ThemeChanger>(context).getTheme as ThemeMode;
    print('lists - $listResult');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text('Pull down to refresh',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.separated(
                separatorBuilder: (context, i) {
                  return Container(
                    height: 12,
                  );
                },
                itemCount: listResult.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: Arguments(param1: listResult[index]),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: themeModeNow == ThemeMode.dark
                              ? Colors.green.shade600
                              : Colors.green.shade200),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Hero(
                          tag: listResult[index].device.name != null &&
                                  listResult[index].device.name != ''
                              ? listResult[index].device.name.toString()
                              : listResult[index].device.id.toString(),
                          child: Text(
                            listResult[index].device.name != null &&
                                    listResult[index].device.name != ''
                                ? listResult[index].device.name.toString()
                                : listResult[index].device.id.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noDeviceFoundLayout(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 40,
        ),
        SizedBox(
          height: 200,
          width: 200,
          child: Image.asset(
            'assets/icons/safebox.png',
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Center(
          child: Column(
            children: [
              Text(
                'No devices found at the moment',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Text('Pull down to refresh',
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
      ],
    );
  }
}
