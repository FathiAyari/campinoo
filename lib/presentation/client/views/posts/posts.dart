import 'package:campino/Models/postModel.dart';
import 'package:campino/presentation/ressources/dimensions/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';

import 'add_post.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  ScrollController _controller = ScrollController();
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffe3eaef),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("${user['profileUrl']}"),
                          radius: Constants.screenHeight * 0.025,
                        ),
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Get.to(AddPost());
                        },
                        child: Container(
                          height: Constants.screenHeight * 0.06,
                          child: Container(
                            decoration:
                                BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Ajouter une publication",
                                    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueAccent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("posts").orderBy("creationDate", descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.size != 0) {
                      return RawScrollbar(
                        thumbColor: Colors.blueAccent,
                        controller: _controller,
                        isAlwaysShown: true,
                        radius: Radius.circular(20),
                        child: ListView.builder(
                            controller: _controller,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              List<PostModel> postslists = [];
                              var listOfData = snapshot.data!.docs.toList();

                              for (var center in listOfData) {
                                postslists.add(PostModel.fromJson(center.data() as Map<String, dynamic>));
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(postslists[index].owner)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                                            if (snapshot.hasData) {
                                              return InkWell(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    Hero(
                                                      tag: snapshot.data!.id,
                                                      child: CircleAvatar(
                                                        radius: Constants.screenHeight * 0.033,
                                                        backgroundColor: Colors.green,
                                                        child: CircleAvatar(
                                                          backgroundImage: NetworkImage("${snapshot.data!.get("profileUrl")}"),
                                                          radius: Constants.screenHeight * 0.030,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("${snapshot.data!.get("userName")}"),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "${DateFormat("yyyy-MM-dd hh:mm").format(postslists[index].creationDate)}"),
                                                              Icon(
                                                                Icons.access_time_sharp,
                                                                size: Constants.screenHeight * 0.02,
                                                                color: Colors.blueAccent,
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    children: [
                                                      ReadMoreText(
                                                        '${postslists[index].description}',
                                                        trimLines: 2,
                                                        style: TextStyle(color: Colors.black),
                                                        colorClickableText: Colors.pink,
                                                        trimMode: TrimMode.Line,
                                                        trimCollapsedText: '...voir plus',
                                                        trimExpandedText: ' reduire ',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (postslists[index].image!.isNotEmpty) ...[
                                            Container(
                                              width: double.infinity,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: Container(
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(20),
                                                    child: Image.network(
                                                      "${postslists[index].image}",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Center(
                        child: Container(
                          height: Constants.screenHeight * 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/lotties/error.json", repeat: false, height: Constants.screenHeight * 0.1),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Pas des publications pour le moment "),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
