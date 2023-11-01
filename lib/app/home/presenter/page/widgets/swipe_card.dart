library swipeable_card_stack;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:progressprodis/app/home/presenter/page/widgets/swipe_controller.dart';

export 'swipe_controller.dart';

const List<Alignment> cardsAlign = [
  Alignment(0.0, 1.3),
  Alignment(0.0, 1.0),
  Alignment(0.0, 0.0)
];
List<Size> cardsSize = List.filled(3, const Size(1, 1));

class SwipeableCardsSection extends StatefulWidget {
  final SwipeableCardSectionController? cardController;
  final List<Widget> items;
  final Function? onCardSwiped;
  final double cardWidthTop;
  final double cardWidthMiddle;
  final double cardWidthBottom;
  final double cardHeightTop;
  final double cardHeightMiddle;
  final double cardHeightBottom;
  final double cardHeight;
  final Function? appendItemCallback;
  final bool enableSwipeUp;
  final bool enableSwipeDown;

  SwipeableCardsSection({
    super.key,
    this.cardController,
    required BuildContext context,
    required this.items,
    this.onCardSwiped,
    this.cardHeight = 200,
    this.cardWidthTop = 0.9,
    this.cardWidthMiddle = 0.85,
    this.cardWidthBottom = 0.8,
    this.cardHeightTop = 0.99,
    this.cardHeightMiddle = 0.90,
    this.cardHeightBottom = 0.80,
    this.appendItemCallback,
    this.enableSwipeUp = true,
    this.enableSwipeDown = true,
  }) {
    final width = MediaQuery.of(context).size.width;
    cardsSize[0] = Size(width * cardWidthTop, cardHeight * cardHeightTop);
    cardsSize[1] = Size(width * cardWidthMiddle, cardHeight * cardHeightMiddle);
    cardsSize[2] = Size(width * cardWidthBottom, cardHeight * cardHeightBottom);
  }

  @override
  _CardsSectionState createState() => _CardsSectionState();
}

