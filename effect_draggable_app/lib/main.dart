import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: DragAndDropClassification(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

const List<Item> _items = [
  Item(
    name: '苹果',
    image: 'images/fruit.png'
  ),
  Item(
    name: '小白菜',
    image: 'images/vegetable.png',
  ),
];

@immutable
class DragAndDropClassification extends StatefulWidget {
  const DragAndDropClassification({super.key});

  @override
  State<DragAndDropClassification> createState() => _DragAndDropClassificationState();
}

class _DragAndDropClassificationState extends State<DragAndDropClassification>
    with TickerProviderStateMixin {
  final List<Classification> _plant = [
    Classification(
      name: '水果',
    ),
    Classification(
      name: '蔬菜',
    ),
  ];

  final GlobalKey _draggableKey = GlobalKey();

  void _itemDroppedOnClassificationCart({
    required Item item,
    required Classification classfication,
  }) {
    setState(() {
      classfication.items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF64209)),
      title: Text(
        '快来给我们分分类',
        style: Theme.of(context).textTheme.headline4?.copyWith(
          fontSize: 36,
          color: const Color(0xFFF64209),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildPlantList(),
              ),
              _buildClassficationRow(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlantList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 12.0,
        );
      },
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildPlantItem(
          item: item,
        );
      },
    );
  }

  Widget _buildPlantItem({
    required Item item,
  }) {
    return LongPressDraggable<Item>(
      data: item,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: _draggableKey,
        photoPath: item.image,
      ),
      child: PlantListItem(
        name: item.name,
        photoPath: item.image,
      ),
    );
  }

  Widget _buildClassficationRow() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 20.0,
      ),
      child: Row(
        children: _plant.map(_buildClassficationWithDropZone).toList(),
      ),
    );
  }

  Widget _buildClassficationWithDropZone(Classification classfication) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
        ),
        child: DragTarget<Item>(
          builder: (context, candidateItems, rejectedItems) {
            return ClassficationCart(
              hasItems: classfication.items.isNotEmpty,
              highlighted: candidateItems.isNotEmpty,
              classification: classfication,
            );
          },
          onAccept: (item) {
            _itemDroppedOnClassificationCart(
              item: item,
              classfication: classfication,
            );
          },
        ),
      ),
    );
  }
}

class ClassficationCart extends StatelessWidget {
  const ClassficationCart({
    super.key,
    required this.classification,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Classification classification;
  final bool highlighted;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    final textColor = highlighted ? Colors.white : Colors.black;

    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8.0 : 4.0,
        borderRadius: BorderRadius.circular(22.0),
        color: highlighted ? const Color(0xFFF64209) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8.0),
              Text(
                classification.name,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: textColor,
                  fontWeight:
                  hasItems ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              Visibility(
                visible: hasItems,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Column(
                  children: [
                    const SizedBox(height: 4.0),
                    Text(
                      classification.totalSize,
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        color: textColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '已分类${classification.items.length}个',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: textColor,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlantListItem extends StatelessWidget {
  const PlantListItem({
    super.key,
    this.name = '',
    required this.photoPath,
    this.isDepressed = false,
  });

  final String name;
  final String photoPath;
  final bool isDepressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12.0,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.easeInOut,
                    height: isDepressed ? 115 : 120,
                    width: isDepressed ? 115 : 120,
                    child: Image.asset(photoPath, fit:BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.photoPath,
  });

  final GlobalKey dragKey;
  final String photoPath;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          height: 150,
          width: 150,
          child: Opacity(
            opacity: 0.85,
            child: Image.asset(photoPath, fit:BoxFit.cover)
          ),
        ),
      ),
    );
  }
}

@immutable
class Item {
  const Item({
    required this.name,
    required this.image,
  });
  final String name;
  final String image;
}

class Classification {
  Classification({
    required this.name,
    List<Item>? items,
  }) : items = items ?? [];

  final String name;
  final List<Item> items;

  String get totalSize {
    return items.length.toString();
  }
}