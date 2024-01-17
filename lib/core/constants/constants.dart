import 'package:chat_app/feature/home/data/model/chat_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Constants {
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for acessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //for storing self information
  static late ChatUserModel me;

  static User get user => auth.currentUser!;

  //for cheking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  //for getting current user info
  static Future<void> getSelfInfo() async {
    return await firestore
        .collection('users')
        .doc(user.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        me = ChatUserModel.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  //for create a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUserModel(
      user.photoURL.toString(),
      "Hey, I'm using a Chat App",
      user.displayName.toString(),
      time,
      user.uid,
      time,
      false,
      '',
      user.email.toString(),
    );
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  //for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where("id", isNotEqualTo: user.uid)
        .snapshots();
  }
}
