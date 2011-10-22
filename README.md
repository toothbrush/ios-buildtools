#iOS build tools for command line

*Author: Paul van der Walt, 2011*

INTRO
=====

If you're like me, you don't like to use XCode, but are forced to. Here is a
(partial) solution to the problem: a set of ugly hacks using Rake, xcodebuild
(the XCode command-line build tool) and a utility called iphonesim (from
https://github.com/jhaynie/iphonesim) which can launch the iOS simulator from
the console.

USAGE
=====

Make a clone of these scripts somewhere and place this directory in your `$PATH`.
This way, if something gets updated, you just do a `git pull` and you're good
to go again. Now make go to your iOS project directory (or a directory which
has a `.xcodeproj` file somewhere in it's children), and make a symlink to the
Rakefile. For example, do:

```sh
$ cd $YOUR_COOL_PROJECT
$ ln -s $IOS_BUILDTOOLS_CLONE/Rakefile
```

Now, you'll be able to run `rake` from within any subdirectory of your project
(for example if you're using Vim as an editor), and the Rake system will locate
the Rakefile. Next, the Rakefile locates the `.xcodeproj/