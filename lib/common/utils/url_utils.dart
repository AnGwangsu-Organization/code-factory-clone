import 'package:code_factory_clone/common/const/data.dart';

class UrlUtils {
  // ! 무조건 스태틱이어야함
  static String pathToUrl(String value){
    return 'http://$ip$value';
  }
}