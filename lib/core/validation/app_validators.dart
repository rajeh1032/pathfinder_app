class AppValidators {
  const AppValidators._();

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  static String? email(String? value) {
    final requiredMessage = required(value);
    if (requiredMessage != null) return requiredMessage;
    if (!value!.contains('@')) return 'Invalid email';
    return null;
  }
}
