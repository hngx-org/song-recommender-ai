import 'dart:async';

import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setLoadingWithDuration(bool loading) {
    _isLoading = loading;
    futureDelayedLoadingFalse(false);
    notifyListeners();
  }

  void futureDelayedLoadingFalse(bool loading) {
    Timer(const Duration(milliseconds: 900), () {
      _isLoading = loading;
      notifyListeners();
    });
  }
}
