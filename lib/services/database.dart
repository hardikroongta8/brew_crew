import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;

  DatabaseService({required this.uid});
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength)async{
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength')
    );
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(name: doc.get('name'), strength: doc.get('strength'), sugars: doc.get('sugars'));
    }).toList();
  } 

  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}