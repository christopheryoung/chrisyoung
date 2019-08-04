---
title: Readings in Computational Stemmatology
date: 2014-01-01
biblio: files.bib
csl: the-journal-of-hellenic-studies.csl
---

# Introduction

What follows is a to-do list in the form of a thin, unsatisfying, much too
English-language-oriented, somewhat (Greek and Latin) Classics biased,
bibliographical essay. This page may, circumstances permitting, grow over time
as I collect references and record brief remarks on a few of them. I have a lot
to add and it will take time to dump my private list of resources into
something worthwhile, still longer to find more resources, and even longer
still to say anything sensible about them. Eventually---again, circumstances
permitting---this page may be of use to someone other than me.

If you're impatient for an excellent, recent, and far more comprehensive (and
more richly multilingual) bibliography, I highly recommend
@trovato2017everything. Unfortunately it doesn't provide a full bibliography,
but it makes up for it with a select bibliography supplemented by short
bibliographical essays throughout the book paired with specific topics. Most's
bibliographical supplements to his translation of @timpanaro2005genesis also
contains much helpful recent material.

You can find all the references on this page collected at the bottom of this
page. You can find my complete bibtex file
[here](https://raw.githubusercontent.com/christopheryoung/chrisyoung/master/site/biblio/files.bib).

A full history of edits to this page can be found
[here](https://github.com/christopheryoung/chrisyoung/commits/master/site/reading/computational-stemmatology.markdown).

If you see an especially glaring error or omission, please feel free to let me
know at chris@chrisyoung.net.


# Traditional Textual Criticism

## Introduction to Textual Criticism

An accessible and engaging introduction to the whole world of ancient,
medieval, and renaissance scholarship and textual criticism can be found in
@reynolds1974scribes (now in it's scrupulously updated fourth edition,
@reynolds2013scribes).

A superb introduction to most of the topics discussed on this page, including
both traditional Lachmannian stemmatology and computational stemmatology, is
@trovato2017everything. Trovato gives a spirited, lucid defence of
neo-Lachmannian stemmatology and offers some skeptical remarks about
(biologically oriented) computational approaches to textual criticism. If you
have any interest in the field you should read this book.

Karl Lachmann, working in the second half of the 19th Century, is associated
with a leap forward in rigour in the establishment of classical texts.
@timpanaro2005genesis, whose relatively recent translation from the Italian we
owe to Glenn Most[^uchicago], traces the development of the method now
associated with Lachmann's name. One irony: Lachmann is neither the first to
develop the method now associated with his name nor does his work provide an
especially good example of the method in practice. Although the main text of
@timpanaro2005genesis is devoted to tracing the historical development of the
method, the appendices to the work wrestle with various technical challenges,
and are still worth reading. (At a slight remove from our main topic,
@timpanaro1976freudian has also been translated into English.)

Earlier introductions to the practice of textual criticism include
@maas1958textual and @west1973textual. Both books are starting to show their
age, the former in particular. But both are worth reading, including
@maas1958textual, which is a little gem of a book. @west1973textual has a
deeper discussion of the phenomenon of contamination, if I recall, and is a
great read too. An important role in 20th century debates about stemmatological
method was also played by (the Italian language, and still untranslated)
@pasquali1952storia. I have not been able to review @reeve2011manuscripts yet,
but it looks like a valuable collection of papers.

A very different review of the history of textual criticism (focusing on New
Testament textual criticism) and biology is offered by @lin2016erotic (see
[this review](http://bmcr.brynmawr.edu/2016/2016-10-25.html) for a bit more). I
hope to comment on this strange book at some point.

Finally, I do not discuss here the "Coherence Based Genealogical Method", which
is all the rage in New Testament studies.

## Lachmann's Method

Editing a text is traditionally divided into *recensio*, *selectio*, and
*emendatio*. *Recensio* refers to the construction of a stemma --- a family
tree relating witness to the text --- *selectio* to the selection from
manuscript variants in a way constrained by the stemma, and *emendatio* to the
use of conjecture to repair cruxes. This page is entirely concerned with
techniques, old and new, for the first stage only.

And now for Lachmann's method, as it is often called:

1. Collate your manuscripts against some reference text that you hope is not
   too far from what the author wrote. Departures from the reference text are
   provisionally considered "errors." Shared readings are only considered
   evidence of provenance when they are errors.

2. Discard polygenetic errors, that is, those that may easily occur
   spontaneously across a tradition --- or may be easily corrected by a copyist
   --- and so are unlikely to carry information about provenance: "only
   monogenetic errors should be used as indicative errors"
   (@trovato2017everything, p. 56).

3. Take the pattern of indicative errors and use it to build a tree called a
   stemma. If B contains all the errors of A and adds some further errors
   ("separative errors") of its own, we conclude that B is a child of A. If A
   and B each contain separative errors not shared in common with any other
   manuscript but also conjunctive errors together against the rest of the
   manuscripts, posit a parent for both that is the source of the conjunctive
   errors. Add more manuscripts to the tree in the same way.

The resulting stemma, if it can be reconstructed with confidence, provides the
basis for an edition of the text. A stemma can cut through a great deal of
noise and focus attention on the essential choices between variants.

This first step of editorial practice (*redactio*) along with subsequent
refinements is also sometimes called neo-Lachmannian stemmatology. An
alternative to this is the so-called "best manuscript" method championed by
Bédier, which selects a "best manuscript" as the basis for a text and departs
from it only when absolutely necessary.

We call the root of the stemma the archetype, and usually designate it with a
ω. Reconstructed nodes are often called hyparchetypes and represented by Greek
letters. Consider the following stemma, which follows these conventions:

![](/media/extra_manuscripts.png)

And suppose that we observe a number of variants at a particular location in
the text, where for convenience each variant is assigned a number:

| Manuscript | Variant |
|:----------:|:-------:|
| A          | 1       |
| B          | 2       |
| C          | 2       |
| D          | 3       |
| E          | 4       |
| F          | 4       |

Without a stemma, an editor has to consider 4 possible variants at this
location. But the stemma suggests that D, E, and F can be discarded as
witnesses. For they are copies relying entirely on C, whose readings we already
possess. We may confine our attention, then, to a simplified stemma:

![](/media/simple_bifurcation.png)

Now our attention is restricted to a subset of variants:

| Manuscript | Variant |
|:----------:|:-------:|
| A          | 1       |
| B          | 2       |
| C          | 2       |


Variant 2 is represented in twice the number of manuscripts as variant 1. No
matter. Both variants have an equal probability (as far as the stemma is
concerned) of being in the archetype of the stemma. The editor must now choose.
The stemma can say no more.

Now consider a trifurcating tradition:

![](/media/simple_trifurcation.png)

and the following table of variants for a particular location:

| Manuscript | Variant |
|:----------:|:-------:|
| A          | 1       |
| B          | 2       |
| α          | 2       |

We must suppose that our archetype, ω, contained variant 2 and that it is A
which is in error. Otherwise we must suppose that a monogenetic variants occurs
twice by coincidence.

A stemma may in many cases therefore reduce the number of variants that need to
be carefully considered by an editor. Later, it eases the burden on readers,
since far fewer variants need to be reported in the apparatus of the text.

It is important to remember that even the most impeccably grounded stemma is a
representation of the logical relationships between the surviving manuscripts,
not a claim about the specific details of actual historical transmission.
Single lines may connect two manuscripts to a hypothesized "parent" manuscript,
but this does not imply any confidence about the number of steps between those
manuscripts and the parents.

To review:

**A stemma allows us to reduce the number of witnesses to the text that need
to be considered.**: Wherever a manuscript is found to depend on another it may
be discarded.

**The number of manuscripts that contain a given reading is irrelevant**: What
matters is the logical relationship between the witnesses, more specifically,
which ones provide independent testimony about the archetype.

**The value of a witness is determined solely by the stemma**: There is the
value a manuscript has at auction and the value it has for an editor. The
former has to do with age and provenance and beauty and chains of ownership and
so on.[^ms_value] The latter is solely a function of what other witnesses have survived
and how they are related. If I copy the original of a tradition and then lose
the original, my copy will fetch nothing at auction (my handwriting is a
disgrace, my paper cheap) but it is a witness to the original that is
independent of every other, and this makes is extremely valuable. This is true
even if my copy is sloppy, since the errors I make will be different from those
made in other lines of descent and I will likely preserve readings lost in
other parts of the tradition. A copy of my copy is of no value --- we already
have the first copy. If that first copy is lost, my copy of that copy is
suddenly promoted in worth as a witness.

**The number of errors in a manuscript is irrelevant to its value as a
witness**: Of course a large omission in a manuscript will prevent it from
weighing in on affected passages but in general an error-ridden manuscript may,
in virtue of its place in the stemma, offer readings independent of other
witnesses and so have great value.

**Recentiores non deteriores**: That is, more recent manuscripts are not worse.
Another way of putting all this is that the *age* of a manuscript is irrelevant
to its value as a witness. Now, it may well turn out in practice that older
manuscripts offer a more direct route to the archetype than later ones, or that
later manuscripts will turn out to be copied from some older and still
surviving manuscript, and so can be eliminated from a stemma. Nevertheless, the
veneration of old manuscripts at the outset of an investigation in textual
criticism is the confusion of auction value with editorial value.[^recentiores]

If this rather abstract argument grounded in stemmatatological reasoning fails
to convince, see @browning1960recentiores for helpful discussion of evidence
from paleography and indirect testimony about Byzantine and medieval copying
practices. He collects a number of examples in which later manuscripts preserve
now lost readings from sources which were clearly independent of all other
surviving witnesses, and concludes that "[w]hat emerges from the above examples
is that it was not an exception for a thirteenth or fourteenth century scholar
to have access to early tradition, it was the rule" (p. 18). Note finally that
it is not just manuscripts that fall under this principle:
@reeve1982manuscripts argues that early editions should be considered witnesses
to the textual tradition as well. And see @reynolds2013scribes, 218 for further
examples and discussion.

Now consider several common complaints about Lachmann's method:

**Circularity**: We assume we know what the errors are and then use them to
build a tool which will aid us in distinguishing between good and bad readings
(that is, errors!).

**Scalability**: A complicated tradition for even a medium sized text contains
an enormous quantity of information in the form of variants and metadata about
those variants. Scholars have groaned and sometimes collapsed under the weight.

**Bédier's Paradox of Trifurcation**: The Bédier mentioned above noticed a
century ago that very few published stemmas contain trifurcations let alone
higher order splits. They consist almost exclusively of bifurcations. Why?
There seems to be no rational explanation for this, since manuscripts were
surely copied multiple times from the same exemplar.

For Bédier the phenomenon suggests that stemmas are figments of the
imagination, rather than rational reconstructions. A bifurcation allows an
editor an irresistable degree of freedom in the construction of a text, since
the stemma itself can't determine the correct reading. A higher order split by
contrast ties an editor's hands because the reading of the archetype can usually
be inferred.

Besides wishful thinking, Bédier also thought that the technique itself has a
methodological bias in favour of bifurcation. (I will say more about this in a
later revision.) His influence loomed large over the development of 20th
Century textual criticism and is still felt, especially in French scholarship.

**Contamination**: The method as stated above assumes that the manuscripts are
copied from single exemplars. But the reality is more complicated, indeed far
more complicated. As a friend remarked to me recently some medieval manuscripts
are more like critical editions themselves and they represent a lot of work not
just in copying but in collating other witnesses to the text. These collations
are often noted in the margin or above the line and when these manuscripts were
themselves copied scribes were at liberty to choose between readings. Past a
certain point it's not clear that Lachmann's method can determine a workable
stemma.[^contamination]

One response to the concern about circularity is to affirm that there are
clearly monogenetic errors and that in sufficient quantity they can be used to
reconstruct a stemma that can then be useful in determining between harder
cases. The long and often implausibly successful story of philology provides
some support for this.

I will have more to say about the issue of scalability below.

Bédier's Paradox of Trifurcation was apparently a spur to @pasquali1952storia
as well as to @timpanaro2005genesis (see, especially his Appendix C, where he
wrestles at length with this problem), and @trovato2017everything credits
Bédier with stimulating much of the development of 20th Century stemmatology in
reaction to his criticisms.

@trovato2017everything features a long and interesting discussion of Bédier's
Paradox of Trifurcation. There is the point stressed by Timpanaro that it can
be difficult in practice to distinguish between bifurcation with contamination
and trifurcation. But I think Timpanaro sensed that this was only a partial
explanation for the phenomenon. The best response to the problem is rooted in
work that realistically simulates manuscript reproduction and survival. For
this, see especially @Weitzman1987. Assuming realistic rates of manuscript loss
(discussed carefully and with examples by @trovato2017everything), most stemmas
will consist of bifurcations only. Contra Bédier, the preponderance of stemmas
featuring bifurcation can be explained by the way that radical loss shapes a
tradition, and not by the wishful thinking of scholars.

Contamination presents the most serious challenge to any stemmatological
method, traditional or computational. Maas's famous pronouncement "Gegen die
Kontamination ist kein Kraut gewachsen" ("No remedy has been developed against
contamination") is often quoted in discussions of the subject.[^noch]


## The Mathematics of Stemmas

@Buneman1971, an early paper on the mathematics of manuscript descent, was
also important in the development of modern phylogenetics. A trio of papers by
Colin Flight, @flight1990many, @flight1992stemmatic, @flight1994complete, works
out theoretical problems with stemmas and contamination.


# Computational Stemmatology

The field of computational/mathematical stemmatology has flourished in recent
years, motivated especially by the concerns about circularity and scalability
noted above.

## Biologically-based and Traditional Computational Stemmatology

The parallels between problems presented by manuscripts and their descent and
by biological sequences (nucleotides and proteins) and their evolution are
striking. Not only is there error introduced by copying in both cases, but the
phenomenon of contamination has an analogue in gene transfer. See
@howe2004parallels for a useful discussion of parallels between phylogenetics
and stemmatology.

@trovato2017everything usefully distinguishes between computational approaches
that aim to automate the more labourious aspects of Lachmann's method and those
that aim to apply biological software to the problem. It is very clear that the
*dominant* approach to computational stemmatology is biologically-inspired. He
cites @salemans2000building (which I have not yet read) as an excellent example
of the former approach. He is highly critical of the latter, dominant,
approach.

An important early spur to the development of the field was a challenge issued
in 1991, which is reviewed in @robinson1992report.

In a future revision of this essay I will have much more to say about specific
tools and approaches.

# The Use of Artificial Traditions

A sensible first step in the development of algorithms and techniques for
handling manuscript traditions is probably to generate artificial traditions to
various specifications so that we can observe how well different techniques
fare under different conditions (e.g., levels of contamination, mss loss,
etc.).

This is not an original idea. A friend informs me that Pasquali mentions that
Kantorowicz had the idea in 1912: "He asked a batch of his students to make
copies of a Latin document, and his task was to edit it properly; his
conclusion was to stress how fallible this process is." The idea has been
carried forward in more recent work, including @spencer2004phylogenetics,
@baret2006testing, @roos2009evaluating.

# Other Work

This essay is a draft-in-progress and what follows is a mostly unstructured
dump of readings, many of which I haven't gotten to you.

A trove of interesting papers can be found in @van2004studies. These include,
but are not limited to @howe2004parallels, @mink2004problems,
@schmid2004genealogy, @wattel2004constructing, @spencer2004effects.

I list the remaining papers in this category in chronological order:

> @silva1969identification

> @o1993computer

> @gjessing1994stochastic

> @schmid2004genealogy

> @eagleton2006copying

> @andrews2009prolegomena

A number of resources for textual criticism are online:

> [http://www.textualscholarship.org/](http://www.textualscholarship.org/]
> (the source of some of the references on this page).

> [Interedition](http://www.interedition.eu/)

> [Centre for Manuscript Genetics](https://www.uantwerp.be/en/rg/centre-for-manuscript-genetics/)

> [European Society for Textual Scholarship](http://www.textualscholarship.eu/)


I list the remaining items in this category in chronological order:

> @silva1969identification

> @o1993computer

> @gjessing1994stochastic

> @robinson1996cladistic

> @salemans2000building

> @mooney2001stemmatic

> @spencer2002greek

> @spencer2003reliable

> @howe2004parallels

> @mink2004problems

> @robinson2004making

> @schmid2004genealogy

> @spencer2004effects

> @spencer2004article

> @spencer2004representing

> @robins2007editing

> @windram2008dante

> @andrews2009prolegomena

> @schmidt2009data

> @schmidt2009merging

> @dekker2011computer

> @roos2011analysis

> @andrews2012analyzing

> @howe2012responding

> @andrews2013beyond

> @nassourou2013computer

> @hoenen2015simulating

> @hoenenlachmannian

# Tools

Manuscripts often contain information that is both genealogically relevant and
tricky to capture. The [Text Encoding Initiative](https://tei-c.org/) attempts
to standardize the many issues that arise in trying to manage multiple copies
of a text.

The [Interedition Github page](https://github.com/interedition) contains a
number of repositories for projects dealing with textual criticism, including
especially the [collatex](https://github.com/interedition/collatex) project.

[Juxta](http://www.juxtasoftware.org/) "is an open-source tool for comparing
and collating multiple witnesses to a single textual work." Its source is
available on github
([desktop](https://github.com/performant-software/juxta-desktop), [web
service](https://github.com/performant-software/juxta-service)). This is one
offering of several from [Performant](https://www.performantsoftware.com/),
which specializes in software for the humanities.

<!-- TODO: Look at bookmarks and pinboard -->

The upshot of all this: I think it's absolutely worth making low-effort
experiments with biological software, as a check on our results. But what I'd
prefer to focus on computationally is developing a tool that allows us to
automate the tedious parts of traditional Lachmanian stemmatology. It should
support queries and outputs relevant to this task. E.g.,


Build a stemma using separative and conjunctive monogetic variants Given a
proposed stemma, print out all counterevidence to that stemma (that is, list
all conjunctive monogenetic variants that don't fit the stemma and so suggest a
bad stemma or contamination). Allow repeating the above while easily altering
(perhaps in another column of the spreadsheet?) the base text, and so
assumptions about which readings are in error. Identify all cases when
counterevidence to the stemma would in fact support the stemma if we altered a
reading in the base text. Allow all the above while excluding manuscripts so
that we can quickly experiment with subsets of the tradition. Allow us to build
a stemma with a subset of manuscripts and then add manuscripts one by one in a
specified order. Give us complete visibility into the process and data
supporting any particular conclusion Allow error checking of variants and
reporting List all the editorial choices left open by a given stemma

A command line tool (that is, one you run from a terminal and not a graphical user interface) to do this would be manageable I think. A richer interface on a website seems to me like a lot more work, but then it's been a long time since I built a website. Perhaps Nick will disagree about how much more work a richer interface would be.

Requirements for the suggested command line tool:
A column in the spreadsheet for departures from our base text (Bekker's edition)
A way (another column?) of distinguishing in our spreadsheet between monogenetic and polygenetic variants



# Phylogenetics

A rather mathematically demanding introduction to Phylogenetics is:

> @semple2003phylogenetics

An introduction to phylogenetics which succeeds in being less intimidating
without apparent sacrifice of mathematical rigour is:

> @huson2010phylogenetic

As the book's title suggests, its emphasis is on phylogenetic *networks* as
opposed to simply *trees*, which should make it of special interest of
stemmatologists.

And speaking of phylogenetic networks, don't miss [The Genealogical World of Phylogenetic Networks](http://phylonetworks.blogspot.com/), a blog that is chock full of references and interesting posts.

# Complete List of References


[^uchicago]: Most's translation of @timpanaro2005genesis is out of print and almost
impossible to buy on the secondary market. The University of Chicago Press
brought the volume out recently, in 2006, and yet I can't even find a reference
to it on the Press's website. No electronic edition has been made available to
the public by the press, and indeed perhaps doing so would undercut the
rationale for the high price of the original volume aimed at academic
libraries, without a thought to a cultured public. Depending on the vagaries of
fortune, the long term cultural survival of the volume may depend on an illegal
reproduction of the book that can sometimes be found on the internet. Does an
academic press exist to disseminate knowledge, even as a secondary goal?

[^noch]: As @kiss2016taking points out in his review of the first (2014)
edition of @trovato2017everything the prouncement itself has variants: the
sentence originally read "Gegen die Kontamination ist noch kein Kraut
gewachsen" ("No remedy has yet been developed against contamination"). Between
the second (1950) edition (on which Flower's translation was based) and third
(1957) edition, Maas had apparently grown a shade more pessimistic about the
problem.

[^ms_value]: It's worth adding that there is also the value a manuscript has in
teaching us about the intellectual history associated with its transmission.
[@reynolds2013scribes, 193] credits this point originally to Ludwig Traube
(1861-1907) and comment: "A manuscript which may be proved utterly useless as a
copy of the an author's text may none the less be of the greatest value in
another way, since if it can be assigned with certainty to its place of origin,
or better still, if the scribe of it can be identified with certainty, it will
tell us something about the intellectual history of the Middle Ages."

[^contamination]: @reynolds2013scribes, 293 caution that the intense focus
generated by the problem of contamination can distract from the larger picture:
"in many traditions the amount of contamination that has taken place is not
sufficient to prevent the useful application of stemmatic theory."

[^recentiores]: This was apparently understood even in the 16th Century. See
reynolds2013scribes, 295.
