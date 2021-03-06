import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PracticeApi extends StatefulWidget {
  @override
  _PracticeApiState createState() => _PracticeApiState();
}

class _PracticeApiState extends State<PracticeApi> {
  var newList = [];
  var data;
  Future<List<Welcome>> getApiData() async {
    String url = "https://testapi.saxonmarket.com/categories";
    Uri myuri = Uri.parse(url);
    var client = http.Client();
    var response = await client.get(myuri);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
    }

    return welcomeFromJson((response.body));
  }

  setDataFromJson() async {
    newList = await getApiData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setDataFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("New page"),
      ),
      body: ListView.builder(
          itemCount: newList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(newList[index].id.toString()),
              subtitle: Text(newList[index].name),

            );
          }),
    );
  }
}
