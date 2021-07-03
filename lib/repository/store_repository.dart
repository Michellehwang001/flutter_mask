import 'dart:convert';
import 'package:example/model/store.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
  Future<List<Store>> fetch() async {
    final List<Store> stores = [];

    var url = Uri.parse(
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');
    var response = await http.get(url);

    // final 은 상수값
    final jsonResult = jsonDecode(response.body);
    final jsonStores = jsonResult['stores'];

    // 익명함수 List<stores>를 만들어 준다.
    jsonStores.forEach((e) {
      Store store = Store.fromJson(e);
      stores.add(store);
    });

    print('fetch 완료');
    return stores;
  }
}
