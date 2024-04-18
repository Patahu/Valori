



abstract class TiempoEvent  {
  TiempoEvent();

  @override
  List<Object> get props => [];
}

class StartTimer extends TiempoEvent {}

class StopTimer extends TiempoEvent {}


class updateTimer extends TiempoEvent {
  final String tiempo;
  updateTimer(this.tiempo);

}


