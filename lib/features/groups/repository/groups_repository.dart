import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stema/core/core.dart';
import 'package:stema/features/auth/controller/auth_controller.dart';
import 'package:stema/features/auth/models/user_model.dart';
import 'package:stema/features/groups/models/group_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final groupsRepositoryProvider = Provider<GroupsRepository>(
  (ref) => GroupsRepository(supabase: ref.watch(supabaseProvider), ref: ref),
);

class GroupsRepository {
  final SupabaseClient _supabase;
  final Ref _ref;
  GroupsRepository({required SupabaseClient supabase, required Ref ref})
      : _supabase = supabase,
        _ref = ref;

  FutureVoid createGroup(String title, String course) async {
    try {
      final userId = _ref.watch(userProvider)?.id;
      final groupTableData = await _supabase
          .from(SupabaseTables.groupTable)
          .insert({"title": title, "course": course})
          .select()
          .single();
      await _supabase
          .from(SupabaseTables.groupMemberTable)
          .insert({"group_id": groupTableData["id"], "user_id": userId})
          .select()
          .single();
      return right(null);
    } on PostgrestException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  FutureEither<List<GroupModel>> getUserGroups() async {
    List<GroupModel> groups = [];
    try {
      //get user id for the current authinticated user
      final userId = _ref.watch(userProvider)?.id;
      //get group ids from group memeber table where the user id equals the given id
      final groupMemberTableData = await _supabase
          .from(SupabaseTables.groupMemberTable)
          .select("group_id")
          .eq('user_id', userId!);
      //convert the map into a list
      final groupIds = [];
      for (var element in groupMemberTableData) {
        groupIds.add(element["group_id"]);
      }
      //get group id from group table where the group id is in the given list
      final userGroups = await _supabase
          .from(SupabaseTables.groupTable)
          .select()
          .filter('id', 'in', groupIds);
      //convert the group map into a list of group model
      for (var i = 0; i < userGroups.length; i++) {
        final currentGroup = GroupModel.fromJson(userGroups[i]);
        groups.add(currentGroup);
      }
      //get memebers for each group
      for (var i = 0; i < groups.length; i++) {
        final members = await getGroupMembers(groups[i].id);
        members.fold(
          (l) => throw (l),
          (r) {
            final updatedGroup = groups[i].copyWith(members: r);
            groups[i] = updatedGroup;
          },
        );
      }
      return right(groups);
    } on Failure catch (e) {
      return left(e);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<List<UserModel>> getGroupMembers(String groupId) async {
    List<UserModel> members = [];
    try {
      //get user ids from group memeber table where the group id equals the given id
      final data = await _supabase
          .from(SupabaseTables.groupMemberTable)
          .select("user_id")
          .eq("group_id", groupId);
      //for each user id, get the user data from the user table
      for (var element in data) {
        final user = await _ref
            .read(authControllerProvider)
            .getUserData(element["user_id"]);
        members.add(user);
      }
      return right(members);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
