mixin KeyMap {
  bool _keyUp = false;
  bool _keyDown = false;
  bool _keyLeft = false;
  bool _keyRight = false;

  void arrowUp(bool pressed) {
    _keyUp = pressed;
  }

  void arrowDown(bool pressed) {
    _keyDown = pressed;
  }

  void arrowLeft(bool pressed, bool flip) {
    if (flip) {
      _keyRight = pressed;
    } else {
      _keyLeft = pressed;
    }
  }

  void arrowRight(bool pressed, bool flip) {
    if (flip) {
      _keyLeft = pressed;
    } else {
      _keyRight = pressed;
    }
  }

  bool get isUp => _keyUp;

  bool get isDown => _keyDown;

  bool get isBackward => _keyLeft;

  bool get isForward => _keyRight;

  bool get isIdle => !(_keyLeft || _keyRight || _keyUp || _keyDown);
}
