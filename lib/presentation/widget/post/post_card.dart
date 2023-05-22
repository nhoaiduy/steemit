import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:steemit/data/model/post_model.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/bloc/post/controller/post_controller_cubit.dart';
import 'package:steemit/presentation/bloc/post/data/posts/posts_cubit.dart';
import 'package:steemit/presentation/bloc/user/data/me/me_cubit.dart';
import 'package:steemit/presentation/injection/injection.dart';
import 'package:steemit/presentation/page/post/comments_page.dart';
import 'package:steemit/presentation/page/user/user_profile_page.dart';
import 'package:steemit/presentation/widget/avatar/avatar_widget.dart';
import 'package:steemit/util/helper/string_helper.dart';
import 'package:steemit/util/path/services_path.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class PostCard extends StatefulWidget {
  final PostModel postModel;

  const PostCard({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isShow = true;
  bool isSaved = false;
  bool isMe = false;
  bool isLike = false;
  bool isLoading = false;
  bool isOk = false;
  double progress = 0.0;
  PostModel postModel = PostModel();
  final CarouselController imageController = CarouselController();
  final Dio dio = Dio();

  @override
  void initState() {
    postModel = widget.postModel;
    getIt.get<MeCubit>().getData();
    final state = getIt.get<MeCubit>().state;
    if (state is MeSuccess) {
      final user = state.user;
      if (user.id == postModel.userId) {
        setState(() {
          isMe = true;
        });
      }
      if (user.savedPosts!.contains(postModel.id)) {
        setState(() {
          isSaved = true;
        });
      }
      if (postModel.likes!.contains(user.id)) {
        setState(() {
          isLike = true;
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 3, color: BaseColor.grey60))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: AvatarWidget.base(
                      name:
                          "${postModel.user!.firstName} ${postModel.user!.lastName}",
                      size: mediumAvatarSize),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => isMe
                            ? null
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfilePage(postModel.userId!))),
                        child: Text(
                            "${postModel.user!.firstName} ${postModel.user!.lastName}",
                            style: BaseTextStyle.label()),
                      ),
                      Row(
                        children: [
                          Text(
                            StringHelper.formatDate(
                                postModel.updatedAt!.toDate().toString()),
                            style: BaseTextStyle.caption(),
                          ),
                          if (postModel.location != null)
                            Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  postModel.location!,
                                  style: BaseTextStyle.caption(),
                                ))
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {},
                  itemBuilder: (BuildContext context) {
                    return [
                      if (!isMe)
                        PopupMenuItem<String>(
                          value: S.current.btn_save_post,
                          child: Text(isSaved
                              ? S.current.btn_saved_post
                              : S.current.btn_save_post),
                          onTap: () async {
                            if (isSaved) {
                              await getIt
                                  .get<PostControllerCubit>()
                                  .unSave(postId: postModel.id!);
                            } else {
                              await getIt
                                  .get<PostControllerCubit>()
                                  .save(postId: postModel.id!);
                            }
                            setState(() {
                              isSaved = !isSaved;
                            });
                          },
                        ),
                      if (isMe)
                        PopupMenuItem<String>(
                          onTap: () async {
                            getIt.get<PostsCubit>().clean();
                            await getIt
                                .get<PostControllerCubit>()
                                .delete(postId: postModel.id!);
                            getIt.get<PostsCubit>().getPosts();
                          },
                          value: S.current.btn_delete,
                          child: Text(S.current.btn_delete),
                        ),
                    ];
                  },
                ),
              ],
            ),
          ),
          if (postModel.content != null)
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  child: RichText(
                    softWrap: true,
                    overflow:
                        isShow ? TextOverflow.ellipsis : TextOverflow.visible,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: postModel.content,
                          style: BaseTextStyle.body2(),
                        )
                      ],
                    ),
                  ),
                )),
          // Image
          if (postModel.images!.isNotEmpty) imageSlider(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (postModel.likes!.isNotEmpty)
                    ? Text(
                        '${postModel.likes!.length} ${postModel.likes!.length > 1 ? S.current.txt_likes : S.current.txt_like}',
                        style: BaseTextStyle.body2(),
                        overflow: TextOverflow.fade,
                      )
                    : const SizedBox.shrink(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CommentsPage()));
                  },
                  child: Text(
                    '${postModel.comments!.length} ${postModel.comments!.length > 1 ? S.current.txt_comments : S.current.txt_comment}',
                    style: BaseTextStyle.body2(),
                  ),
                ),
              ],
            ),
          ),
          // Actions
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0.8, color: BaseColor.grey60))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      // await DatabaseService().likePost(
                      //     postModel: postModel
                      // );
                      if (isLike) {
                        await getIt
                            .get<PostControllerCubit>()
                            .unLike(postId: postModel.id!);
                        postModel.likes!.removeAt(0);
                      } else {
                        await getIt
                            .get<PostControllerCubit>()
                            .like(postId: postModel.id!);
                        postModel.likes!.add("");
                      }
                      setState(() {
                        isLike = !isLike;
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLike
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: Colors.redAccent,
                                ),
                          const SizedBox(width: 5),
                          Text(S.current.btn_like),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CommentsPage()));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.comment_outlined,
                          ),
                          const SizedBox(width: 5),
                          Text(S.current.btn_comment),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageSlider() {
    return CarouselSlider.builder(
        carouselController: imageController,
        itemCount: postModel.images!.length,
        itemBuilder: (context, index, realIndex) {
          final urlImage = postModel.images![index];
          final postId = postModel.id!;
          return isLoading
              ? isDownload()
              : buildImage(urlImage: urlImage, postId: postId);
        },
        options: CarouselOptions(
            height: 250, enableInfiniteScroll: false, viewportFraction: 1));
  }

  Widget buildImage({required String urlImage, required String postId}) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    urlImage,
                    fit: BoxFit.cover,
                  ),
                ),
                contentPadding: EdgeInsets.zero,
              );
            });
      },
      onLongPress: (){
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: buildListItem(
                    urlImage: urlImage,
                    postId: postId,
                    content: S.current.btn_save_to_phone,
                    icon: Icons.save_alt_outlined,
                ),
              );
            },
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildListItem(
      {required String urlImage,
        required String postId,
        required String content,
        required IconData icon}) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
        downloadFile(urlImage: urlImage, postId: postId);
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8,),
            Text(content, style: const TextStyle(fontSize: 16),),
          ],
        ),
      ),
    );
  }

  Widget isDownload() {
    String downloadProgressing = (progress * 100).toInt().toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(value: progress, color: BaseColor.green600,),
        ),
        Text("Downloading: $downloadProgressing%",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BaseColor.green600),),
      ],

    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> messageFail(){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: BaseColor.green500,
        behavior: SnackBarBehavior.floating,
        content: Text(S.current.txt_exist_this_file,
            style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  Future<bool> saveFile(String url, String fileName) async{
    Directory? directory;
    try{
      if(Platform.isAndroid){
        if(await requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          List<String> folders = directory!.path.split("/");
          for(int i = 1; i < folders.length; i++){
            String folder = folders[i];
            if(folder != "Android"){
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/Steemit";
          directory = Directory(newPath);
         } else {
           return false;
         }
      } else {
        /// Here for IOS.
        return false;
      }
      if(!await directory.exists()){
        await directory.create(recursive: true);
      }
      if(await directory.exists()){
        File saveFile = File("${directory.path}/$fileName");
        //print("$saveFile \n ${saveFile.path}");
        final List<FileSystemEntity> entities = await directory.list().toList();
        for (var element in entities) {
          if(saveFile.path == element.path) {
            messageFail();
            return false;
          }
        }
        await dio.download(url, saveFile.path, onReceiveProgress: (downloaded, totalSize){
          setState(() {
            progress = downloaded / totalSize;
          });
        });
        return true;
      }
    } catch(e){
      print(e);
    }
    return false;
  }

  Future<bool> requestPermission(Permission permission) async{
    if(await permission.isGranted){
      return true;
    } else {
      var result = await permission.request();
      if(result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadFile({required String urlImage, required String postId}) async {
    setState(() {
      isLoading = true;
      progress = 0.0;
    });

    final ref = FirebaseStorage.instance.ref(ServicePath.post).child(postId);
    final result = await ref.listAll();
    final urls = result.items.map((e) => e.getDownloadURL()).toList();
    String? fileName;

    for (int i=0; i<urls.length ; i++){
      if(!isOk) {
        await urls.elementAt(i).then((value) async {
          if(value == urlImage) {
            await result.items[i].getMetadata().then((value) {
              List<String> types = value.contentType!.split("/");
              String name = value.name;
              String type = types[1];
              fileName = "$name.$type";
              setState(() {
                isOk = true;
              });
            });
          }
        });
      } else {
        break;
      }
    }

    bool downloaded = await saveFile(urlImage, fileName!);
    if(downloaded) {
      print("File Downloaded");
    } else {
      print("Problem Downloading File");
    }

    setState(() {
      isLoading = false;
      isOk = false;
    });
  }


}
