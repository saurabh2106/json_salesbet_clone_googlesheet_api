import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_salesbet/appdata_model.dart';

class DynamicUIScreen extends StatefulWidget {
  const DynamicUIScreen({super.key});

  @override
  State<DynamicUIScreen> createState() => _DynamicUIScreenState();
}

class _DynamicUIScreenState extends State<DynamicUIScreen> {
  late Future<AppData?> _appDataFuture;

  static const sheetApiUrl =
      'https://script.google.com/macros/s/AKfycbwct9K3D4RlnEw3QiJ7Jh7GyQcTGT0UZvmGPYfgTLFijjCpCLZTpUQ4Wp5VFBBDuPVwIw/exec';

  @override
  void initState() {
    super.initState();
    _appDataFuture = fetchAppData();
  }

  Future<AppData?> fetchAppData() async {
    try {
      final response = await http.get(Uri.parse(sheetApiUrl));
      debugPrint('Status: ${response.statusCode}');
      debugPrint('Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return AppData.fromJson(jsonData);
      } else {
        debugPrint('Invalid status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Fetch error: $e');
      return null;
    }
  }

  IconData _getIcon(String name) {
    switch (name) {
      case 'sports_cricket':
        return Icons.sports_cricket;
      case 'sports_basketball':
        return Icons.sports_basketball;
      case 'sports_baseball':
        return Icons.sports_baseball;
      case 'sports_golf':
        return Icons.sports_golf;
      case 'list_alt_rounded':
        return Icons.list_alt_rounded;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppData?>(
      future: _appDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('Failed to load data')),
          );
        }

        final appData = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text(appData.appBar.title),
            backgroundColor: Colors.blueAccent,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appData.appTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  "Categories",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: appData.categories.length,
                    itemBuilder: (context, index) {
                      final item = appData.categories[index];
                      return Card(
                        margin: const EdgeInsets.only(right: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(_getIcon(item.icon), size: 32),
                              const SizedBox(height: 5),
                              Text(item.text),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const Divider(height: 32),

                Text(
                  appData.mainContent.infoBox.text,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Icon(_getIcon(appData.mainContent.infoBox.icon), size: 40),

                const Divider(height: 32),

                Text(
                  appData.mainContent.aboutUs.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(appData.mainContent.aboutUs.description),

                const Divider(height: 32),

                Text.rich(
                  TextSpan(
                    text: "${appData.mainContent.footer.text} ",
                    children: [
                      TextSpan(
                        text: appData.mainContent.footer.highlight,
                        style: const TextStyle(color: Colors.blue),
                      ),
                      TextSpan(text: " ${appData.mainContent.footer.suffix}"),
                    ],
                  ),
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
