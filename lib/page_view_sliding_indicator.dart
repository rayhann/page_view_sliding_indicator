library page_view_sliding_indicator;

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A Page view sliding indicator.
class PageViewSlidingIndicator extends HookWidget {
  final PageController controller;
  final int pageCount;
  final Color color;
  final double size;
  final double borderRadius;

  PageViewSlidingIndicator({
    required this.controller,
    required this.pageCount,
    this.color = const Color(0xff278fff),
    this.borderRadius = 2,
    this.size = 8,
  });
  @override
  Widget build(BuildContext context) {
    final _currentPage = useState(0);
    final _leftPosition = useState(size / 2);

    print('position ${_leftPosition.value}');

    useEffect(() {
      controller.addListener(() {
        if (controller.page != null) {
          _currentPage.value = controller.page!.round();
          _leftPosition.value = controller.page! * (size * 2) + (size / 2);
        }
      });
      return;
    }, []);
    return Stack(
      children: [
        SizedBox(
          height: size,
          child: ListView.separated(
            itemCount: pageCount,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => AnimatedContainer(
              width: _currentPage.value == index ? (size * 2) : size,
              height: size,
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(
              width: size,
            ),
          ),
        ),
        AnimatedPositioned(
          top: 0,
          bottom: 0,
          left: _leftPosition.value,
          duration: Duration(milliseconds: 100),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        )
      ],
    );
  }
}
