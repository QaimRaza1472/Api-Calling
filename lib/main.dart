import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
// to remove top  shadow or small bar  on the screen

  /*  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ),
  );*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _users = [];
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const FittedBox(
          child: Text('API Call'),
        ),
      ),
      body: _users.isNotEmpty
          ? ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).primaryColor,
                                  //color:Colors.red.withOpacity(0.2),
                                  offset: Offset(0, 5),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                )
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  _users[index]['image'],
                                ),
                                fit: BoxFit.contain,
                              )),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              _users[index]['firstName'],
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(_users[index]['email']),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(_users[index]['phone']),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Container(
              child: Center(
                child: _loading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: loadUserList,
                        child: const Text("Load Users"),
                      ),
              ),
            ),
    );
  }

  void loadUserList() async {
    setState(() {
      _loading = true;
    });
    var res = await http.get(Uri.https('dummyjson.com', 'users'));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      setState(() {
        _users = jsonData['users'];
        _loading = false;
        print("##############################");
        print(_users);
      });
    }
  }
}
