import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/core/common/divider_with_text.dart';
import 'package:stema/core/common/input_with_label.dart';
import 'package:stema/core/core.dart';
import 'package:stema/features/groups/repository/groups_repository.dart';

class AddGroupForm extends ConsumerStatefulWidget {
  const AddGroupForm({super.key});

  @override
  ConsumerState<AddGroupForm> createState() => _AddGroupFormState();
}

class _AddGroupFormState extends ConsumerState<AddGroupForm> {
  final _createFormKey = GlobalKey<FormState>();
  void _submit() {
    if (_createFormKey.currentState!.validate()) {
      // ref.read(groupsRepositoryProvider).createGroup("title", "course");
      ref.read(groupsRepositoryProvider).getUserGroups();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _createFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _formTitle("Create New Group"),
              const SizedBox(height: 20),
              InputWithLabel(
                label: "Title",
                validator: (val) {},
                onChanged: (val) {},
                inputColor: Palette.dark_bg,
              ),
              const SizedBox(height: 10),
              InputWithLabel(
                label: "Course",
                validator: (val) {},
                onChanged: (val) {},
                inputColor: Palette.dark_bg,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                child: const Text("Create Group"),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        const DividerWithText(
          text: "OR",
          color: Palette.text_grey,
        ),
        const SizedBox(height: 20),
        Form(
          child: Column(
            children: [
              _formTitle("Join a Group"),
              const SizedBox(height: 20),
              InputWithLabel(
                label: "Code",
                validator: (val) {},
                onChanged: (val) {},
                inputColor: Palette.dark_bg,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Join Group"),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _formTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Palette.onPrimary,
        fontSize: 17,
      ),
    );
  }
}
