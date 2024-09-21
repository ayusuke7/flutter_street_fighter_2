mixin KeyMap {
  bool flip = false;

  bool _keyUp = false;
  bool _keyDown = false;
  bool _keyLeft = false;
  bool _keyRight = false;

  bool keyA = false;
  bool keyB = false;
  bool keyX = false;
  bool keyY = false;

  set keyUp(bool pressed) {
    _keyUp = pressed;
  }

  set keyDown(bool pressed) {
    _keyDown = pressed;
  }

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

  bool get isUp => _keyUp;

  bool get isDown => _keyDown;

  bool get isBackward => _keyLeft;

  bool get isForward => _keyRight;

  bool get isIdle => !(_keyLeft || _keyRight || _keyUp || _keyDown);
}
