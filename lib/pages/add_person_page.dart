import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:simple_people_data_list_app/data_models/person.dart';
import 'package:simple_people_data_list_app/utils/datetime_utils.dart';

import '../database/database.dart';
import '../widgets/custom_textfield.dart';

final addPersonDataErrorProvider = StateProvider<String?>((ref) {
  return null;
});

class AddPersonPage extends ConsumerStatefulWidget {
  const AddPersonPage({super.key});

  @override
  AddPersonPageState createState() => AddPersonPageState();
}

class AddPersonPageState extends ConsumerState<AddPersonPage> {
  static const _maxStep = 3;

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
  final TextEditingController _personDataDateOfBirthController =
  TextEditingController();

  void onStepCancel(int stepperIndex) {
    switch (stepperIndex) {
      case 0:
        _personDataFirstnameController.clear();
        _personDataLastnameController.clear();
      case 1:
        _personDataDateOfBirthController.clear();
      case 2:
        _personDataAddressController.clear();
    }
    if (stepperIndex > 0) {
      ref
          .read(_stepperIndex.notifier)
          .state -= 1;
    }
  }

  bool isEmptyStringInForm() {
    final isEmptyString = _personDataFirstnameController.text.isEmpty ||
        _personDataLastnameController.text.isEmpty ||
        _personDataDateOfBirthController.text.isEmpty ||
        _personDataAddressController.text.isEmpty ||
        _personDataProvinceController.text.isEmpty;
    if (isEmptyString) {
      ref
          .read(addPersonDataErrorProvider.notifier)
          .state =
      'กรุณากรอกข้อมูลให้ครบถ้วน';
    } else {
      ref
          .read(addPersonDataErrorProvider.notifier)
          .state = null;
    }
    return isEmptyString;
  }

  void clearAllTextController() {
    _personDataFirstnameController.clear();
    _personDataLastnameController.clear();
    _personDataDateOfBirthController.clear();
    _personDataAddressController.clear();
    _personDataProvinceController.clear();
  }

  void onStepContinue(int stepperIndex) async {
    if (stepperIndex < _maxStep - 1) {
      ref
          .read(_stepperIndex.notifier)
          .state += 1;
    }
    if (stepperIndex == _maxStep - 1) {
      if (isEmptyStringInForm()) {
        return;
      }

      final newPerson = Person()
        ..firstname = _personDataFirstnameController.text
        ..lastname = _personDataLastnameController.text
        ..address = _personDataAddressController.text
        ..province = _personDataProvinceController.text
        ..dob = _personDataDateOfBirthController.text;

      final havePerson = await isarDB.persons
          .filter()
          .firstnameEqualTo(newPerson.firstname)
          .lastnameEqualTo(newPerson.lastname)
          .findFirst();

      if (havePerson == null) {
        await isarDB.writeTxn(() async {
          await isarDB.persons.put(newPerson);
        });
        clearAllTextController();
        ref
            .read(_stepperIndex.notifier)
            .state = 0;
      }
    }
  }

  Widget buildStepperTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stepperIndexWatcher = ref.watch(_stepperIndex);
    final addPersonDataErrorWatcher = ref.watch(addPersonDataErrorProvider);

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
            onStepTapped: (stepperIndex) {
              ref
                  .read(_stepperIndex.notifier)
                  .state = stepperIndex;
            },
            steps: [
              Step(
                title: buildStepperTitle('Enter Firstname & Lastname'),
                content: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Firstname',
                        textController: _personDataFirstnameController,
                        onChange: (_) {
                          isEmptyStringInForm();
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: 'Lastname',
                        textController: _personDataLastnameController,
                        onChange: (_) {
                          isEmptyStringInForm();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: buildStepperTitle('Enter Date Of Birth'),
                content: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: 'Date Of Birth',
                        textController: _personDataDateOfBirthController,
                        onTap: () async {
                          final pickDOB = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (!mounted) {
                            return;
                          }
                          if (pickDOB != null) {
                            _personDataDateOfBirthController.text =
                                DateTimeUtils.dobDateToString(pickDOB);
                          }
                        },
                        onChange: (_) {
                          isEmptyStringInForm();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                title: buildStepperTitle('Enter Address according to ID card'),
                content: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        hintText: 'Address',
                        textController: _personDataAddressController,
                        onChange: (_) {
                          isEmptyStringInForm();
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: 'Province',
                        textController: _personDataProvinceController,
                        onChange: (_) {
                          isEmptyStringInForm();
                        },
                      ),
                      if (addPersonDataErrorWatcher != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          addPersonDataErrorWatcher,
                          style: const TextStyle(
                              color: Colors.redAccent, fontSize: 16),
                        ),
                      ],
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
