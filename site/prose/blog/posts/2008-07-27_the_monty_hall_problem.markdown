---
{date: '2008-07-27', explananda: '', title: The Monty Hall Problem, tags: code, math}

---
Thanks to a friend, this morning I learned about the <a href="http://www.nytimes.com/2008/04/08/science/08tier.html?_r=6&8dpc&oref=slogin&oref=slogin&oref=login&oref=slogin&oref=login&oref=login">Monty Hall Problem</a>.  As she remarked, it is counter-intuitive in the extreme.  But I see from the <a href="http://en.wikipedia.org/wiki/Monty_Hall_problem">Wikipedia article</a> that even Paul Erdos got it wrong the first time, so I don't feel too bad about being initially stumped.  (If you're having trouble getting it, I found it very helpful to step back and think about the related N doors puzzle discussed in the Wikipedia article.)

One of the wonderful things about picking up even the slightest bit of programming is that you can test and play around with things like this.  The Python programming language makes it especially easy for a beginner to muddle through to a test very quickly:

[sourcecode language='python']
import random

remainingchoice = []
carcount = 0.0
trials = 100000

for i in range(1, trials):
	possibilities = ['goat', 'goat', 'car']
	random.shuffle(possibilities)
	if possibilities[1] == 'goat':
		remainingchoice.append(possibilities[2])
	else:
		remainingchoice.append(possibilities[1])

remainingchoice.sort()
for item in remainingchoice:
	if item == 'goat':
		pass
	else:
		carcount +=1

print (carcount * 100) / trials
[/sourcecode]

Somehow makes it all seem more solid.  Except when I changed the trials variable to 100000000 and my computer was all like "What the fuuuu?" and then Python crashed hard.


<h1>Comments</h1>


<br/>
<em>Author:</em> Steve Laniel
<br/><em>Date:</em> 2008-07-27

Awesome! Though a large number in a for-loop should never cause you problems. The problem is probably that you're using range() rather than xrange(): range() creates a list of the size specified, meaning that range(100000000) will create a 100000000-item list. BAD NEWS. xrange() always uses the same amount of memory, no matter how large the argument is. It's what's known as an "iterator"; Python has lots of lovely support for iterators.

If you've not yet discovered docs.python.org, it is your friend. See specifically http://docs.python.org/lib/built-in-funcs.html for xrange() documentation (and, as it happens, range() documentation).
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Steve Laniel
<br/><em>Date:</em> 2008-07-27

I should note here that I'm impressed by your coding, given that I gather you've only just started programming. (Right?) Nice work.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-27

Thanks!  But (possibly quite silly question) isn't the problem that the remainingchoice list swells in size (to roughly 66 for every 100 in the trials), regardless of whether you use xrange() or range() to get the for loop going?  Or am I just totally missing your point?
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-27

Wait a minute!  Why not just this (with dashes representing spaces):

import random

carcount = 0.0
trials = 100000

for i in range(1, trials):
----possibilities = ['goat', 'goat', 'car']
----random.shuffle(possibilities)
----if (possibilities[1] == 'goat' and possibilities[2] == 'goat'):
--------pass
----else:
--------carcount += 1

print (carcount * 100) / trials

Much simpler, no?
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-27

Oh no, wait.  xrange for range.  Of course you're right.  When I change it to xrange it gets up to 1,000,000 but seems to conk out at 10,000,000.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-27

Oh wait, eventually it recovered and managed to cope with 10,000,000.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-27

No, that doesn't work.  Forget it.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-27

Now I don't know why I did this:

remainingchoice.sort()
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Steve Laniel
<br/><em>Date:</em> 2008-07-27

Will chime in more later, but here's a quick stylistic hint: rather than


if condition:
	pass
else:
	doSomething()


it's prettier to just do


if not condition:
	doSomething()

<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Steve Laniel
<br/><em>Date:</em> 2008-07-27

I tried to submit that with PRE tags around the code. No love.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-27

