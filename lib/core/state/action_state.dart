abstract class ActionState<T> {
  const ActionState();
}

class ActionInitial<T> extends ActionState<T> {
  const ActionInitial();
}

class ActionLoading<T> extends ActionState<T> {
  const ActionLoading();
}

class ActionSuccess<T> extends ActionState<T> {
  final T? data;

  const ActionSuccess({this.data});
}

class ActionError<T> extends ActionState<T> {
  final String message;

  const ActionError({required this.message});
}