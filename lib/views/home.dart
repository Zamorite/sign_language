import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slc/utils/assets.dart';
import 'package:slc/utils/colors.dart';
import 'package:slc/utils/rrect.shape.dart';
import 'package:slc/utils/textstyles.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KeyboardVisibilityBuilder(
              builder: (context, _visible) {
                return Expanded(
                  flex: _visible ? 2 : 2,
                  child: Container(
                    color: SLCColors.black,
                    height: double.infinity,
                    child: SafeArea(
                      bottom: false,
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.yellow,
                            child: SvgPicture.asset(
                              kBg,
                              fit: BoxFit.cover,
                            ),
                          ),
                          KeyboardVisibilityBuilder(
                            builder: (context, _visible) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          kIdleSign,
                                          height: ((_visible ? .1 : .2) *
                                              _size.height),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: .05 * _size.height,
                                          ),
                                          child: const Text(
                                            'O',
                                            style: SLCTextStyles.display,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: _visible ? 0 : (.1 * _size.height),
                                    color: SLCColors.black,
                                    child: Offstage(
                                      offstage: _visible,
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          thumbShape:
                                              const RoundRectSliderThumbShape(),
                                        ),
                                        child: Slider(
                                          activeColor: SLCColors.white,
                                          thumbColor: SLCColors.white,
                                          inactiveColor: SLCColors.black,
                                          value: .5,
                                          onChanged: (v) {},
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Flexible(
              child: Container(
                color: SLCColors.white,
                height: double.infinity,
                child: Stack(
                  children: [
                    // tabs and stuff
                    KeyboardVisibilityBuilder(
                      builder: (context, _visible) {
                        // todo: if visible show use stuff below (with margin and chips)
                        // todo: else, show tabbed view s without margin
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsetsDirectional.only(
                            top: .05 * _size.height,
                          ),
                          child: const Text('data'),
                        );
                      },
                    ),
                    // text field
                    KeyboardVisibilityBuilder(
                      builder: (context, _visible) {
                        return Offstage(
                          // offstage: false,
                          offstage: !_visible,
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              -(.05 * _size.height),
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: .1 * _size.width,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: .05 * _size.width,
                              ),
                              decoration: BoxDecoration(
                                color: SLCColors.lightBlue,
                                borderRadius: BorderRadius.circular(9),
                                // boxShadow: const [
                                //   BoxShadow(
                                //     blurRadius: 10,
                                //     spreadRadius: -10,
                                //   ),
                                // ],
                              ),
                              height: .1 * _size.height,
                              child: Container(
                                // color: Colors.red,
                                child: Center(
                                  child: TextField(
                                    focusNode: _node,
                                    style: SLCTextStyles.input,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    cursorColor: SLCColors.blue,
                                    onSubmitted: (v) {
                                      FocusScope.of(context).unfocus();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: KeyboardVisibilityBuilder(
          builder: (context, _visible) {
            return _visible
                ? const Offstage()
                : FloatingActionButton(
                    onPressed: () {
                      _node.requestFocus();
                    },
                    child: const Icon(
                      Icons.keyboard_alt_outlined,
                      color: SLCColors.white,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
