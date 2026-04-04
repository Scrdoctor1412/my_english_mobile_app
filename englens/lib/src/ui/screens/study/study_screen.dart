import 'package:englens/src/ui/screens/scan_to_translate/scan_to_translate_screen.dart';
import 'package:englens/src/ui/screens/study/grammar/grammar_screen.dart';
import 'package:englens/src/ui/screens/study/learning_category/learning_category_screen_viewmodel.dart';
import 'package:englens/src/ui/screens/study/random_flashcards/random_flashcards_screen.dart';
import 'package:englens/src/ui/screens/study/study_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyScreen extends GetView<StudyScreenViewmodel> {
  static const routeName = '/studyScreen';
  const StudyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderRow(context),
              const SizedBox(height: 32),
              _buildTitleSection(context),
              const SizedBox(height: 24),
              _buildMostRecentCard(),
              const SizedBox(height: 24),
              _buildFeaturesList(context),
              const SizedBox(height: 32),
              _buildEditorsNote(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Header
  Widget _buildHeaderRow(BuildContext context) {
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
          onPressed: () {},
          icon: const Icon(Icons.search_rounded, color: Color(0xFF7B61FF)),
        ),
      ],
    );
  }

  // Title Section
  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Study",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: context.textTheme.bodyLarge?.color ?? const Color(0xFF222222),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Pick a lens and sharpen your focus today.",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: context.isDarkMode ? Colors.white54 : Colors.black54,
          ),
        ),
      ],
    );
  }

  // Most Recent Card
  Widget _buildMostRecentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF7B61FF), // Deep purple
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7B61FF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'MOST RECENT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Advanced Business\nIdioms',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Unit 4: Strategic Negotiations',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.65,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '65%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'Continue Learning',
                style: TextStyle(
                  color: Color(0xFF7B61FF),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Features List
  Widget _buildFeaturesList(BuildContext context) {
    return Column(
      children: [
        _buildFeatureItem(
          title: 'Vocabulary',
          subtitle: 'Expand your lexicon',
          icon: Icons.menu_book_rounded,
          iconColor: const Color(0xFF7B61FF),
          iconBgColor: context.isDarkMode ? const Color(0xFF3A3066) : const Color(0xFFEBE3FF),
          backgroundColor: context.theme.cardColor, // fully wide
          isFullWidth: true,
          context: context,
          onTap: () => controller.onTapToLearningCat(
            title: "Vocabulary",
            screenType: LearningCategoryScreenType.vocabulary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFeatureItem(
                title: 'Grammar',
                subtitle: 'Master the rules',
                icon: Icons.architecture,
                iconColor: const Color(0xFF3278FF),
                iconBgColor: context.isDarkMode ? const Color(0xFF213A6B) : const Color(0xFFD6E4FF),
                backgroundColor: context.theme.cardColor,
                context: context,
                onTap: () => Get.toNamed(GrammarScreen.routeName),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFeatureItem(
                title: 'Translate',
                subtitle: 'Bridge the gap',
                icon: Icons.translate_rounded,
                iconColor: const Color(0xFFE5A633),
                iconBgColor: context.isDarkMode ? const Color(0xFF59431E) : const Color(0xFFFDECD4),
                backgroundColor: context.theme.cardColor,
                context: context,
                onTap: () => Get.toNamed(ScanToTranslateScreen.routeName),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFeatureItem(
                title: 'Expressions',
                subtitle: 'Speak naturally',
                icon: Icons.chat_bubble_outline_rounded,
                iconColor: const Color(0xFF7B61FF),
                iconBgColor: context.isDarkMode ? const Color(0xFF3A3066) : const Color(0xFFEBE3FF),
                backgroundColor: context.theme.cardColor,
                context: context,
                onTap: () => controller.onTapToLearningCat(
                  title: "Expressions",
                  screenType: LearningCategoryScreenType.expressions,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFeatureItem(
                title: 'Flashcards',
                subtitle: 'Active recall',
                icon: Icons.style_rounded,
                iconColor: const Color(0xFFEB5757),
                iconBgColor: context.isDarkMode ? const Color(0xFF5C2323) : const Color(0xFFFFE5E5),
                backgroundColor: context.theme.cardColor,
                context: context,
                onTap: () => Get.toNamed(RandomFlashcardsScreen.routeName),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required Color backgroundColor,
    required BuildContext context,
    bool isFullWidth = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(context.isDarkMode ? 0.3 : 0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isFullWidth
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: context.textTheme.bodyLarge?.color ?? const Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: context.isDarkMode ? Colors.white54 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: iconColor),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: context.textTheme.bodyLarge?.color ?? const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode ? Colors.white54 : Colors.black54,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // Editor's note
  Widget _buildEditorsNote(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.isDarkMode ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFFFEDD5), // Light orange/brown tint
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb_outline_rounded, color: Color(0xFFC7841F), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "EDITOR'S NOTE",
                  style: TextStyle(
                    color: Color(0xFFC7841F),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "\"Consistency isn't about perfection; it's about showing up even when the words don't come easily.\"",
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textTheme.bodyLarge?.color ?? Colors.black87,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
