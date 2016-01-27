# ExJournal

A simple journal written in Elixir used for learning purposes.

#Usage

just write:

```bash
$ exjournal "Hello World"
```

and a ~/.exjournal/[timestamp].txt will be created with your entry appended to that file.

You can view previuos entries with the following API:

```bash
$ exjournal --from today
$ exjournal --from yesterday
```
