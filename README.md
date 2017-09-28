# watchosslowdatatask
Example of 10x (or worse) slower response time in URLSessionDataTask on watchOS

1. All relevant code for iOS target is in ViewController.swift

2. All relevant code for watchOS target is in ExtensionsDelegate.swift

Run both and look into console output. 

## Results

1. iOS will printout it needed something like 200-600ms

2. watchOS will printout it needed something like *6-10 seconds*

It's the same behavior on both the Simulator or device.
