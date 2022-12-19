// -- state | global
import 'package:app/global/state/global_state.dart';

// -- package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

void setPageRoute(WidgetRef ref, String routeName) {
  ref.read(activeRouteNameProvider.notifier).state = routeName;
}