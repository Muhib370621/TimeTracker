
import 'package:blu_time/utilities/extensions.dart';
import 'package:flutter/material.dart';

class PagedList extends StatelessWidget {
  const PagedList(
      {Key? key,
        required this.itemCount,
        required this.itemBuilder,
        this.onScrollToBottom,
        this.onRefresh,
        this.isLastLoader = false,
        this.physics,
        this.separatorBuilder})
      : super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Function()? onScrollToBottom;
  final Function()? onRefresh;
  final IndexedWidgetBuilder? separatorBuilder;
  final bool refreshEnabled = false;
  final bool separatorEnabled = false;
  final bool isLastLoader;
  final String noDataText = 'No data found';
  final ScrollPhysics? physics;

  Widget getSeparator(context, index) {
    return const Divider(
      indent: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          debugPrint("Top scroll : ${metrics.pixels}");
          onScrollToBottom?.call();
        }
        return true;
      },
      child: RefreshIndicator(
          onRefresh: () async {
            onRefresh?.call();
          },
          child: (isLastLoader == false ? (itemCount == 0) : (itemCount == 1))
              ? NoDataView(noDataText: noDataText)
              : ListView.builder(
            physics: physics,
            itemCount: itemCount,
            shrinkWrap: false,
            itemBuilder: (BuildContext context, int index) {
              // if (index == itemCount - (loadMore ? 1 : 0)) {
              //   return loadMore
              //       ? SizedBox(
              //           width: MediaQuery.of(context).size.width,
              //           height: 100,
              //           child: const Center(
              //               child: CircularProgressIndicator()),
              //         )
              //       : SizedBox(
              //           width: MediaQuery.of(context).size.width,
              //           height: 100,
              //         );
              // }
              return itemBuilder.call(context, index);
            },
            //separatorBuilder: getSeparator,
          )),
    );
  }
}

class NoDataView extends StatelessWidget {
  const NoDataView({
    Key? key,
    required this.noDataText,
  }) : super(key: key);

  final String noDataText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: TextExtension.noData(noDataText)));
  }
}
