class AppValidators {
  static String? validateEmail(value, {bool allowEmpty = false}) {
    const String emptyValidator = "Email can't be empty";
    const String validValidator = "Email is invalid";
    if (value == null || value.isEmpty && !allowEmpty) {
      return emptyValidator;
    }
    if ((value == null || value.isEmpty) && allowEmpty) {
      return null;
    }
    String pattern =
        r"^([a-zA-Z0-9_\-\.\+]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return validValidator;
    }
    return null;
  }

  static String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Password is Required';
    }
    // at least one lower case, upper case and special charachter more than 8 length
    RegExp pattern = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,}$');
    if (!pattern.hasMatch(value)) {
      return 'Password must have one upper case, one lower case and a special character and must be 8 charachters long';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String ogPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != ogPassword) {
      return 'Password do not match';
    }
    return null;
  }
}
