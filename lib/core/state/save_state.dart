

abstract class SaveState {
  const SaveState();
}

class SaveInitial extends SaveState {
  const SaveInitial();
}

class SaveLoading extends SaveState {
  const SaveLoading();
}

class SaveSuccess extends SaveState {
  const SaveSuccess();
}

class SaveError extends SaveState {
  final String message;

  const SaveError({required this.message});
}