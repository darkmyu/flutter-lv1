import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppBar(),
          renderBuilderSliverList(),
          renderSliverGridBuilder(),
        ],
      ),
    );
  }

  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      // 스크롤 했을때 리스트 중간 이어도 AppBar 내려옴
      floating: true,
      // AppBar 상단 고정
      pinned: false,
      // 자석 효과
      // ㄴ floating: true 에만 사용 가능
      snap: true,
      // 상단 스크롤 최대시 AppBar 차지
      stretch: true,
      expandedHeight: 200,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'FlexibleSpace',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        background: Image.asset(
          'asset/img/image_1.jpeg',
          fit: BoxFit.cover,
        ),
      ),
      title: const Text(
        'CustomScrollViewScreen',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.blue,
    );
  }

  // 1. SliverChildListDelegate - 전부 렌더링 (성능 이슈)
  // ㄴ ListView() 와 유사함
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  // 2. SliverChildBuilderDelegate - 리스트 가상화 (성능 향상)
  // ㄴ ListView.builder() 와 유사함
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100,
      ),
    );
  }

  // 3. Grid - SliverChildListDelegate
  // ㄴ GridView.count() 와 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  // 4. Grid - SliverChildBuilderDelegate
  // ㄴ GridView.builder() 와 유사함
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);

    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