Ah, thank you.  Will do that from now on.

Yeah, sorry about the lack of formatting in comments.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Paul
<br/><em>Date:</em> 2008-07-28

For a long time I had myself convinced I understood this. I thought: Look, there's a 1/3 chance that I have initially chosen the right door, and a 2/3 chance that it's behind *either* of two other doors. You can take one of those two other doors away, but this doesn't change the fact that there is a 2/3 chance that the car is behind one of the doors <i>in that group</i>. But now that that group consists of only one door, the 2/3 probability that it's behind one of those doors in that group becomes a 2/3 probability that it's behind the only door of that group that remains.

But this can't be right, since the initial individuation of groups is utterly arbitrary. Why not say that there is a 1/3 chance that the car is behind one door I don't initially pick and which is not opened by Monte, and a 2/3 chance that it's behind *either* the one I do initially pick or behind the door that Monte ultimately opens up? Then, when he opens it up, I should not switch, because my initial choice is now the only door left from the *group* whose probability was 2/3.

It was upon realizing that my solution was pure sophistry that I came to believe that I'd never understand what the fuck was going on.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-28

<em>Why not say that there is a 1/3 chance that the car is behind one door I don't initially pick and which is not opened by Monte, and a 2/3 chance that it's behind *either* the one I do initially pick or behind the door that Monte ultimately opens up?</em>

But Monte isn't going to open up a door with a car behind it.  Does that help?  It looks to me like your original solution is right.

Does thinking of the n door case help?  Suppose you have a 100 doors.  You choose one.  Now Monte opens up 98 doors, revealing goats behind every one of them.  Should you switch to the one remaining door?  Obviously!  Because the chance of your picking the right door on the first try is 1/100.  Choosing the remaining unopened door after the 98 have been eliminated gives you a 99/100 chance of getting it right.

Or do I not understand it either?
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Paul
<br/><em>Date:</em> 2008-07-28

You're definitely on to something when you point to Monte's avoidance of the prize door, I'm sure. But it's just here where my solution failed. I don't know the vocab here, but my solution seems to rely on what we might call static probabilities. I pick one door, which has a 1/3 chance. That means the other two, as a group, have a 2/3 chance. So whatever door is left when Monte opens one, I should go for. But the fact that Monte avoided one played no role in my solution; it's based entirely on antecedent estimations of probability. And this method is wrong, because it can be used to give my initial pick a 2/3 probability. We do that by saying that my door plus another door ("let us say it's whatever door that Monte opens," I will say) have 2/3 chance. So the other has 1/3. So when the door is opened, I should stay with the one I chose, since it's the only one left of a group with 2/3 chance.

Again, the problem for my solution, I think, is that I figured I could assign probabilities to antecedently chosen groups, abstractly defined. But this fails to take into account the fact that he <I>deliberately avoids one door</i>, and this is, so far as I understand it, crucial to determining the probabilities here. This is the factor that enables us to avoid the problem I claimed beset my solution: namely that if my static solution worked, we could rearrange things so that my door has 2/3 chance.

Does that make sense?
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-28

Does this part of the Wikipedia article address this point? "The most commonly voiced objection to the solution is that the past can be ignored when assessing the probability—that it is irrelevant which doors the player initially picks and the host opens. However, in the problem as originally presented, the player's initial choice does influence the host's available choices subsequently."
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Paul
<br/><em>Date:</em> 2008-07-28

I believe so, yes. As is surely obvious, I don't know nearly enough about probability to know what I'm talking about. But with knowledge of the real probabilities once a door is opened, I was sure my solution failed, and that it had something to do with the allure of what I called static probabilities, what the wiki calls the irrelevance of the contestant's pick and the host's openings.

FWIW, there is a logic textbook by a guy named Hurley that I used in college and which I found extremely good. Apparently, the most recent edition includes a chapter on probability, in which Hurley ultimate proves Bayes' theorem. I'm going to try to get my hands on it. If I do, then I'll go ahead and lanielize them to what I know to be interested parties.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-28

