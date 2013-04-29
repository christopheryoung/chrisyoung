---
title: A very, very gentle introduction to the Linux Command Line
---

I recently set a friend of mine up with a fresh install of Ubuntu on her laptop.  Ubuntu is such a user friendly version of Linux that you can go a long way without having to touch the command line.  Still, I thought it would be good to give her a few tips about using the command line, since sooner or later she might end up needing it (say, at a web page that only tells her how to install software from the command line).  Anyway, it's fun and liberating to learn something new.  And then I thought I might as well post a tutorial here in case it helps someone else (even though there are already about a hundred thousand of them out there already).

Just a warning, I'm fairly new to all this stuff myself, so if you have corrections or suggestions, please feel free to add them in the comments.


<strong>Getting Around</strong>


OK, if you're using Ubuntu, open up the Applications menu, click "Accessories" and then select "Terminal."  (If you want handy access to the terminal in the future, you can right click on it in the menu and add it to the launcher panel.  A little icon will appear up where the Firefox icon is.)

You should follow along with the tutorial.

Here's what my prompt looks like:

    chris@bobo:~$


Yours will no doubt look different.  My user name is "chris" and my laptop's name is "bobo," which was also a nickname for <a href="http://www.explananda.com/2007/12/18/coltrane-choi-rip-march-1993-december-2007/">he of beloved memory</a>  Different terminals can be customized in all sorts of ways, so yours might have the date, or display exactly where you are in the file system at all times, etc.

The first question when we get to some new place is "Where am I?"  We can learn the answer to this at the command line by asking the computer to <em>p</em>rint our <em>w</em>orking <em>d</em>irectory:

    $ pwd
    /home/chris

Each user gets his or her own home directory.  It's where we keep our files and it's where we start when we open up a new terminal.

What's in here?  Well, let's list the contents of the directory:

    chris@bobo:~$ ls
    code
    Desktop
    Documents
    Dropbox
    Music
    Pictures
    workspace
    ...

Lots of stuff.

Now, often when you read instructions about how to do something or other, you'll be asked to navigate to a directory.  Chances are that it won't be your home directory.  To do this, we'll want to <em>c</em>hange our <em>d</em>irectory.  Let's try changing to my desktop:

    chris@bobo:~$ cd Desktop/
    chris@bobo:~/Desktop$

It worked!  Notice that my prompt changed to indicate where I am in my file system.  The tilde symbol is a convenient way of writing my home directory (/home/chris).  So "~/Desktop" actually means "/home/chris/Desktop"

At this point you might be thinking that people who use Linux are idiots, since this is a lot of typing, when a few clicks of your mouse would have got you there much faster.  In fact, people who use Linux tend to hate typing, and if you find yourself doing much typing you should ask yourself if you're missing a convenient shortcut.  Let's back up and try again:

    chris@bobo:~/Desktop$ cd ..

The two dots tell us to move up a level in our directory structure.  Remember this: It's useful.  (Remember also that you can always pwd to check where you are, if your prompt doesn't already tell you.)

Now, let's try navigating into the desktop again, but this time with less typing.  So type this and then the tab key:

    chris@bobo:~$ cd D

(It's case sensitive.)  If "Desktop" is the only folder in your home directory that starts with "D," then it should expand to the whole word when you hit the tab key.  Notice above that I actually have three directories that start with "D," so nothing happens.  However, if I hit it again, I'll see this:

    Desktop/   Documents/ Dropbox/

Now I can type an additional character, "e," and then tab, and the letters should expand to "Desktop."  Then I can hit enter and be on my merry way.

Using tab completion, you can <em>race</em> through your file system.  Because if there's another folder within Desktop, you can either enter the first letter or two and then tab, or just hit tab twice to see the options and then type and tab.

Two other useful tips for navigation: First, typing:

    chris@bobo:~$ cd -

Will take you to the previous directory you were in.  And second, typing:

    chris@bobo:~$ cd ~

will always take you back to your home directory.

Let's create a folder (<em>m</em>a<em>k</em>e a <em>dir</em>ectory) on your desktop and then navigate to it:

    chris@bobo:~$ mkdir Desktop/my_awesome_folder
    chris@bobo:~$ cd Desktop/my_awesome_folder

(If you want spaces in the folder name, use quotation marks around the
entire path.)

Now let's go home again:

    chris@bobo:~$ cd ~

Leave your terminal now and check to make sure that "my_awesome_folder" exists on your Ubuntu desktop.

Clutter is annoying.  Let's get rid of it.  Hey!  Hands away from the mouse.  We'll remove it from the command line:

    chris@bobo:~$ rmdir Desktop/my_awesome_folder

Try monkeying around with all this for a while until you feel comfortable.  Notice that you can go above your home directory in your computer.  Feel free to explore and then come back to your home directory.

OK, now what did you do?  Well, don't rely on your memory---just check your history:

    chris@bobo:~$ history
    ...
    8538  cd Desktop/
    8539  cd ~
    8540  history

This will give you a numbered list of the commands you've used.  This is very handy if you've done something clever or useful or dangerously stupid and then forgotten what it was, exactly.  You can always execute a command from the list by typing an exclamation mark plus the number:

    chris@bobo:~$ !8539
    cd ~

Here I just told the computer to change to my home directory, which was pretty useless since I was already there.

You can also scroll through previous commands by using the up and down arrows.  And two explanation marks just repeats the last command.

Now let's read a text file.  (Notice that you won't be able to read some types of files, e.g., MS Word documents, using this technique.)  First we need to create something so that you can read it.

    chris@bobo:~$ ls > myls.txt

