import 'package:hive/hive.dart';

part 'flashcardfile.g.dart';

@HiveType(typeId: 3)
class FlashcardClass extends HiveObject{

  @HiveField(0)
  int collectionId = 0;

  @HiveField(1)
  int cardColor = 0;

  @HiveField(2)
  String frontside = "";

  @HiveField(3)
  String backside = "";

  FlashcardClass(this.collectionId, this.cardColor, this.frontside, this.backside);

}