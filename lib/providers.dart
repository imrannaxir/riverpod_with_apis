import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'album_state.dart';
import 'album_state_notifier.dart';

final albumStateProvider =
    StateNotifierProvider<AlbumStateNotifier, AlbumState>((ref) {
  return AlbumStateNotifier();
});
