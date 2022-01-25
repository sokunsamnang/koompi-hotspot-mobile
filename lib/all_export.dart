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
export 'dart:convert';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:date_format/date_format.dart';
export 'package:provider/provider.dart';

/*Flutter Package*/
export 'package:koompi_hotspot/utils/data_connectiviy_service.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:package_info/package_info.dart';
export 'package:firebase_remote_config/firebase_remote_config.dart';
export 'package:flutter_launcher_icons/custom_exceptions.dart';
export 'package:flutter_absolute_path/flutter_absolute_path.dart';
export 'package:badges/badges.dart';
export 'package:linkable/linkable.dart';
export 'package:responsive_framework/responsive_framework.dart';
export 'package:quick_actions/quick_actions.dart';

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
export 'package:koompi_hotspot/utils/connection.dart';
export 'package:data_connection_checker/data_connection_checker.dart';

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
export 'package:koompi_hotspot/utils/app_localization.dart';
export 'package:koompi_hotspot/app.dart';
export 'package:koompi_hotspot/utils/app_utils.dart';
export 'package:koompi_hotspot/utils/app_localization.dart';
export 'package:koompi_hotspot/utils/jtw_decoder.dart';

/* Core */
// Model
export 'package:koompi_hotspot/models/balance_model.dart';
export 'package:koompi_hotspot/models/userdata_model.dart';
export 'package:koompi_hotspot/models/location_model.dart';
export 'package:koompi_hotspot/models/get_plan_model.dart';
export 'package:koompi_hotspot/models/trx_history_model.dart';
export 'package:koompi_hotspot/models/change_password_model.dart';
export 'package:koompi_hotspot/models/notification_model.dart';
export 'package:koompi_hotspot/models/vote_result_model.dart';

// Request POST & GET
export 'package:koompi_hotspot/services/post_request.dart';
export 'package:koompi_hotspot/services/get_request.dart';

// Service
export 'package:koompi_hotspot/utils/services.dart';
export 'package:koompi_hotspot/utils/updater.dart';

// Component
export 'package:koompi_hotspot/services/component.dart';
export 'package:koompi_hotspot/services/api_service.dart';

/* Screen UI */
// Form Card Widget
export 'package:koompi_hotspot/widgets/components/formcard/formcardNewPassword.dart';
export 'package:koompi_hotspot/widgets/components/formcard/formcardCreatePhoneNumber.dart';
export 'package:koompi_hotspot/widgets/components/formcard/formcardForgotPassword.dart';
export 'package:koompi_hotspot/widgets/components/formcard/formcardLoginPhone.dart';

// Login Page
export 'package:koompi_hotspot/screens/login/login_phone.dart';

// Create Account Page
export 'package:koompi_hotspot/screens/create_phone/create_phone.dart';
export 'package:koompi_hotspot/screens/create_phone/create_phone_body.dart';

// Verification Page
export 'package:koompi_hotspot/screens/verfication/phone_verfication_account.dart';
export 'package:koompi_hotspot/screens/verfication/forgot_password_verification.dart';

// Forgot Password Page
export 'package:koompi_hotspot/screens/forget_password/forgot_password.dart';
export 'package:koompi_hotspot/screens/forget_password/forgot_password_body.dart';

// Home Page
export 'package:koompi_hotspot/screens/home/home_page.dart';
export 'package:koompi_hotspot/screens/option_page/more_page.dart';
export 'package:koompi_hotspot/screens/home/home_page_body.dart';

// Map Page
export 'package:koompi_hotspot/screens/map/location_view.dart';

// Speed Test Page
export 'package:koompi_hotspot/screens/speedtest/speedtest.dart';

// Reset Password Page
export 'package:koompi_hotspot/screens/reset_new_password/reset_password.dart';
export 'package:koompi_hotspot/screens/reset_new_password/reset_password_body.dart';

// Info Page
export 'package:koompi_hotspot/screens/complete_info/complete_info.dart';

