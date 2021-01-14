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
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter = _counter +2;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.display1,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
