import 'package:flutter/material.dart';
import 'package:steemit/presentation/page/home/comments_card.dart';
import 'package:steemit/util/style/base_color.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BaseColor.background,
        title: const Text('Comments', style: TextStyle(color: BaseColor.grey900),),
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: BaseColor.grey900, //change your color here
        ),
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) => CommentsCard(),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://antimatter.vn/wp-content/uploads/2022/04/buon-anh-meo-khoc-cute.jpg'),
                radius: 18,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Add your comment here...',
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: const Text(
                    'Post',
                    style: TextStyle(color: BaseColor.blue400),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

