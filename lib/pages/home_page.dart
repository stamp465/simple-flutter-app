import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/pages/add_person_page.dart';
import 'package:simple_people_data_list_app/pages/person_data_page.dart';
import 'package:simple_people_data_list_app/pages/person_list_page.dart';

import '../providers/bottom_navigation_index_provider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    PersonListPage(),
    AddPersonPage(),
    PersonDataPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavigationIndexWatcher =
        ref.watch(bottomNavigationIndexProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Text(widget.title),
      ),
      body: _widgetOptions.elementAt(bottomNavigationIndexWatcher),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            label: 'List of name',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'Add new person',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Person data',
          ),
        ],
        currentIndex: bottomNavigationIndexWatcher,
        selectedItemColor: Colors.purple[400],
        onTap: (index) {
          ref.read(bottomNavigationIndexProvider.notifier).state = index;
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
