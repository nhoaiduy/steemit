import 'package:flutter/material.dart';
import 'package:steemit/util/style/base_color.dart';
import 'package:steemit/util/style/base_text_style.dart';

class TextFieldWidget {
  static Widget base(
      {required ValueChanged<String> onChanged,
      VoidCallback? onTap,
      ValueChanged<String>? onSubmit,
      String? labelText,
      String? hintText,
      String? errorText,
      String? initialValue,
      bool required = false,
      bool isObscured = false,
      bool enable = true,
      EdgeInsets? contentPadding,
      FocusNode? focusNode,
      TextEditingController? textEditingController,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool autoFocus = false,
      int? maxLength,
      int? maxLines,
      Color? fillColor,
      bool readOnly = false,
      TextStyle? textStyle,
      bool isSearch = false,
      TextAlign textAlign = TextAlign.start,
      TextAlignVertical textAlignVertical = TextAlignVertical.center,
      TextInputAction? textInputAction,
      VoidCallback? onSuffixIconTap,
      VoidCallback? onPrefixIconTap,
      IconData? prefixIconPath,
      IconData? suffixIconPath,
      TextInputType? textInputType}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if ((labelText != null))
            Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(labelText, style: BaseTextStyle.label()),
                  if (required)
                    Text(" *",
                        style: BaseTextStyle.label(color: BaseColor.red400))
                ])),
          Container(
            height: 44.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: isSearch ? fillColor : Colors.transparent),
            child: TextFormField(
                initialValue: initialValue,
                onChanged: onChanged,
                onFieldSubmitted: onSubmit,
                onTap: onTap,
                enabled: enable,
                readOnly: readOnly,
                obscureText: isObscured,
                cursorColor: BaseColor.green600,
                cursorWidth: 2,
                cursorHeight: 20,
                enableInteractiveSelection: false,
                cursorRadius: const Radius.circular(2),
                showCursor: enable,
                style: enable
                    ? textStyle ?? BaseTextStyle.body1(color: BaseColor.grey900)
                    : BaseTextStyle.body1(color: BaseColor.grey300),
                focusNode: focusNode,
                controller: textEditingController,
                autofocus: autoFocus,
                textAlign: textAlign,
                textCapitalization: textCapitalization,
                textAlignVertical: textAlignVertical,
                textInputAction: textInputAction,
                maxLength: maxLength,
                maxLines: maxLines,
                keyboardType: textInputType,
                decoration: InputDecoration(
                  prefixIcon: prefixIconPath != null
                      ? IconButton(
                          onPressed: onPrefixIconTap != null
                              ? () => onPrefixIconTap()
                              : () {},
                          icon: Icon(prefixIconPath,
                              color: isSearch
                                  ? BaseColor.grey600
                                  : BaseColor.grey60))
                      : null,
                  suffixIcon: suffixIconPath != null
                      ? IconButton(
                          onPressed: onSuffixIconTap != null
                              ? () => onSuffixIconTap()
                              : () {},
                          icon: Icon(suffixIconPath,
                              color: isSearch
                                  ? BaseColor.grey600
                                  : BaseColor.grey60))
                      : null,
                  hintText: hintText,
                  fillColor: isSearch
                      ? Colors.transparent
                      : fillColor ??
                          (enable ? Colors.white : BaseColor.grey300),
                  filled: true,
                  contentPadding: contentPadding ??
                      EdgeInsets.only(
                          top: 12.0,
                          bottom: 12.0,
                          left: prefixIconPath != null ? 0 : 12,
                          right: suffixIconPath != null ? 0 : 12),
                  hintStyle: BaseTextStyle.body1(
                      color: isSearch ? BaseColor.grey600 : BaseColor.grey300),
                  enabledBorder: isSearch
                      ? InputBorder.none
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: errorText != null
                                ? BaseColor.red400
                                : BaseColor.grey60,
                            width: 0.8,
                          )),
                  disabledBorder: isSearch
                      ? InputBorder.none
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: BaseColor.grey300, width: 0.8)),
                  focusedBorder: isSearch
                      ? InputBorder.none
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: errorText != null
                              ? const BorderSide(
                                  color: BaseColor.red500, width: 0.8)
                              : const BorderSide(
                                  color: BaseColor.green300, width: 0.8)),
                )),
          ),
          if (errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(errorText,
                  style: BaseTextStyle.body2(
                      color: enable ? BaseColor.red500 : BaseColor.grey500)),
            )
        ]);
  }

  static Widget common(
      {required ValueChanged<String> onChanged,
      VoidCallback? onTap,
      ValueChanged<String>? onSubmit,
      String? labelText,
      String? hintText,
      String? errorText,
      String? initialValue,
      bool required = false,
      bool enable = true,
      FocusNode? focusNode,
      TextEditingController? textEditingController,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool isObscured = false,
      bool autoFocus = false,
      int? maxLines,
      bool readOnly = false,
      TextInputAction? textInputAction,
      VoidCallback? onSuffixIconTap,
      VoidCallback? onPrefixIconTap,
      IconData? prefixIconPath,
      IconData? suffixIconPath,
      TextInputType? textInputType}) {
    return TextFieldWidget.base(
        onChanged: onChanged,
        labelText: labelText,
        onSubmit: onSubmit,
        onTap: onTap,
        hintText: hintText,
        errorText: errorText.toString().isNotEmpty ? errorText : null,
        initialValue: initialValue,
        required: required,
        enable: enable,
        isObscured: isObscured,
        focusNode: focusNode,
        textEditingController: textEditingController,
        textCapitalization: textCapitalization,
        autoFocus: autoFocus,
        maxLines: maxLines,
        readOnly: readOnly,
        textInputAction: textInputAction,
        onPrefixIconTap: onPrefixIconTap,
        onSuffixIconTap: onSuffixIconTap,
        prefixIconPath: prefixIconPath,
        suffixIconPath: suffixIconPath,
        textInputType: textInputType);
  }

  static Widget search(
      {required ValueChanged<String> onChanged,
      VoidCallback? onTap,
      ValueChanged<String>? onSubmit,
      String? labelText,
      String? errorText,
      String? initialValue,
      bool required = false,
      bool enable = true,
      FocusNode? focusNode,
      TextEditingController? textEditingController,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool isObscured = false,
      bool autoFocus = false,
      int? maxLines,
      bool readOnly = false,
      TextInputAction? textInputAction,
      VoidCallback? onSuffixIconTap,
      VoidCallback? onPrefixIconTap,
      IconData? suffixIconPath,
      TextInputType? textInputType,
      Color? fillColor}) {
    return TextFieldWidget.base(
        onChanged: onChanged,
        onTap: onTap,
        onSubmit: onSubmit,
        labelText: labelText,
        hintText: "Search",
        errorText: errorText,
        initialValue: initialValue,
        required: required,
        enable: enable,
        isObscured: isObscured,
        focusNode: focusNode,
        textEditingController: textEditingController,
        textCapitalization: textCapitalization,
        autoFocus: autoFocus,
        maxLines: maxLines,
        readOnly: readOnly,
        isSearch: true,
        textInputAction: textInputAction,
        onPrefixIconTap: onPrefixIconTap,
        onSuffixIconTap: onSuffixIconTap,
        prefixIconPath: Icons.search_outlined,
        fillColor: fillColor ?? Colors.white,
        textInputType: textInputType);
  }

  static Widget searchWhite(
      {required ValueChanged<String> onChanged,
      VoidCallback? onTap,
      ValueChanged<String>? onSubmit,
      String? labelText,
      String? errorText,
      String? initialValue,
      bool required = false,
      bool enable = true,
      FocusNode? focusNode,
      TextEditingController? textEditingController,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool isObscured = false,
      bool autoFocus = false,
      int? maxLines,
      bool readOnly = false,
      TextInputAction? textInputAction,
      VoidCallback? onSuffixIconTap,
      VoidCallback? onPrefixIconTap,
      String? suffixIconPath,
      TextInputType? textInputType}) {
    return TextFieldWidget.search(
        onChanged: onChanged,
        onTap: onTap,
        onSubmit: onSubmit,
        labelText: labelText,
        errorText: errorText,
        initialValue: initialValue,
        required: required,
        enable: enable,
        isObscured: isObscured,
        focusNode: focusNode,
        textEditingController: textEditingController,
        textCapitalization: textCapitalization,
        autoFocus: autoFocus,
        maxLines: maxLines,
        readOnly: readOnly,
        fillColor: Colors.white,
        textInputAction: textInputAction,
        onPrefixIconTap: onPrefixIconTap,
        onSuffixIconTap: onSuffixIconTap,
        textInputType: textInputType);
  }

  static Widget searchGrey(
      {required ValueChanged<String> onChanged,
      VoidCallback? onTap,
      ValueChanged<String>? onSubmit,
      String? labelText,
      String? errorText,
      String? initialValue,
      bool required = false,
      bool enable = true,
      FocusNode? focusNode,
      TextEditingController? textEditingController,
      TextCapitalization textCapitalization = TextCapitalization.none,
      bool isObscured = false,
      bool autoFocus = false,
      int? maxLines,
      bool readOnly = false,
      TextInputAction? textInputAction,
      VoidCallback? onSuffixIconTap,
      VoidCallback? onPrefixIconTap,
      TextInputType? textInputType}) {
    return TextFieldWidget.search(
        onChanged: onChanged,
        onSubmit: onSubmit,
        onTap: onTap,
        labelText: labelText,
        errorText: errorText,
        initialValue: initialValue,
        required: required,
        enable: enable,
        isObscured: isObscured,
        focusNode: focusNode,
        textEditingController: textEditingController,
        textCapitalization: textCapitalization,
        autoFocus: autoFocus,
        maxLines: maxLines,
        readOnly: readOnly,
        textInputAction: textInputAction,
        onPrefixIconTap: onPrefixIconTap,
        onSuffixIconTap: onSuffixIconTap,
        fillColor: BaseColor.grey40,
        textInputType: textInputType);
  }
}
