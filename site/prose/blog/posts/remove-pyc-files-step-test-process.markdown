---
title: Remove .pyc files as a step in the test process
date: 2009-12-09
---

I got burned the other day at work by a dangling .pyc file.  Although I had deleted the corresponding .py file, the tests failed to register that I was still importing it elsewhere because they were finding the .pyc file and running on their merry way.  We only found this because my boss and I were running the tests at the same time on different computers while chatting on IM, and he had properly deleted the .pyc file too.

Anyway, to prevent this from happening again I inserted this at the beginning of our test script:

```python

#Zap .pyc files so our tests aren't fooled if we delete a .py file
#and forget to delete the corresponding .pyc file.
for path, dirs, files in os.walk(os.path.dirname(__file__)):
    for f in os.listdir(path):
        if re.search('\.pyc$', f):
            fullpath = os.path.join(path, f)
            print "removing %s" % fullpath
            os.remove(fullpath)
```

(The test setup script in this case is in the top level directory.  Obviously you'll want to adapt the directory that os.walk works on to your own circumstances.)

This seems a sensible thing to do---so sensible, in fact, that I'm wondering why it's not a standard practice to zap .pyc files before running your tests.  (It only adds a tenth of a second at most to the process.)  If I'm missing something, and especially if there's some good reason <em>not</em> to do this, please let me know in the comments, and I'll update (or, in the case of maximum embarrassment, delete) the post.

UPDATE: Oh, I just noticed the django-command-extensions has a <a href="http://github.com/django-extensions/django-extensions/blob/master/django_extensions/management/commands/clean_pyc.py">clean_pyc command</a>.  The code is nicer than what I have above too.  Here's the relevant bit:

```python

def handle_noargs(self, **options):
    project_root = options.get("path", None)
    if not project_root:
        project_root = get_project_root()
    exts = options.get("optimize", False) and [".pyc", ".pyo"] or [".pyc"]
    verbose = int(options.get("verbosity", 1)) > 1

    for root, dirs, files in os.walk(project_root):
        for file in files:
            ext = os.path.splitext(file)[1]
            if ext in exts:
                full_path = _j(root, file)
                if verbose:
                    print full_path
                os.remove(full_path)
```

(The _j is just os.path.join.)
