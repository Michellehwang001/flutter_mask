import 'package:example/model/store.dart';
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
          title: Text(
              '마스크 재고 있는 곳 : ${storeViewModel.stores.where((e) => (e.remainStat == 'plenty' || e.remainStat == 'some' || e.remainStat == 'few')).length}곳'),
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
          children: storeViewModel.stores
              .where((e) => (e.remainStat == 'plenty' ||
              e.remainStat == 'some' ||
              e.remainStat == 'few'))
              .map((e) {
            return ListTile(
              title: Text('${e.name}'),
              subtitle: Text('${e.addr}'),
              trailing: _buildRemainStatWidget(e),
            );
          }).toList(),
        ),
      );
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    if (store.remainStat == 'plenty') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    } else if (store.remainStat == 'some') {
      remainStat = '';
      description = '100개 이상';
      color = Colors.green;
    }

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30~100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2~30개';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: [
        Text(
          '$remainStat',
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(
          '$description',
          style: TextStyle(color: color),
        ),
      ],
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
