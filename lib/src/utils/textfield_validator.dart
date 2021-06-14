class TextFieldValidator{
  static String validateEmail(String value) {
    final validEmail = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(validEmail);
    if (value.isEmpty) {
      return 'Completa este campo';
    } else if (!regExp.hasMatch(value)) {
      return 'Ingrese un correo electrónico valido';
    } else {
      return null;
    }
  }

  static String validatePassword(String value) {
    if (value.isEmpty) return 'Completa este campo';
    if (value.length < 5) return 'Contraseña debe ser entre 5 y 16 caracteres';
    return null;
  }

  static String validateEmpty(String value) {
    if (value.isEmpty) return 'Completa este campo.';
    return null;
  }

  static String validateCellPhone(String value) {
    value.trim();
    if (value.isEmpty || value.length!=10) return 'Teléfono celular no válido';
    return null;
  }
}