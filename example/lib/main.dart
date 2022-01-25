import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_authentication_microfront/firebase_auth_micro_front.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyBQOX97p0660aJGsa5SQVoU3_qZChjw-tc",
    authDomain: "cashflow-b1b18.firebaseapp.com",
    databaseURL: "https://cashflow-b1b18-default-rtdb.firebaseio.com",
    projectId: "cashflow-b1b18",
    storageBucket: "cashflow-b1b18.appspot.com",
    messagingSenderId: "126474088672",
    appId: "1:126474088672:web:a27b455c8cc23861bc6085"
  );
  await Firebase.initializeApp(
    options: firebaseOptions);

  final firebaseAuthMF = FirebaseAuthMicroFront();

  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => const HomePage()),
      firebaseAuthMF.page(
          name: '/auth',
          onExit: (){
            Get.offAllNamed('/home');
          },
          onAfterLogin: () {
            Get.offAllNamed('/home');
          }) as GetPage
    ],
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open AuthView'),
          onPressed: () {
            Get.toNamed('/auth');
          },
        ),
      ),
    );
  }
}
