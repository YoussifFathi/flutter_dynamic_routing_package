library dynamic_routing;

import 'package:flutter_dynamic_routing/src/work_flow_controller.dart';
import 'package:flutter_dynamic_routing/src/work_flow_model.dart';
import 'package:flutter/material.dart';
export 'src/work_flow_model.dart';
export 'src/work_flow_controller.dart';


/// This class handles dynamic routing in the app.
///
/// It allows developers to define workflows based on the user's choices and the app's state.
abstract class DynamicRouting {

  static WorkFlowController? _workFlowController;


  /// Sets the routes and workflows for the app.
  ///
  /// The `routesMap` contains all the available routes, and `workFlows` define
  /// the screens a user should go through based on their choices. The `callback` is used
  /// to navigate to the correct screen.
  ///
  /// - [routesMap] A map of integer IDs to routes.
  /// - [workFlows] A list of `WorkFlowModel` defining screen sequences.
  /// - [onNext] The function to execute when navigating to the next screen.
  static void setRoutes(Map<int, String> routes, List<WorkFlowModel> workflows, Function(dynamic) onNext) {
    _workFlowController = WorkFlowController(routes: routes, workflows: workflows,onNext: onNext);
  }

  // Method to start the workflow
  static void startWorkflow(BuildContext context, int workFlowId) {
    if (_workFlowController == null) {
      throw Exception('Routes must be set using setRoutes() before starting the workflow.');
    }
    _workFlowController!.startWorkflow(context, workFlowId);
  }

  // Method to go to the next screen
  static void next(BuildContext context) {
    if (_workFlowController == null) {
      throw Exception('Routes must be set using setRoutes() before navigating.');
    }
    _workFlowController!.next(context);
  }

  // Method to go to the previous screen
  static void previous(BuildContext context) {
    if (_workFlowController == null) {
      throw Exception('Routes must be set using setRoutes() before navigating.');
    }
    _workFlowController!.previous(context);
  }
}
