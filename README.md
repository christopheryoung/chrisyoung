Hakyll-powered static site generator for <a href="http://chrisyoung.net">chrisyoung.net</a>.

To create the executable: stack build && stack install chrisyoung

To work on the site: ./build

To deploy: ./deploy

## Hover translations

Foreign language text can show an English translation on hover using
Pandoc's bracketed span syntax:

```markdown
[une crise touche les études classiques]{.translation title="a crisis afflicts classical studies"}
```

This renders as a `<span>` with a dotted underline. Hovering shows the
translation in a tooltip above the text. The feature degrades gracefully
in RSS readers and on mobile (the foreign text appears inline with no
tooltip).
