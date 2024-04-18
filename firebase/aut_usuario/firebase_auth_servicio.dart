

import 'package:firebase_auth/firebase_auth.dart';
import 'package:valorix/src/modelos/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseAuthService{
  FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  // crear usuario en la base de datos
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      // Intenta crear un usuario con el correo electrónico y la contraseña.
      UserCredential credential =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Devuelve el usuario si la operación es exitosa.
      return credential.user;
    } catch (e) {
      // Captura y maneja cualquier error que pueda ocurrir durante la autenticación.
      print("Ocurrió un error en signWithEmailAndPassword: $e");
    }

    // Devuelve null en caso de error.
    return null;
  }

    // SingUp - Registro
  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }
    // Esta logueado?
  Future<bool> isSignedIn() async {
    final user = _auth.currentUser;
    return user != null;
  }

    // SingOut
  Future<Future<List<void>>> signOut() async {
    return Future.wait([_auth.signOut()]);
  }
  Future<void> crearUsuarioDb(
      String? correo, String? nombre) async {
    _firebaseFirestore
        .collection("usuario")
        .doc(_auth.currentUser!.uid)
        .set({
          'id':_auth.currentUser!.uid,
      'nombres': nombre,
      'correo': correo,
      'apellidos':'',
      'es_administrador':false,
      'es_maestro':false,
      'es_padre':false,
      'es_psicologo':false,
      'es_nino':false,
      'fecha_creada':Timestamp.now(),
      'progreso':0,

    });
  }

  Future<void> resetPassDB(String correo) async {
    try{
      await _auth.sendPasswordResetEmail(email: correo.trim());
    }on FirebaseAuthException catch(e){
      print(e);

    }

  }
  // validar usuario en la base de datos
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Intenta iniciar sesión con el correo electrónico y la contraseña.
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);



      // Devuelve el usuario si la operación de inicio de sesión es exitosa.
     
      return credential.user;
    } catch (e) {
      // Captura y maneja cualquier error que pueda ocurrir durante el inicio de sesión.
      print("----Ocurrió un error en signInWithEmailAndPassword: $e");
    }

    // Devuelve null en caso de error.
    return null;
  }

}