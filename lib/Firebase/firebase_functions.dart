import 'dart:math';

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

  Future<Map<String, dynamic>?> getUser({required String id}) async {
    DocumentSnapshot snapshot = await firestore
        .collection("Users")
        .doc(id)
        .get();

    if (!snapshot.exists) return null;

    return snapshot.data() as Map<String, dynamic>;
  }

  Future<String?> getUserName({required String id}) async {
    final Map<String, dynamic>? userData = await getUser(id: id);

    if (userData!['FirstName'] != null && userData['LastName'] != null) {
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
      final user = await getUser(id: chatIds[i]);
      if (user != null) {
        users.add(user);
      }
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

  Future<void> saveProduct({
    required String name,
    required String description,
    required double price,
    required int discount,
    required String category,
    required String imageUrl,
  }) async {
    double priceAfterDiscount = price - (price * discount / 100);
    await firestore.collection("products").add({
      "description": description,
      "image": imageUrl,
      "name": name,
      "price": price,
      "priceAfterDiscount": priceAfterDiscount,
      "category": category,
      "rate": double.parse((1 + Random().nextDouble() * 4).toStringAsFixed(2)),
    });
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    QuerySnapshot snapshot = await firestore.collection("products").get();

    return snapshot.docs.map((product) {
      return product.data() as Map<String, dynamic>;
    }).toList();
  }

  Future<String> getProductId({required String productName}) async {
    QuerySnapshot snapshot = await firestore
        .collection("products")
        .where("name", isEqualTo: productName)
        .get();
    String id = snapshot.docs[0].id;
    return id;
  }

  Future<void> deleteProduct({required String productName}) async {
    String id = await getProductId(productName: productName);
    List<String> usersIds = await getAllUsersIds();
    for (int i = 0; i < usersIds.length; i++) {
      await firestore
          .collection("cart")
          .doc(usersIds[i])
          .collection("products")
          .doc(id)
          .delete();
    }
    await firestore.collection("products").doc(id).delete();
  }

  Future<Map<String, dynamic>> getProductData({
    required String productName,
  }) async {
    String id = await getProductId(productName: productName);
    DocumentSnapshot snapshot = await firestore
        .collection("products")
        .doc(id)
        .get();

    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> updateProduct({
    required String name,
    required String description,
    required double price,
    required int discount,
    required String category,
    required String imageUrl,
    required double rate,
  }) async {
    double priceAfterDiscount = price - (price * discount / 100);
    String id = await getProductId(productName: name);
    await firestore.collection("products").doc(id).update({
      "description": description,
      "image": imageUrl,
      "name": name,
      "price": price,
      "priceAfterDiscount": priceAfterDiscount,
      "category": category,
      "rate": rate,
    });
  }

  Future updateName({
    required String firstName,
    required String lastName,
    required String id,
  }) async {
    await firestore.collection("Users").doc(id).update({
      "FirstName": firstName,
      "LastName": lastName,
    });
  }

  Future<bool> checkIfUserBanned({required String userId}) async {
    Map<String, dynamic>? userData = await getUser(id: userId);
    return userData!['Active'];
  }
}
