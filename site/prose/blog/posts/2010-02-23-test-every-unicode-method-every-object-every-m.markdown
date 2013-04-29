---
title: Test every unicode method on every object for every model
---

I'm working on a relatively new Django-based website now as a personal project.  It'll be an open source project that I hope to interest others in, so I'm keen to get certain things right.  One of my goals is 100% test coverage for the project.  When I first started programming, I couldn't see the point of this.  Suffice it to say, I've since learned my lesson.

Take the following extremely simple model:

```python

class Post(models.Model):
    title = models.CharField(max_length=100)
    subtitle = models.CharField(max_length=100, null=True, blank=True)
    body = models.TextField()

    def __unicode__(self):
        return self.title
```

It wasn't immediately clear when I started, for example, why I would bother to test the `__unicode__` method on a model.  But then, as if to mock my hubris, the programming gods tricked me <em>several thousand times</em> into changing the name of the field referenced in a `__unicode__` method without remembering to change it in the `__unicode__` method itself.  And this wouldn't show up until the admin would crash or something equally irritating.  Or I would decide to make the `__unicode__` method slightly more complicated:

```python

def __unicode__(self):
    if self.subtitle:
        return "%s: %s" % (self.title, self.subtitle)
    return self.title
```

thereby multiplying the possibilities for stupid, annoying little errors that would sometimes escape my notice until later on.  Of course this happens most in the early stages of a project (when you're least likely to have tests), but errors like this can creep in later on too.

So, it's a nice idea to make sure that you test every `__unicode__` method---even the simplest kind---by at least <em>calling</em> it for every model on a number of objects in your database.  Luckily, this doesn't need to be done manually for every model.  Django's super-awesome powers of introspection allow us to easily iterate over every object for every model in our entire project.  Here's the test method I use to do that.

```python

from django.db.models.loading import cache
from django.test import TestCase


no_unicode_method = ['Session', 'LogEntry']


class TestUnicodeMethods(TestCase):
    """Sanity check on unicode methods.  You catch a surprising number
    of errors (especially in the early stages of development) just by
    calling the unicode method on every object for every model."""
    for model in cache.get_models():
        meta = model._meta
        if meta.object_name not in no_unicode_method:
            objs = model.objects.all()
            for obj in objs:
                `obj.__unicode__()`
```

Obviously, if you have some fancy-schmancy `__unicode__` method, you'll want to give it a proper test of its own.  But this single test can be helpful, especially when you're getting your project off the ground.

UPDATE: Now that I think about it, I hope I haven't given the impression that this is a substitute for a proper test, which would actually compare the <em>result</em> of calling the method with an expected result.  All this does is test that you <em>can</em> call it.  So perhaps it makes sense to say that this <em>exercises</em> your code a bit.  I'm thinking about writing a few more general tests that exercise your code in this way (say, by using the test client to visit every page on your admin, as a way of making sure that the fields in your models.py and admin.py files don't conflict) and bundling it up together in an app.  Hmmm, django-calisthenics, perhaps?
