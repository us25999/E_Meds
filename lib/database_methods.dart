import 'package:agp_ziauddin_virtual_clinic/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      String colName, String userId, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection(colName)
        .doc(userId)
        .set(userInfoMap);
  }

  Future UpdateUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userInfoMap);
  }

  Future createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getPatients() async {
    return FirebaseFirestore.instance
        .collection("patients")
        .where("doctor_email", isEqualTo: prefs!.getString("email"))
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatroom() async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .where("userIds", arrayContains: prefs!.getString("id"))
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getPatientReports() async {
    return FirebaseFirestore.instance
        .collection(prefs!.getString("type")=="Doctor"?"reports":"precriptions")
        .where(prefs!.getString("type")=="Doctor"?"doctor_id":"patient_id", isEqualTo: prefs!.getString("id"))
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getDoctors() async {
    return FirebaseFirestore.instance.collection("doctors").snapshots();
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  Future lastMessageUpdate(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  Future deleteSingleMessage(String chatRoomId, String messageId) async {
    await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .delete();
  }

  Future updateMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .update(messageInfoMap);
  }

  Future<Stream<QuerySnapshot>> getMessages(String chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> searchCategoriesByLocation(
      String colName, String location) async {
    return FirebaseFirestore.instance
        .collection(colName)
        .where("location.city",
            isGreaterThanOrEqualTo: location.substring(0, 1).toUpperCase() +
                location.substring(1).toLowerCase())
        .where("location.city",
            isLessThan: location.substring(0, 1).toUpperCase() +
                location.substring(1).toLowerCase() +
                'z')
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> searchCategoriesByPrice(
      String colName, int price) async {
    return FirebaseFirestore.instance
        .collection(colName)
        // .where("price", isGreaterThanOrEqualTo: price+100000)
        .where("price", isLessThan: price)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getCollection(String col) async {
    return FirebaseFirestore.instance.collection(col).snapshots();
  }

  Future<Stream<QuerySnapshot>> getMultiCollection(
      String col1, String col2, String doc) async {
    return FirebaseFirestore.instance
        .collection(col1)
        .doc(doc)
        .collection(col2)
        .snapshots();
  }

  Future deleteMessages(String chatRoomId) async {
    await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future updateMessages(String chatRoomId) async {
    await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("DAte", isEqualTo: DateTime.now())
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.update({});
      }
    });
  }
}
