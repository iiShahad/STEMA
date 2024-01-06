import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/core/common/divider_with_text.dart';
import 'package:stema/core/common/error_notification.dart';
import 'package:stema/core/common/input_with_label.dart';
import 'package:stema/core/common/left_overlay.dart';
import 'package:stema/core/core.dart';
import 'package:stema/core/utils.dart';
import 'package:stema/features/groups/controller/groups_controller.dart';
import 'package:stema/features/groups/repository/groups_repository.dart';

class AddGroupForm extends ConsumerStatefulWidget {
  const AddGroupForm({super.key});

  @override
  ConsumerState<AddGroupForm> createState() => _AddGroupFormState();
}

class _AddGroupFormState extends ConsumerState<AddGroupForm> {
  final _createFormKey = GlobalKey<FormState>();
  final _joinFormKey = GlobalKey<FormState>();
  String title = "";
  String course = "";
  String invitationCode = "";
  bool isCreatingGroup = false;

  void _createGroupsubmition() {
    if (_createFormKey.currentState!.validate()) {
      isCreatingGroup = true;
      ref.read(groupsControllerProvider.notifier).createGroup(
            title: title,
            course: course,
            onError: () {
              //check if entry not null, if so, insert it to the overlay context
              Overlay.of(context)
                  .insert(ErrorNotification.entry ?? ErrorNotification.entry!);
            },
            onSuccess: () {
              LeftOverlay.removeOverlay();
            },
          );
    }
  }

  void _joinGroupSubmission() {
    isCreatingGroup = false;
    if (_joinFormKey.currentState!.validate()) {
      ref.read(groupsControllerProvider.notifier).joinGroup(
            invitationCode: invitationCode,
            onError: () {
              //check if entry not null, if so, insert it to the overlay context
              Overlay.of(context)
                  .insert(ErrorNotification.entry ?? ErrorNotification.entry!);
            },
            onSuccess: () {
              LeftOverlay.removeOverlay();
            },
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupsControllerStatus = ref.watch(groupsControllerProvider);

    return Column(
      children: [
        Form(
          key: _createFormKey,
          child: Column(
            children: [
              _formTitle("Create New Group"),
              const SizedBox(height: 20),
              InputWithLabel(
                label: "Title",
                validator: (val) => requiredValidatior(val),
                onChanged: (val) {
                  title = val!;
                },
                inputColor: Palette.dark_bg,
              ),
              const SizedBox(height: 10),
              InputWithLabel(
                label: "Course",
                validator: (val) => requiredValidatior(val),
                onChanged: (val) {
                  course = val!;
                },
                inputColor: Palette.dark_bg,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _createGroupsubmition();
                },
                child: groupsControllerStatus == true && isCreatingGroup == true
                    ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text("Create Group"),
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
          key: _joinFormKey,
          child: Column(
            children: [
              _formTitle("Join a Group"),
              const SizedBox(height: 20),
              InputWithLabel(
                label: "Code",
                validator: (val) => requiredValidatior(val),
                onChanged: (val) {
                  invitationCode = val!;
                },
                inputColor: Palette.dark_bg,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _joinGroupSubmission(),
                child:
                    groupsControllerStatus == true && isCreatingGroup == false
                        ? const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Join Group"),
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