(What that did was run the "ls" command and then write the output to a file called "myls.txt.")

To read this file at the command line, we use this command:

    chris@bobo:~$ cat myls.txt

(Did you just type out all of "myls.txt"?  Shame on you!  Remember tab completion!)

This command is called "cat," I believe, because it concatenates multiple files and prints them to the standard output.  In this case there's only one file, so it just prints it to the standard output.

We don't want that file cluttering up our file system, so let's remove it:

    chris@bobo:~$ rm myls.txt

(Did you just type out all of "myls.txt"?  Double shame on you!  I just told you to remember tab completion!)


<strong>Installing Stuff</strong>

OK, now let's install something!  Ubuntu maintains an extremely helpful repository of software packages and makes it very easy to install them.  Here's a package that is essential to working with the Python programming language, the subject of a future post (don't worry if you're not interested, since it's small and installing it is harmless).  Here's how we install it:

    chris@bobo:~$ sudo apt-get install python-setuptools

(We don't have to be in our home directory.  We can use apt-get from anywhere in our file system.)

What's going on here?  Well, the first bit, "sudo" is telling the computer that we know we're trying to do something that requires enhanced permissions.  The second bit, "apt-get" is the command for Ubuntu's special package repository.  What are we going to do here?  Install, of course, which is the third part of our command.  What follows are all the different packages we want to install, separated by a space.  In this case it's just one.

Try it, and then enter your password when prompted.  (You may also be asked whether you want to use up the space.)

OK, now do it again.

(I hope you didn't type out the command again, since that would have been <em>exhausting</em>.  You just hit the up arrow and then enter, right?)

Notice that this time your system simply tells you that it's already installed.  This is handy, since sometimes someone will give you some incredibly long list of things to install.  You don't need to worry whether you already have them, since the computer will simply skip the ones you already have.

Sometimes you have a rough idea of what the package you want to install is called, but you're not quite sure.  Suppose you're curious about what the resources are in the repository for, say, greek:

    chris@bobo:~$ sudo aptitude search greek


<strong>Piping</strong>

Now you know how to navigate around your file system, install software, and then get the history of what you've done.  There's one last idea I want to introduce: piping.

The idea in piping is that we can take the output of one program and pipe it into another.  And, if we want, we can take the output of that second program and pipe it into a third, and so on <em>all the live-long day</em>.  This may sound very modest, but arguably the power and the beauty of the Linux operating system lies in the possibilities that this creates.

A few very basic examples will give a hint of what I mean.  First, notice that my history above had 8539 entries.  That's a lot of entries!  What if I want to know what I've installed using apt-get, and I don't want to see any other entries?  Well, why not pipe the output of history into a program that searches that history for the string of characters "apt-get"?

    chris@bobo:~$ history | grep apt-get

Remember that we produce the output of the history program simply by typing "history."  The vertical bar is the pipe.  So each line produced by history goes into our search program, called "grep," which searches for the string "apt-get."  And so you'll see something like:

    ...
    8528 sudo apt-get install python-setuptools
    8552 history | grep apt-get

The line you just typed even includes itself, since it too includes the search string "apt-get" and is in the history as soon as you hit enter.

Suppose that the output of the above command is still too long.  Well, let's just pipe our output into a program that feeds us the output of any program in manageable chunks!

    chris@bobo:~$ history | grep apt-get | less

The program is called "less."  Once we type this, we briefly enter less to read our text.  We can page forward by hitting the space bar and back by hitting the "b" character.  When we're done reading, we just hit the "q" character.

less is a very handy program, and you'll find yourself using it a lot.  Recall above that you used cat to read the file.  Since your home directory is probably pretty skimpy, chances are the entire file fit on a single screen.  But if it had been long, it would have flown by too fast to read.  In that case, you could have used less:

    chris@bobo:~$ cat myls.txt | less


OK, I think that's enough to absorb in one day.  The trick is to play around <em>a lot</em> and use the commands frequently.  After a while, they become second nature.  Good luck!
