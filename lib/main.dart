import 'package:flutter/material.dart';
import 'package:flutter_practice_api/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postalCode = ref.watch(apiProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text) => onPostalCodeChanged(text, ref),
            ),
            Text(postalCode?.data[0].en.address1 ?? 'No postal code')
          ],
        ),
      ),
    );
  }

  void onPostalCodeChanged(String text, WidgetRef ref) {
    if (text.length != 7) {
      return;
    }

    try {
      int.parse(text);
      ref.watch(postalCodeProvider.state).state = text;
      print(text);
    } catch (ex) {}
  }
}
