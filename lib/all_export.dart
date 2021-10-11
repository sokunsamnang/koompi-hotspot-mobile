/* -------------This file is hold all Packages, Path of file -------------*/

/* flutter Strandard Library */
export 'dart:async';
export 'package:flutter/material.dart';
export 'dart:convert';
export 'package:flutter/services.dart';
export 'dart:io';
export 'dart:io' show Platform;
export 'package:flutter/foundation.dart';
export 'package:flutter/rendering.dart';
export 'package:flutter/gestures.dart';


/*Flutter Package*/

// Groovin
export 'package:groovin_widgets/groovin_widgets.dart';

// Navigator 
export 'package:page_transition/page_transition.dart';

// Responsive
export 'package:flutter_screenutil/flutter_screenutil.dart';

// Storage
export 'package:shared_preferences/shared_preferences.dart';

// Http
export 'package:http_parser/http_parser.dart';

// Connection and Wi-Fi
export 'package:connectivity/connectivity.dart';
export 'package:koompi_hotspot/core/services/connection.dart';


// Widget
export 'package:pin_code_fields/pin_code_fields.dart';
export 'package:flutter_form_builder/flutter_form_builder.dart';
export 'package:flutter_material_pickers/helpers/show_scroll_picker.dart';
export 'package:google_nav_bar/google_nav_bar.dart';
export 'package:intl_phone_number_input/intl_phone_number_input.dart';

// Image and File
export 'package:flutter_svg/flutter_svg.dart';
export 'package:flutter_image_compress/flutter_image_compress.dart';
export 'package:multi_image_picker2/multi_image_picker2.dart';

// Animation
export 'package:flare_flutter/flare_actor.dart';

// QR
export 'package:qr_code_scanner/qr_code_scanner.dart';
export 'package:qr_flutter/qr_flutter.dart';

// Share to other platform
export 'package:share/share.dart';

// Map
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:flutter_map/flutter_map.dart';

// App Setting
export 'package:app_settings/app_settings.dart';

// Icons and Font
export 'package:google_fonts/google_fonts.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:line_icons/line_icons.dart';

/* Local File */

// App unit
export 'package:koompi_hotspot/ui/utils/app_localization.dart';
export 'package:koompi_hotspot/ui/app.dart';
export 'package:koompi_hotspot/ui/utils/app_utils.dart';
export 'package:koompi_hotspot/ui/utils/app_localization.dart';

/* Core */
// Model
export 'package:koompi_hotspot/core/models/model_balance.dart';
export 'package:koompi_hotspot/core/models/model_userdata.dart';
export 'package:koompi_hotspot/core/models/model_wallet.dart';
export 'package:koompi_hotspot/core/models/model_location.dart';
export 'package:koompi_hotspot/core/models/model_get_plan.dart';
export 'package:koompi_hotspot/core/models/model_trx_history.dart';
export 'package:koompi_hotspot/core/models/model_change_password.dart';

// Request POST & GET
export 'package:koompi_hotspot/core/backend/post_request.dart';
export 'package:koompi_hotspot/core/backend/get_request.dart';

// Service
export 'package:koompi_hotspot/core/services/services.dart';
export 'package:koompi_hotspot/core/services/updater.dart';

// Component
export 'package:koompi_hotspot/core/backend/component.dart';
export 'package:koompi_hotspot/core/backend/api_service.dart';



/* Screen UI */
// Form Card Widget
export 'package:koompi_hotspot/ui/components/formcard/formcardNewPassword.dart';
export 'package:koompi_hotspot/ui/components/formcard/formcardCreatePhoneNumber.dart';
export 'package:koompi_hotspot/ui/components/formcard/formcardForgotPassword.dart';
export 'package:koompi_hotspot/ui/components/formcard/formcardLoginPhone.dart';

// Login Page
export 'package:koompi_hotspot/ui/screen/login/login_phone.dart';

