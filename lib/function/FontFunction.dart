part of network_font;

/// Manages your network font with [FontFunction]
class FontFunction {
  static final FontFunction instance = FontFunction._internal();
  static final Set<String> _initedFont = {};
  static final Completer _initCompleter = Completer();
  static bool _isIniting = false;

  static const String _hiveBoxName = 'networkFonts';
  static Duration _expiredDuration = const Duration(days: 30);
  static Duration get expiredDuration => _expiredDuration;

  FontFunction._internal();

  Future<String> get _localFontPath async {
    final Directory cacheDirectory = await getTemporaryDirectory();
    return '${cacheDirectory.path}/network_font_package/local_font';
  }

  Future<Box> get _localFontData async {
    late final Box _box;

    if (_isIniting) await _initCompleter.future;

    if (!_initCompleter.isCompleted) {
      _isIniting = true;

      final Directory cacheDirectory = await getTemporaryDirectory();
      Hive.init('${cacheDirectory.path}/network_font_package');
      Hive.registerAdapter(FontHiveDataAdapter());
      _box = await Hive.openBox(_hiveBoxName);
      _initCompleter.complete();

      _isIniting = false;
    } else
      _box = Hive.box(_hiveBoxName);

    return _box;
  }

  FontHiveData _fontDataToHive(NetworkFont fontData) => FontHiveData()
    ..family = fontData.family
    ..url = fontData.url
    ..initedTimestamp = DateTime.now().millisecondsSinceEpoch;

  /// Set expired duration of cached font.
  ///
  /// Default is 30 days
  /// **Note: You should call this before [initFont]**
  void setExpiredDuration(Duration duration) => _expiredDuration = duration;

  /// Init [fontData] from network to your application.
  ///
  /// This operation'll read font data from cache if it exists.
  /// Otherwise download from [fontData.url] and store it to cache.
  ///
  /// Also This operation has unnecessary initialization checker,
  /// so call same [fontData] multiple-time does not repeated.
  ///
  /// ***Note: Currently only support OpenType (OTF) and TrueType (TTF) fonts.***
  Future<void> initFont(NetworkFont fontData) async {
    if (_initedFont.contains(fontData.family)) return;
    late final Future<ByteData> fontBytes = _getFontBytesData(fontData);

    final FontLoader font = FontLoader(fontData.family);
    font.addFont(fontBytes);
    await font.load();

    _initedFont.add(fontData.family);
  }

  /// get font data
  /// 
  /// ![](https://github.com/kithe-raker/network_font/blob/master/docs/WorkFlow.png?raw=true)
  ///
  Future<ByteData> _getFontBytesData(NetworkFont fontData) async {
    late final Future<ByteData> fontBytes;

    // // get local font
    final Box fontBox = await _localFontData;

    final FontHiveData? localFont = fontBox.get(fontData.id);

    if (localFont == null ||
        localFont.url != fontData.url ||
        _expiredDuration.compareTo(localFont.sinceInitedDate).isNegative)
      fontBytes = _storeFont(fontData);
    else
      fontBytes = _readLocalFont(fontData);

    return fontBytes;
  }

  Future<ByteData> _readLocalFont(NetworkFont fontData) async {
    final File localFile = File('${await _localFontPath}/${fontData.fileName}');
    final bool exists = await localFile.exists();
    final ByteData byteData = exists
        ? ByteData.view(localFile.readAsBytesSync().buffer)
        : await _storeFont(fontData);
    return byteData;
  }

  Future<ByteData> _storeFont(NetworkFont fontData) async {
    final Box fontBox = await _localFontData;
    final File localFile = File('${await _localFontPath}/${fontData.fileName}');
    final FontHiveData fontHiveData = _fontDataToHive(fontData);
    late final ByteData fontBytes;

    await Future.wait([
      _downloadFont(fontData.url).then((value) => fontBytes = value),
      fontBox.put(fontData.id, fontHiveData),
      localFile.create(recursive: true)
    ]);
    localFile.writeAsBytesSync(fontBytes.buffer.asUint8List());
    return fontBytes;
  }

  Future<ByteData> _downloadFont(String url) async {
    final http.Client client = http.Client();
    late final ByteData data;
    try {
      final http.Response response = await client.get(Uri.parse(url));
      final Uint8List uint = response.bodyBytes;
      data = ByteData.view(uint.buffer);
    } catch (e) {
      print('download font error: $e');
    } finally {
      client.close();
    }
    return data;
  }
}
