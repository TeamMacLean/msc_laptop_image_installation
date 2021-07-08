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

Please follow the steps in the repo to install them all. You will also install Ubuntu in the process.

## Data carpentry option B setup

Tools required for data carpentry can all be installed using conda. Conda is available after you follow the step from github repo above.

In Windows, click the search icon (looks like magnifying glass) and type **ubuntu** to start searching. Ubuntu will appear in the list and click it to start/Launch Ubuntu. This will open up ubuntu in command mode in terminal app. In the terminal, the prompt will show as **(base) username@machinename**. It is ready to accept the commands. The **(base)** here is a conda environment named **base** which conda created by default and selected by default.

We will now install following tools using conda
1) fastqc
2) trimmomatic
3) bwa
4) samtools
5) bcftools

To install the tools using conda, the command is

```
conda install --yes fastqc trimmomatic bwa samtools bcftools
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
$ which trimmomatic
$ which bwa
$ which samtools
$ which bcftools
```

The commands will print the paths to the executable tool. If a path is not shown, the tool has not been installed.

## Installing IGV

IGV is a graphical genome browser application. Since ubuntu that we have is only command mode, we can't run igv in ubuntu. So, we will install igv in windows.

Go to the [IGV website](https://software.broadinstitute.org/software/igv/download) and download IGV for windows (with Java included). Double click the downloaded file to install it.

## Database course tools

```
$ conda install --yes sra-tools spades prokka kallisto
```

To test the tools installation, let's use the command below:
```
$ which prefetch     # prefetch is a part of sra-tools package
$ which spades.py
$ which prokka
$ which kallisto
```

Again, each command should show the paths to the tools, if they are installed successfully.

Busco can be installed with the command
```
$ conda install --yes -c bioconda -c conda-forge busco=5.2.1
```
This command takes longer time to install than other tools mentioned above. You will see the lines printed like
```
Solving environment: failed with initial frozen solve. Retrying with flexible solve
Solving enrironment: failed with repodata from current_repodata.json, will retry with next repodata source.
```
This is fine and do not worry. It is taking time as there are many dependencies.

Let's check the installation of busco with the command
```
$ which busco
$ busco --version
$ busco --help
```

It should display the busco path, the version and the help message.

## Installing R v4.1 and Rstudio

We will install R and Rstudio in windows. Rstudio is graphical application so can't be installed in the ubuntu with commandline mode only here.

Click to download [R v4.1.0](https://cran.r-project.org/bin/windows/base/R-4.1.0-win.exe) and double click it to install it. Follow the installation step by accepting license and clicking **Next** buttons and finally click **Finish**.

Click to download a free version of [RStudio from here](https://download1.rstudio.org/desktop/windows/RStudio-1.4.1717.exe) and double click the downloaded file to install it. As before, follow the installation step.

Once R v4.1 and Rstudio are installed, you should see them listed when you click the windows icon at the lower left corner or if you type **R x64 4.1.0** to search and find R. Similary, type  **Rstudio** to search and find Rstudio.


## Installing R packages

Click the search icon and type Rstudio. Rstudio will be listed. At the right side, select **Run as administrator** from the list. Rstudio will open up and you will see R console at the left side of Rstudio.

We will now install R packages from this R console. I have listed out names of packages in the following files:

```
C:/Users/shrestha/Downloads/list_of_packages_in_cran.txt
C:/Users/shrestha/Downloads/list_of_packages_in_github.txt
```

Let's check the default path where the libraries will be installed with the command

```
.libPaths()
```

So it listed,
```
[1] "C:/Users/shrestha/Documents/R/win-library/4.1"
[2] "C:/Program Files/R/R-4.1.0/library"
```

The first path is specific to the users. We want to install in the second path, which is the global path.

Now, use the **for loop** in R code below to read the list of packages one by one and install them and their dependencies in global library path.
```
toInstallFromCran <- read.csv("C:/Users/shrestha/Downloads/list_of_packages_in_cran.txt", header=F)

for (packageName in toInstallFromCran){
        install.packages(packageName, lib="C:/Program Files/R/R-4.1.0/library", dependencies=TRUE)
}
```

Now let's install packages whose source is github. For that we install **remotes** first.

```
install.packages("remotes")
library(remotes)
```

Installing packages from github, will go to personal library by default. So I changed the default library installation path to the global library path first.

```
.libPaths()
```

The output is 
```
[1] "C:/Users/shrestha/Documents/R/win-library/4.1"
[2] "C:/Program Files/R/R-4.1.0/library"
```
The default is the first one - "C:/Users/shrestha/Documents/R/win-library/4.1"

```
myPaths <- .libPaths()
myPaths <- c(myPaths[2], myPaths[1])
.libPaths(myPaths)
.libPaths()
```
It will display
```
[1] "C:/Program Files/R/R-4.1.0/library"
[2] "C:/Users/shrestha/Documents/R/win-library/4.1"
```
Now, the default path is - "C:/Program Files/R/R-4.1.0/library"

Then I installed the packages from github

```
remotes::install_github("teammaclean/besthr")
remotes::install_github("danmaclean/itssl")
remotes::install_github("danmaclean/simplebf")
```

This asked me if I wanted to update packages to more recent versions. I chose options 1: All. Then, it asked me "Do you want to install from sources the package which needs compilation?" and I clicked **No**.

The package **htmltools** has been installed from CRAN. Dan's lock file shows, it is available from github. However, the github page of the tools tells to that the stable release is available in CRAN.

```
install.packages("htmltools")
```

Final package Dan asked to install - nycflights13. I checked if it was installed as a dependency of other tools and it was already installed.

All packages have been installed. To test if packages installation is successful, you can import the package with library function

```
library(packagename)
```

If you get no any error that means the package has been installed successfully and imported.
If you get the error message **there is no package called Packagename **, that means the package has not been installed.

