import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void setupLocator() => $initGetIt(getIt);

class $initGetIt {
  $initGetIt(GetIt getIt);
}