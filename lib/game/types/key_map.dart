mixin KeyMap {
  bool flip = false;

  bool keyUp = false;
  bool keyDown = false;

  bool _keyLeft = false;
  bool _keyRight = false;

  bool keyA = false;
  bool keyB = false;
  bool keyX = false;
  bool keyY = false;

  bool get keyLeft => _keyLeft;

  bool get keyRight => _keyRight;

  set keyLeft(bool pressed) {
    if (flip) {
      _keyRight = pressed;
    } else {
      _keyLeft = pressed;
    }
  }

  set keyRight(bool pressed) {
    if (flip) {
      _keyLeft = pressed;
    } else {
      _keyRight = pressed;
    }
  }
}
