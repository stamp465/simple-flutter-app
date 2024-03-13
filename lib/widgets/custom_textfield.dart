import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  const CustomTextField({
    required this.textController,
    required this.hintText,
    this.onTap,
    this.onChange,
    super.key,
  });

  final TextEditingController textController;
  final String hintText;
  final Future<void> Function()? onTap;
  final void Function(String)? onChange;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: textController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: hintText,
          ),
          style: const TextStyle(fontSize: 20),
          onTap: onTap,
          readOnly: onTap != null,
          onChanged: onChange,
        ),
      ],
    );
  }
}
