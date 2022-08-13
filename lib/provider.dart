import 'dart:convert';

import 'package:flutter_practice_api/data/postal_code.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

StateProvider<String> postalCodeProvider = StateProvider(
  (ref) => '',
);

FutureProvider<PostalCode> apiProvider = FutureProvider((ref) async {
  final postalcode = ref.watch(postalCodeProvider.state).state;
  if (postalcode.length != 7) {
    //7桁じゃない場合
    throw Exception('Postal Code must be 7 charactors'); //7桁じゃないよ
  }
  final upper = postalcode.substring(0, 3); //郵便番号最初の3桁
  final lower = postalcode.substring(3); //後の4桁
  final apiUrl =
      'https://madefor.github.io/postal-code-api/api/v1/$upper/$lower.json'; // アクセスするアドレス
  final apiUri = Uri.parse(apiUrl); //URIに変更
  http.Response response = await http.get(apiUri);

  if (response.statusCode != 200) {
    throw Exception('No postal code: $postalcode');
  }

  var jsonData = json.decode(response.body);
  return PostalCode.fromJson(jsonData);
});
