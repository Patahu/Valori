




import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../firebase/aut_usuario/firebase_data_user.dart';
import '../../../modelos/habilidad.dart';
import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';
import 'bloc.dart';

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';


class ReporteBloc extends Bloc<ReporteEvent, ReporteState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  StreamSubscription? _subscriptionTodo1;
  late List<Usuario> _listaUsuarios;
  List<Usuario> _listaPractico=[];
  List<Usuario> _listaAyudo=[];
  List<Habilidad> _listaValores=[];
  late Usuario _user;
  String _tipo='valor';
  final valoreviole={'valor':'7WHNRTlEpV4hyLstOyWt','violencia':'OspYS2UCSZyKY3BscHJm'};
  ReporteBloc() : super(ReporteState.empty()) {
    on<initReporte>(iniciarResum);
    on<updateReporte>(contin);
    on<cambiarToAyudoReporte>(quienAyudo);
    on<cambiarToAyudoPractico>(quienPractico);
    on<cambiarToValorPractico>(quePractico);
    on<continuarReporte>(determinar);
    on<cambiarToDescripcion>(ingresarDescripcion);
    on<buscarAmigosReporte>(buscarAmigos);
    on<ingresarUsuarioReporteParticipo>(ingresarUsuarioPractico);
    on<ingresarUsuarioReporteAyudo>(ingresarUsuarioAyudo);
    on<ingresarQuePractico>(ingresarQueP);
    on<ingresarReporteDB>(ingresarReporteTOdb);
    

  }
  List<Usuario> get listaPractico=>_listaPractico;
  List<Usuario> get listaAyudo=>_listaAyudo;
  List<Habilidad> get listaValores=>_listaValores;

  FutureOr<void> ingresarReporteTOdb(ingresarReporteDB event, Emitter<ReporteState> emit) async {
   
    final Map<String,dynamic> listaAyudo={};
    for (var element in _listaAyudo) { 
      listaAyudo[element.id]=[element.nombres,element.imagen];
    }


    final Map<String,dynamic> listaPractico={};
    for (var element in _listaPractico) { 
      listaPractico[element.id]=[element.nombres,element.imagen];
    }

    final Map<String,String> listaValores={};
    for (var element in _listaValores) { 
      listaValores[element.id]=element.nombre;
    }
    _firebaseAuthDataUser.crearReporte(event.descripcion,_user,_tipo,listaAyudo,listaPractico,listaValores);
    emit(state.copyWith(isSuccess: true));
    
  }

  FutureOr<void> ingresarQueP(ingresarQuePractico event, Emitter<ReporteState> emit) async {
    
    final usu=state.habilidades[event.index];
    if(usu.colorR==0){
      _listaValores.add(usu);
      state.habilidades[event.index].colorR=4291359200;
    }else{
      _listaValores.remove(usu);
      state.habilidades[event.index].colorR=0;
    }

    emit(state.copyWith(habilidades: state.habilidades));
  }

  FutureOr<void> ingresarUsuarioAyudo(ingresarUsuarioReporteAyudo event, Emitter<ReporteState> emit) async {
    
    final usu=state.usuarios[event.index];
    if(usu.puesto==0){
      _listaAyudo.add(usu);
      state.usuarios[event.index].puesto=4291359200;
    }else{
      _listaAyudo.remove(usu);
      state.usuarios[event.index].puesto=0;
    }
    print("RAUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU"+_listaAyudo.length.toString());
    emit(state.copyWith(usuarios: state.usuarios));
  }
  FutureOr<void> ingresarUsuarioPractico(ingresarUsuarioReporteParticipo event, Emitter<ReporteState> emit) async {
    
    final usu=state.usuarios[event.index];
    if(usu.puesto==0){
      _listaPractico.add(usu);
      state.usuarios[event.index].puesto=4291359200;
    }else{
      _listaPractico.remove(usu);
      state.usuarios[event.index].puesto=0;
    }
    print("RAUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU"+_listaPractico.length.toString());
    emit(state.copyWith(usuarios: state.usuarios));
  }
  FutureOr<void> buscarAmigos(buscarAmigosReporte event, Emitter<ReporteState> emit) async {
    _listaUsuarios=await _firebaseAuthDataUser.datosAmigos();
    List<Usuario> listaUsuarios=[];
    _listaUsuarios.forEach((value) {
      listaUsuarios.add(value);
      });
     
     emit(state.copyWith(usuarios: listaUsuarios));
  }
  FutureOr<void> determinar(continuarReporte event, Emitter<ReporteState> emit) async {
    if(event.etapa==0){
      add(cambiarToAyudoPractico());
    }
    else if (event.etapa==1){
      add(cambiarToAyudoReporte());
    }else if (event.etapa==2){
      add(cambiarToValorPractico());
    }else if (event.etapa==3){
      add(cambiarToDescripcion());
    }

  }
  FutureOr<void> ingresarDescripcion(cambiarToDescripcion event, Emitter<ReporteState> emit) async {
    emit(state.activaDescripcion());
  }

  FutureOr<void> quePractico(cambiarToValorPractico event, Emitter<ReporteState> emit) async {
    final lista=await _firebaseAuthDataUser.datosHabilidadesNoGlobales(valoreviole[_tipo]!);
    List<Habilidad> listaHabilidades=[];
    lista.forEach((value) {
      
      listaHabilidades.add(Habilidad.copyR(value.nombre, value.id, 0));
      });
    emit(state.activaTipo(listaHabilidades));
  }

  FutureOr<void> quienPractico(cambiarToAyudoPractico event, Emitter<ReporteState> emit) async {

    _listaPractico=[];
    _listaAyudo=[];
    _listaValores=[];
    emit(state.activaPractico());
  }

  FutureOr<void> quienAyudo(cambiarToAyudoReporte event, Emitter<ReporteState> emit) async {
    List<Usuario> listaUsuarios=[];
    _listaUsuarios.forEach((value) {
      value.puesto=0;
      listaUsuarios.add(value);
      });
     
    emit(state.activaAyudo(listaUsuarios));
  }
  FutureOr<void> contin(updateReporte event, Emitter<ReporteState> emit) async {

    emit(state.copyWith(reportes: event.reportes,isLoad: true,isPractico: true));
  }
  FutureOr<void> iniciarResum(initReporte event, Emitter<ReporteState> emit) async {
      _cancelSubscription();
      _tipo=event.tipo;
      _user = await _firebaseAuthDataUser.getUsuario();
      
      _subscriptionTodo1=_firebaseAuthDataUser.datosReporte(_user.id,_tipo).listen((elementos) {  

        add(updateReporte(elementos));

      });

  }

  // Método para cancelar la suscripción
  void _cancelSubscription() {
    if (_subscriptionTodo1 != null) {
      _subscriptionTodo1!.cancel();
    }
  }





}
