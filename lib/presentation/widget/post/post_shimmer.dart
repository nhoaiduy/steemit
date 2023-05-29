import 'package:flutter/material.dart';
import 'package:steemit/generated/l10n.dart';
import 'package:steemit/presentation/widget/shimmer/shimmer_widget.dart';
import 'package:steemit/util/style/base_color.dart';

class PostShimmer extends StatelessWidget {
  const PostShimmer({Key? key}) : super(key: key);

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
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ShimmerWidget.base(
                            width: 32, height: 32, shape: BoxShape.circle)),
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget.base(
                              width: 100,
                              height: 21,
                              borderRadius: BorderRadius.circular(10.0)),
                          const SizedBox(height: 2.0),
                          ShimmerWidget.base(
                              width: 150,
                              height: 16,
                              borderRadius: BorderRadius.circular(10.0))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ShimmerWidget.base(
                  width: double.infinity,
                  height: 18,
                  borderRadius: BorderRadius.circular(10.0))),
          // Image
          ShimmerWidget.base(
            height: 250,
            width: double.infinity,
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
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_outline,
                      ),
                      const SizedBox(width: 5),
                      Text(S.current.btn_like),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.comment_outlined,
                    ),
                    const SizedBox(width: 5),
                    Text(S.current.btn_comment),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
