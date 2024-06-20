import 'package:hive/hive.dart';
import 'flashcardfile.dart';

part 'collectionfile.g.dart';

@HiveType(typeId: 2)
class CollectionClass extends HiveObject{

  @HiveField(0)
  int collectionId = 0;

  @HiveField(1)
  String name = "";

  @HiveField(2)
  int userBelong = 0;



  late List<FlashcardClass> cards;

  CollectionClass(this.collectionId, this.name, this.userBelong){
   cards = [];
  }

  void addCard (card) {
    cards.add(card);
  }

  void deleteCard (card) {
    cards.remove(card);
  }

  String toString() {

    return "$collectionId : $name";
  }

}