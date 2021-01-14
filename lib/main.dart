import 'package:flutter/material.dart';
import 'strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(GHFlutterApp());
// the => operator for a single line function to run the app
// class for the app named GHFlutterApp

class GHFlutterState extends State<GHFlutter> {
  // primary task you have when making a new widget is
  // to override the build() method that gets called
  // when the widget is rendered to the screen

  var _members = <Member>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final member = Member(memberJSON["login"], memberJSON["avatar_url"]);

  // underscores at the beginning make the members of the class private

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold is a container for material design widgets
      appBar: AppBar(
        title: Text(Strings.appTitle),
      ),
      // body: Text(Strings.appTitle),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _members.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRow(position);
          }),
    );
  }

  Widget _buildRow(int i) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          title: Text("${_members[i].login}", style: _biggerFont),
          leading: CircleAvatar(
              backgroundColor: Colors.green,
              backgroundImage: NetworkImage(_members[i].avatarUrl)),
        ));
  }

  _loadData() async {
    // asynchronous HTTP call
    String dataURL = "https://api.github.com/orgs/raywenderlich/members";
    http.Response response = await http.get(dataURL);
    setState(() {
      final membersJSON = json.decode(response.body);
      for (var memberJSON in membersJSON) {
        final member = Member(memberJSON["login"]);
        _members.add(member);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }
}

class GHFlutterApp extends StatelessWidget {
  // entities in a Flutter app are widgets, either stateless or stateful
  @override
  Widget build(BuildContext context) {
    // override the widget build() method to create your app widget
    return MaterialApp(
      title: Strings.appTitle,
      home: GHFlutter(),
    ); // MaterialApp
  }
}

class GHFlutter extends StatefulWidget {
  @override
  createState() => GHFlutterState();
}

class Member {
  final String login;
  final String avatarUrl;

  Member(this.login, this.avatarUrl) {
    if (login == null) {
      throw ArgumentError("login of Member cannot be null. "
          "Received: '$login'");
    }
    if (avatarUrl == null) {
      throw ArgumentError("avatarUrl of Member cannot be null. "
          "Received: '$avatarUrl'");
    }
  }
}
