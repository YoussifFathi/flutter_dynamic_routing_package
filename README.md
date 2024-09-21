A Flutter package to enable dynamic routing based on user choices or application states. With this package, you can define custom workflows that control the navigation paths users will follow based on their selections.

## Features

- Define workflows with a custom sequence of screens.
- Support for dynamic navigation based on the user's choice.
- Simple and easy-to-use API for setting up routes and workflows.
- Compatible with navigation Types.

## Full Example
For a full working example of how to use the Dynamic Routing package, check out the This Project

### Running the Example

1. Clone this repository:
   ```bash
   git clone https://github.com/YoussifFathi/dynamic_routing_example.git
    ```
## Getting started And Example

To use this package, add the following to your `pubspec.yaml` file:


```yaml
dependencies:
   dynamic_routing: ^1.0.0
```

```dart
DynamicRouting.setRoutes(
{0: Routes.home, // NOTE route 0 is the root that will redirect user to back to it when finish path
1: Routes.screenOne,
2: Routes.screenTwo,
3: Routes.screenThree,
4: Routes.screenFour,
5: Routes.screenFive,
},
[
WorkFlowModel(id: 1, screenSequence: [1, 2, 3]),
WorkFlowModel(id: 2, screenSequence: [2, 4]),
WorkFlowModel(id: 3, screenSequence: [3, 4, 5]),
WorkFlowModel(id: 4, screenSequence: [1, 2, 3, 4, 5]),
],
(routeName) {
Get.toNamed(routeName);
},
);
```
### Example Workflow
Product Type 1: Goes through screens 1, 2, and 3.

Product Type 2: Goes through screens 2 and 4.

Product Type 3: Goes through screens 3, 4, and 5.

Product Type 4: Goes through screens 1, 2, 3, 4 and 5.


## Additional information

This will provide clear instructions and information about your package to potential users. Let me know if you'd like to customize any part!

