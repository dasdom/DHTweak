DHTweaks
======

Swift implementation of [Tweaks](https://github.com/facebook/Tweaks) from Facebook.

What is it?
-----------

Tweaks lets you make changes to your iOS app while it is running. This is especially useful if you are not sure about the right font size, colors or if you want to hide certain functionallities from some of your testers.

Installation
------------

1. Download the zip and add the Tweaks.xcodeproj to your workspace.
2. Chose the Tweaks scheme and your iOS device and build.
3. In you application target add the Tweaks framework to 'Embedded Binaries'.
4. Add `import Tweaks` in your AppDelegate.
5. Exchange the line `var window = UIWindow?` with `var window = ShakeableWindow(frame: UIScreen.mainScreen().bounds)`.

Usage
-----

At the moment only tweak values are supported. Let's say you want to tweak the text size of a label at run time. To do this add `import Tweaks` to the view controller which controls the label. In `viewWillAppear(Bool)` or `viewDidAppear(Bool)` add the code

```
let fontSize = CGFloat(Tweak.valueForCategory("Main View", collectionName: "Text", name: "Size", defaultValue: 20, minimumValue: 10, maximumValue: 40))
        
label.font = UIFont.systemFontOfSize(fontSize)
```

Build and run the App. In the Simulator go to **Hardware/Shake Gesture**. Navigate to **Main View** and change the font size. Touch **Done**.

Supported types for tweaks
--------------------------

1. Float
2. Double
3. Bool
4. String
5. UIColor

Other examples
--------------

```
let textColor = Tweak.valueForCategory("Main View", collectionName: "Text", name: "Color", defaultValue: UIColor.blackColor())
label.textColor = textColor
        
let backgroundColor = Tweak.valueForCategory("Main View", collectionName: "Background", name: "Color", defaultValue: UIColor.whiteColor())
view.backgroundColor = backgroundColor
        
let text = Tweak.valueForCategory("Main View", collectionName: "Text", name: "Text", defaultValue: "Hello")
label.text = text

```

The author
----------

Dominik Hauser

Visit my [blog](http://dasdev.de) or follow me on [Twitter](http://twitter.com/dasdom) or [App.net](http://alpha.app.net/dasdom).

Licence
-------

MIT Licence. See the LICENCE file for details.
