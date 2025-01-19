import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sky_nova/modles/userProfile.dart';

class ChatsLogic extends GetxController {
  List<SkyNova> mySkyNova = [];
  var myFbAuth = FirebaseAuth.instance;
  var myFbFs = FirebaseFirestore.instance;

  // Fetch all users from Firebase
  Future<List<SkyNova>> getUsersOnFirebase() async {
    try {
      QuerySnapshot myAllDocs = await myFbFs.collection('Sky').get();
      for (var element in myAllDocs.docs) {
        SkyNova myUser =
            SkyNova.fromJson(element.data() as Map<String, dynamic>);
        if (!mySkyNova.any((user) => user.id == myUser.id)) {
          mySkyNova.add(myUser);
        }
      }
      return mySkyNova;
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch users: $e");
      return [];
    }
  }

  // Create chat room or navigate to existing one
  Future<void> createChatRoom(String otherUserId, String receiverName) async {
    try {
      String currentUserId = myFbAuth.currentUser!.uid;
      String chatRoomId = currentUserId.hashCode <= otherUserId.hashCode
          ? "$currentUserId-$otherUserId"
          : "$otherUserId-$currentUserId";

      var myChatRoomDoc =
          await myFbFs.collection('Chatting').doc(chatRoomId).get();

      if (!myChatRoomDoc.exists) {
        // Create new chat room
        await myFbFs.collection('Chatting').doc(chatRoomId).set({
          'chatRoomId': chatRoomId,
          'participants': [currentUserId, otherUserId],
          'timestamp': FieldValue.serverTimestamp(),
        });
        print("Chat room created: $chatRoomId");
      }

      /*  // Navigate to chat screen
      Get.to(() => ChatsPage(
            chatRoomId: chatRoomId,
            receiverId: otherUserId,
            receiverName: receiverName,
          ));*/
    } catch (e) {
      Get.snackbar("Error", "Failed to create chat room: $e");
    }
  }
}
