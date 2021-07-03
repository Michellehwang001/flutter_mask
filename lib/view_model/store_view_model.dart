import 'package:example/model/store.dart';
import 'package:example/repository/store_repository.dart';
import 'package:flutter/foundation.dart';

class StoreViewModel with ChangeNotifier{
  bool isLoading = false;
  List<Store> stores = [];

  // _ view 에서 접근 할 수 없다.
  final _storeRepository = StoreRepository();

  StoreViewModel() {
    fetch();
  }

  Future fetch() async{
    isLoading = true;
    notifyListeners();

    stores = await _storeRepository.fetch();
    isLoading = false;
    notifyListeners();
  }
}