import 'package:flutter/material.dart';

import '../common_widget/icerik_icon_more_horiz.dart';
import '../model/feed_model.dart';
import '../services/feed_controller.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late Future<List<Feed>> _feedListFuture;

  @override
  void initState() {
    super.initState();
    _feedListFuture = FeedController.getFeedList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: FutureBuilder<List<Feed>>(
              future: _feedListFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Feed> feedList = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: feedList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      Feed feed = feedList[index];
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.09),
                              spreadRadius: 2.2,
                            ),
                          ],
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(feed.profileImage),
                                        radius: 26,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            feed.username,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            feed.department,
                                            style: const TextStyle(
                                                color: Colors.white54),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await MoreHoriz
                                        .buildCustomBottomSheetFeedcomplaint(
                                            context);
                                  },
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              feed.description,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Container(
                                height: 250,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(feed.postImage),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.favorite,
                                            size: 24, color: Colors.red),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          feed.likes.toString(),
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white70,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _showCommentList(
                                                feed.commentContent);
                                          },
                                          icon: const Icon(
                                            Icons.comment,
                                            size: 24,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          feed.comments.toString(),
                                          style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white70,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Transform.rotate(
                                  angle: -0.6,
                                  child: IconButton(
                                    onPressed: () {
                                      _showsendList(feed.commentContent);
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      size: 23,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCommentList(List<CommentContent> comments) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              CommentContent comment = comments[index];
              return ListTile(
                title: Text(comment.username),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                ),
                subtitle: Text(comment.content),
              );
            },
          ),
        );
      },
    );
  }

  void _showsendList(List<CommentContent> comments) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              CommentContent comment = comments[index];
              return ListTile(
                title: Text(comment.username + "_${comment.id} "),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                ),
              );
            },
          ),
        );
      },
    );
  }

/* class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.09),
                spreadRadius: 2.2,
              ),
            ],
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/profile_picture.png'),
                          radius: 26,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Batu özçelik",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Bilgisayar mühendisliği",
                              style: TextStyle(color: Colors.white54),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "..... bir şeyler paylaşmak",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 250,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image:
                              AssetImage('assets/images/KODLAMA-DERSLERI.png'),
                          fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.favorite, size: 24, color: Colors.red),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Begen",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.messenger_outline,
                            size: 24,
                            color: Colors.white70,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "yorum yap",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Transform.rotate(
                    angle: -0.6,
                    child: const Icon(
                      Icons.send,
                      size: 23,
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
 */
}