class _CardsSectionState extends State<SwipeableCardsSection>
    with SingleTickerProviderStateMixin {
  int cardsCounter = 0;
  int index = 0;
  Widget? appendCard;

  List<Widget?> cards = [];
  late AnimationController _controller;
  bool enableSwipe = true;

  final Alignment defaultFrontCardAlign = const Alignment(0.0, 0.0);
  Alignment frontCardAlign = cardsAlign[2];
  double frontCardRot = 0.0;

  void _triggerSwipe(Direction dir) {
    final swipedCallback = widget.onCardSwiped ?? (_, __, ___) => true;
    bool? shouldAnimate = false;
    if (dir == Direction.left) {
      shouldAnimate = swipedCallback(Direction.left, index, cards[0]);
      frontCardAlign = const Alignment(-0.001, 0.0);
    } else if (dir == Direction.right) {
      shouldAnimate = swipedCallback(Direction.right, index, cards[0]);
      frontCardAlign = const Alignment(0.001, 0.0);
    } else if (dir == Direction.down) {
      shouldAnimate = swipedCallback(Direction.down, index, cards[0]);
      frontCardAlign = const Alignment(0.0, 0.0);
    }

    shouldAnimate ??= true;

    if (shouldAnimate) {
      animateCards();
    }
  }

  void _appendItem(Widget newCard) {
    appendCard = newCard;
  }

  void _enableSwipe(bool isSwipeEnabled) {
    setState(() => enableSwipe = isSwipeEnabled);
  }

  @override
  void initState() {
    super.initState();

    final cardController = widget.cardController;
    if (cardController != null) {
      cardController.listener = _triggerSwipe;
      cardController.addItem = _appendItem;
      cardController.enableSwipeListener = _enableSwipe;
    }

    // Init cards
    for (cardsCounter = 0; cardsCounter < 3; cardsCounter++) {
      if (widget.items.isNotEmpty && cardsCounter < widget.items.length) {
        cards.add(widget.items[cardsCounter]);
      } else {
        cards.add(null);
      }
    }

    frontCardAlign = cardsAlign[2];

    // Init the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _controller.addListener(() => setState(() {}));
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) changeCardsOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;
    return Expanded(
      child: IgnorePointer(
        ignoring: !enableSwipe,
        child: Stack(
          children: <Widget>[
            if (cards[2] != null) backCard(),
            if (cards[1] != null) middleCard(),
            if (cards[0] != null) frontCard(),
            ((_controller.status != AnimationStatus.forward))
                ? SizedBox.expand(
                    child: GestureDetector(
                      onPanUpdate: (DragUpdateDetails details) {
                        setState(() {
                          frontCardAlign = Alignment(
                            frontCardAlign.x + 20 * details.delta.dx / wid,
                            frontCardAlign.y + 20 * details.delta.dy / hei,
                          );
                          frontCardRot = frontCardAlign.x;
                        });
                      },
                      onPanEnd: (_) {
                        final onCardSwiped = widget.onCardSwiped ?? () => true;
                        bool? shouldAnimate = false;
                        if (frontCardAlign.x > 3.0) {
                          shouldAnimate = onCardSwiped(
                            Direction.right,
                            index,
                            cards[0],
                          );
                        } else if (frontCardAlign.x < -3.0) {
                          shouldAnimate =
                              onCardSwiped(Direction.left, index, cards[0]);
                        } else if (frontCardAlign.y > 3.0 &&
                            widget.enableSwipeDown) {
                          shouldAnimate =
                              onCardSwiped(Direction.down, index, cards[0]);
                        } else {
                          setState(() {
                            frontCardAlign = defaultFrontCardAlign;
                            frontCardRot = 0.0;
                          });
                        }

                        shouldAnimate ??= true;
                        if (shouldAnimate) {
                          animateCards();
                        }
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget backCard() {
    return Align(
      alignment: _controller.status == AnimationStatus.forward
          ? CardsAnimation.backCardAlignmentAnim(_controller).value
          : cardsAlign[0],
      child: SizedBox.fromSize(
        size: _controller.status == AnimationStatus.forward
            ? CardsAnimation.backCardSizeAnim(_controller).value
            : cardsSize[2],
        child: cards[2],
      ),
    );
  }

  Widget middleCard() {
    return Align(
      alignment: _controller.status == AnimationStatus.forward
          ? CardsAnimation.middleCardAlignmentAnim(_controller).value
          : cardsAlign[1],
      child: SizedBox.fromSize(
        size: _controller.status == AnimationStatus.forward
            ? CardsAnimation.middleCardSizeAnim(_controller).value
            : cardsSize[1],
        child: cards[1],
      ),
    );
  }

  Widget frontCard() {
    return Align(
      alignment: _controller.status == AnimationStatus.forward
          ? CardsAnimation.frontCardDisappearAlignmentAnim(
              _controller,
              frontCardAlign,
            ).value
          : frontCardAlign,
      child: Transform.rotate(
        angle: (pi / 180.0) * frontCardRot,
        child: SizedBox.fromSize(
          size: cardsSize[0],
          child: cards[0],
        ),
      ),
    );
  }

  void changeCardsOrder() {
    setState(() {
      cards[0] = cards[1];
      cards[1] = cards[2];
      cards[2] = appendCard;
      appendCard = null;
      cardsCounter++;
      index++;
      frontCardAlign = defaultFrontCardAlign;
      frontCardRot = 0.0;
    });
  }

  void animateCards() {
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward();
  }
}

class CardsAnimation {
  static Animation<Alignment> backCardAlignmentAnim(
    AnimationController parent,
  ) {
    return AlignmentTween(begin: cardsAlign[0], end: cardsAlign[1]).animate(
      CurvedAnimation(
        parent: parent,
        curve: const Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );
  }

  static Animation<Size?> backCardSizeAnim(
    AnimationController parent,
  ) {
    return SizeTween(begin: cardsSize[2], end: cardsSize[1]).animate(
      CurvedAnimation(
        parent: parent,
        curve: const Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );
  }

  static Animation<Alignment> middleCardAlignmentAnim(
    AnimationController parent,
  ) {
    return AlignmentTween(begin: cardsAlign[1], end: cardsAlign[2]).animate(
      CurvedAnimation(
        parent: parent,
        curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );
  }

  static Animation<Size?> middleCardSizeAnim(AnimationController parent) {
    return SizeTween(begin: cardsSize[1], end: cardsSize[0]).animate(
      CurvedAnimation(
        parent: parent,
        curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
      ),
    );
  }

  static Animation<Alignment> frontCardDisappearAlignmentAnim(
      AnimationController parent, Alignment beginAlign) {
    if (beginAlign.x == -0.001 ||
        beginAlign.x == 0.001 ||
        beginAlign.x > 3.0 ||
        beginAlign.x < -3.0) {
      return AlignmentTween(
        begin: beginAlign,
        end: Alignment(
          beginAlign.x > 0 ? beginAlign.x + 30.0 : beginAlign.x - 30.0,
          0.0,
        ),
      ).animate(
        CurvedAnimation(
          parent: parent,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
        ),
      );
    } else {
      return AlignmentTween(
        begin: beginAlign,
        end: Alignment(
          0.0,
          beginAlign.y > 0 ? beginAlign.y + 30.0 : beginAlign.y - 30.0,
        ),
      ).animate(
        CurvedAnimation(
          parent: parent,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
        ),
      );
    }
  }
}
