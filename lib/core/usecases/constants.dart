import 'package:myinoface/core/util/app_utils.dart';
import 'package:myinoface/core/mobx/mobx_app.dart';
import '../network/network_logic.dart';
import '../network/network_state.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../utils/utils_logic.dart';
import '../utils/utils_state.dart';


final AppUtils appUtils = GetIt.I.get<AppUtils>();
final MobxApp mobxApp = MobxApp();
final Logger logger = Logger();

//! NetworkLogic
final NetworkLogic networkLogic = NetworkLogic.instance;
final NetworkState networkState = networkLogic.state;


//! Utils
final UtilsLogic utilsLogic = UtilsLogic.instance;
final UtilsState utilsState = utilsLogic.state;