---
title: 'Read in February 2026'
date: '2026-04-10'
tags: books, logic, math, set_theory
---

**Katherine Heiny. *Single, Carefree, Mellow: Stories***

I read the first half of this book while pulling an all-nighter in an airport
lounge in Delhi. It was great for that purpose: The stories draw you in like a
good gossip session. The connecting theme is infidelity and other romantically
disastrous choices and situations. The characters in these stories and their
values are mostly pretty mysterious to me---their choices seem to make them so
much lonelier than they realize. But the stories are told well and I laughed
out loud a few times.

**Peter Smith, *An Introduction To Formal Logic***

I [read this book with pleasure last
year](https://chrisyoung.net/prose/blog/posts/2025-02-08_recently_read/) and
enjoyed it even more the second time through. It's an excellent *philosophical*
introduction to logic in that it's sensitive and alive to so many of the
interesting philosophical issues raised by the technical material. Smith does a
wonderful job of sticking in a disciplined way to what is appropriate in an
introductory text, while also clearly indicating some of the philosophical
choices and issues that await the reader beyond that threshold.

**Paul Torday. *Salmon Fishing in the Yemen***

I read this book because it was said to be funny---won the Bollinger Everyman
Wodehouse Prize for being funniest book of the year it was published (2007), in
fact. It started out pretty funny, but the laughs became increasingly spaced
out until halfway through I wasn't sure if I cared enough to finish it. I
finished the book anyway, laughed a few more times, and don't *entirely* regret
having read it.

The story is about an improbable attempt to bring salmon fishing to Yemen. It
is told improbably by way of a series of selections from diary entries,
letters, testimony from an official inquiry, memoirs, etc. from the central
characters in the story. Just as the characters need to suspend disbelief in
their project, so too does the reader need to suspend disbelief in the various
literary techniques employed to tell the story. No one would ever, for example,
talk so frankly about their romantic aspirations on the record to an official
inquiry. But no matter. It's all meant to be as silly as possible, and at that
I guess it succeeds.

It seems they made a movie based on this book. From skimming the Wikipedia
summary, I gather they modified the romantic aspect of the plot in the most
predictably Hollywood way possible. I think I will skip it.

**Shinzen Young. *Natural Pain Relief: How to Soothe &amp; Dissolve Physical Pain with Mindfulness***

Moved [here](../2026-04-10_young_natural_pain_relief).

**Jacqueline de Romilly and Monique Trédé. *Petites leçons sur le grec ancien***

Moved [here](../2026-04-10_romilly_petites_lecons).

**Papers**

In addition to books, I also read a number of papers in February. Most of my
reading was around the subject of Tarski and truth, which I'll write about
separately later.

I also read George Boolos's classic 1972 paper, ["The Iterative Conception of
Set"](https://jstor.org/stable/2025204).

Sets are aggregates of objects considered extensionally. The "considered
extensionally" just means that a given set is determined entirely by what it
contains, no more or less. The set {2, 3} is the same as the set {3, 2} and the
set {2, 2, 3} because all these sets contain exactly the same two elements;
order or duplication doesn't matter. We might specify the same set in different
ways, e.g., {2, 4} and {x : x is an even number under 5}. No matter the
different ways of specifying the elements here: these are the same set
nonetheless. Notice the "x is an even number under 5" bit. It's very convenient
to build sets using predicates in this way. Now, wrap up these two
points---extensionality and "comprehension" (the use of predicates to specify a
set) in axioms---and you have naive set theory.

The problem, as mathematicians and logicians realized pretty early in the
development of set theory, is that naive set theory hits paradoxes pretty
quickly. Here's a famous one: If we can use *any* predicate we like to specify
a set, then why not the predicate 'is not self-membered' which picks out sets
that are not members of themselves? Now, if {x : x is not self-membered} does
not contain itself then the predicate tells us it must contain itself,
but---wait!---if it does contain itself then the predicate tells us that it
must not. Whoops!

There are various ways of blocking such paradoxes, but a very popular one is
the iterative conception of set. On this approach, we 'build' sets in stages
using axioms carefully chosen to block paradoxical sets. At each stage, we can
use sets built up in earlier stages as material for subsequent stages. (And
yes, there is *so* much work to do here spelling out the dependence relation
and the quasi-temporal language of building.) The key move is a modified
version of comprehension that allows predicates to range *only* over sets we've
already constructed in earlier stages. This restriction blocks the paradox
mentioned above, since the predicate used to build the set can no longer range
over the set itself during its construction (it isn't available at that stage
to be ranged over).

Now, because I read everything in the wrong order, and because I don't know
this area very well (to say the least), I was originally confused by the point
of Boolos' paper. What was the celebrated Harvard logician doing telling his
colleagues about something as commonplace as the iterative conception of the
set as though it would be news to them? As he himself notes (footnote 3), the
iterative conception goes back to Zermelo and Russell, working long before
Boolos's 1971 paper. (Though see Potter's *Set Theory and Its Philosophy*
(especially pages 36 and 37 for scepticism about how early it *really* appears.
He thinks we don't really get a clear description in print until a 1947 paper
by Gödel.) I think my initial impression was confused because as Boolos points
out in the same footnote, "philosophers, in the main, seem to be unaware of
it". There's been a *lot* of philosophical water under the bridge since 1971,
and Boolos's paper played an important role in getting it flowing. So *now* the
iterative conception of the set and its philosophical motivation is familiar to
philosophers working in this area. But I guess that wasn't the case when the
paper was originally published.[^button]

[^button]: After writing the first draft of these remarks I came across this
sentence in chapter 9 of Button's *Set Theory: An Open Introduction*: "The
approach is *entirely* inspired by Boolos (1971), Scott (1974), and Shoenfield
(1977)."
