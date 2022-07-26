import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../style/colors.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
    );

void navigateToAndReplace(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
      (route) => false,
    );

void navigatePop(context) => Navigator.pop(context);

Widget textFormField({
  required TextEditingController controller,
  required Function validate,
  String? labelText,
  IconData? prefix,
  required TextInputType textInputType,
  double borderRadius = 10.0,
  String? hintText,
  String? counterText,
  String? helperText,
  String? prefixText,
  bool autoFocus = false,
  bool isPassword = false,
  bool isDense = false,
  IconData? suffix,
  Function? suffixOnTap,
  Function? onTap,
  Function? onChange,
  Function? onSubmit,
  TextDirection? textDirection,
}) {
  return TextFormField(
    keyboardType: textInputType,
    style: TextStyle(color: iconColor),
    controller: controller,
    autofocus: autoFocus,
    obscureText: isPassword,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: iconColor, width: 3.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightBackground, width: 1.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      isDense: isDense,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      counterText: counterText,
      hoverColor: HexColor('023E8A'),
      focusColor: iconColor,
      filled: true,
      prefixText: prefixText,
      prefixStyle: TextStyle(color: textColor),
      labelStyle: TextStyle(color: textColor),
      hintStyle: TextStyle(color: textColor),
      counterStyle: TextStyle(color: textColor),
      helperStyle: TextStyle(color: textColor),
      prefixIcon: Icon(prefix, color: textColor),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: () {
                suffixOnTap!();
              },
              icon: Icon(suffix),
            )
          : null,
      suffixIconColor: iconColor,
    ),
    textDirection: textDirection,
    validator: (value) {
      return validate(value);
    },
    onTap: () {
      // ignore: void_checks
      onTap!();
    },
    onChanged: (String value) {
      onChange!(value);
    },
    onFieldSubmitted: (value) {
      onSubmit!(value);
    },
  );
}

Widget separatorHorizontal({
  double height = 2.0,
  double opacity = 1.0,
  double padding = 10.0,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: padding),
    child: Container(
      height: height,
      color: separatorColor.withOpacity(opacity),
    ),
  );
}

Widget separatorVertical() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: 0.5,
      color: separatorColor,
    ),
  );
}

Widget circularProgressIndicator() {
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: darkBackground,
    color: lightBackground,
  ));
}

Widget decorationPageRouteButton(
  context, {
  Widget? pageRoute,
  Color? color,
  required String text,
}) {
  return InkWell(
    onTap: () {
      navigateTo(context, pageRoute);
    },
    child: Center(
      child: Container(
        height: 40.0,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: buttonColor,
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              gradientColor1,
              gradientColor2,
            ],
          ),
        ),
        child: Text(text, style: Theme.of(context).textTheme.bodyText1),
      ),
    ),
  );
}

Widget decorationButton(
  context, {
  Function? onTap,
  Color? color,
  double borderRadius = 15.0,
  required String text,
}) {
  return InkWell(
    onTap: () {
      onTap!();
    },
    child: Center(
      child: Container(
        height: 40.0,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonColor,
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              lightBackground,
              iconColor,
            ],
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            color: HexColor('004C99'),
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
          ),
        ),
      ),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack(
  context, {
  required String content,
  Color? bgColor = Colors.green,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: const TextStyle(
        fontFamily: 'RobotoCondensed',
        color: Colors.white,
        fontSize: 12.0,
      ),
      textAlign: TextAlign.center,
    ),
    duration: const Duration(milliseconds: 4000),
    padding: const EdgeInsets.all(8),
    backgroundColor: bgColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    behavior: SnackBarBehavior.fixed,
  ));
}

Widget stackText(context, {required String text}) {
  return Text(
    text.capitalize!,
    style: Theme.of(context).textTheme.overline,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
  );
}

Widget alertMessage(
  context, {
  required String data,
  Function? onPressed,
  String? buttonText,
}) {
  return Container(
    height: 50.0,
    width: double.infinity,
    color: HexColor('66B2FF').withOpacity(0.6),
    child: Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Icon(Icons.info_outline_rounded, color: darkBackground),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                data,
                style: TextStyle(
                  color: darkBackground,
                  fontSize: 14.0,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10.0),
            TextButton(
              onPressed: () {
                onPressed!();
              },
              child: Text(buttonText!, style: TextStyle(color: darkBackground)),
            )
          ],
        ),
      ),
    ),
  );
}

Widget loadingAnimation(context,{
  String text = 'Loading, Please Wait ...',
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoadingAnimationWidget.flickr(
          leftDotColor: const Color(0xFF66B2FF),
          rightDotColor: const Color(0xFF004C99),
          size: 50,
        ),
        const SizedBox(height: 10.0),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    ),
  );
}
