import 'package:flutter/material.dart';
import 'package:proyect/src/screens/post_screen.dart';
import 'package:proyect/src/models/post.dart';
import 'package:proyect/src/screens/api_screen.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<SocialPost> socialPosts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        title: Text('Social Media App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter, 
            colors: [Colors.black, Colors.lightBlueAccent],
          ),
        ),
        child: GridView.count(
          crossAxisCount: 1,
          children: _buildSocialPostCards(socialPosts),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final newPost = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostScreen()),
              );
              if (newPost != null) {
                setState(() {
                  socialPosts.add(newPost);
                });
              }
            },
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApi()),
              );
              // Do something with the result if needed
            },
            child: Text(
              "API",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSocialPostCards(List<SocialPost> socialPosts) {
    return socialPosts.map((post) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              socialPosts.remove(post);
            });
          },
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    post.imageUrl,
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            post.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                socialPosts.remove(post);
                              });
                            },
                          ),
                        ],
                      ),
                      Text(
                        post.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        post.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
