import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goldenoil/Controlare/controler_page.dart';
import 'package:goldenoil/WidgetsA/themw.dart';


class SettingsPage2 extends StatefulWidget {
  const SettingsPage2({Key? key}) : super(key: key);

  @override
  State<SettingsPage2> createState() => _SettingsPage2State();
}

class _SettingsPage2State extends State<SettingsPage2> {
  @override
  void initState() {

    super.initState();
  }

  ControlerPage controlerPage = Get.put(ControlerPage());
  String? language='english';

  void gate(){
    if (Get.isDarkMode) {
      Get.changeTheme(Thems.customlightThem);
    } else {
      Get.changeTheme(Thems.customDarkThem);
    }
       controlerPage.updateDarkMode(!controlerPage.isDarkMode.value);

  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Theme(
        data: controlerPage.isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
    child: Scaffold(

        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _SingleSection(
                  title: 'General',
                  children: [


              _CustomListTile(
              title: 'Dark Mode',
              icon: Icons.dark_mode_outlined,
              trailing: Obx(() => Switch(
                value: controlerPage.isDarkMode.value,
                onChanged: (value) => gate(),
              )),
            ),
                  ],
                ),
                const Divider(),
                _SingleSection(
                  children: [
                    InkWell(
                      onTap: (){


                      },
                      child: _CustomListTile(
                          title: 'About', icon: Icons.info_outline_rounded),
                    ),
                    InkWell(
                      onTap: (){},
                      child: _CustomListTile(
                          title: 'Sign out', icon: Icons.exit_to_app_rounded),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;

  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ControlerPage>(
      builder: (controller) => ListTile(
        title: Text(title),
        leading: Icon(icon),
        trailing: Switch(
          value: controller.isDarkMode.value,
          onChanged: (value) => controller.updateDarkMode(value),
        ),
      ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}