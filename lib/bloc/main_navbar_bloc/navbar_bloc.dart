import 'package:bloc/bloc.dart';

import 'navbar_event.dart';
import 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarInitial()) {
    on<ChangeIndex>(_onIndexChange);
  }

  void _onIndexChange(ChangeIndex event, Emitter<NavbarState> emit){
    try{
      emit(IndexChanged(event.currentIndex));
    }catch(e){
      emit(IndexError(e.toString()));
    }
  }
}
