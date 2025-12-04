

import 'package:arc_to_do_list/DesignSytem/Components/Loads/action_load.dart';
import 'package:arc_to_do_list/DesignSytem/Components/Loads/action_load_view_model.dart';

ActionLoad showLoading() {
    final vm = ActionLoadViewModel(4, 48, ActionLoadType.primary);
    return ActionLoad.initialize(viewModel: vm);
  }
