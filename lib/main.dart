import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: JsonPage());
  }
}

class JsonPage extends StatefulWidget {
  const JsonPage({Key? key}) : super(key: key);

  @override
  _JsonPageState createState() => _JsonPageState();
}

class _JsonPageState extends State<JsonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: Center(
        child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString("../assets/mockdata.json"),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var showData = json.decode(snapshot.data.toString());

                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            child: CircleAvatar(
                              backgroundImage: showData[index]
                                      .containsKey('avatar')
                                  ? NetworkImage(showData[index]['avatar'])
                                  : NetworkImage(
                                      'https://static.thenounproject.com/png/3134331-200.png'),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      showData[index]['first_name'] +
                                          " " +
                                          showData[index]['last_name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(showData[index]['username']),
                                    Text(showData[index].containsKey("status")
                                        ? showData[index]['status']
                                        : 'N/A')
                                  ],
                                ),
                              )),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                            child: Column(
                              children: [
                                Text(
                                  showData[index]['last_seen_time'],
                                ),
                                CircleAvatar(
                                  child: Text(showData[index]
                                          .containsKey('messages')
                                      ? showData[index]['messages'].toString()
                                      : "0"),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: showData.length,
                );
              } else
                return Center(child: Text("Loading..."));
            }),
      ),
    );
  }
}
