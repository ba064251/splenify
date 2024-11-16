
class ApiState {}

class ApiInitial extends ApiState {}

class APIDataLoading extends ApiState{}

class APIDataError extends ApiState{
  final String errorMessage;

  APIDataError(this.errorMessage);
}

class APIDataGet extends ApiState{}