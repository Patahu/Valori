import '../../../modelos/resume.dart';
import '../../../modelos/usuario.dart';

abstract class ResumeEvent {}


class initResume extends ResumeEvent{
  final List<Resume> resumenes;
  initResume(this.resumenes);
  @override
  List<Object> get props => [resumenes];
}

class continuarResume extends ResumeEvent{
}


class videoResume extends ResumeEvent{

  final Resume resumen;
  videoResume(this.resumen);
  @override
  List<Object> get props => [resumen];
}

class ejercicioResume extends ResumeEvent{
  final Resume resumen;
  ejercicioResume(this.resumen);
  @override
  List<Object> get props => [resumen];
}

class rollResume extends ResumeEvent{

}