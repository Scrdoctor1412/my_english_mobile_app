import 'package:englens/src/ui/screens/home/home_screen_viewmodel.dart';
import 'package:englens/src/ui/widget/my_wordlists/my_wordlists_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen.dart';
import 'package:englens/src/ui/widget/word_details/word_details_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:englens/src/data/models/word.dart';

class HomeScreen extends GetView<HomeScreenViewmodel> {
  static const routeName = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderRow(),
              const SizedBox(height: 32),
              _buildWelcomeTexts(context),
              const SizedBox(height: 32),
              _buildTwoCards(context),
              const SizedBox(height: 32),
              _buildProgressCard(context),
              const SizedBox(height: 32),
              _buildRandomWordsLabel(context),
              const SizedBox(height: 16),
              _buildRandomWordsStack(context),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage('assets/images/launcher_icon.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Text(
          'ENGLENS',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF7B61FF),
            letterSpacing: 1.2,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined, color: Color(0xFF7B61FF)),
        ),
      ],
    );
  }

  Widget _buildWelcomeTexts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 4),
            children: [
              TextSpan(text: 'W ', style: TextStyle(color: Color(0xFF7B61FF))),
              TextSpan(text: 'e ', style: TextStyle(color: Color(0xFF4C8DFF))),
              TextSpan(text: 'l ', style: TextStyle(color: Color(0xFF7B61FF))),
              TextSpan(text: 'c ', style: TextStyle(color: Color(0xFF4C8DFF))),
              TextSpan(text: 'o ', style: TextStyle(color: Color(0xFFFF9500))),
              TextSpan(text: 'm ', style: TextStyle(color: Color(0xFFFF9500))),
              TextSpan(text: 'e ', style: TextStyle(color: Color(0xFF7B61FF))),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your linguistic journey continues today.',
          style: TextStyle(color: context.isDarkMode ? Colors.white54 : Colors.black54, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildTwoCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed(MyWordlistsScreen.routeName);
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: context.isDarkMode ? const Color(0xFF28243D) : const Color(0xFFF3EDFD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.book_rounded, color: Color(0xFF7B61FF), size: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'My WordLists',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: context.isDarkMode ? Colors.white : Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '12 ACTIVE LISTS',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: context.isDarkMode ? Colors.white54 : Colors.black45, letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            onTap: () => controller.onTapToLeinerDailyWords(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF3278FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.calendar_month_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Daily words',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'READY FOR TODAY',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, color: Colors.white70, letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(context.isDarkMode ? 0.3 : 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'How many words have you learned\ntoday?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: context.textTheme.bodyLarge?.color ?? Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          GetBuilder<HomeScreenViewmodel>(builder: (ctrl) {
            String value = "${ctrl.todaLearnWordsIds.length}";
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.isDarkMode ? const Color(0xFF2E2A40) : const Color(0xFFF9F5FF),
                  ),
                ),
                SizedBox(
                  width: 130,
                  height: 130,
                  child: CircularProgressIndicator(
                    value: ctrl.indicatorValue,
                    backgroundColor: Colors.transparent,
                    color: const Color(0xFF7B61FF),
                    strokeWidth: 8,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontWeight: FontWeight.w800, color: context.textTheme.bodyLarge?.color ?? Colors.black87),
                        children: [
                          TextSpan(text: value, style: const TextStyle(fontSize: 48)),
                          TextSpan(text: '/5', style: TextStyle(fontSize: 32, color: context.isDarkMode ? Colors.white38 : Colors.black38)),
                        ],
                      ),
                    ),
                    Text(
                      'GOAL',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: context.isDarkMode ? Colors.white38 : Colors.black38, letterSpacing: 1.5),
                    ),
                  ],
                ),
              ],
            );
          }),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8A63F8), Color(0xFF6F43F5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7B61FF).withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(28),
                child: const Center(
                  child: Text(
                    "START TODAY'S LESSON",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRandomWordsLabel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily random 5 words for you!',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: context.textTheme.bodyLarge?.color ?? Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Curated based on your progress.',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: context.isDarkMode ? Colors.white54 : Colors.black54),
            ),
          ],
        ),
        GetBuilder<HomeScreenViewmodel>(builder: (ctrl) {
          return InkWell(
            onTap: () => ctrl.onInitRandomWords(),
            child: const Icon(Icons.refresh_rounded, color: Color(0xFF7B61FF), size: 24),
          );
        }),
      ],
    );
  }

  Widget _buildRandomWordsStack(BuildContext context) {
    return GetBuilder<HomeScreenViewmodel>(builder: (ctrl) {
      if (ctrl.listRandomWords.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      Word firstWord = ctrl.listRandomWords[0];
      return Column(
        children: [
          // The Top Card
          InkWell(
            onTap: () => Get.toNamed(
              WordDetailsScreen.routeName,
              arguments: WordDetailsScreenViewmodelArgs(
                isFromLessonDetailsScreen: false,
                onlyWord: [firstWord],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.theme.cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(context.isDarkMode ? 0.3 : 0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC7841F),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 12,
                                  runSpacing: 8,
                                  children: [
                                    Text(
                                      firstWord.word,
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: context.textTheme.bodyLarge?.color ?? Colors.black87),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: context.isDarkMode ? Colors.white12 : Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        firstWord.pos,
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: context.isDarkMode ? Colors.white70 : Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: context.isDarkMode ? Colors.white12 : const Color(0xFFF3EDFD),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.volume_up_rounded, color: Color(0xFF7B61FF), size: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            firstWord.phoneticText != "" ? firstWord.phoneticText : '/.../',
                            style: const TextStyle(color: Color(0xFF7B61FF), fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            firstWord.senses.isNotEmpty ? firstWord.senses[0].definition : 'No definition available.',
                            style: TextStyle(fontSize: 14, color: context.textTheme.bodyLarge?.color ?? Colors.black87, height: 1.5),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
                          // Mock hashtags
                          Row(
                            children: [
                              Text('#family', style: TextStyle(color: context.textTheme.bodyLarge?.color ?? Colors.black87, fontWeight: FontWeight.w600, fontSize: 13)),
                              const SizedBox(width: 12),
                              Text('#relationships', style: TextStyle(color: context.textTheme.bodyLarge?.color ?? Colors.black87, fontWeight: FontWeight.w600, fontSize: 13)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          // Stacked Next Word Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            decoration: BoxDecoration(
              color: context.isDarkMode ? const Color(0xFF1E1C24).withOpacity(0.6) : Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black.withOpacity(0.02)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Unlock next word...',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: context.isDarkMode ? Colors.white38 : Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.lock_outline_rounded, color: context.isDarkMode ? Colors.white38 : Colors.black45, size: 20),
              ],
            ),
          ),
        ],
      );
    });
  }
}
