BooksSearching
==============
⌘⌘
This is a test project for searching books from https://openlibrary.org/dev/docs/api

This **_BooksSearchingDemo App_** demonstrate using [**Alamofire**](https://github.com/Alamofire/Alamofire) with [**SwiftyJSON**](https://github.com/SwiftyJSON/SwiftyJSON) for parsing requests.
[**SnapKit**](https://github.com/SnapKit/SnapKit) used for generating dynamyc views autolayout constraints programmaticaly.
[**Nuke**](https://github.com/kean/Nuke) used for loading cover images into item cell (if exist).
[**WebKit**](https://developer.apple.com/documentation/webkit) uses for loading detail page information.


Getting starting
----------------

1. Download or clone repository to your own folder
2. Open **Terminal**
3. Go to repository folder
4. Go to **_BooksSearchongDemo_** folder with command ```cd BooksSearchongDemo```
5. Install pods with command ```pod install```. See about cocoapods there - [https://cocoapods.org](https://cocoapods.org)
6. Open the project workspace in Xcode or by running the command ```open BooksSearchongDemo.xcworkspace```.
7. Select your device or simulator and tap **Build & Run** button or select menu **Product -> Run**. Also you can run the project by pressing **⌘+R** keys.


Changelog
---------

10/02/2020 
- added SwiftyJSON;
- added Nuke;
- added books parsing;
- added list of books screen;
- added book view screen;
- added searching images if exist

09/02/2020
- added first screen UI (search field and search button);

09/02/2020

- added Podfile;
- added Alamofire;
- added SnapKit;

09/02/2020
- added initial project

License
-------

MIT License

Copyright (c) 2020 Ruslan Yupyn

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.