
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';






import '../../bloc/blocs_login/bloc_auth/bloc.dart';
import '../../bloc/blocs_login/bloc_login_screen/bloc.dart';
import '../../modelos/usuario.dart';

import 'LoginButton.dart';




class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBlocScreen? _loginBloc;

  bool _showPassword = false;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBlocScreen>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBlocScreen, LoginState>(listener: (context, state) {
      // tres casos, tres if:
      if (state.isFailure) {
        ScaffoldMessenger.of(context)
        // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text('Ingreso Fallido'), Icon(Icons.error)],
                ),
              ),
              backgroundColor: Color(4293309470).withOpacity(0.8),
            ),
          );
      }
      if (state.isSubmitting) {
        ScaffoldMessenger.of(context)
        // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
        // ignore: deprecated_member_use
          ..showSnackBar(SnackBar(
            
            content: Container(
                 height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Ingresando... '),
                  CircularProgressIndicator(),
                ],
              ),
            ),
            backgroundColor:Color.fromARGB(255, 141, 197, 243),
          ));
      }
      if (state.isSuccess) {
                ScaffoldMessenger.of(context)
        // ignore: deprecated_member_use
          ..hideCurrentSnackBar()
        // ignore: deprecated_member_use
          ..showSnackBar(SnackBar(
            
            content: Container(
                 height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Correcto... '),
                  CircularProgressIndicator(),
                ],
              ),
            ),
            backgroundColor:Color(4278245019).withOpacity(0.8),
          ));
        BlocProvider.of<AuthBloc>(context).add(enterIdUser(idUser: state.idUsuario!));
      }
    }, child: BlocBuilder<LoginBlocScreen, LoginState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 60.0),
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    child: Image(image: AssetImage('lib/icon/imageLogin.png')),
                  ),
                ),
                Center(
                  child: Text(
                    '¡Ingresa a la App!',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(color: Colors.black45, width: 1.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
        
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Padding(
                          padding: EdgeInsets.only(left:20), // Ajusta la cantidad de espacio a la derecha
                          child: Image.asset(
                            'lib/icon/usuario.png', // Adjust the path to your PNG image
                            width: 24, // Set the desired width of the image
                            height: 24, // Set the desired height of the image
                          ),
                        ),
                        labelText: 'Usuario',
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.black45)),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
        
                    validator: (_) {
                      return !state.isEmailValid ? 'Email inválido' : null;
                    },
                    style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.none, // Elimina el subrayado del texto ingresado
                    ),
                  ),
                ),
               
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(color: Colors.black45, width: 1.0), // Agrega un borde de color negro
        
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.lock_outline, color: Colors.black45),
                      ),
                      labelText: 'Contraseña',
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.black45,fontSize: 15,),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          _showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    obscureText: !_showPassword,
                    autovalidateMode: AutovalidateMode.always,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Contraseña inválida' : null;
                    },
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Tres botones:
                      // LoginButton
                      LoginButton(onPressed: () {
                        isLoginButtonEnabled(state) ? _onFormSubmitted() : null;
                      }),
                      
        
                     
              
                    ],
                  ),
                ),
        
        
        
        
              ],
            ),
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {

    _loginBloc!.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc?.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc?.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }
}