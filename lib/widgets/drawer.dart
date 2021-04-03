import 'package:flutter/material.dart';
import 'package:hypervolt_ble/providers/ble.dart';
import 'package:hypervolt_ble/providers/themeChanger.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<BLENotifier>(
              builder: (context, ble, _) => ListTile(
                title: Text(ble.isAutoModeOn
                    ? 'Disable Auto-Search'
                    : 'Enable Auto-Search'),
                subtitle: Text(ble.isAutoModeOn
                    ? 'Clicking here will disable auto search feature'
                    : 'This searches for every one minutes'),
                trailing: Icon(Icons.schedule_rounded),
                onTap: () {
                  ble.isAutoModeOn ? ble.stopAutoScan() : ble.startAutoScan();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<ThemeChanger>(
              builder: (context, themeChanger, _) => ListTile(
                title: Text(themeChanger.getTheme == ThemeMode.dark
                    ? 'Turn Day Mode On'
                    : 'Turn Night Mode On'),
                subtitle: Text(themeChanger.getTheme == ThemeMode.dark
                    ? 'This will brighten your theme.'
                    : 'This will make your theme dark.'),
                trailing: Icon(Icons.brightness_6_rounded),
                onTap: () {
                  themeChanger.swapTheme();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
