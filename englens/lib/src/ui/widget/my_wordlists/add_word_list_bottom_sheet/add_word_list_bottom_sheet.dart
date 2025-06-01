import 'package:englens/src/theme/theme_primary.dart';
import 'package:englens/src/ui/widget/my_wordlists/add_word_list_bottom_sheet/add_word_list_bottom_sheet_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class AddWordListBottomSheet extends StatelessWidget {
  const AddWordListBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddWordListBottomSheetViewmodel>(
      init: AddWordListBottomSheetViewmodel(),
      builder: (controller) {
        controller.context = context;
        Widget _emptyWidget() {
          // return
          return Container(
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                // color: Colors.white,
                ),
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/images/empty_data.png'),
                ),
                Text(
                  'You haven\'t add any word list yet!',
                  style: TextStyle(
                    color: ThemePrimary.grey.withAlpha(150),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              AppBar(
                title: Text(
                  'Choose your Word List',
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        controller.onTapAddWordList();
                      },
                      icon: Icon(Icons.add)),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
              ),
              const SizedBox(height: 20),
              controller.isLoading
                  ? CircularProgressIndicator()
                  : controller.wordLists.isEmpty
                      ? _emptyWidget()
                      : Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pop(controller.wordLists[index].id);
                                },
                                child: SizedBox(
                                  height: 50,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.folder,
                                        color: ThemePrimary.grey,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        controller.wordLists[index].name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              color: ThemePrimary.grey.withAlpha(80),
                              height: 20,
                            ),
                            itemCount: controller.wordLists.length,
                          ),
                        ),
            ],
          ),
        );
      },
    );
  }
}
