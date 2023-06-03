import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_with_apis/album_state.dart';
import 'package:riverpod_with_apis/api_provider.dart';

class AlbumStateNotifier extends StateNotifier<AlbumState> {
  AlbumStateNotifier() : super(AlbumInitialState());

  AlbumAPIProvider albumAPIProvider = AlbumAPIProvider();

  void fetchAlbums() async {
    state = AlbumLoadingState();

    try {
      var albums = await albumAPIProvider.fetchAlbums();
      state = AlbumLoadedState(albums: albums);
    } catch (e) {
      state = AlbumErrorState(errorMessage: e.toString());
    }
  }
}
