import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: Center(
          child: ParallaxEffectApp(),
        ),
      ),
    );
  }
}

class ParallaxEffectApp extends StatelessWidget {
  const ParallaxEffectApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final card in cards)
            CardListItem(
              imageUrl: card.imageUrl,
              name: card.name,
            ),
        ],
      ),
    );
  }
}

class CardListItem extends StatelessWidget {
  CardListItem({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  final String imageUrl;
  final String name;
  final GlobalKey _backgroundImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _buildParallaxBackground(context),
              _buildTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context)!,
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Image.asset(imageUrl,key: _backgroundImageKey,fit: BoxFit.cover)
      ],
    );
  }

  Widget _buildTitle() {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);


  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // 把listItem的坐标转换成为scrollableBox里面的坐标
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // 计算listItemOffset.dy在整个scrollable的比例
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
    (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // 计算verticalAlignment
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // 将背景verticalAlignment转换成为绘制的pixel
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
    verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // 绘制背景图片
    context.paintChild(
      0,
      transform:
      Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class MyCard {
  const MyCard({
    required this.name,
    required this.imageUrl,
  });

  final String name;
  final String imageUrl;
}

const cards = [
  MyCard(
    name: '第一张卡片',
    imageUrl: 'images/image.webp',
  ),
  MyCard(
    name: '第二张卡片',
    imageUrl: 'images/image.webp',
  ),
  MyCard(
    name: '第三张卡片',
    imageUrl: 'images/image.webp',
  ),
  MyCard(
    name: '第四张卡片',
    imageUrl: 'images/image.webp',
  ),
  MyCard(
    name: '第五张卡片',
    imageUrl: 'images/image.webp',
  ),
  MyCard(
    name: '第六张卡片',
    imageUrl: 'images/image.webp',
  ),
  MyCard(
    name: '第七张卡片',
    imageUrl: 'images/image.webp',
  ),
];