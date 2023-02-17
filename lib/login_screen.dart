import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserCredential? userCredential;

  @override
  void initState() {
    // TODO: implement initState
    successGoogle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login Hear",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                // userCredential = await signInWithGoogle();
                signInWithGoogle();

                // debugPrint("userCredential ------>>> ${userCredential!.user!.displayName}");
                // debugPrint("userCredential ------>>> ${userCredential!.user!.email}");
                // debugPrint("userCredential ------>>> ${userCredential!.user!.phoneNumber}");
                // debugPrint("userCredential ------>>> ${userCredential!.user!.photoURL}");
                // debugPrint("userCredential ------>>> ${userCredential!.user!.uid}");
              },
              child: Container(
                height: 50,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Google Login",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  GoogleSignInAccount? currentUser;
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  signInWithGoogle() {
    googleSignIn.signIn();
  }

  void successGoogle() {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      currentUser = account;

      if (account != null) {
        debugPrint('''
          Google Logged in!
          Google Id: ${currentUser!.id}
          Email: ${currentUser!.email};
          Name: ${currentUser!.displayName ?? ""};
          Profile Pic: ${currentUser!.photoUrl ?? ""};
      ''');

        // // Obtain the auth details from the request
        // final GoogleSignInAuthentication? googleAuth = await currentUser?.authentication;
        //
        // // Create a new credential
        // final credential = GoogleAuthProvider.credential(
        //   accessToken: googleAuth?.accessToken,
        //   idToken: googleAuth?.idToken,
        // );
        //
        // // Once signed in, return the UserCredential
        // await FirebaseAuth.instance.signInWithCredential(credential);

        await account.clearAuthCache();
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
        currentUser = null;
      }
    });
  }
}
