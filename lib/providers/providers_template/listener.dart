abstract class Listener {
  onAddListener(Function run);

  onChangeListener(Function run);

  onDeleteListener(Function run);

  removeListeners();
}
