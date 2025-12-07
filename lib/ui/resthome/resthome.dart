import 'package:flutter/material.dart';
import 'package:inn/models/post.dart';
import 'package:inn/services/remote_service.dart';

class Resthome extends StatefulWidget {
  const Resthome({super.key});

  @override
  State<Resthome> createState() => _ResthomeState();
}

class _ResthomeState extends State<Resthome> {
  List<Post>? posts;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('posts')),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(5),
              child: Text(posts![index].title),
            );
          },
        ),
      ),
    );
  }
}
