// import 'package:dreamer/model/exception/CommonException.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class FireauthUtil {
//   static FirebaseAuth get _instance => FirebaseAuth.instance;
//
//   static Future<User?> getUser() async {
//     await for (User? user in _instance.authStateChanges()) {
//       return user;
//     }
//   }
//
//   static Future<bool> isLogin() async {
//     return (await getUser()) != null;
//   }
//
//   static Future<void> register(
//       {required String email, required String password}) async {
//     try {
//       await _instance.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         throw CommonException("비밀번호 형식이 안전하지 않습니다");
//       } else if (e.code == 'email-already-in-use') {
//         throw CommonException("이미 ID가 있습니다");
//       } else if (e.code == 'invalid-email') {
//         throw CommonException("이메일이 형식이 잘못되었습니다");
//       } else if (e.code == 'too-many-requests') {
//         throw CommonException("잠시 후에 다시 시도해주세요");
//       } else if (e.code == 'network-request-failed') {
//         throw CommonException("네트워크 요청이 실패하였습니다");
//       } else if (e.code == 'internal-error') {
//         throw CommonException("에러가 발생하였습니다");
//       } else {
//         throw CommonException(e.code);
//       }
//     }
//   }
//
//   static Future<void> login(
//       {required String email, required String password}) async {
//     try {
//       await _instance.signInWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'invalid-email') {
//         throw CommonException("이메일이 형식이 잘못되었습니다");
//       } else if (e.code == 'wrong-password') {
//         throw CommonException("비밀번호가 틀렸습니다");
//       } else if (e.code == 'too-many-requests') {
//         throw CommonException("잠시 후에 다시 시도해주세요");
//       } else if (e.code == 'network-request-failed') {
//         throw CommonException("네트워크 요청이 실패하였습니다");
//       } else if (e.code == 'internal-error') {
//         throw CommonException("에러가 발생하였습니다");
//       } else {
//         throw CommonException(e.code);
//       }
//     }
//   }
//
//   static Future<void> logout() async {
//     await _instance.signOut();
//   }
// }
