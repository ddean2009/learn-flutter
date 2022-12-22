import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: ShimmerLoadingApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFCACAE6),
    Color(0xFFF4F4F4),
    Color(0xFFCACAE6),
  ],
  stops: [
    0.2,
    0.4,
    0.5,
  ],
  begin: Alignment(-2.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.mirror,
);

class ShimmerLoadingApp extends StatefulWidget {
  const ShimmerLoadingApp({
    super.key,
  });

  @override
  State<ShimmerLoadingApp> createState() =>
      _ShimmerLoadingAppState();
}

class _ShimmerLoadingAppState extends State<ShimmerLoadingApp> {
  bool _isLoading = true;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperTotalWidget(
        linearGradient: _shimmerGradient,
        child: ListView(
          children: [
            _buildListItem(),
            _buildListItem(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleLoading,
        child: Icon(
          _isLoading ? Icons.downloading : Icons.switch_right,
        ),
      ),
    );
  }

  Widget _buildListItem() {
    return WrapperInnerWidget(
      isLoading: _isLoading,
      child: MyListItem(
        isLoading: _isLoading,
      ),
    );
  }
}

class WrapperTotalWidget extends StatefulWidget {
  static WrapperTotalWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<WrapperTotalWidgetState>();
  }

  const WrapperTotalWidget({
    super.key,
    required this.linearGradient,
    this.child,
  });

  final LinearGradient linearGradient;
  final Widget? child;

  @override
  WrapperTotalWidgetState createState() => WrapperTotalWidgetState();
}

class WrapperTotalWidgetState extends State<WrapperTotalWidget> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: 0, max: 1, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
    colors: widget.linearGradient.colors,
    stops: widget.linearGradient.stops,
    begin: widget.linearGradient.begin,
    end: widget.linearGradient.end,
    transform:
    _SlidingGradientTransform(slidePercent: _shimmerController.value),
  );

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final outsideBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: outsideBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class WrapperInnerWidget extends StatefulWidget {
  const WrapperInnerWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<WrapperInnerWidget> createState() => _WrapperInnerWidgetState();
}

class _WrapperInnerWidgetState extends State<WrapperInnerWidget> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = WrapperTotalWidget.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    // 找到父组件中的wrapperTotalWidget
    final wrapperTotalWidget = WrapperTotalWidget.of(context)!;
    final totalSize = wrapperTotalWidget.size;
    final gradient = wrapperTotalWidget.gradient;
    final offsetWithinTotalWidget = wrapperTotalWidget.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      //当前child的mask
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        //整个shimmer的渐变
        return gradient.createShader(
          Rect.fromLTWH(
            //把坐标移动到左上角，以便于不同的gradient展示为同一个整体
            -offsetWithinTotalWidget.dx,
            -offsetWithinTotalWidget.dy,
            totalSize.width,
            totalSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class MyListItem extends StatelessWidget {
  const MyListItem({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(height: 16),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset('images/head.jpg',fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildText() {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 120,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          '胜日寻芳泗水滨，无边光景一时新。等闲识得东风面，万紫千红总是春。',
        ),
      );
    }
  }
}