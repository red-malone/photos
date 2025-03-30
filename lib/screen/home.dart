import 'package:flutter/material.dart';
import 'package:photos/provider/photo_provider.dart';
import 'package:photos/screen/favourites.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<PhotoProvider>(context, listen: false).fetchPhotos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Gallery"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Favourites(),
                ),
              );
            },
            icon: const Icon(Icons.favorite),
          )
        ],
      ),
      body: photoProvider.photos.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: photoProvider.photos.length,
              itemBuilder: (context, index) {
                final photo = photoProvider.photos[index];
                final isFavorite = photoProvider.isFavorite(photo.id);
                return ListTile(
                  leading: Image.network('https://placehold.co/600x400.png'),
                  title: Text(photo.title),
                  subtitle: Text(photo.url),
                  trailing: IconButton(
                    icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border),
                    onPressed: () {
                      photoProvider.togglefav(photo.id);
                    },
                  ),
                );
              }),
    );
  }
}
