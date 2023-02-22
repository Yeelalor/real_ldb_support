import 'package:testflutter/screens/FillMoney/fill_money_screen.dart';
import 'package:testflutter/screens/CustomerInfo/pages/customer_info_screen.dart';
import 'package:testflutter/screens/SumFee/sumfee_screen.dart';
import 'package:testflutter/screens/Waters/payment_water_screen.dart';
import 'package:testflutter/screens/EDL/EDL_screen.dart';
import 'package:testflutter/screens/TransferIn/transfer_in_screen.dart';
import 'package:testflutter/screens/TransactionFailed/tsn_failed_screen.dart';
import 'package:testflutter/screens/TransferOtherBank/tsn_other_bank_screen.dart';
import 'package:testflutter/screens/TransactionSuccess/tsn_success_screen.dart';
import 'package:testflutter/screens/OTP/otp_screen.dart';
import 'package:page_transition/page_transition.dart';

routes(context) => {
      'CheckOTP()': (context) => const CheckOTP(),
      '/customerinfo': (context) => const ChecktCustomerInfo(),
      '/sumfee': (context) => const CheckMoney(),
      '/success': (context) => const CheckSuccess(),
      '/failed': (context) => const CheckFailed(),
      '/otherbank': (context) => const CheckOtherBank(),
      '/water': (context) => const CheckPayWater(),
      '/electrity': (context) => const CheckPayElectrity(),
      '/addmoney': (context) => const CheckAddMoney(),
      '/transferin': (context) => const CheckTransferIn(),
    };
