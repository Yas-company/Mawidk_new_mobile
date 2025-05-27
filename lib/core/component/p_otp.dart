import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

typedef OnCodeEnteredCompletion = void Function(String value);
typedef OnCodeChanged = void Function(String value);
typedef HandleControllers = void Function(List<TextEditingController?> controllers);

// ignore: must_be_immutable
class OtpTextField extends StatefulWidget {
  final bool showCursor;
  final int numberOfFields;
  final double fieldWidth;
  final double? fieldHeight;
  final double borderWidth;
  final Alignment? alignment;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color disabledBorderColor;
  final Color borderColor;
  final Color? cursorColor;
  final EdgeInsetsGeometry margin;
  final TextInputType keyboardType;
  final TextStyle? textStyle;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final OnCodeEnteredCompletion? onSubmit;
  final OnCodeEnteredCompletion? onCodeChanged;
  final HandleControllers? handleControllers;
  final bool obscureText;
  final bool showFieldAsBox;
  final bool enabled;
  final bool filled;
  final bool autoFocus;
  final bool readOnly;
  bool clearText;
  final bool hasCustomInputDecoration;
  final Color fillColor;
  final BorderRadius borderRadius;
  final InputDecoration? decoration;
  final List<TextStyle?> styles;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;

  OtpTextField({super.key,
    this.showCursor = true,
    this.numberOfFields = 4,
    this.fieldWidth = 60,
    this.fieldHeight,
    this.alignment,
    this.margin = const EdgeInsets.only(right: 8.0),
    this.textStyle,
    this.clearText = false,
    this.styles = const [],
    this.keyboardType = TextInputType.number,
    this.borderWidth = 2.0,
    this.cursorColor,
    this.disabledBorderColor = AppColors.whiteColor,
    this.enabledBorderColor = AppColors.whiteColor,
    this.borderColor = AppColors.whiteColor,
    this.focusedBorderColor = AppColors.primaryColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.handleControllers,
    this.onSubmit,
    this.obscureText = false,
    this.showFieldAsBox = false,
    this.enabled = true,
    this.autoFocus = false,
    this.hasCustomInputDecoration = false,
    this.filled = true,
    this.fillColor = AppColors.primaryColor,
    this.readOnly = false,
    this.decoration,
    this.onCodeChanged,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.inputFormatters,
    this.contentPadding,
  })  : assert(numberOfFields > 0),
        assert(styles.isNotEmpty ? styles.length == numberOfFields : styles.isEmpty);

  @override
  OtpTextFieldState createState() => OtpTextFieldState();
}

class OtpTextFieldState extends State<OtpTextField> {
  late List<String?> _verificationCode;
  late List<FocusNode?> _focusNodes;
  late List<TextEditingController?> _textControllers;
  int? _focusedIndex;

  @override
  void initState() {
    super.initState();

    _verificationCode = List<String?>.filled(widget.numberOfFields, null);
    _focusNodes = List<FocusNode?>.filled(widget.numberOfFields, null);
    _textControllers = List<TextEditingController?>.filled(
      widget.numberOfFields,
      null,
    );
  }

