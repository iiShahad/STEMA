String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!value.contains('@') || !value.contains('.')) {
    return 'Please enter a valid email';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  if (value.trim().length < 8) {
    return 'Your password should not be less than 8 characters';
  }
  return null;
}

String? requiredValidatior(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}
