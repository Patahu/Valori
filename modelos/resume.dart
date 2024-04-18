


class Resume {
  int _correctas = 0;
  int _incorrectas = 0;
  int _puntajeCorrectas = 0;
  int _puntajeIncorrectas = 0;
  int _numeroOrden;
  String _tipo = ''; // Nuevo atributo tipo String
  int _indexTempora=0;
  Resume({
    required int correctas,
    required int incorrectas,
    required int puntajeCorrectas,
    required int puntajeIncorrectas,
    required int numeroOrden,
    required int indexTemporal,
    required String tipo, // Agregar el nuevo atributo tipo String
  })  : _correctas = correctas,
        _incorrectas = incorrectas,
        _puntajeCorrectas = puntajeCorrectas,
        _puntajeIncorrectas = puntajeIncorrectas,
        _numeroOrden = numeroOrden,
        _indexTempora=indexTemporal,
        _tipo = tipo; // Inicializar el nuevo atributo tipo String
  int get indexTemporal => _indexTempora;
  set indexTemporal(int value) => _indexTempora = value;
  
  int get correctas => _correctas;
  set correctas(int value) => _correctas = value;

  int get incorrectas => _incorrectas;
  set incorrectas(int value) => _incorrectas = value;

  int get pcorrectas => _puntajeCorrectas;
  set pcorrectas(int value) => _puntajeCorrectas = value;

  int get pincorrectas => _puntajeIncorrectas;
  set pincorrectas(int value) => _puntajeIncorrectas = value;
  
  int get numeroOrden => _numeroOrden;
  set numeroOrden(int value) => _numeroOrden = value;

  String get tipo => _tipo; // Getter para el nuevo atributo tipo String
  set tipo(String value) => _tipo = value; // Setter para el nuevo atributo tipo String

  factory Resume.empty() {
    return Resume(
      correctas: 0,
      incorrectas: 0,
      puntajeCorrectas: 0,
      puntajeIncorrectas: 0,
      numeroOrden: 0,
      indexTemporal:0,
      tipo: '', // Asegúrate de incluir el atributo tipo aquí
    );
  }
  @override
  String toString() {
    return 'Correctas: $_correctas\n'
        'Incorrectas: $_incorrectas\n'
        'Puntaje Correctas: $_puntajeCorrectas\n'
        'Puntaje Incorrectas: $_puntajeIncorrectas\n'
        'Número de Orden: $_numeroOrden\n'
        'indexTemporal: $_indexTempora\n'
        'Tipo: $_tipo';
  }
}

