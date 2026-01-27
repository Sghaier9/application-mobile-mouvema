class MyUser {
  final String uid;
  final String username;
  final String email;
  final String birthdate;
  final String tel;
  final List<dynamic> favoriteLoads;
  final String image;

  const MyUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.birthdate,
    required this.tel,
    required this.favoriteLoads,
    required this.image,
  });

  factory MyUser.fromFirestore(Map<String, dynamic> map) {
    return MyUser(
      uid: map['uid'] ?? 'null',
      username: map['username'] ?? 'null',
      email: map['email'] ?? 'null',
      birthdate: map['birthdate'] ?? 'null',
      tel: map['tel'] ?? 'null',
      favoriteLoads: map['favoriteLoads'] ?? 'null',
      image: map['image'],
    );
  }

  Map<String, dynamic> toFirestore() => {
        'uid': uid,
        'username': username,
        'email': email,
        'birthdate': birthdate,
        'tel': tel,
        'favoriteLoads': favoriteLoads,
        'image': image,
      };
}
