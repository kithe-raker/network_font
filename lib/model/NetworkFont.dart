part of network_font;

/// Data of network font
class NetworkFont {
  /// Family name of you font
  final String family;

  /// Url where to download your font file.
  ///
  /// ***Note: Currently only support OpenType (OTF) and TrueType (TTF) fonts.***
  final String url;
  NetworkFont(this.family, {required this.url});

  late final String id = this.family.trim();
  late final String fileName = '${this.id}.tmp';

  /// Decorate [Text] with your custom font
  TextStyle style({
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<ui.Shadow>? shadows,
    List<ui.FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return TextStyle(
            color: color,
            backgroundColor: backgroundColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            letterSpacing: letterSpacing,
            wordSpacing: wordSpacing,
            textBaseline: textBaseline,
            height: height,
            locale: locale,
            foreground: foreground,
            background: background,
            shadows: shadows,
            fontFeatures: fontFeatures,
            decoration: decoration,
            decorationColor: decorationColor,
            decorationStyle: decorationStyle,
            decorationThickness: decorationThickness)
        .network(this);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkFont &&
          runtimeType == other.runtimeType &&
          family == other.family &&
          url == other.url;

  @override
  int get hashCode => family.hashCode ^ url.hashCode;
}
