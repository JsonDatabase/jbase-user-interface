import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_package/jbase_package.dart';

class ControlPlaneCubit extends Cubit<ControlPlane> {
  ControlPlaneCubit() : super(ControlPlane(ControlPlaneSetting()));

  void addEntity(String entityName, String entityJSON) {
    state.addEntity(entityName, entityJSON);
    emit(state);
  }

  void removeEntity(String entityName) {
    state.removeEntity(entityName);
    emit(state);
  }
}
