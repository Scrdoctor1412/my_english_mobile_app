
import 'package:englens/src/ui/screens/tabs/tabs_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsScreen extends GetView<TabsScreenViewmodel> {
  static const routeName = '/tabsScreen';
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    _buildNavItem(int index, IconData icon, String label) {
      return Obx(() {
        bool isSelected = controller.tabIndex.value == index;
        Color color = isSelected ? const Color(0xFF7B61FF) : (context.isDarkMode ? Colors.white54 : Colors.black38);
        return InkWell(
          onTap: () => controller.onTapChangeScreen(index),
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      });
    }

    _bottomNavigationBar() {
      return Container(
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(0, Icons.home_rounded, 'Home'),
                _buildNavItem(1, Icons.collections_bookmark_rounded, 'Library'),
                _buildNavItem(2, Icons.menu_book_rounded, 'Handbook'),
                _buildNavItem(3, Icons.person_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      );
    }

    _body() {
      // return Obx(() => controller.tabsScreen[controller.tabIndex.value]);
      return Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: controller.tabsScreen,
        ),
      );
    }

    return Scaffold(body: _body(), bottomNavigationBar: _bottomNavigationBar());
  }
}
