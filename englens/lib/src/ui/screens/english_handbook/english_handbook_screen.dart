import 'package:englens/src/ui/screens/english_handbook/english_handbook_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:englens/src/data/models/word.dart';

class EnglishHandbookScreen extends GetView<EnglishHandbookScreenViewmodel> {
  static const routeName = '/englishHandbookScreen';
  const EnglishHandbookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildHeader(context),
                    const SizedBox(height: 32),
                    _buildTitleSection(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchBarDelegate(
                  maxHeight: 80.0,
                  minHeight: 80.0,
                  child: Container(
                    color: context.theme.scaffoldBackgroundColor, // Match background to hide scrolling elements behind it
                    padding: const EdgeInsets.only(bottom: 24.0),
                    alignment: Alignment.center,
                    child: _buildSearchBar(context),
                  ),
                ),
              ),
              _buildSliverWordList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/images/launcher_icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'ENGLENS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: context.textTheme.bodyLarge?.color ?? const Color(0xFF333333),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () => controller.onTapToWordSearch(),
          icon: const Icon(Icons.search_rounded, color: Color(0xFF7B61FF)),
        ),
      ],
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CURATED RESOURCES',
          style: TextStyle(
            color: Color(0xFF7B61FF),
            fontWeight: FontWeight.w800,
            fontSize: 11,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'English\nHandbook',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: context.textTheme.bodyLarge?.color ?? const Color(0xFF222222),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Explore complex idiomatic expressions and fixed phrases with precise grammatical contexts.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: context.isDarkMode ? Colors.white54 : Colors.black54,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return InkWell(
      onTap: () => controller.onTapToWordSearch(),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 56, // fixed height to match SliverPersistentHeader cleanly
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xFF28243D) : const Color(0xFFF3EDFD),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: context.isDarkMode ? Colors.white38 : Colors.black45, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search expressions, prepositions, or idio...',
                style: TextStyle(
                  color: context.isDarkMode ? Colors.white38 : Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverWordList(BuildContext context) {
    return GetBuilder<EnglishHandbookScreenViewmodel>(
      builder: (ctrl) {
        if (ctrl.wordList.isEmpty) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.only(bottom: 24, top: 4),
          sliver: SliverList.builder(
            itemCount: ctrl.wordList.length > 0 ? (ctrl.wordList.length * 2) - 1 : 0,
            itemBuilder: (context, index) {
              if (index.isOdd) return const SizedBox(height: 20);
              int wordIndex = index ~/ 2;
              Word word = ctrl.wordList[wordIndex];
              return _buildHandbookCard(context, word, wordIndex);
            },
          ),
        );
      },
    );
  }

  Widget _buildHandbookCard(BuildContext context, Word word, int index) {
    bool isTinted = index % 2 != 0;
    
    Color tagBgColor;
    Color tagTextColor;
    if (index % 3 == 0) {
      tagBgColor = const Color(0xFFDBECFF);
      tagTextColor = const Color(0xFF6C93FF);
    } else if (index % 3 == 1) {
      tagBgColor = const Color(0xFFEBE3FF);
      tagTextColor = const Color(0xFF8B64FF);
    } else {
      tagBgColor = const Color(0xFFFFF2D9);
      tagTextColor = const Color(0xFFEBA542);
    }

    String levelText = index % 2 == 0 ? 'LEVEL: ADVANCED' : 'LEVEL: FORMAL';

    return InkWell(
      onTap: () {
        Get.toNamed(
          WordDetailsScreen.routeName,
          arguments: WordDetailsScreenViewmodelArgs(
            lessonTitle: '',
            isFromLessonDetailsScreen: false,
            onlyWord: [word],
          ),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isTinted ? (context.isDarkMode ? const Color(0xFF28243D) : const Color(0xFFFCFAFF)) : context.theme.cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isTinted
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(context.isDarkMode ? 0.3 : 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: tagBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    word.pos.toUpperCase(),
                    style: TextStyle(
                      color: tagTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? Colors.white12 : const Color(0xFFF3EDFD),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.volume_up_rounded, color: Color(0xFF7B61FF), size: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              word.word,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: context.textTheme.bodyLarge?.color ?? const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              word.phoneticText.isNotEmpty ? word.phoneticText : '/.../',
              style: TextStyle(
                color: context.isDarkMode ? Colors.white54 : Colors.black45,
                fontSize: 14,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: 32,
              height: 3,
              color: const Color(0xFF7B61FF), // Purple separator
            ),
            const SizedBox(height: 16),
            Text(
              word.senses.isNotEmpty ? word.senses[0].definition : 'No definition available.',
              style: TextStyle(
                color: context.textTheme.bodyLarge?.color ?? Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  levelText,
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white54 : Colors.black45,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                  ),
                ),
                Row(
                  children: const [
                    Text(
                      'Usage Details',
                      style: TextStyle(
                        color: Color(0xFF7B61FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward_rounded, color: Color(0xFF7B61FF), size: 14),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SearchBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
