import 'package:equatable/equatable.dart';
import 'package:valorix/src/modelos/aprende.dart';

import '../../../modelos/reporte.dart';



abstract class ReportePsicologEvent  {
  const ReportePsicologEvent();
  @override
  List<Object> get props => [];
}


class iniciarVistaReportePsicolog extends ReportePsicologEvent {

}

class iniciarVistaReportePsicologTodo extends ReportePsicologEvent {

}

class iniciarCambiarVisto extends ReportePsicologEvent{
  final String idDocumento;

  iniciarCambiarVisto(this.idDocumento);
}
class updateReportesPsicologo extends ReportePsicologEvent {
  final List<Reporte> reportes;

  updateReportesPsicologo(this.reportes);

}

class updateReportesPsicologoTodo extends ReportePsicologEvent {
  final List<Reporte> reportes;

  updateReportesPsicologoTodo(this.reportes);

}
