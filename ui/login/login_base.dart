import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/ui/login/pantalla_login.dart';


import '../../bloc/blocs_login/bloc_login_screen/bloc.dart';




class LoginScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color:Colors.white24,
          ),
          BlocProvider<LoginBlocScreen>(
            create: (context) => LoginBlocScreen(),
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}