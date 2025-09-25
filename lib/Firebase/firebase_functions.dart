import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunctions {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    QuerySnapshot snapshot = await firestore.collection("Users").get();

    List<Map<String, dynamic>> users = [];

    for (int i = 0; i < snapshot.docs.length; i++) {
      users.add(snapshot.docs[i].data() as Map<String, dynamic>);
    }
    return users;
  }

  Future<List<String>> getAllUsersIds() async {
    QuerySnapshot snapshot = await firestore.collection("Users").get();
    return snapshot.docs.map((user) {
      return user.id;
    }).toList();
  }

  Future<Map<String, dynamic>> getUser({required String id}) async {
    DocumentSnapshot snapshot = await firestore
        .collection("Users")
        .doc(id)
        .get();

    return snapshot.data() as Map<String, dynamic>;
  }

  Future<String?> getUserName({required String id}) async {
    final Map<String, dynamic> userData = await getUser(id: id);

    if (userData['FirstName'] != null && userData['LastName'] != null) {
      return "${userData['FirstName']} ${userData['LastName']}";
    }

    return null;
  }

  Future<List<String>> getChatIds() async {
    QuerySnapshot snapshot = await firestore.collection("Chats").get();

    return snapshot.docs.map((doc) {
      return doc.id;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getUsersChats() async {
    final List<String> chatIds = await getChatIds();
    List<Map<String, dynamic>> users = [];

    for (int i = 0; i < chatIds.length; i++) {
      users.add(await getUser(id: chatIds[i]));
    }

    return users;
  }

  Future<String> findUserId({required String userEmail}) async {
    final users = await firestore.collection("Users").get();
    for (int i = 0; i < users.docs.length; i++) {
      if (users.docs[i].data()['Email'] == userEmail) {
        return users.docs[i].id;
      }
    }
    return "";
  }

  Future<void> banUser({required String userEmail}) async {
    String id = await findUserId(userEmail: userEmail);
    if (id.isNotEmpty) {
      await firestore.collection("Users").doc(id).update({'Active': false});
    } else {
      print("Error");
    }
  }

  Future<void> unBanUser({required String userEmail}) async {
    String id = await findUserId(userEmail: userEmail);
    if (id.isNotEmpty) {
      await firestore.collection("Users").doc(id).update({'Active': true});
    } else {
      print("Error");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages({
    required String id,
  }) {
    return firestore
        .collection("Chats")
        .doc(id)
        .collection("Messages")
        .orderBy("Timestamp")
        .snapshots();
  }

  Future<void> sendMessage({
    required String id,
    required String message,
    required String sender,
  }) async {
    await firestore.collection("Chats").doc(id).collection("Messages").add({
      "Msg": message,
      "Sender": sender,
      "Receiver": "Admin",
      "Timestamp": Timestamp.now(),
    });
    await firestore.collection("Chats").doc(id).set({"isSend": true});
  }
}
