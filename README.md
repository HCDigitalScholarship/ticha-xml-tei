# ticha-xml-tei

The files in this repository include representations in TEI of Colonial Zapotec Texts that are part of the [Ticha project](https://ds-omeka.haverford.edu/ticha/en/index.html).

## How to use Git

### Installing (on Windows)

Before you can get started using Git, make sure you have it installed. Go to [the Git downloads page](https://git-scm.com/downloads) and download and run the installer for Windows. The default settings should work fine.

### Cloning this repo & using the command line (on Windows)

Once you have it installed, you need to clone the repo locally. It's probably easiest to do this from the command line, which might seem a little disorienting at first if you haven't used command line before, but is really pretty straightforward. To open command line on Windows, open the start menu and search for 'cmd' and you should find it.

In command line, you're always located at a particular folder, just like if you were looking through Windows' normal file explorer interface. To see which folder you're currently in, just look at the prompt, which is just to the left of your cursor. Command typically opens to the root folder of your user, so your prompt will look something like `C:\Users\conor>` (except hopefully with your name, not mine.) You can't use your mouse for most things in command line, so moving around folders requires a few basic commands.

To look at a list of files and folders inside your current folder, type `dir` (for "directory") and hit enter. The command `cd` ("change directory") moves you between folders. Typing `cd ..` and hitting enter will move you up one folder, and `cd [folder name]` will move you to a specific folder inside your current one.

Using these three commands, you should navigate to whatever place on your computer you'd like to keep ticha-xml-tei (i.e., your Documents folder.) Once there, you should be ready to start a Git repository. If Git commands aren't working, make sure that Git is added to your PATH directory. To set up the folder initially, just type `git clone https://github.com/HCDigitalScholarship/ticha-xml-tei.git` and enter. That completely copies the repository from Github to your hard drive, and might take a minute. You only need to do this once - from now on, the only things you'll be taking from and giving to the central repository on Github are *changes*, which are smaller and more efficient to send, and also allow the version control system to combine files with changes to different parts.

### Pulling, committing, and pushing

To do anything else with Git, step inside the folder by entering `cd ticha-xml-tei`. For examples, you can enter `git fetch` to see any changes that have been pushed to Github without actually changing your local files, `git status` to see the status of any changes you've made, and `git pull` to update your local version to whatever the current version is on Github, by loading a set of specific changes. Pulling shouldn't overwrite changes you've already made locally unless you and someone else are editing the exact same part of the same file, and even then it will alert you and let you manage any merge conflicts, or just decide not to pull the conflicting changes.

You can edit files in a Git repository the same way you would edit any other file. For editing an XML document, you can use Windows' built-in text editor Notepad, but I recommend using software like [Atom](https://atom.io/) or [Sublime Text](https://www.sublimetext.com/), which are a little prettier and have the intelligence to do things like collapse sections you're not interested in looking at.

Adding your edits to the communal version requires three steps. First you stage any changed files to be committed by entering `git add [file]`, then combine your changes into a commit by entering `git commit -m [description of your change]`. The reason for this two-step process is to allow you to group together sets of related changes into a commit that represents the completion of one coherent task. If you want to add all of your changes to the current commit, you can skip the adding step and just enter `git commit -a -m [description of your change]`. Once you've put together a commit, you can push it to Github for everyone else to see and download by entering `git push`.

### Avoiding merge conflicts

If two people change and push the same part of a document, Git gets mad, and understandably so - how can it know whose work to overwrite? Hopefully we'll all be working on different parts of our transcription but it can still cause issues if your local version of the file is too old. To avoid potential conflicts altogether, you should pull as often as possible.

Specifically, I recommend pulling every time before you start working on encoding, pulling before you `git add` any changes, and pulling after committing but before pushing.

If you encounter "merge conflicts" that need to be resolved, be careful what you do next. You can ask someone familiar with Git for help and an explanation. Don't "force-push".

## Encoding guidelines

Here are a few TEI encodings you should know how to use:

### Line breaks

```xml
lengua para muchas cosas, y se junta ã muchas diccio
<lb/>
nes, y assi significa de muchas maneros: V.S. con los no
```

Line breaks cannot be encoded by simply hitting enter in your text editor, and have to be encoded with the line break tag `<lb/>`. Unlike most XML tags we'll use, the line break tag typically appears not as an opener and closer but as a single tag, with a slash at the end. Technically, any XML tag can be "self-closing" like this, implying that the tag has no content. Since line breaks can never have words inside them (what would that look like?) they're always written as self-closing, but this can be thought of as an abbreviation for `<lb></lb>`.

### Headings

Headings can be marked with the `<head>` tag. In general, headings should not appear on the same line as non-heading text.

There are two types of headings: outline and normal. Normal headings appear in the HTML output:

```xml
<head>2.a Conjugacion</head>
```

Outline headings appear only in the outline:
```xml
<head type="outline">3.2 [2.a Conjugacion]</head>
```

Usually both are seen together. This means that a heading in the HTML output will have a corresponding heading in the automatically-generated outline:

```xml
<head>2.a Conjugacion</head>
<head type="outline">2.a Conjugación</head>
<lb/>
La 2.a  Conjugacion solo tiene tres verbos irregulares
```

Outline headings should not contain choice tags. Their content should be the normalized text of the heading. Normal headings should contain choice tags that normalize text as appropriate.

```xml
<head type="outline">Quenta en Zaapoteco</head>
<head>
  <choice>
    <orig>Quenta</orig>
    <reg type="spanish">Cuenta</reg>
  </choice>
  en
  <choice>
    <orig>Zaapoteco</orig>
    <reg type="spanish">Zapoteco</reg>
  </choice>
</head>
```

This way, headings in the text have normalized and original versions available, and the automatically-generated outline appears in a normalized transcription.

### Foreign languages

```xml
Primeramente esta particula <foreign xml:lang="zap">Ca</foreign>, se usa de ella en esta
```

Foreign languages are marked with the `<foreign>` tag. This one is a little harder than the others, since it is likely to be the first tag you need which has "attributes."

The attribute we're interested in is the `xml:lang` attribute, which tells what foreign language the span of text is in. This seems a little weird for highly bilingual texts like many that we're working with, since we have to decide what the non-foreign language should be, but typically we'll choose a particular language to consider unmarked in each text, and mark everything else in foreign tags. For Zapotec, the attribute should be `xml:lang="zap"`, for Latin `xml:lang="lat"`, and for Spanish `xml:lang="esp"`.

Two important things to remember about foreign tags are that the foreign text should always go in between the foreign tags, never as an attribute, and that you only need to specify attributes in the opening tag, never the closing tag.

### Normalization

To make these texts more accessible, we can encode a modern Spanish version of the transcription using the `<choice>` tag. While viewing the text, someone can then choose to view the original transcription or the modernized transcription by clicking on the tabs directly above the transcription (https://ticha.haverford.edu/en/texts/levanto-arte/101/original/). Currently, the Levanto Arte has a modern Spanish normalization.

```xml
<choice><orig>Como</orig><reg type="spanish">¿Cómo</reg></choice>
```

### Nesting tags

In XML, you can have tags inside other tags, but only if the opening and closing of one tag are completely within the opening and closing of the higher tag. The range of tags can never overlap. For example,

```xml
<head>La Particula <foreign xml:lang="zap">Ca</foreign></head>
```

and

```xml
<foreign xml:lang="zap">Conna rinni, ni niartenni cocalo Bixooze (Xiñaa)
<lb/>
yohoto quella rirabaniza, cocalo rtijalaaya, laa</foreign>
```

are both fine, but never

```xml
<head>La Particula <foreign xml:lang="zap">Ca</head>
<lb/>
Conna rinni, ni niartenni cocalo Bixooze (Xiñaa)
<lb/>
yohoto quella rirabaniza, cocalo rtijalaaya, laa</foreign>
```

since the head and foreign tags overlap. To repair that, you'd have to do something like

```xml
<head>La Particula <foreign xml:lang="zap">Ca</foreign></head>
<lb/>
<foreign xml:lang="zap">Conna rinni, ni niartenni cocalo Bixooze (Xiñaa)
<lb/>
yohoto quella rirabaniza, cocalo rtijalaaya, laa</foreign>
```

Don't nest `<pb/>` tags inside `<choice>` tags.

## Standard XML style for Ticha documents

In XML, things like spaces and which type of quotes used don't matter. But to keep all our XML documents looking uniform, we use a standard style for all XML tags:

Use the green-highlighted formatting for XML tags, not the red ones. Note that there's no space after the `=`. Note the use of double-quotes (`"`), not single-quotes.

```diff
* Standard:
+ <tag attribute="value">
* Incorrect:
- <tag attribute= "value">
- <tag attribute = "value">
- <tag attribute='value'>
- <tag attribute= 'value'>
- <tag attribute = 'value'>
```

## Editor tools

Use [Atom](https://atom.io/) to edit TEI files. Atom is a "hackable" text editor which means we can install packages that allow it to help us edit TEI files more easily and with fewer mistakes.

### Snippets

Custom Ticha snippets in Atom can help type repetitive tags faster. [Read the `ticha-atom-snippets` documentation](https://github.com/qubist/ticha-atom-snippets) to learn about how snippets can help and how to install them in your Atom editor.

### Linting

"Linting" is checking a file to make sure it adheres to correct code format. For XML files like our TEI documents, this means checking that tags are matched with closing tags, among other things. Atom can lint your XML files as you edit them:

1. Install the [`linter-xmllint` package](https://atom.io/packages/linter-xmllint) in Atom
2. Allow Atom to automatically install any dependencies too
3. Open a .xml file and look for a group of three new icons in the bar at the bottom of the window.

These new icons count how many errors were detected in the file you have open. Click on them to pull up the Linter window. Click on each row to jump to the error, and read the description for a hint at how to solve it.

Note that sometimes the real line-number of the error is written in the description and the line-number in the "Line" column is wrong. You can scroll or use `control-G` to go to the correct line number.
