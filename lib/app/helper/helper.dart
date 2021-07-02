class Helper {
  static String lengthValidator(
    String text, {
    int length = 0,
    String message = 'Campo Obrigatório',
  }) {
    if (text.isEmpty) {
      return message;
    } else if (text.length < length) {
      return "Precisa ter no mínimo $length digítos";
    }

    return null;
  }

  static String emailValidator(String text) {
    if (text.isEmpty || text.indexOf('@') == -1 || text.indexOf('.') == -1) {
      return 'Email inválido';
    }

    return null;
  }

  static String equalValidator(
    String text, {
    String value,
    String message = 'A senha não coincide',
  }) {
    if (text != value) {
      return message;
    }
    return null;
  }
}
