Instructions to run a Flutter App in local.
In order to run the Challenge locally you need to follow bellow instructions.
1- Clone repository from Git hub (number 1 on image), or download it and extract inside directory
(number 2) that you want.
Use this URL. https://github.com/pablomunoz83nqn/xxxxxxxx
VS Code Process

- Open Visual studio Code, we want to execute our app on iOS Emulator o physical device.
- Open an external Terminal and follow step by step.
1: flutter doctor
2: cd <yourappsdirectory>
3: flutter pub get
4: flutter packages pub run build_runner build --delete-conflicting-outputs
5: flutter run (if you already opened an ios emulator) or flutter build ios.
Also you can run the project after step by step instructions pressing F5 on your keyboard, a prompt will
appear asking you what device, Real or emulator, do you want to use. Please select iOS Simulator.

You can see console output by pressing DEBUG CONSOLE inside VS Code

If any compilation problem shows up, please use the following command
flutter clean
then repeat step by step process.

XCODE process
Open Xcode in your Mac by pressing cmd + space. Write Xcode and press enter.
Select Open a project or file and select, select your IOS directory inside your Appdirectory/ios.

Once opened your project, it can take a little to full open, please wait if you see any progress bar,
Select Your emulator, in my case Iphone se 3 generation. Then press PLAY button on top left

Ready!
Your project is running on your local Simulator.