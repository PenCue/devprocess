<!-- please update the text as needed --> 

# The PenCue Repository Template. 	

This repo can be used as a template for new repositories.  use

<!-- include client if client specific repo: * **Client:** Client name -->

* **Slack Channel:** :[#dev](https://pencue.slack.com/archives/C01545N92F3)
* [Requirements](#Requirements)
* [Installation](#Installation)
* [Usage](#Usage)
* [Testing](#Testing)
* [Deployment](#Deployment)
* [Development Process](#development-process)

## Requirements

- Python >3.8.2
- pyenv
- ...

## Installation

how to setup your development environment. 

```
pyenv local 3.8.3
pyenv virtualenv repo_name
pyenv activate repo_name
pip3 install -r requirements.txt
```

## Usage 

how to run use the code locally 

```
python runme.py -db local.sq3
```

and open listed url in browser, default login etc. 

## Deployment

Code is deployed by following the [PenCue Release Process](https://github.com/pencue/devproc)


## Development Process

The development process follows the [PenCue development process](https://github.com/pencue/devproc)

Here's a quick summary:

* Assign issues you're working on to yourself.
* Work on a branch per issue, something like `issueno-name-of-feature`. One branch per feature/bug, please.
* File a PR early so it can be used for tracking progress.
* When you're finished, mark the PR for review by labelling with "Review &amp; Merge".
* Get someone to review your code, and assign to them; if no one is around, the project lead () can review.

