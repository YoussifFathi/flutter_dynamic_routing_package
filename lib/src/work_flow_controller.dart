import 'package:flutter_dynamic_routing/src/work_flow_model.dart';
import 'package:flutter/material.dart';

class WorkFlowController {
  // Singleton implementation
  static final WorkFlowController _instance = WorkFlowController._internal();

  factory WorkFlowController({
    required Map<int, String> routes,
    required List<WorkFlowModel> workflows,
    required Function(dynamic) onNext,
  }) {
    _instance._routes = routes;
    _instance._workflows = workflows;
    _instance._onNext = onNext;
    return _instance;
  }

  WorkFlowController._internal();

  // Fields to store routes and workflows
  late Map<int, String> _routes;
  late List<WorkFlowModel> _workflows;
  late Function(dynamic) _onNext;

  WorkFlowModel? _currentWorkflow;
  int? _currentScreenId;

  // Start the workflow for a specific product type
  void startWorkflow(BuildContext context, int workFlowId) {
    _currentWorkflow = _workflows.firstWhere(
          (workflow) => workflow.id == workFlowId,
      orElse: () => throw Exception("Invalid typeId"),
    );
    _currentScreenId = _currentWorkflow!.screenSequence.first;

    // Navigate to the first screen in the sequence
    _navigateToNewScreen(context);
  }



  // Navigate to the next screen
  void next(BuildContext context) {
    if (_hasNext()) {
      final currentIndex =
      _currentWorkflow!.screenSequence.indexOf(_currentScreenId!);
      _currentScreenId = _currentWorkflow!.screenSequence[currentIndex + 1];
      _navigateToNewScreen(context);
    }else{
        _navigateToRootScreen(context);
    }
  }

  // Navigate to the previous screen
  void previous(BuildContext context) async {
    if (_hasPrevious()) {
      final currentIndex =
      _currentWorkflow!.screenSequence.indexOf(_currentScreenId!);
      _currentScreenId = _currentWorkflow!.screenSequence[currentIndex - 1];
    }
    Navigator.maybePop(context);
  }


  // Check if there is a next screen
  bool _hasNext() {
    return _currentWorkflow != null &&
        _currentScreenId != null &&
        _currentWorkflow!.screenSequence.indexOf(_currentScreenId!) <
            _currentWorkflow!.screenSequence.length - 1;
  }

  // Check if there is a previous screen
  bool _hasPrevious() {
    return _currentWorkflow != null &&
        _currentScreenId != null &&
        _currentWorkflow!.screenSequence.indexOf(_currentScreenId!) > 0;
  }

  // Private method to handle navigation to New Screen
  void _navigateToNewScreen(BuildContext context) {
    final routeName = _routes[_currentScreenId];
    if (routeName != null) {
      _onNext.call(routeName);
    } else {
      throw Exception("Route not found for screen ID: $_currentScreenId");
    }
  }

  // Private method to handle navigation to Root
  void _navigateToRootScreen(BuildContext context) {
    final routeName = _routes[0];
    if (routeName != null) {
      Navigator.pushNamedAndRemoveUntil(context, routeName,(Route<dynamic> route) => false,);
    } else {
      throw Exception("Did not Find Root");
    }
  }
}
