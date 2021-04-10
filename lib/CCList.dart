import 'dart:convert';
import 'package:cctracer/CCData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CCList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CCListState();
  }
  
}

class CCListState extends State<CCList> {
List<CCData> data = [];
   
  @override
  Widget build(BuildContext context) {
   
    return new Scaffold(
      appBar: AppBar(
        title: Text('Криптовалюты'),
      ),
      body: Container(
        child: ListView(
          children: _buildList() 
          ),
      ),
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: ()=> _loadCC(),
        ),
      

      );
  }
  _loadCC() async{
      var url =  Uri.https('api.coincap.io', '/v2/assets', {'limit': '15'});
    final response = await http.get(url);
    if (response.statusCode == 200){
      var allData = (json.decode(response.body) as Map)['data'];
      List<CCData> ccDataList = [];
      allData.forEach((val){
        var record = CCData(
          name: val['name'],
          symbol: val['symbol'],
          price: double.parse(val['priceUsd']),
          rank: int.parse(val['rank'])
        );
      ccDataList.add(record);
      });
      setState(() {
        data = ccDataList;
      });
    }
}
List<Widget> _buildList() {
 return data.map((CCData f) => ListTile(
   title: Text(f.name),
   subtitle: Text(f.symbol),
   leading: CircleAvatar(child: Text(f.rank.toString()),),
   trailing: Text('\$${f.price.toStringAsFixed(2)}'),
 )).toList();
}

void initState() {
  super.initState();
  _loadCC();
}
}