import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/providers/bottom_navigation_index_provider.dart';
import 'package:simple_people_data_list_app/providers/person_information_provider.dart';
import 'package:simple_people_data_list_app/widgets/person_list_province_widget.dart';
import 'package:simple_people_data_list_app/widgets/person_list_widget.dart';

class PersonListPage extends ConsumerStatefulWidget {
  const PersonListPage({super.key});

  @override
  PersonListPageState createState() => PersonListPageState();
}

class PersonListPageState extends ConsumerState<PersonListPage> {
  @override
  void initState() {
    super.initState();
    ref.read(personsList.notifier).init();
    ref.read(personsList.notifier).streamDB();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('PersonListPage'),
      children: [
        const Expanded(
          child: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: TabBar(
                    tabs: [
                      Tab(text: 'List of name'),
                      Tab(text: 'List of name (By province)'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      PersonListWidget(),
                      PersonListByProvinceWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 40,
          color: Colors.purple[700],
          child: Center(
            child: IconButton(
              icon: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Add New Person Data',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                ref.read(bottomNavigationIndexProvider.notifier).state = 1;
              },
            ),
          ),
        ),
      ],
    );
  }
}
