import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stema/core/common/error_notification.dart';
import 'package:stema/features/groups/models/group_model.dart';
import 'package:stema/features/groups/repository/groups_repository.dart';

final groupsProvider =
    StateNotifierProvider<GroupsNotifier, AsyncValue<List<GroupModel>>>(
  (ref) => GroupsNotifier(ref.watch(groupsRepositoryProvider)),
);

class GroupsNotifier extends StateNotifier<AsyncValue<List<GroupModel>>> {
  final GroupsRepository _groupsRepository;
  GroupsNotifier(this._groupsRepository) : super(const AsyncLoading()) {
    getUserGroups();
  }

  Future<void> getUserGroups() async {
    state = const AsyncLoading();
    final data = await _groupsRepository.getUserGroups();
    data.fold(
      (l) => state = AsyncError(l.message, StackTrace.current),
      (r) => state = AsyncData(r),
    );
  }
}

final groupsControllerProvider = StateNotifierProvider<GroupsController, bool>(
  (ref) => GroupsController(
      groupsRepository: ref.watch(groupsRepositoryProvider), ref: ref),
);

class GroupsController extends StateNotifier<bool> {
  final Ref _ref;
  final GroupsRepository _groupsRepository;
  GroupsController(
      {required GroupsRepository groupsRepository, required Ref ref})
      : _groupsRepository = groupsRepository,
        _ref = ref,
        super(false);

  // Method to reset the state to initial values
  Future createGroup({
    required String title,
    required String course,
    required VoidCallback onError,
    VoidCallback? onSuccess,
  }) async {
    //indicate loading
    state = true;
    final res = await _groupsRepository.createGroup(title, course);
    //TODO: delete delay
    await Future.delayed(const Duration(seconds: 2));
    res.fold(
      (l) {
        state = false;
        ErrorNotification.showOverlay(
            errorMessage: l.message, onError: onError);
      },
      (r) {
        state = false;
        onSuccess != null ? onSuccess() : () {};
        _ref.read(groupsProvider.notifier).getUserGroups();
      },
    );
  }

  Future joinGroup({
    required String invitationCode,
    required VoidCallback onError,
    VoidCallback? onSuccess,
  }) async {
    //indicate loading
    state = true;
    final res = await _groupsRepository.joinGroup(invitationCode);
    //TODO: delete delay
    await Future.delayed(const Duration(seconds: 2));
    res.fold(
      (l) {
        state = false;
        ErrorNotification.showOverlay(
            errorMessage: l.message, onError: onError);
      },
      (r) {
        state = false;
        onSuccess != null ? onSuccess() : () {};
        _ref.read(groupsProvider.notifier).getUserGroups();
      },
    );
  }
}
