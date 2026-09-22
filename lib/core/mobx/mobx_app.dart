import 'package:myinoface/core/util/static.dart';
import 'package:mobx/mobx.dart';

part 'mobx_app.g.dart';

class MobxApp = MobxHomeBase with _$MobxApp;

abstract class MobxHomeBase with Store {

  @observable
  double selected = 0.0;

  @observable
  bool alert = false;

  @action
  void select(double val) {
    selected = val;
  }

  @action
  void setAlert(bool val) {
    alert = val;
  }

  @observable
  int currentIndex = 0;

  @action
  void onPageChanged(int index) {
    currentIndex = index;
    Static.currentIndex = index;
  }

  @observable
  int index = 0;

  @action
  void setIndex(int val) => index = val;

  @observable
  bool isLoading = false;

  @action
  void setLoadingState(bool val) => isLoading = val;

  @observable
  int indexClass = 0;

  @action
  void setIndexClass(int index) {
    indexClass = index;
  }
}