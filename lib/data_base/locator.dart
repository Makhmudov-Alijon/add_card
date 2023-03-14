
import 'package:add_card/data_base/data_base.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
Future<void> locatorSetUp() async{

   // await Firebase.initializeApp(
   //    options: DefaultFirebaseOptions.currentPlatform,
   // );
   locator.registerSingleton(DatabaseHelper());
}