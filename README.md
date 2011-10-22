#iOS build tools for command line

*Author: Paul van der Walt, 2011*

##Introduction

If you're like me, you don't like to use XCode, but are forced to. Here is a
(partial) solution to the problem: a set of ugly hacks using Rake, xcodebuild
(the XCode command-line build tool) and a utility called iphonesim (from
https://github.com/jhaynie/iphonesim) which can launch the iOS simulator from
the console.

##Usage

Make a clone of these scripts somewhere and place this directory in your `$PATH`.
This way, if something gets updated, you just do a `git pull` and you're good
to go again. Now make go to your iOS project directory (or a directory which
has a `.xcodeproj` file somewhere in it's children), and make a symlink to the
Rakefile. For example, do:

```sh
$ cd $YOUR_COOL_PROJECT
$ ln -s $IOS_BUILDTOOLS_CLONE/Rakefile
$ cd some/deep/subdir
$ rake
```

Now, you'll be able to run `rake` from within any subdirectory of your project
(for example if you're using Vim as an editor), and the Rake system will locate
the Rakefile. Next, the Rakefile locates the `.xcodeproj/` directory, which it
passes to the `xcodebuild-wrapper.sh` script. It does some magic (feel free to
customize the script for your needs, current defaults are latest iOS SDK, iPad,
Debug build), and then, if the build was successful, runs your new target in
the iOS simulator. I find this very useful.

If you want Vim to be able to use the rakefile using the normal `:make` command,
you can add the following line to your `.vimrc`:

    autocmd FileType objc set makeprg=rake

##Caveats

Note that if you want to run the Vim command `:make`, you might need to edit Vim's path setting, for example with `:set path+=/checkout/location`. In my case, I also needed to add a file to `/etc/paths.d` with the paths to `xcodebuild-wrapper.sh` and `iphonesim`, before MacVim would manage to make things out the box.

##Recommendations

If you use (Mac)Vim like me, you might want to look at the following plugins.

* cocoa.vim
* snipmate.vim
* errormarker.vim

##Credits

I didn't really create anything here, I just put a few building blocks together the way I liked them. Credit should go to the following people (see the URLs for where I got all the ingredients for this toolset):

* https://github.com/jhaynie/iphonesim
* http://blog.highorderbit.com/2009/09/02/building-xcode-projects-in-vim-with-rake/
