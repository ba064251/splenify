import 'package:bloc/bloc.dart';
import 'package:taskbysplenify/services/api_service.dart';

import 'api_event.dart';
import 'api_state.dart';


class ApiBloc extends Bloc<ApiEvent, ApiState> {
  APIServices _apiServices;
  ApiBloc(this._apiServices) : super(ApiInitial()) {
    on<GettingData>(_onDataGet);
  }

  void _onDataGet(GettingData event, Emitter<ApiState> emit){
    try{
      emit(APIDataLoading());
      _apiServices.getAllProducts();
      _apiServices.getCategory();
      emit(APIDataGet());
    } catch(e){
      emit(APIDataError(e.toString()));
    }
  }
}
