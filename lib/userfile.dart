import 'collectionfile.dart';
import 'package:hive/hive.dart';

part 'userfile.g.dart';



@HiveType(typeId: 1)
class UserClass {

  @HiveField(0)
  int userID = 0;

  @HiveField(1)
  String userName = "";

  @HiveField(2)
  String password = "";

  List<CollectionClass> userCollections = [];

  UserClass(this.userID, this.userName, this.password);
  
  String toString() {
    String toReturn = "$userName $password";
    return toReturn;
  }

  void addCollection (collection) {
    userCollections.add(collection);
  }
  
}