Cocoapods Search Workflow for Alfred
================================

A simple workflow for searching CocoaPods.

![screenshot](http://f.cl.ly/items/0y383Y1C3O2B2336040M/Screen%20Shot%202013-04-11%20at%2012.34.55%20PM.png)

**How to use it**
- Clone the repo (or download a zip) & double-click the `CocoaPods.alfredworkflow` file to install it into Alfred.
- Bring Alfred up and type `pod` followed by your query.
- Once you have a result selected Return opens the pod's homepage & Alt+Return copies the pod's definition for your `podfile`.

Enjoy!

**Notes:**

- The backend utility is now a binary written in pure Cocoa (instead of a python script). The result is that is wayyy faster and smaller than the previous version.
- The workflow uses the [Cocoapods.org public search API](http://blog.cocoapods.org/Search-API-Version-1/). Many thanks to [@floere](https://github.com/floere) for his work, tips & heads up.

**Contact me:**

alladinian@gmail.com || [@alladinian](https://twitter.com/alladinian)
