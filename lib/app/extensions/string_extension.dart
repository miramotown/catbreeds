extension NullableStringExtension on String? {
  String orHyphen() => this ?? '-';

  String safeEmpty() => this ?? '';

  int toSafeInt() => int.tryParse(this ?? '0') ?? 0;

  double toSafeDouble() => double.tryParse(this ?? '0.0') ?? 0.0;
}

extension StringExtension on String {
  int toInt() => int.tryParse(this) ?? 0;

  double toDouble() => double.tryParse(this) ?? 0.0;

  String masked(int revealChars) {
    if (revealChars <= 0 || revealChars >= length) {
      return '*' * length;
    } else {
      return '*' * (length - revealChars) + substring(length - revealChars);
    }
  }

  String maskedLast(int maskedLastChars) {
    if (maskedLastChars <= 0 || maskedLastChars >= length) {
      return '*' * length;
    } else {
      return substring(0, length - maskedLastChars) + '*' * (maskedLastChars) ;
    }
  }

  bool validateEmail() {
    const pattern1 = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    const pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    final regex = RegExp(pattern);

    return regex.hasMatch(this);
  }

  String removeAccents() {
    return replaceAll(RegExp(r'[áäâàãåā]'), 'a')
        .replaceAll(RegExp(r'[ÁÄÂÀÃÅĀ]'), 'A')
        .replaceAll(RegExp(r'[éëêèěẽēėę]'), 'e')
        .replaceAll(RegExp(r'[ÉËÊÈĚẼĒĖĘ]'), 'E')
        .replaceAll(RegExp(r'[íïîìǐĩīį]'), 'i')
        .replaceAll(RegExp(r'[ÍÏÎÌǏĨĪĮ]'), 'I')
        .replaceAll(RegExp(r'[óöôòǒõō]'), 'o')
        .replaceAll(RegExp(r'[ÓÖÔÒǑÕŌ]'), 'O')
        .replaceAll(RegExp(r'[úüûùǔũūűů]'), 'u')
        .replaceAll(RegExp(r'[ÚÜÛÙǓŨŪŰŮ]'), 'U')
        .replaceAll("'", "");
  }

  String capitalizeWord() {
    if (isEmpty) return this;
    return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
  }

  String capitalizeFirstLetter() {
    if (isEmpty) {
      return this;
    }

    List<String> words = split(RegExp(r"(\b|(?=[,.]))")); // Divide por límites de palabra, puntos y comas
    List<String> formattedWords = [];

    for (int i = 0; i < words.length; i++) {
      String word = words[i];
      if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9\s]').hasMatch(word)) {
        formattedWords.add(word); // Si es un carácter especial o un espacio, lo agrega sin modificar
      } else {
        formattedWords.add(_formatWord(word));
      }
    }

    return formattedWords.join("");
  }

  String _formatWord(String word) {
    if (word.length == 1 && !RegExp(r'\b').hasMatch(word)) {
      return word.toLowerCase(); // Si la palabra tiene solo un carácter y no es una palabra completa, lo convierte a minúsculas
    } else if (word.length == 2 && word.endsWith(".")) {
      return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}'; // Capitaliza la primera letra y convierte la segunda en minúscula si la palabra tiene exactamente dos caracteres y termina con un punto
    } else if (word.length == 2) {
      return word.toLowerCase(); // Si la palabra tiene solo dos caracteres, los convierte a minúsculas
    } else {
      String firstLetter = word.substring(0, 1).toUpperCase();
      String restOfWord = word.substring(1).toLowerCase();

      if (RegExp(r'\bJR\.\b').hasMatch(word.toUpperCase())) { // Corregimos la expresión regular para que sea insensible a mayúsculas
        return 'Jr.$restOfWord'; // Convierte "JR." en "Jr."
      } else if (RegExp(r'[áéíóúü]').hasMatch(firstLetter)) {
        return '$firstLetter$restOfWord'; // Mantiene la tilde solo en la primera letra de la palabra
      } else {
        return '$firstLetter$restOfWord';
      }
    }
  }

  String removeHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return replaceAll(exp, '');
  }
}
 
