import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/data_models/person.dart';
import 'package:simple_people_data_list_app/providers/people_provider.dart';
import 'package:simple_people_data_list_app/widgets/textfield_provider.dart';

class AddPersonPage extends ConsumerStatefulWidget {
  const AddPersonPage({super.key});

  @override
  AddPersonPageState createState() => AddPersonPageState();
}

class AddPersonPageState extends ConsumerState<AddPersonPage> {
  static const _maxStep = 2;

  final _stepperIndex = StateProvider<int>((ref) {
    return 0;
  });

  final TextEditingController _personDataFirstnameController =
      TextEditingController();
  final TextEditingController _personDataLastnameController =
      TextEditingController();
  final TextEditingController _personDataAddressController =
      TextEditingController();
  final TextEditingController _personDataProvinceController =
      TextEditingController();

  void onStepCancel(int stepperIndex) {
    switch (stepperIndex) {
      case 0:
        _personDataFirstnameController.clear();
        _personDataLastnameController.clear();
      case 1:
        _personDataAddressController.clear();
    }
    if (stepperIndex > 0) {
      ref.read(_stepperIndex.notifier).state -= 1;
    }
  }

  void onStepContinue(int stepperIndex) {
    if (stepperIndex < _maxStep - 1) {
      ref.read(_stepperIndex.notifier).state += 1;
    }
    if (stepperIndex == _maxStep - 1) {
      final personProviderWatcher = ref.watch(peopleProvider);
      ref.read(peopleProvider.notifier).state.add(
            Person(
              id: personProviderWatcher.length + 1,
              firstname: _personDataFirstnameController.text,
              lastname: _personDataLastnameController.text,
              address: _personDataAddressController.text,
              province: _personDataProvinceController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stepperIndexWatcher = ref.watch(_stepperIndex);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stepper(
            currentStep: stepperIndexWatcher,
            onStepCancel: () {
              onStepCancel(stepperIndexWatcher);
            },
            onStepContinue: () {
              onStepContinue(stepperIndexWatcher);
            },
            onStepTapped: (int index) {
              ref.read(_stepperIndex.notifier).state = index;
            },
            steps: [
              Step(
                title: const Text(
                  'Enter Firstname & Lastname',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      TextFieldProvider(
                        hintText: 'Firstname',
                        textController: _personDataFirstnameController,
                      ),
                      const SizedBox(height: 16),
                      TextFieldProvider(
                        hintText: 'Lastname',
                        textController: _personDataLastnameController,
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text(
                  'Enter Address according to ID card',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      TextFieldProvider(
                        hintText: 'Address',
                        textController: _personDataAddressController,
                      ),
                      const SizedBox(height: 16),
                      TextFieldProvider(
                        hintText: 'Province',
                        textController: _personDataProvinceController,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
