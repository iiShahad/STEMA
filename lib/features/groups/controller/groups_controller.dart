import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/core/common/error_notification.dart';
import 'package:stema/features/groups/repository/groups_repository.dart';

final groupsControllerProvider = Provider<GroupsController>(
  (ref) => GroupsController(
    groupsRepository: ref.watch(groupsRepositoryProvider),
  ),
);

class GroupsController extends StateNotifier<bool> {
  final GroupsRepository _groupsRepository;
  GroupsController({required GroupsRepository groupsRepository})
      : _groupsRepository = groupsRepository,
        super(false);

  Future createGroup(
      {required String title,
      required String course,
      required VoidCallback onError}) async {
    state = true;
    try {
      await _groupsRepository.createGroup(title, course);
    } catch (e) {
      ErrorNotification.showOverlay(
          errorMessage: e.toString(), onError: onError);
      state = false;
      rethrow;
    }
  }
}
