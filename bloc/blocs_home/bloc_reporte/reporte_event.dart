import '../../../modelos/reporte.dart';


abstract class ReporteEvent {}


class initReporte extends ReporteEvent{
  final String tipo;

  initReporte(this.tipo);
}

class updateReporte extends ReporteEvent{
  final List<Reporte> reportes;

  updateReporte(this.reportes);
}

class cambiarToAyudoReporte extends ReporteEvent{
}


class cambiarToAyudoPractico extends ReporteEvent{
}

class cambiarToDescripcion extends ReporteEvent{
}

class buscarAmigosReporte extends ReporteEvent{}

class cambiarToValorPractico extends ReporteEvent{
}

class ingresarUsuarioReporteParticipo extends ReporteEvent{
  final int index;

  ingresarUsuarioReporteParticipo(this.index);
}
class ingresarQuePractico extends ReporteEvent{
  final int index;

  ingresarQuePractico(this.index);
}
class ingresarReporteDB extends ReporteEvent{
  final String descripcion;

  ingresarReporteDB(this.descripcion);
}


class ingresarUsuarioReporteAyudo extends ReporteEvent{
  final int index;

  ingresarUsuarioReporteAyudo(this.index);
}

class continuarReporte extends ReporteEvent{
  final int etapa;

  continuarReporte(this.etapa);
}