Happy Lanielizing.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> ben wolfson
<br/><em>Date:</em> 2008-07-29

Monty Hall.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-29

Oh, for the love of Pete, what is the matter with me?  Thanks, Ben.  Fixed.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Steve Laniel
<br/><em>Date:</em> 2008-07-29

Proving Bayes' Theorem isn't hard. I mean, maybe it's hard depending on how far down you need your axioms to be.

The idea is just like so.

1. Pr(A|B) = Pr(A and B)/Pr(B). The idea here is intuitive, for some values of "intuition." If you ask "What is the probability that I am wealthy, given that I drive a BMW," that's like asking "What fraction of people who drive BMWs are wealthy?" So B is the event "person is wealthy" and A is the event "person drives a BMW." So you divide the number of people who are wealthy AND drive BMWs by the number of people who drive BMWs. And there's your formula.

2. So we have Pr(A|B)=Pr(A and B)/Pr(B), by the definition of conditional probability. Apply that definition one more time: you have

Pr(B|A)=Pr(A and B)/Pr(A), whence
Pr(A and B)=Pr(A)Pr(B|A) (just multiply both sides by Pr(A)).

So now substitute this new Pr(A and B) into Pr(A|B):

Pr(A|B) = Pr(A)Pr(B|A)/Pr(B).

3. Now the only thing to bother with is the denominator. You want to break up Pr(B) into its constituent parts. Again go back to the wealthy person/BMW example. Here B is the event "person is wealthy." People who are wealthy can be "partitioned" into two categories: those who are wealthy and have BMWs, and those who are wealthy and *don't* have BMWs. (A partition of a set divides that set into nonoverlapping subsets that together equal the original set.) Suppose 70% of wealthy people have BMWs and 30% do not. So then you can say

Pr(B) = .7 Pr(B|A) + .3 Pr(B|not-A)

There's a more rigorous proof here, but that's the idea. In general, assume A can be divided into n nonoverlapping, exhaustive subsets; for instance, maybe A stands for annual income, with values ranging from $0 to $100 billion, at one-dollar increments. Then you can say

Pr(B) = Pr(A=0)Pr(B|A=0) + Pr(A=1)Pr(B|A=0) + ... + Pr(A=100 billion)Pr(B|A=100 billion)

So the denominator is just the sum of the conditional probabilities, each weighted by the probabilities of values of A.

And you're done. That's Bayes' Theorem.

This concludes your mathy blog comment.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Paul
<br/><em>Date:</em> 2008-07-29

What I meant was "Boy am I glad I don't have to learn Bayes' Theorem now, as I won't have the book for a while!"

Just kidding. Thanks Steve. Looking forward to reading through and mastering this while on vaca next week.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Chris
<br/><em>Date:</em> 2008-07-30

Ah, interesting.  I just came across this on p. 265 of Lutz's Learning Python:

"Python today also provides a built-in called xrange that generates indexes one at a time instead of storing all of them in a list at once like range does. There's no speed advantage to xrange, but it's useful as a space optimization if you have to generate a huge number of values. At this writing, however, it seems likely that xrange may disappear in Python 3.0 altogether, and that range may become a generator object that supports the iteration
protocol to produce one item at a time, instead of all at once in a list; check the 3.0 release notes for future developments on this front."
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Steve Laniel
<br/><em>Date:</em> 2008-07-30

I didn't know that xrange was going away, but that would make a ton of sense. If people are going to be routinely writing "for i in range(1,5*10**9)" or whatever, the default ought to be that it doesn't eat up ALL YOUR MEMORY.
<br/>
<br/>

*******************************************************************************



<br/>
<em>Author:</em> Paul
<br/><em>Date:</em> 2008-07-30

What has become of Explananda? Books and python. And not even books about pythons! Good grief!
<br/>
<br/>

*******************************************************************************
