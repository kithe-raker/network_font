import 'package:hive/hive.dart';
part 'FontHiveData.g.dart';

@HiveType(typeId: 0)
class FontHiveData extends HiveObject {
  @HiveField(0)
  late String family;

  @HiveField(1)
  late String url;

  @HiveField(2)
  late int initedTimestamp;

  Duration get sinceInitedDate => DateTime.now()
      .difference(DateTime.fromMillisecondsSinceEpoch(this.initedTimestamp));
}
