---
title: Dynamically Constructing "Or" Queries with Django's ORM
date: 2009-12-06
---

A quick point for people who are already familiar with Django's ORM.

Suppose I have a model:

```python

class Entry(models.Model):
    title = models.CharField(max_length=50)
    text = models.TextField()
    tag = models.ManyToManyField(Tag)

```

and I want to query all the entries that have a particular tag.  This is easy:

```python

>>> entries = Entry.objects.filter(tag='good_times')

```

I can also encapsulate that filter using a Q object:

```python

>>> from django.db.models import Q
>>> q = Q(tag='good_times')
>>> good_times_entries = Entry.objects.filter(q)

```

(The documention on Q objects is <a href="http://docs.djangoproject.com/en/dev/topics/db/queries/#complex-lookups-with-q-objects">here</a>.  You can import Q directly from django.db.models (it is imported into that module's __init__.py), but the code for it, if case you want to take a look, actually lives in django.db.models.query_utils.)

Now suppose I want to construct a query using tags as filters, for some number of tags that won't be determined until runtime.

If I want to filter every entry that has the tag 'good_times' AND the tag 'bad_times' AND 'you_know_Ive_had_my_share', I don't even need a Q object (though I could use one).  I can use the <a href="http://docs.djangoproject.com/en/dev/ref/models/querysets/#in">"in" field lookup</a>:

```python

>>> taglist = ['good_times', 'bad_times', 'you_know_Ive_had_my_share']
>>> my_entries = Entry.objects.filter(tag__in=taglist)

```

This obviously doesn't require me to know in advance how many tags I'll be using.  So I can construct my list however I like (using user input, for example), and then use it in my query.

Recently I had the problem of needing to dynamically construct an "or" query.  I'm not sure if the following solution is the best one.  If there's something simpler, please let me know in the comments.  (The basic idea is due to some clever person on Stack Overflow, but I had trouble finding the answer in the first place, and now I can't find it again to give proper credit.)

In any case, this works:

```python

>>> taglist = ['good_times', 'bad_times', 'you_know_Ive_had_my_share']
>>> from django.db.models import Q
>>> q = Q()
>>> for tag_in_list in taglist:
            q |= Q(tag=tag_in_list)
>>> or_entry_query = Entry.objects.filter(q)

```

Voila!  This is the sort of thing that looks obvious to me once I see it.  The documentation on the Q object says "Q objects can be combined using the & and | operators. When an operator is used on two Q objects, it yields a new Q object."  It took a while for me to clue in to the fact that it would permit this too.
