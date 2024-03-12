import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/providers/bottom_navigation_index_provider.dart';
import 'package:simple_people_data_list_app/widgets/person_list_province_widget.dart';
import 'package:simple_people_data_list_app/widgets/person_list_widget.dart';

class PersonListPage extends ConsumerStatefulWidget {
  const PersonListPage({super.key});

  @override
  PersonListPageState createState() => PersonListPageState();
}

class PersonListPageState extends ConsumerState<PersonListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                      Tab(text: 'รายชื่อทั้งหมด'),
                      Tab(text: 'รายชื่อตามจังหวัด'),
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
          height: 60,
          color: Colors.amber,
          child: Center(
            child: IconButton(
              icon: const Text('เพิ่มข้อมูล'),
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
