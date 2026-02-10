double parseFormattedNumber(String formattedNumber) {
  String cleanedNumber = formattedNumber.replaceAll(',', '');

  return double.tryParse(cleanedNumber) ?? 0.0;
}
double extractDouble(String input) {
  // Remove all non-digit and non-decimal characters
  final cleaned = input.replaceAll(RegExp(r'[^0-9.]'), '');

  // Handle cases like empty or multiple dots
  if (cleaned.isEmpty || RegExp(r'^\.|\.\.').hasMatch(cleaned)) {
    return 0.0;
  }

  return double.tryParse(cleaned) ?? 0.0;
}