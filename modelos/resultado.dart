


class Resultado {
  int _enProgreso=0;
  int _total=0;
  String _idAptitud;

  Resultado(this._enProgreso, this._total, this._idAptitud);

  int get enProgreso => _enProgreso;
  set enProgreso(int value) => _enProgreso = value;

  int get total => _total;
  set total(int value) => _total = value;

  String get idResultado => _idAptitud;
  set idResultado(String value) => _idAptitud = value;
}
