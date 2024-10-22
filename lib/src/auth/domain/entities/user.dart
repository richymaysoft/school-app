// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.fullName,
    required this.email,
    required this.profilePic,
    required this.password,
    this.score = 0,
    this.followings = const [],
    this.followers = const [],
    this.groupsId = const [],
    this.bio,
    this.uid,
    this.enrolledCoursesIds = const [],
  });

  const LocalUser.empty()
      : this(
          email: '',
          fullName: 'fullName.empty',
          password: 'password.empty',
          uid: 'uid.empty',
          profilePic: 'sfpo',
          score: 0,
          bio: '',
        );

  final String? uid;
  final String fullName;
  final String email;
  final String? profilePic;
  final int? score;
  final List<String>? followings;
  final List<String>? followers;
  final String password;
  final List<String>? groupsId;
  final String? bio;
  final List<String>? enrolledCoursesIds;

  @override
  List<Object?> get props => [uid, email];
}
