import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/modelos/aprende.dart';
import 'package:valorix/src/modelos/leccion_progreso.dart';

import '../../../firebase/aut_usuario/firebase_data_user.dart';
import 'bloc.dart';

class ReportePsicologBloc extends Bloc<ReportePsicologEvent, ReportePsicologState> {
  FirbaseAuthDataUser _firebaseAuthDataUser = FirbaseAuthDataUser();
  StreamSubscription? _subscriptionTodo1;
  StreamSubscription? _subscriptionTodo2;


  ReportePsicologBloc() : super(ReportePsicologState.empty()) {
    on<iniciarVistaReportePsicolog>(busReportePsicologPrincipio);
    on<updateReportesPsicologo>(updateReportesPsicolog);
    on<iniciarVistaReportePsicologTodo>(busReportePsicologPrincipioTodos);
    on<updateReportesPsicologoTodo>(updateReportesPsicologTodo);
    on<iniciarCambiarVisto>(cambiarVisto);
   

  }

    FutureOr<void> cambiarVisto(iniciarCambiarVisto event, Emitter<ReportePsicologState> emit) async {
    _firebaseAuthDataUser.modificarVistoReporte(event.idDocumento);
  }
 
  FutureOr<void> updateReportesPsicologTodo(updateReportesPsicologoTodo event, Emitter<ReportePsicologState> emit) async {
    emit(state.copyWith(todosReportes:event.reportes,esCargadoTodo: true,esCargando: false));

  }
  FutureOr<void> busReportePsicologPrincipioTodos(iniciarVistaReportePsicologTodo event, Emitter<ReportePsicologState> emit) async {

    _cancelSubscription();
    _subscriptionTodo2 = _firebaseAuthDataUser.datosReporteTodos().listen((reportes) {
      add(updateReportesPsicologoTodo(reportes));
     
    });
    //emit(state.copyWith(reportes:resultados,esCargado: true,esCargando: false));

  }
  FutureOr<void> updateReportesPsicolog(updateReportesPsicologo event, Emitter<ReportePsicologState> emit) async {
    emit(state.copyWith(reportesNuevos:event.reportes,esCargadoTodo: false,esCargando: true));

   

  }
  
  FutureOr<void> busReportePsicologPrincipio(iniciarVistaReportePsicolog event, Emitter<ReportePsicologState> emit) async {

    _cancelSubscription();
    _subscriptionTodo1 = _firebaseAuthDataUser.datosReporteInicio().listen((reportes) {
      add(updateReportesPsicologo(reportes));
     
    });
    //emit(state.copyWith(reportes:resultados,esCargado: true,esCargando: false));

  }

  // Método para cancelar la suscripción
  void _cancelSubscription() {
    if (_subscriptionTodo1 != null) {
      _subscriptionTodo1!.cancel();

    }
    if(_subscriptionTodo2!=null){
      _subscriptionTodo2!.cancel();
    }
  }
  @override
  Future<void> close() {
    // Asegurarse de cancelar la suscripción al cerrar el Bloc
    _cancelSubscription();

    return super.close();
  }


  



}
