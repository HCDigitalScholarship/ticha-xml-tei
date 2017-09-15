The files in this repository include representations in TEI of Colonial Zapotec Texts that are part of the [Ticha project](https://ds-omeka.haverford.edu/ticha/en/index.html).

# Using Git on windows

Before you can get started using Git, make sure you have it installed. Go to [the Git downloads page](https://git-scm.com/downloads) and download and run the installer for Windows. The default settings should work fine.

Once you have it installed, you need to clone the repo locally. It's probably easiest to do this from the command line, which might seem a little disorienting at first if you haven't used command line before, but is really pretty straightforward. To open command line on Windows, open the start menu and search for 'cmd' and you should find it.

In command line, you're always located at a particular folder, just like if you were looking through Windows' normal file exlorer interface. To see which folder you're currently in, just look at the prompt, which is just to the left of your cursor. Command typically opens to the root folder of your user, so your prompt will look something like C:\Users\conor> (except hopefully with your name, not mine.) You can't use your mouse for most things in command line, so moving around folders requires a few basic commands. 

To look at a list of files and folders inside your current folder, type 'dir' (for "directory") and hit enter. The command 'cd' ("change directory") moves you between folders. Typing 'cd..' and hitting enter will move you up one folder, and 'cd [folder name]' will move you to a specific folder inside your current one. 

Using these three commands, you should navigate to whatever place on your computer you'd like to keep ticha-xml-tei (i.e., your Documents folder.) Once there, you should be ready to start a Git repository. If Git commands aren't working, make sure that Git is added to your PATH directory. To set up the folder initially, just type 'git clone https://github.com/HCDigitalScholarship/ticha-xml-tei.git' and enter. That completely copies the repository from Github to your hard drive, and might take a minute. You only need to do this once - from now on, the only things you'll be taking from and giving to the central repository on Github are *changes*, which are smaller and more efficient to send, and also allow the version control system to combine files with changes to different parts.

To do anything else with Git, step inside the folder by entering 'cd ticha-xml-tei'. For examples, you can enter 'git fetch' to see any changes that have been pushed to Github without actually changing your local files, 'git status' to see the status of any changes you've made, and 'git pull' to update your local version to whatever the current version is on Github, by loading a set of specific changes. Pulling shouldn't overwrite changes you've already made locally unless you and someone else are editing the exact same part of the same file, and even then it will alert you and let you manage any merge conflicts, or just decide not to pull the conflicting changes.

You can edit files in a Git repository the same way you would edit any other file. For editing an XML document, you can use Windows' built-in text editor Notepad, but I recommend using software like [Atom](https://atom.io/) or [Sublime Text](https://www.sublimetext.com/), which are a little prettier and have the intelligence to do things like collapse sections you're not interested in looking at.

Adding your edits to the communal version requires three steps. First you stage any changed files to be committed by entering 'git add [file]', then combine your changes into a commit by entering 'git commit -m [description of your change]'. The reason for this two-step process is to allow you to group together sets of related changes into a commit that represents the completion of one coherent task. If you want to add all of your changes to the current commit, you can skip the adding step and just enter 'git commit -a -m [description of your change]'. Once you've put together a commit, you can push it to Github for everyone else to see and download by entering 'git push'.