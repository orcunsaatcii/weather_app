import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageControlNotifier extends StateNotifier<bool> {
  PageControlNotifier() : super(true);

  void setSearchMode() {
    state = false;
  }

  void setLocalMode() {
    state = true;
  }
}

final pageControlProvider = StateNotifierProvider<PageControlNotifier, bool>(
  (ref) => PageControlNotifier(),
);