// Create Account Page
export 'package:koompi_hotspot/ui/screen/create_phone/create_phone.dart';
export 'package:koompi_hotspot/ui/screen/create_phone/create_phone_body.dart';

// Verification Page
export 'package:koompi_hotspot/ui/screen/verfication/phone_verfication_account.dart';
export 'package:koompi_hotspot/ui/screen/verfication/forgot_password_verification.dart';

// Forgot Password Page
export 'package:koompi_hotspot/ui/screen/forget_password/forgot_password.dart';
export 'package:koompi_hotspot/ui/screen/forget_password/forgot_password_body.dart';

// Home Page
export 'package:koompi_hotspot/ui/screen/home/home_page.dart';
export 'package:koompi_hotspot/ui/screen/option_page/more_page.dart';
export 'package:koompi_hotspot/ui/screen/home/home_page_body.dart';

// Map Page
export 'package:koompi_hotspot/ui/screen/map/MyLocationView.dart';

// Speed Test Page
export 'package:koompi_hotspot/ui/screen/speedtest/speedtest.dart';

// Reset Password Page
export 'package:koompi_hotspot/ui/screen/reset_new_password/reset_password.dart';
export 'package:koompi_hotspot/ui/screen/reset_new_password/reset_password_body.dart';

// Info Page
export 'package:koompi_hotspot/ui/screen/complete_info/complete_info.dart';

// Plan Hotspot Page
export 'package:koompi_hotspot/ui/screen/hotspot_plan/buy_plan.dart';
export 'package:koompi_hotspot/ui/screen/hotspot_plan/buy_plan_complete.dart';
export 'package:koompi_hotspot/ui/screen/hotspot_plan/view_plan.dart';
export 'package:koompi_hotspot/ui/screen/hotspot_plan/choose_option.dart';
export 'package:koompi_hotspot/ui/screen/hotspot_plan/change_plan.dart';
export 'package:koompi_hotspot/ui/screen/hotspot_plan/renew_option.dart';

// Wallet Page
export 'package:koompi_hotspot/ui/screen/mywallet/wallet_choice.dart';
export 'package:koompi_hotspot/ui/screen/mywallet/history_transaction.dart';
export 'package:koompi_hotspot/ui/screen/mywallet/receive_request.dart';
export 'package:koompi_hotspot/ui/screen/mywallet/send_request.dart';
export 'package:koompi_hotspot/ui/screen/mywallet/qr_scanner.dart';
export 'package:koompi_hotspot/ui/screen/mywallet/send_payment_complete.dart';
export 'package:koompi_hotspot/ui/screen/mywallet/my_wallet.dart';
export 'package:koompi_hotspot/ui/screen/mywallet/wallet_screen_body.dart';
export 'package:koompi_hotspot/ui/screen/mywallet/wallet_screen.dart';

// Account Page
export 'package:koompi_hotspot/ui/screen/option_page/myaccount.dart';


// On Boading
export 'package:koompi_hotspot/ui/screen/onboarding/styles.dart';
export 'package:koompi_hotspot/ui/screen/onboarding/onboarding_screen.dart';

// Web Page
export 'package:koompi_hotspot/ui/screen/web_view/captive_portal_web.dart';

// Promotion Page
export 'package:koompi_hotspot/ui/screen/promotion/promotion_carousel.dart';

// Change Password Page
export 'package:koompi_hotspot/ui/screen/option_page/change_password.dart';

// Component
export 'package:koompi_hotspot/ui/components/qr_widget/qr_text.dart';
export 'package:koompi_hotspot/ui/components/navbar.dart';
export 'package:koompi_hotspot/ui/components/qr_widget/qr_appbar.dart';
export 'package:koompi_hotspot/ui/components/qr_widget/qr_scaffold.dart';
export 'package:koompi_hotspot/ui/components/validator_mixin.dart';
export 'package:koompi_hotspot/ui/components/socialmedia.dart';

// Reuse Widget
export 'package:koompi_hotspot/ui/reuse_widget/reuse_widget.dart';