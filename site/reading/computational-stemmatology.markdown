---
title: Readings in Computational Stemmatology
date: 2014-01-01
biblio: files.bib
csl: the-journal-of-hellenic-studies.csl
---

# Introduction

What follows is a to-do list in the form of a (thin, unsatisfying, much too
English-language-oriented) bibliographical essay. Watch this space: the essay
may, circumstances permitting, grow over time as I collect references and
record brief remarks on a few of them. I have a lot to add and it will take
time to dump my private list of resources into something worthwhile, still
longer to find more resources, and even longer still to say anything sensible
about them. Eventually---again, circumstances permitting---this page may be
of use to someone other than me.

If you're impatient for an excellent, recent, and far more comprehensive (and
more richly multilingual) bibliography, I recommend [@trovato2017everything].
Most's bibliographical supplements to his translation of @timpanaro2005genesis
also contain much helpful recent material.

You can find all the references on this page collected at the bottom of this
page. You can find my complete bibtex file
[here](https://raw.githubusercontent.com/christopheryoung/chrisyoung/master/site/biblio/files.bib).

A full history of edits to this page can be found
[here](https://github.com/christopheryoung/chrisyoung/commits/master/site/reading/computational-stemmatology.markdown).

If you see an especially glaring error or omission, please feel free to let me
know at chris@chrisyoung.net.

# Textual Criticism and Stemmatology

An accessible and engaging (non-technical) introduction to the whole world of
textual criticism (and more) can be found in @reynolds1974scribes.

Lachmann, working in the second half of the 19th Century is associated with a
leap forward in rigour in the establishment of classical texts. Lachmann's
contribution has been famously reviewed in the @timpanaro2005genesis, whose
recent translation from the Italian we owe to Glenn Most. Timpanaro traces the
development of the method now associated with Lachmann's name. One irony:
Lachmann is neither the first to develop the method now associated with his
name nor does his work provide good example of the method in practice.

(Most's translation of @timpanaro2005genesis is out of print and almost
impossible to buy on the secondary market. The University of Chicago Press
brought the volume out recently, in 2006, and yet I can't even find a reference
to it on the Press's website. No electronic edition has been made available to
the public by the press, and indeed perhaps doing so would undercut the
rationale for the high price of the original volume aimed at academic
libraries, without a thought to a cultured public. Depending on the vagaries of
fortune, the long term cultural survival of the volume may depend on an illegal
reproduction of the book that can sometimes be found on the internet. Does an
academic press exist to disseminate knowledge, even as a secondary goal?)

Introductions to the practice of textual criticism include @maas1958textual and
@west1973textual. Other notable early work includes @housman1921application
which is a frontal attack on the mechanical aspects of Lachmann's method. The
other notable early attack on Lachmann is due to @bedier1970tradition.

Introductions to the practice of textual criticism include @maas1958textual and
@west1973textual. Both books are starting to show their age, the Maas in
particular. But both are worth reading, including the Maas, which is a little
gem of a book summing up the hard won insights of a true master. The West has a
deeper discussion of the phenomenon of contamination, if I recall, and is a
great read too.

A superb introduction to most of the topics discussed on this page, including
both traditional Lachmannian stemmatology and computational stemmatology, is
@trovato2017everything. Trovato gives a spirited, lucid defence of
neo-Lachmannian stemmatology and offers some skeptical remarks about
(biologically oriented) computational approaches to textual criticism. If you
have any interest in the field, you should read this book.

A fairly recent contribution to the history of textual criticism (focusing on
New Testament textual criticism) and biology is @lin2016erotic (see [this
review](http://bmcr.brynmawr.edu/2016/2016-10-25.html) for a bit more).

And I recently picked up this odd-sounding book, but haven't gotten around to
it yet @timpanaro1976freudian.


# Computational Stemmatology

The field of computational/mathematical stemmatology has flourished in recent
years. @Buneman1971 is an early paper on the mathematics of manuscript descent
was also important in the development of modern phylogenetics.

A trio of papers by Flight in the early 1990s outlines his own approach:
@flight1990many, @flight1992stemmatic, @flight1994complete.

This work seems to have been mostly ignored in subsequent work on the subject.
To do: check if this is the right attitude.

An important early spur to the development of the field was a challenge issued
in 1991, which is reviewed in @robinson1992report.

A sensible first step in the development of algorithms and techniques for
handling manuscript traditions is probably to generate artificial traditions to
various specifications so that we can observe how well the techniques fare
under different conditions (e.g., levels of contamination, mss loss, etc.).

This is not an original idea. A friend informs me that Pasquali mentions that
Kantorowicz had the idea in 1912: "He asked a batch of his students to make
copies of a Latin document, and his task was to edit it properly; his
conclusion was to stress how fallible this process is." The idea has been
carried forward in more recent work, including @spencer2004phylogenetics,
@baret2006testing, @roos2009evaluating.

A trove of interesting papers can be found in @van2004studies. These include,
but are not limited to @howe2004parallels, @mink2004problems,
@schmid2004genealogy, @wattel2004constructing, @spencer2004effects.

I list the remaining papers in this category in chronological order:

> @silva1969identification

> @o1993computer

> @gjessing1994stochastic

> @salemans2000building

> @howe2004parallels

> @mink2004problems

> @schmid2004genealogy

> @spencer2004effects

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

> @bourdaillet2007practical

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

> @Hoenen:2015

> @hoenen2015simulating

> @hoenenlachmannian

# Tools

Manuscripts often contain information that is both genealogically relevant and
tricky to capture. A few works that address this side of the problem:

> @maddison1997nexus

The [Text Encoding Initiative](https://tei-c.org/) attempts to standardize the
many issues that arise in trying to manage multiple copies of a text.

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

A random selection of papers I've come across follows, to be structured and commented on
later:

> @bandelt1992split

> @huson1999disk

> @strimmer1997likelihood

> @hagedorn2000determining

> @billera2001geometry

> @bastert2002landscapes

> @gascuel2005mathematics

> @vogtmann2007geodesics

> @paten2013unifying

> @huson2006application


# Complete List of References
