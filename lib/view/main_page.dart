import 'package:example/view/widget/remain_stat_list_tile.dart';
import 'package:example/view_model/store_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeViewModel = context.watch<StoreViewModel>();
    //final storeViewModel = Provider.of<StoreViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeViewModel.stores.length}곳'),
        actions: [
          IconButton(
              onPressed: () {
                storeViewModel.fetch();
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: storeViewModel.isLoading
          ? loadingWidget()
          : ListView(
              // 충분과 보통만 가져온다.
              children: storeViewModel.stores.map((e) {
                return ListTile(
                  title: Text('${e.name}'),
                  subtitle: Text('${e.addr}'),
                  trailing: RemainStatListTile(e),
                );
              }).toList(),
            ),
    );
  }



  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
