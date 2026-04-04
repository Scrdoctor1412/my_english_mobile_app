import 'package:englens/src/core/utils/helper.dart';
import 'package:englens/src/ui/screens/settings/settings_screen_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsScreenViewmodel> {
  static const routeName = '/settingsScreen';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsScreenViewmodel>(
      builder: (controller) {
        controller.context = context;

        return Scaffold(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeaderRow(context),
                  const SizedBox(height: 32),
                  _buildLogoSection(context),
                  const SizedBox(height: 40),
                  _buildSectionTitle('ACCOUNT & INTERFACE', context),
                  const SizedBox(height: 16),
                  _buildAccountInterfaceGroup(controller, context),
                  const SizedBox(height: 32),
                  _buildSectionTitle('SUPPORT', context),
                  const SizedBox(height: 16),
                  _buildSupportGroup(context),
                  const SizedBox(height: 48),
                  _buildLogoutButton(context, controller),
                  const SizedBox(height: 48),
                  _buildFooterQuote(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            // Can be disabled if it's the root tab, but kept for visual fidelity
            // with the mockup if needed.
          },
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF7B61FF)),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 12),
        Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: context.textTheme.titleLarge?.color ?? const Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSection(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: const Color(0xFF7B61FF), // deep purple
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7B61FF).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.camera,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'ENGLENS',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: context.textTheme.titleLarge?.color ?? const Color(0xFF222222),
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'ENGLISH WITH CAMERAS',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: context.isDarkMode ? Colors.white60 : Colors.black45,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: context.isDarkMode ? Colors.white60 : Colors.black45,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildAccountInterfaceGroup(SettingsScreenViewmodel controller, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode ? Colors.transparent : Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          _buildSwitchRow(
            icon: Icons.dark_mode_rounded,
            title: 'Dark Mode',
            value: controller.darkModeSwitchValue,
            onChanged: (val) => controller.onTapToggleDarkMode(),
            context: context,
          ),
          Divider(color: context.isDarkMode ? Colors.white12 : Colors.black.withOpacity(0.05), height: 1),
          _buildSwitchRow(
            icon: Icons.notifications_rounded,
            title: 'Notification',
            value: controller.notificationSwitchValue ?? true,
            onChanged: (val) => controller.onTapToggleNotification(),
            context: context,
          ),
          Divider(color: context.isDarkMode ? Colors.white12 : Colors.black.withOpacity(0.05), height: 1),
          _buildActionRow(
            icon: Icons.translate_rounded,
            title: 'Language',
            trailing: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? Colors.black26 : const Color(0xFFEBE3FF), // Light purple
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'vi/en',
                    style: TextStyle(
                      color: Color(0xFF7B61FF),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right_rounded, color: context.isDarkMode ? Colors.white60 : Colors.black45, size: 20),
              ],
            ),
            onTap: () => controller.onTapToggleLanguage(),
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportGroup(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode ? Colors.transparent : Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          _buildActionRow(
            icon: Icons.help_center_rounded,
            title: 'Help Center',
            isSquareIcon: true,
            trailing: Icon(Icons.chevron_right_rounded, color: context.isDarkMode ? Colors.white60 : Colors.black45, size: 20),
            onTap: () {},
            context: context,
          ),
          Divider(color: context.isDarkMode ? Colors.white12 : Colors.black.withOpacity(0.05), height: 1),
          _buildActionRow(
            icon: Icons.description_rounded,
            title: 'Terms of Service',
            isSquareIcon: true,
            trailing: Icon(Icons.chevron_right_rounded, color: context.isDarkMode ? Colors.white60 : Colors.black45, size: 20),
            onTap: () {},
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow({
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.isDarkMode ? Colors.white12 : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF7B61FF), size: 20),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: context.textTheme.bodyLarge?.color ?? const Color(0xFF333333),
            ),
          ),
          const Spacer(),
          CupertinoSwitch(
            value: value,
            activeColor: const Color(0xFF7B61FF),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow({
    required IconData icon,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
    required BuildContext context,
    bool isSquareIcon = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSquareIcon ? const Color(0xFF7B61FF) : (context.isDarkMode ? Colors.white12 : Colors.white),
                borderRadius: isSquareIcon ? BorderRadius.circular(8) : BorderRadius.circular(20), // circles vs rounded squares
              ),
              child: Icon(
                icon,
                color: isSquareIcon ? Colors.white : const Color(0xFF7B61FF),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: context.textTheme.bodyLarge?.color ?? const Color(0xFF333333),
              ),
            ),
            const Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, SettingsScreenViewmodel controller) {
    return InkWell(
      onTap: () {
        showCustomAlertDialog(
          context: context,
          title: 'Alert',
          content: 'Are you sure you want to logout?',
          onAccept: () {
            controller.signout();
            Navigator.of(context).pop();
          },
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: context.isDarkMode ? context.theme.cardColor : const Color(0xFFFCFAFF), // Very soft background
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.logout_rounded, color: Color(0xFFE53935), size: 20),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(
                color: Color(0xFFE53935),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterQuote(BuildContext context) {
    return Column(
      children: [
        Text(
          '"Learning another language is like',
          style: TextStyle(
            fontSize: 11,
            color: context.isDarkMode ? Colors.white60 : Colors.black45,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'becoming another person."',
          style: TextStyle(
            fontSize: 11,
            color: context.isDarkMode ? Colors.white60 : Colors.black45,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
