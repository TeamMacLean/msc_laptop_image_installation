---
title: "Msc laptop image installation"
author: "Ram Krishna Shrestha"
date: "05/07/2021"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## WSL, Ubuntu and miniconda3 installation

I have documented wsl, ubuntu and miniconda3 installation separately in the github repo: https://github.com/TeamMacLean/conda_on_ubuntu_wsl

Please follow the steps in the repo to install them all. 

## Data carpentry option B setup

Tools required for data carpentry can all be installed using conda. Conda is available after you follow the step from github repo above.

In Windows, start/Launch Ubuntu. This will open up ubuntu in command mode in terminal app. In the terminal, the prompt will show your username@machinename.

To install the tools using conda, the command is

```
conda install --yes fastqc trimmomatic bwa samtools bcftools igv
```
At the end of the installation, you should see the message:
```
Preparing transaction: done
Verifying transaction: done
Executing transaction: done
```

To test if each tools is installed successfully, let's use the command below:
```
$ which fastqc 
$ fastqc --version
$ which trimmomatic
$ trimmomatic -version
$ which bwa
$ bwa 
$ which samtools
$ samtools
$ which bcftools
$ bcftools --help
$ which igv
$ igv --version
```

Each command will show the path to the executable tool. If a path is not shown, the tool has not been installed.

igv requires graphics but since we are using ubuntu in command prompt mode only, we get error as below when trying to run igv.

```
shrestha@N114156:~$ igv
Using system JDK.
WARNING: package com.sun.java.swing.plaf.windows not in java.desktop
WARNING: package sun.awt.windows not in java.desktop
openjdk version "11.0.9.1-internal" 2020-11-04
OpenJDK Runtime Environment (build 11.0.9.1-internal+0-adhoc..src)
OpenJDK 64-Bit Server VM (build 11.0.9.1-internal+0-adhoc..src, mixed mode)
INFO [2021-07-05T23:32:26,965]  [DirectoryManager.java:180] [main]  IGV Directory: /home/shrestha/igv
INFO [2021-07-05T23:32:27,879]  [Main.java:206] [AWT-EventQueue-0]  Startup  IGV Version user not_set
INFO [2021-07-05T23:32:27,895]  [Main.java:207] [AWT-EventQueue-0]  Java 11.0.9.1-internal (build 11.0.9.1-internal+0-adhoc..src) 2020-11-04
INFO [2021-07-05T23:32:27,896]  [Main.java:210] [AWT-EventQueue-0]  Java Vendor: Oracle Corporation https://openjdk.java.net/
INFO [2021-07-05T23:32:27,897]  [Main.java:212] [AWT-EventQueue-0]  JVM: OpenJDK 64-Bit Server VM
INFO [2021-07-05T23:32:27,952]  [Main.java:215] [AWT-EventQueue-0]  Default User Directory: /home/shrestha
INFO [2021-07-05T23:32:27,953]  [Main.java:216] [AWT-EventQueue-0]  OS: Linux 5.4.72-microsoft-standard-WSL2 amd64
ERROR [2021-07-05T23:32:27,960]  [DefaultExceptionHandler.java:49] [AWT-EventQueue-0]  Unhandled exception
java.awt.HeadlessException:
No X11 DISPLAY variable was set, but this program performed an operation which requires it.
        at java.awt.GraphicsEnvironment.checkHeadless(GraphicsEnvironment.java:208) ~[?:?]
        at java.awt.Window.<init>(Window.java:548) ~[?:?]
        at java.awt.Frame.<init>(Frame.java:423) ~[?:?]
        at java.awt.Frame.<init>(Frame.java:388) ~[?:?]
        at javax.swing.JFrame.<init>(JFrame.java:180) ~[?:?]
        at org.broad.igv.ui.Main.lambda$main$0(Main.java:115) ~[igv.jar:?]
        at java.awt.event.InvocationEvent.dispatch(InvocationEvent.java:313) ~[?:?]
        at java.awt.EventQueue.dispatchEventImpl(EventQueue.java:770) ~[?:?]
        at java.awt.EventQueue$4.run(EventQueue.java:721) ~[?:?]
        at java.awt.EventQueue$4.run(EventQueue.java:715) ~[?:?]
        at java.security.AccessController.doPrivileged(Native Method) ~[?:?]
        at java.security.ProtectionDomain$JavaSecurityAccessImpl.doIntersectionPrivilege(ProtectionDomain.java:85) ~[?:?]
        at java.awt.EventQueue.dispatchEvent(EventQueue.java:740) ~[?:?]
        at java.awt.EventDispatchThread.pumpOneEventForFilters(EventDispatchThread.java:203) [?:?]
        at java.awt.EventDispatchThread.pumpEventsForFilter(EventDispatchThread.java:124) [?:?]
        at java.awt.EventDispatchThread.pumpEventsForHierarchy(EventDispatchThread.java:113) [?:?]
        at java.awt.EventDispatchThread.pumpEvents(EventDispatchThread.java:109) [?:?]
        at java.awt.EventDispatchThread.pumpEvents(EventDispatchThread.java:101) [?:?]
        at java.awt.EventDispatchThread.run(EventDispatchThread.java:90) [?:?]
INFO [2021-07-05T23:32:28,981]  [ShutdownThread.java:47] [Thread-1]  Shutting down
               
```

## Database course tools

```
$ conda install --yes sra-tools spades prokka kallisto
$ conda install -c bioconda -c conda-forge busco=5.2.1
```

To test the tools installation, let's use the command below:
```
$ which prefetch     # prefetch is a part of sra-tools package
$ which spades.py
$ which prokka
$ which busco
$ which kallisto
```

Again, each command should show the paths to the tools, if they are installed successfully.

However, when I try to check busco version, busco runs to error "no module named busco"

```
$ busco --version

No module named 'busco'
There was a problem installing BUSCO or importing one of its dependencies. See the user guide and the GitLab issue board (https://gitlab.com/ezlab/busco/issues) if you need further assistance.
```

To get around this issue, I added the python site-packages path to environment variable PYTHONPATH.

```
$ export PYTHONPATH=~/miniconda/lib/python3.8/site-packages
$ busco --version
BUSCO 5.2.1
```

## Installing R v4.1

R v3.6.3 was already present as a dependency while installing other tools above. To install R v4.1, I did

```
$ R --version
R version 3.6.3
$ conda install --yes R=4.1
$ R --version
R version 4.1.0
```

## Instaling Rstudio

Can't install Rstudio in ubuntu inside windows 10 as ubuntu is command mode only.
