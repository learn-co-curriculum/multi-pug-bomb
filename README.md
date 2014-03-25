---
tags: nsoperationqueue,multithreading,advanced
language: objc
---
# Multi-Threading For Speed

So we've done a multi-threading example to just not block the main thread, but let's do one to make things faster.

## Instructions

  1. Open up the app we worked on in lecture yesterday. I included it in here.
  2. So since we know we want 100 pugs...why don't we just precache all of the pug urls. On `viewDidLoad` hit the pugme API 100 times and get the list of Image urls. Go ahead and do any other modifications to make this work with the UITableView
  3. So you are doing all of those in sequence...not good.
  4. Multi-thread these...make sure that no more than ten operations are happening at a time.

## Extra Credit

  1. Also download the images...but don't not let the view load until that's done. 

## Hints

  1. You can set how many operations can happen simultaneously in an `NSOperationQueue` by doing 

  ```
  [myOperationQueue setMaxConcurrentOperationCount:10];
  ```
