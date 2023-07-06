import 'dart:async';

class Debouncer {
  final Duration _delay;
  Timer? _timer;

  Debouncer([
    this._delay = const Duration(milliseconds: 3000),
  ]);

  void run(void Function(bool) bounced) {
    _timer?.cancel();
    bounced(true);
    _timer = Timer(_delay, () => bounced(false));
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
