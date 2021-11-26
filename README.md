
## Customprompt for Flutter


<img src="https://forthebadge.com/images/badges/built-with-love.svg" height="28px" />&nbsp;&nbsp;<img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" height="28px" />&nbsp;&nbsp;<a href="https://pub.dev/packages/customprompt"><img src="https://img.shields.io/pub/v/customprompt.svg?style=for-the-badge" height="28px" /></a>

Customprompt is a simple animated modal for flutter IOS, Android and Web apps. Customprompt was built with with you in mind, all widgets like Icon, Text, Color can be replaced by the user, plus animation curve and animation duration.

It should look something like this:

<a href="https://imgflip.com/gif/44mn8i"><img src="https://i.imgflip.com/44mn8i.gif"></img></a>

Pull requests certainly welcome.

## Installation
In your `pubspec.yaml` root add:

```yaml
dependencies:
  customprompt: ^0.2.7+2
```

and run:
`dart pub get`

then,

`import 'package:customprompt/customprompt.dart';`

## Usage
Typically, customprompt will be used, as follows:

### type: 'success'
 ```dart
    CustomPrompt(
        animDuration: 500,
        type: 'success',
        curve: Curves.easeInCubic,
        transparent: true,
        context: context,
        btnOneText: Text('Okay'),
        content: 'Action was successful!',
        btnOneOnClick: () => print('Okay click'),
    ).alert();
 ```

### type: 'error'
 ```dart
  CustomPrompt(
      animDuration: 500,
      title: 'Error',
      type: 'error',
      curve: Curves.easeInCubic,
      transparent: true,
      context: context,
      btnOneText: Text('Okay'),
      content: 'An error occurred!',
      btnOneOnClick: () => print('Okay click'),
  ).alert();
 ```

### type: 'warning'
 ```dart
    CustomPrompt(
        animDuration: 500,
        title: 'Warning',
        type: 'warning',
        curve: Curves.easeInCubic,
        transparent: true,
        context: context,
        btnOneText: Text('Okay'),
        content: 'Enter password!',
        btnOneOnClick: () => print('Okay click'),
    ).alert();
 ```

### type: 'confirm'
 ```dart
  CustomPrompt(
      context: context,
      type: 'confirm',
      animDuration: 300,
      transparent: true,
      color: Colors.blue,
      title: 'Confirm',
      content: 'Are you sure?',
      curve: Curves.easeIn,
      btnOneText: Text('Yes'),
      btnOneColor: Colors.green,
      btnTwoColor: Colors.red,
      btnTwoText: Text('No'),
      btnOneOnClick: () {
          print('Button one clicked');
      },
      btnTwoOnClick: () {
          print('Button two clicked');
      },
  ).alert();
 ```

### type: 'input'
  ```dart
  CustomPrompt(
      context: context,
      animDuration: 800,
      color: Colors.red,
      type: 'input',
      transparent: true,
      curve: Curves.bounceOut,
      btnOneOnClick: (value) {
          print('Input value ${value}');
      },
  ).alert();
 ```