  @override
  void didUpdateWidget(covariant OtpTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.clearText != widget.clearText && widget.clearText == true) {
      for (var controller in _textControllers) {
        controller?.clear();
      }
      _verificationCode = List<String?>.filled(widget.numberOfFields, null);
      setState(() {
        widget.clearText = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in _textControllers) {
      controller?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _generateTextFields(context);
  }

  Widget _buildTextField({
    required BuildContext context,
    required int index,
    TextStyle? style,
  }) {
    return Expanded(
      child: Container(
        width: widget.fieldWidth,
        height: widget.fieldHeight,
        alignment: widget.alignment,
        // margin: widget.margin,
        margin: index==1||index==2?EdgeInsets.only(left:5,right:5):
        index==0?EdgeInsets.only(left:7):EdgeInsets.only(right:9),
        child: TextFormField(
          showCursor: widget.showCursor,
          keyboardType: widget.keyboardType,
          textAlign: TextAlign.center,
          maxLength: widget.numberOfFields,
          readOnly: widget.readOnly,
          style: style ?? widget.textStyle,
          autofocus: widget.autoFocus,
          cursorColor: widget.cursorColor,
          controller: _textControllers[index],
          focusNode: _focusNodes[index],
          enabled: widget.enabled,
          inputFormatters: widget.inputFormatters,
          decoration: widget.hasCustomInputDecoration
              ? widget.decoration
              : InputDecoration(
            filled:  widget.filled,
            fillColor: _focusedIndex == index ? AppColors.primaryColor100 : AppColors.whiteColor,
            counterText: "",
            focusedBorder: widget.showFieldAsBox
                ? _outlineBorder(widget.focusedBorderColor)
                : _underlineInputBorder(widget.focusedBorderColor),
            enabledBorder: widget.showFieldAsBox
                ? _outlineBorder(widget.enabledBorderColor)
                : _underlineInputBorder(widget.enabledBorderColor),
            disabledBorder: widget.showFieldAsBox
                ? _outlineBorder(widget.disabledBorderColor)
                : _underlineInputBorder(widget.disabledBorderColor),
            border: widget.showFieldAsBox
                ? _outlineBorder(widget.borderColor)
                : _underlineInputBorder(widget.borderColor),
            contentPadding: widget.contentPadding,
          ),
          obscureText: widget.obscureText,
          onChanged: (String value) {
            if (value.length <= 1) {
              _verificationCode[index] = value;
              _onDigitEntered(value, index);
            } else {
              _handlePaste(value, index);
            }
          },
        ),
      ),
    );
  }

  OutlineInputBorder _outlineBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: widget.borderWidth,
        color: color,
      ),
      borderRadius: widget.borderRadius,
    );
  }

  UnderlineInputBorder _underlineInputBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: widget.borderWidth,
      ),
    );
  }

  Widget _generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.numberOfFields, (int i) {
      _addFocusNodeToEachTextField(index: i);
      _addTextEditingControllerToEachTextField(index: i);

      if (widget.styles.isNotEmpty) {
        return _buildTextField(
          context: context,
          index: i,
          style: widget.styles[i],
        );
      }
      if (widget.handleControllers != null) {
        widget.handleControllers!(_textControllers);
      }
      return _buildTextField(context: context, index: i);
    });

    return Row(
      mainAxisAlignment: widget.mainAxisAlignment,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: textFields,
    );
  }

  void _addFocusNodeToEachTextField({required int index}) {
    if (_focusNodes[index] == null) {
      _focusNodes[index] = FocusNode();
      _focusNodes[index]!.addListener(() {
        if (_focusNodes[index]!.hasFocus) {
          setState(() {
            _focusedIndex = index;
          });
        } else {
          if (_focusedIndex == index) {
            setState(() {
              _focusedIndex = null;
            });
          }
        }
      });
    }
  }

  // void _addFocusNodeToEachTextField({required int index}) {
  //   if (_focusNodes[index] == null) {
  //     _focusNodes[index] = FocusNode();
  //   }
  // }

  void _addTextEditingControllerToEachTextField({required int index}) {
    if (_textControllers[index] == null) {
      _textControllers[index] = TextEditingController();

      _textControllers[index]!.addListener(() {
        String text = _textControllers[index]!.text;
        if (text.isEmpty) {
          // Handle backspace by moving focus to the previous field
          _changeFocusToPreviousNode(index);
        }
      });
    }
  }

  void _changeFocusToPreviousNode(int index) {
    try {
      if (index > 0 && index < widget.numberOfFields) {
        _focusNodes[index - 1]?.requestFocus();
      }
    } catch (e) {
      log('Cannot focus on the previous field');
    }
  }

  void _changeFocusToNextNodeWhenValueIsEntered({
    required String value,
    required int indexOfTextField,
  }) {
    //only change focus to the next textField if the value entered has a length greater than one
    if (value.isNotEmpty) {
      //if the textField in focus is not the last textField,
      // change focus to the next textField
      if (indexOfTextField + 1 != widget.numberOfFields) {
        //change focus to the next textField
        FocusScope.of(context).requestFocus(_focusNodes[indexOfTextField + 1]);
      } else {
        //if the textField in focus is the last textField, unFocus after text changed
        _focusNodes[indexOfTextField]?.unfocus();
      }
    }
  }

  void _onSubmit({required List<String?> verificationCode}) {
    if (verificationCode.every((String? code) => code != null && code != '')) {
      if (widget.onSubmit != null) {
        widget.onSubmit!(verificationCode.join());
      }
    }
  }

  void _onCodeChanged({required String verificationCode}) {
    if (widget.onCodeChanged != null) {
      widget.onCodeChanged!(verificationCode);
    }
  }

  _onDigitEntered(String digit, int index) {
    _onCodeChanged(verificationCode: digit);
    _changeFocusToNextNodeWhenValueIsEntered(
      value: digit,
      indexOfTextField: index,
    );
    setState(() {
      _onSubmit(verificationCode: _verificationCode);
    });
  }

  _handlePaste(String str, int index) {
    if (str.length > widget.numberOfFields) {
      str = str.substring(0, widget.numberOfFields);
    }
    int textFieldIndex = index;
    for (int i = 0; i < str.length; i++) {
      if (textFieldIndex >= widget.numberOfFields) break;
      // Extract the current character (digit)
      String digit = str.substring(i, i + 1);
      // Update the text in the corresponding text controller
      _textControllers[textFieldIndex]!.text = digit;
      // Set the text value explicitly for the controller
      _textControllers[textFieldIndex]!.value = TextEditingValue(text: digit);
      // Update the verification code array with the digit
      _verificationCode[textFieldIndex] = digit;
      _onDigitEntered(digit, textFieldIndex);
      textFieldIndex += 1;
      setState(() {});
    }
  }
}