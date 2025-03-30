import 'package:flutter/material.dart';
import 'package:photos/provider/photo_provider.dart';
import 'package:provider/provider.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context);
    final favouritepics = photoProvider.photos
        .where((photo) => photoProvider.isFavorite(photo.id))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: favouritepics.isEmpty
          ? Center(
              child: const Text("No Favourites Yet"),
            )
          : ListView.builder(
              itemCount: favouritepics.length,
              itemBuilder: (context, index) {
                final photo = favouritepics[index];
                return ListTile(
                  leading: Image.network('https://placehold.co/600x400.png'),
                  title: Text(photo.title),
                  subtitle: Text(photo.url),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      photoProvider.togglefav(photo.id);
                    },
                  ),
                );
              }),
    );
  }
}
