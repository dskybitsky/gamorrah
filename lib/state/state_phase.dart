enum StatePhase { initial, success, error, loading }

extension StatePhaseX on StatePhase {
  bool get isInitial => this == StatePhase.initial;
  bool get isSuccess => this == StatePhase.success;
  bool get isError => this == StatePhase.error;
  bool get isLoading => this == StatePhase.loading;
}
