import 'package:flutter/material.dart';
import 'package:instagram/utils/colors.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final Map<String, dynamic> snap;
  const PostCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(snap['profileImage']),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () => feedDiaglog(context),
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),

          //IMAGE SECTION
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              snap['photoUrl'],
              fit: BoxFit.cover,
            ),
          ),

          //BOTTOM SECTION
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border),
                  ),
                ),
              )
            ],
          ),
          //DESCRIPTION AND NUMBER OF COMMENTS SECTION
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '${snap['likes'].length} likes',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  // ignore: prefer_const_constructors
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: AppColors.primaryColor),
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        TextSpan(
                            text: snap['username'],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: " ${snap['description']}",
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'View all 200 comments',
                      style: TextStyle(
                          fontSize: 16, color: AppColors.secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                   DateFormat.yMMMd().format(snap['datePublished'].toDate()),
                    style: TextStyle(
                        fontSize: 16, color: AppColors.secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//Here we are still within the stateless class....
  Future<dynamic> feedDiaglog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shrinkWrap: true,
          children: ['Delete']
              .map(
                (e) => InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Text(e),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
