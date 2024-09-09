class Color {
  final String ral;
  final String rgb;
  final String hex;
  final String cmyk;
  final String? lrv; // Changed to String? to keep the original value
  final String english;
  final String german;
  final String french;
  final String spanish;
  final String italian;
  final String dutch;

  Color({
    required this.ral,
    required this.rgb,
    required this.hex,
    required this.cmyk,
    this.lrv,
    required this.english,
    required this.german,
    required this.french,
    required this.spanish,
    required this.italian,
    required this.dutch,
  });

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      ral: json['RAL'] ?? '',
      rgb: json['RGB'] ?? '',
      hex: json['HEX'] ?? '',
      cmyk: json['CMYK'] ?? '',
      lrv: json['LRV']
          ?.toString(), // Convert to string, will be null if LRV is not present
      english: json['English'] ?? '',
      german: json['German'] ?? '',
      french: json['French'] ?? '',
      spanish: json['Spanish'] ?? '',
      italian: json['Italian'] ?? '',
      dutch: json['Dutch'] ?? '',
    );
  }

  // If you need to get the LRV as a double, you can add this method
  double? get lrvAsDouble {
    if (lrv == null) return null;
    return double.tryParse(lrv!);
  }
}
