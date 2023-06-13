import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Google ile oturum açma işlemini başlat
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      // Google oturum açma bilgilerini al
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;
      // Google yetkilendirmesini Firebase ile bağlama
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Firebase üzerinden oturum açma işlemini tamamla
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      // Oturum açan kullanıcıyı al
      final User? user = userCredential.user;
      return user;
    } catch (e) {
      // Hata durumunda ilgili işlemleri yapabilirsiniz
      print('Google ile oturum açma hatası: $e');
      return null;
    }
  }

  User? currentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    try {
      // Oturumu kapat ve Google'dan çıkış yap
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      // Hata durumunda ilgili işlemleri yapabilirsiniz
      print('Oturumu kapatma hatası: $e');
    }
  }
}
