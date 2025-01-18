class UserProfile {
  final String username;
  final String profileImageUrl;
  final int following;
  final int followers;
  final int likes;
  final String? bio;

  UserProfile({
    required this.username,
    required this.profileImageUrl,
    required this.following,
    required this.followers,
    required this.likes,
    this.bio,
  });
}
