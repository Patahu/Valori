class Validators {
  // Crear regExp
  // Email:
  static final fechasEspa = {1:'Ene',2:'Feb',3:'Mar',4:'Abr',5:'May',6:'Jun',7:'Jul',8:'Ago',9:'Sep',10:'Oct',11:'Nov',12:'Dic'};

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  // Password:
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  // 2 funciones:
  // isValidEmail
  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  // isValidPassword
  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  // isValidPasswordConfirm
  static isValidPasswordConfirm(String passwordCofirm) {
    return _passwordRegExp.hasMatch(passwordCofirm);
  }
  static  bool determinarCon(bool es_visto, bool es_pregunta, bool es_echo) {
    if (es_pregunta && es_visto && es_echo) {
      return true;
    } else if (es_pregunta && !es_visto && !es_echo) {
      return false;
    } else if (!es_pregunta && es_visto) {
      return true;
    } else if (es_echo && !es_visto) {
      return true;
    } else {
      return false;
    }
  }
}