import 'package:attendease/core/app_colors.dart';
import 'package:attendease/core/app_string.dart';
import 'package:attendease/core/app_text.dart';
import 'package:attendease/core/widgets/title_item.dart';
import 'package:attendease/models/filters.dart';
import 'package:attendease/providers/filter_provider.dart';
import 'package:attendease/screens/records_screen_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetScreen extends ConsumerStatefulWidget {
  final bool isRecordScreen1;
  const BottomSheetScreen({super.key, required this.isRecordScreen1});
  @override
  ConsumerState<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends ConsumerState<BottomSheetScreen> {
  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: AppColors.bg100,
      ),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  width: 140,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppColors.text100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: TitleItem(title: 'Select Branch'),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 11,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 21),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.bg200,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Text(
                  'For Theory',
                  style: MyAppTypography.body2,
                ),
              ),
              SizedBox(
                height: 100,
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 41),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 14,
                    crossAxisCount: 3,
                    crossAxisSpacing: 50,
                    mainAxisExtent: 31,
                    childAspectRatio: 2.0645,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(filterProvider.notifier).update(
                              (state) => Filters(
                                  semester: state.semester,
                                  section: state.section,
                                  branch: branchMap[branches[index]],
                                  type: 'Theory'),
                            );
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Item(text: branches[index]),
                    );
                  },
                  itemCount: branches.length,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 21),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.bg200,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Text(
                  'For Practical',
                  style: MyAppTypography.body2,
                ),
              ),
              SizedBox(
                height: 100,
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 41),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 14,
                    crossAxisCount: 3,
                    crossAxisSpacing: 50,
                    mainAxisExtent: 31,
                    childAspectRatio: 2.0645,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(filterProvider.notifier).update(
                              (state) => Filters(
                                  semester: state.semester,
                                  section: state.section,
                                  branch: branchMap[branches[index]],
                                  type: 'Practical'),
                            );
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Item(text: branches[index]),
                    );
                  },
                  itemCount: branches.length,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  width: 140,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppColors.text100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 21),
                child: TitleItem(title: 'Select Section'),
              ),
              SizedBox(
                height: 100,
                child: GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 41),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 14,
                    crossAxisCount: 3,
                    crossAxisSpacing: 50,
                    mainAxisExtent: 31,
                    childAspectRatio: 2.0645,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(filterProvider.notifier).update(
                              (state) => Filters(
                                  semester: state.semester,
                                  section: sections[index],
                                  branch: state.branch,
                                  type: state.type),
                            );
                        if (widget.isRecordScreen1) {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RecordsScreen2(),
                            ),
                          );
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Item(text: sections[index]),
                    );
                  },
                  itemCount: sections.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String text;
  const Item({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.5),
        border: Border.all(width: 2, color: AppColors.text100),
        color: AppColors.bg100,
      ),
      child: Text(
        text,
        style: MyAppTypography.body1,
      ),
    );
  }
}
