// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import '../models/friens.dart';
part 'invite_friend_store.g.dart';

class InviteFriendStore = _InviteFriendStore with _$InviteFriendStore;

class _InviteFriendStore with Store {
  @observable
  ObservableList<Friends> inviteFriends = ObservableList<Friends>();

  @action
  void toggleInviteFriend(Friends item) {
    if (inviteFriends.contains(item)) {
      inviteFriends.remove(item);
    } else {
      inviteFriends.add(item);
    }
  }
}
