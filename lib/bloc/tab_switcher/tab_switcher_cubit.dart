import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_switcher_state.dart';

class TabSwitcherCubit extends Cubit<TabSwitcherState> {
  TabSwitcherCubit() : super(TabSwitcherInitial());

  void loadPending() async {
    // emit(TabSwitcherLoading());
    emit(PendingTabLoaded());
  }

  void loadAccepted() {
    emit(AcceptedTabLoaded());
  }

  void loadDeclined() {
    emit(DeclinedTabLoaded());
  }
}
