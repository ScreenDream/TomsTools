This repository is for the custom operators I create for Tooll3 (https://tooll.io) while learning HLSL and C#.

Feel free to use and modify them however you want.  
Discussion is best done via the Tooll3 Discord: https://discord.gg/PSn8GzNX  

THESE are only tested by myself and often written for specific purposes, so they may or may not work for you!
If you find bugs, please file an issue here on Github.

Cheers,

Tom

### The Operators:

#### "WrapPoints_Tom"

This is the first tool in this collection and extends the factory **"WrapPoints"** node with two more modes in addition to "Wrap", where points going out on one side of the containing box come back in on the other.

**"Clamp"** clamps points that move outside of the containing box "to the walls" of the box. Not the most useful mode but there for completeness anyway... ;-)

**"Mirror"** is the main reason I extended this operator: It mirrors the points that go out one side of the box back inside, as if they would "bounce" from the wall. This looks much more natural and interesting in many cases than the other options and can also create quite interesting patterns, like "folding" a pointcloud in on itself.  
