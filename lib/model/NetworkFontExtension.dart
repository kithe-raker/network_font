part of network_font;

extension NetworkFontExtension on TextStyle {
  /// Decorate [Text] with your custom font from network
  ///
  /// **Note:** [this.fontFamily] will take value from [font.family],
  /// so provide your [fontFamily] in [style] is **Ineffective**
  TextStyle network(NetworkFont font) {
    /// Init [font] from network
    FontFunction.instance.initFont(font);

    return this.copyWith(fontFamily: font.family);
  }
}
