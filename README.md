Cocoapods Search Workflow for Alfred
================================

A simple workflow for searching CocoaPods.

![screenshot](http://f.cl.ly/items/0y383Y1C3O2B2336040M/Screen%20Shot%202013-04-11%20at%2012.34.55%20PM.png)

**Notes:**

- <del>The script is written in Python and it uses the BeautifulSoup module in order to execute XPath queries (if someone knows a way of using a stock library compatible with Python 2.6x+ feel free to contact me)</del>
- <del>The portion of code that executes the request against cocoapods.org comes from _StackOverflow_ workflow by xhinking</del>
- The backend utility is now a binary written in pure Cocoa (instead of a python script). The result is that is wayyy faster and smaller than the previous version.
- Cocoapods.org doesn't have a public api for their search, so the whole thing is nothing more than a hack

**Contact me:**

alladinian@gmail.com || @alladinian
