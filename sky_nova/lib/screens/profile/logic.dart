import 'package:get/get.dart';

import '../../modles/userProfile.dart';

class ProfileLogic extends GetxController {
  final userProfile = UserProfile(
    username: 'Kullanıcı Adı', // Varsayılan değer ataması yapın
    profileImageUrl:
        '', // Varsayılan değer ataması yapın.  Gerçek bir URL veya yerel bir asset kullanın.
    following: 0, // Varsayılan değer ataması yapın
    followers: 0, // Varsayılan değer ataması yapın
    likes: 0, // Varsayılan değer ataması yapın
    bio: 'Profil Biyografisi', // Varsayılan değer ataması yapın
  ).obs;
}
