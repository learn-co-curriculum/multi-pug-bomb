
# Multi-Threading For Speed

So we've done a multi-threading example to just not block the main thread, but let's do one to make things faster.

## Instructions

  1. Open up the app.
  2. So since we know we want 100 pugs...why don't we just pre-download all of the pug urls. On `viewDidLoad` hit the pugme API 100 times and get the list of Image urls. Staying in viewDidLoad, download all the pugs images and display them. Don't worry about multi-threading just yet. Go ahead and do any other modifications to make this work with the UITableView
  3. So you are doing all of those in sequence...not good.
  4. Multi-thread these like we did in class.

## Extra Credit

  1. Put in placeholder images to start so you can scroll around. Reconfigure each cell as the pugs get donwloaded

## Hints

  1. You can set how many operations can happen simultaneously in an `NSOperationQueue` by doing 

  ```
  [myOperationQueue setMaxConcurrentOperationCount:10];
  ```
