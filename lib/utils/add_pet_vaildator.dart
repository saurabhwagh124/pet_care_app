class Validation {
  static String? validateText(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return '$fieldName should only contain letters';
    }
    return null;
  }

  static String? validateNumber(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (double.tryParse(value) == null) {
      return '$fieldName should be a valid number';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validateNotNull(String? value, String FieldName) {
    if (value == null || value.isEmpty) {
      return '${FieldName} is required';
    }
    return null;
  }
}
