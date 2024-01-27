class UserState{
  final String? currentUserId;

  UserState({required this.currentUserId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserState && runtimeType == other.runtimeType &&
              currentUserId == other.currentUserId;

  @override
  int get hashCode => currentUserId.hashCode;

  @override
  String toString() {
    return 'UserState{currentUser: $currentUserId}';
  }
}