// Plan Hotspot Page
export 'package:koompi_hotspot/screens/hotspot_plan/buy_plan.dart';
export 'package:koompi_hotspot/screens/hotspot_plan/buy_plan_complete.dart';
export 'package:koompi_hotspot/screens/hotspot_plan/view_plan.dart';
export 'package:koompi_hotspot/screens/hotspot_plan/choose_option.dart';
export 'package:koompi_hotspot/screens/hotspot_plan/change_plan.dart';
export 'package:koompi_hotspot/screens/hotspot_plan/renew_option.dart';

// Notification Page
export 'package:koompi_hotspot/screens/notification/notification.dart';
export 'package:koompi_hotspot/screens/notification/announcements/announcements_detail.dart';
export 'package:koompi_hotspot/screens/notification/announcements/announcements_list.dart';
export 'package:koompi_hotspot/screens/notification/announcements/announcements_screen.dart';
export 'package:koompi_hotspot/screens/notification/transactions/transactions.dart';
export 'package:koompi_hotspot/screens/promotion/promotion_detail.dart';

// Wallet Page
export 'package:koompi_hotspot/screens/mywallet/wallet_choice.dart';
export 'package:koompi_hotspot/screens/mywallet/history_transaction.dart';
export 'package:koompi_hotspot/screens/mywallet/receive_request.dart';
export 'package:koompi_hotspot/screens/mywallet/send_request.dart';
export 'package:koompi_hotspot/screens/mywallet/qr_scanner.dart';
export 'package:koompi_hotspot/screens/mywallet/send_payment_complete.dart';
export 'package:koompi_hotspot/screens/mywallet/my_wallet.dart';
export 'package:koompi_hotspot/screens/mywallet/wallet_screen_body.dart';
export 'package:koompi_hotspot/screens/mywallet/wallet_screen.dart';
export 'package:koompi_hotspot/screens/mywallet/transaction_detail.dart';
export 'package:koompi_hotspot/screens/mywallet/short_history.dart';

// Account Page
export 'package:koompi_hotspot/screens/option_page/myaccount.dart';

// On Boading
export 'package:koompi_hotspot/screens/onboarding/styles.dart';
export 'package:koompi_hotspot/screens/onboarding/onboarding_screen.dart';

// Web Page
export 'package:koompi_hotspot/screens/web_view/captive_portal_web.dart';

// Promotion Page
export 'package:koompi_hotspot/screens/promotion/promotion_carousel.dart';

// Change Password Page
export 'package:koompi_hotspot/screens/option_page/change_password.dart';

// Wifi Page
export 'package:koompi_hotspot/screens/wifi/wifi.dart';

// Component
export 'package:koompi_hotspot/widgets/components/qr_widget/qr_text.dart';
export 'package:koompi_hotspot/widgets/reuse_widgets/navbar.dart';
export 'package:koompi_hotspot/widgets/components/qr_widget/qr_appbar.dart';
export 'package:koompi_hotspot/widgets/components/qr_widget/qr_scaffold.dart';
export 'package:koompi_hotspot/widgets/reuse_widgets/validator_mixin.dart';
export 'package:koompi_hotspot/widgets/reuse_widgets/socialmedia.dart';
export 'package:koompi_hotspot/utils/shortcut.dart';

// Reuse Widget
export 'package:koompi_hotspot/widgets/reuse_widgets/dialog.dart';
export 'package:koompi_hotspot/widgets/reuse_widgets/datePicker.dart';
export 'package:koompi_hotspot/widgets/reuse_widgets/locationDropDown.dart';
export 'package:koompi_hotspot/widgets/reuse_widgets/customDropDown.dart';

// Side Menu Drawer
export 'package:koompi_hotspot/widgets/reuse_widgets/drawer_menu.dart';

// Provider
export 'package:koompi_hotspot/providers/trx_history_provider.dart';
export 'package:koompi_hotspot/providers/balance_provider.dart';
export 'package:koompi_hotspot/providers/get_plan_provider.dart';
export 'package:koompi_hotspot/providers/notification_provider.dart';
export 'package:koompi_hotspot/providers/vote_result_provider.dart';
export 'package:koompi_hotspot/providers/lang_provider.dart';

export 'package:koompi_hotspot/screens/option_page/flag_language.dart';
export 'package:onesignal_flutter/onesignal_flutter.dart';

export 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
