import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const greyTextColor = Color(0xFF8A8A8E);
  static const cardLighBluecolor = Color(0xFFECF9FC);
  static const secondaryBlueColor = Color(0xFF33C5FD);
  static const primaryBlueColor = Color(0xFF0091FC);
  static const whiteGreyColor = Color(0xFFF9F9F9);
  static const primaryColor = Color(0xFF830404);
  static const secondaryColor = Color(0xFFD30C0C);
  static const thirdlyColor = Color(0xFFE00D0D);
  static const iconsColor = Color(0xFF740303);
  static const mBackgroundColor = Color(0xFFFAFAFA);
  static const mGreyColor = Color(0xFFB4B0B0);
  static const mTitleColor = Color(0xFF333333);
  static const mSubtitleColor = Color(0xFF8E8E8E);
  static const mBorderColor = Color(0xFFE8E8F3);
  static const mFillColor = Color(0xFFFFFFFF);
  static const mCardTitleColor = Color(0xFFE00D0D);
  static const mCardSubtitleColor = mTitleColor;
  static const defaultPadding = 16.0;
  static final homeTitleStyle =
      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 20);

  static final homeSubTitleStyle = GoogleFonts.roboto(
      fontWeight: FontWeight.w500, fontSize: 15, color: greyTextColor);

  static final appointmentDetailTextStyle =
      GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 18);

  static final appBarTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black);
  static final greyTextInfoStyle = GoogleFonts.nunito(
      fontWeight: FontWeight.w500, fontSize: 14, color: greyTextColor);
}
