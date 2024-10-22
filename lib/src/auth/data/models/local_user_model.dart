import 'package:school_app/core/utils/typedefs.dart';
import 'package:school_app/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.fullName,
    required super.email,
    required super.profilePic,
    super.password = '',
    super.score = 0,
    super.followings = const [],
    super.followers = const [],
    super.groupsId = const [],
    super.enrolledCoursesIds = const [],
    super.bio,
    super.uid,
  });

  LocalUserModel.fromMap(DataMap map)
      : this(
          email: map['email'] as String,
          fullName: map['fullName'] as String,
          password: map['password'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          score: (map['score'] as num).toInt(),
          uid: map['uid'] as String,
          followers: (map['followers'] as List<dynamic>).cast<String>(),
          followings: (map['followings'] as List<dynamic>).cast<String>(),
          groupsId: (map['groupsId'] as List<dynamic>).cast<String>(),
          enrolledCoursesIds:
              (map['enrolledCoursesIds'] as List<dynamic>).cast<String>(),
        );

  DataMap toMap() {
    return {
      'email': email,
      'uid': uid,
      'fullName': fullName,
      'profilePic': profilePic,
      'score': score,
      'followings': followings,
      'followers': followers,
      'groupsId': groupsId,
      'enrolledCoursesIds': enrolledCoursesIds,
      'password': password,
      'bio': bio,
    };
  }

  const LocalUserModel.empty()
      : this(
          email: 'empty.email',
          fullName: 'empty.fullName',
          password: 'empty.password',
          profilePic: 'empty.profilePic',
        );

  LocalUserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? profilePic,
    int? score,
    List<String>? followings,
    List<String>? followers,
    String? password,
    List<String>? groupsId,
    String? bio,
    List<String>? enrolledCoursesIds,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      score: score ?? this.score,
      followings: followings ?? this.followings,
      followers: followers ?? this.followers,
      password: password ?? this.password,
      groupsId: groupsId ?? this.groupsId,
      bio: bio ?? this.bio,
      enrolledCoursesIds: enrolledCoursesIds ?? this.enrolledCoursesIds,
    );
  }
}
