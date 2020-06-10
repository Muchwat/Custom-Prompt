
## Customprompt for Flutter

Customprompt is a simple animated modal for flutter IOS, Android and Web apps. Customprompt was built with with you in mind, all widgets like Icon, Text, Color can be replaced by the user, plus animation curve and animation duration.

It should look something like this:

<a href="https://imgflip.com/gif/44mn8i"><img src="https://i.imgflip.com/44mn8i.gif"></img></a>

Pull requests certainly welcome.

## Installation
In your `pubspec.yaml` root add:

```yaml
dependencies:
  customprompt: ^0.2.1
```

then,

`import 'package:customprompt/customprompt.dart';`

## Usage
Typically, customprompt will be used, as follows:
### type: 'error'
 ```dart
  CustomPrompt(
      context: context,
      animDuration: 500,
      title: 'Error',
      type: 'error',
      transparent = false,
      color: Colors.red,
      curve: Curves.easeInCubic,
      btnOneColor: Colors.white,
      btnOneText: 'Okay',
      content: 'An error occurred!',
      onOkay: handleOkay,
  ).alert();

  void handleOkay() {
    print('Okay button clicked');
  }
 ```

### type: 'warning'
 ```dart
  CustomPrompt(
      context: context,
      animDuration: 500,
      title: 'Error',
      type: 'warning',
      transparent = false,
      color: Colors.orange,
      curve: Curves.easeInCubic,
      btnOneColor: Colors.white,
      btnOneText: 'Okay',
      content: 'An error occurred!',
      onOkay: handleOkay,
  ).alert();

  void handleOkay() {
    print('Okay button clicked');
  }
 ```

### type: 'confirm'
 ```dart
  CustomPrompt(
      context: context,
      animDuration: 500,
      title: 'Error',
      type: 'confirm',
      transparent = true,
      color: Colors.blue,
      curve: Curves.easeInCubic,
      btnOneColor: Colors.green,
      btnTwoColor: Colors.red,
      btnOneText: 'Okay',
      btnTwoText: 'Cancel',
      content: 'An error occurred!',
      onOkay: handleOkay,
      onCancel: handleCancel,
  ).alert();
  
  void handleOkay() {
    print('Okay button clicked');
  }

  void handleCancel() {
    print('Cancel button clicked');
  }
 ```

### type: 'input'
  ```dart
  CustomPrompt(
      context: context,
      animDuration: 500,
      title: 'Enter email',
      type: 'input',
      inputHint: 'Enter email...',
      transparent = true,
      color: Colors.blue,
      curve: Curves.easeInCubic,
      btnOneColor: Colors.white,
      btnOneText: 'Submit',
      content: 'An error occurred!',
      onSubmit: handleSubmit,
  ).alert();
  
  void handleSubmit(data) {
    print('Input data ${data}');
  }
 ```