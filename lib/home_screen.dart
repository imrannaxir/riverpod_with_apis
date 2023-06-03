import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_with_apis/album_state.dart';
import 'package:riverpod_with_apis/providers.dart';
import 'package:riverpod_with_apis/widget/album_error_widget.dart';
import 'package:riverpod_with_apis/widget/album_initial_widget.dart';
import 'package:riverpod_with_apis/widget/album_loaded_widget.dart';
import 'package:riverpod_with_apis/widget/album_loading_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  //
  //
  void _increment() {
    ref.read(albumStateProvider.notifier).fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          var state = ref.watch(albumStateProvider);

          if (state is AlbumInitialState) {
            return const AlbumInitialWidget();
          } else if (state is AlbumLoadingState) {
            return const AlbumLoadingWidget();
          } else if (state is AlbumLoadedState) {
            return AlbumLoadedWidget(albums: state.albums);
          } else {
            return AlbumErrorWidget(
                errorMessage: (state as AlbumErrorState).errorMessage);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}
