import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englens/src/data/models/word.dart';
import 'package:englens/src/service/firebase/auth/auth_service.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class WordService extends GetxController{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // final AuthService authService = Get.find<AuthService>();
  var uuid = Uuid();


  Future<List<Word>> getAllUserWords({required String userId}) async {
    List<Word> words = [];
    try {
       QuerySnapshot res = await _fireStore.collection('users').doc(userId).collection('words').get();
       
       for(var docSnapShot in res.docs){
         var data = docSnapShot.data();
         if(data != null && data is Map<String, dynamic> ){
          
          var word = Word.fromJson(data);
          words.add(word);
         }
       }
       return words;
    
    } catch (e) {
      print(e);
      return words;
    }
  }

  Future<bool> addWord({required String userId,required Word word}) async {
    bool isSuccess = false;
    try {
      var id = uuid.v4();
      word.id = id;
      var jsonWord = word.toMap();
      
      await _fireStore.collection('users').doc(userId).collection('words').doc(id).set(jsonWord).then((value) {
        isSuccess = true;
      },);
      return isSuccess;
    } catch (e) {
      print(e);
      return isSuccess;
    }
  }

  Future<bool> deleteWord({required String userId,required String wordId}) async {
    bool isSuccess = false;
    try {
      await _fireStore.collection('users').doc(userId).collection('words').doc(wordId).delete().then((value) {
       isSuccess =true; 
      },);
      return isSuccess;
    
    } catch (e) {
      print(e); 
      return isSuccess;
    }
  }

}