enum ActionLoadType {
  primary,
  secondary,
}

class ActionLoadViewModel {
  final double strokeWidth;
  final double size;
  final ActionLoadType type;

  ActionLoadViewModel(this.strokeWidth, this.size, this.type);
}