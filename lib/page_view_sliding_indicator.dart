library page_view_sliding_indicator;

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A Page view sliding indicator.
class PageViewSlidingIndicator extends HookWidget {
  final PageController controller;
  final int pageCount;
  final Color color;

  PageViewSlidingIndicator({
    required this.controller,
    required this.pageCount,
    this.color = const Color(0xff278fff),
  });
  @override
  Widget build(BuildContext context) {
    final _currentPage = useState(0);
    final _leftPosition = useState(16.0);

    useEffect(() {
      controller.addListener(() {
        if (controller.page != null) {
          _currentPage.value = controller.page!.round();
          _leftPosition.value = controller.page! * 16 + 16;
        }
      });
      return;
    }, []);
    return Stack(
      children: [
        SizedBox(
          height: 8,
          child: ListView.separated(
            itemCount: pageCount,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => AnimatedContainer(
              width: _currentPage.value == index ? 16 : 8,
              height: 8,
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              width: 8,
            ),
          ),
        ),
        AnimatedPositioned(
          top: 0,
          bottom: 0,
          left: _leftPosition.value,
          duration: Duration(milliseconds: 100),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        )
      ],
    );
  }
}
