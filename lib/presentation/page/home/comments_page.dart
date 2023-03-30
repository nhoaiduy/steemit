import 'package:flutter/material.dart';
import 'package:steemit/presentation/page/home/comments_card.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/presentation/widget/textfield/textfield_widget.dart';
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
        elevation: 0,
        title: const Text(
          'Comments',
          style: TextStyle(color: BaseColor.grey900),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(
          color: BaseColor.grey900, //change your color here
        ),
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 1.0),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: BaseColor.grey60))),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => const CommentsCard(),
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
              AvatarWidget.base(name: "steemit_user"),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 8),
                    child: TextFieldWidget.common(
                        onChanged: (text) {}, hintText: "Type your comment")),
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
