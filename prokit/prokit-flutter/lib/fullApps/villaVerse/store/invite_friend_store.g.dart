// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

part of 'invite_friend_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$InviteFriendStore on _InviteFriendStore, Store {
  late final _$inviteFriendsAtom = Atom(name: '_InviteFriendStore.inviteFriends', context: context);

  @override
  ObservableList<Friends> get inviteFriends {
    _$inviteFriendsAtom.reportRead();
    return super.inviteFriends;
  }

  @override
  set inviteFriends(ObservableList<Friends> value) {
    _$inviteFriendsAtom.reportWrite(value, super.inviteFriends, () {
      super.inviteFriends = value;
    });
  }

  late final _$_InviteFriendStoreActionController = ActionController(name: '_InviteFriendStore', context: context);

  @override
  void toggleInviteFriend(Friends item) {
    final _$actionInfo = _$_InviteFriendStoreActionController.startAction(name: '_InviteFriendStore.toggleInviteFriend');
    try {
      return super.toggleInviteFriend(item);
    } finally {
      _$_InviteFriendStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
inviteFriends: ${inviteFriends}
    ''';
  }
}
