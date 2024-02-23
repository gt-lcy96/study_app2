import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:study_app_2/firebase_ref/references.dart';

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage
          .child("question_paper_images")
          .child('${imgName.toLowerCase()}.png');

      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    } on FirebaseException catch (e) {
      print("FirebaseException: ${e.message}");
      throw Exception('Image not found or other Firebase exception.');
    }
    
    catch (e) {
      throw(e);
      // return null;
    }
  }
}
