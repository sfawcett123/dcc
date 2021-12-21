---
title: Python 
nav_order: 20
has_children: true
has_toc: false
layout: page
---

# Python 
{:.no_toc}

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

## Requirements

1. [Install Python](https://docs.python.org/3/index.html)
1. [Install PIP](https://pip.pypa.io/en/stable/installation)
1. [Install arduino-cli and configure](/arduino.md)

## Configure

We will be using python3 so check the version of python and pip

### Python 3
```
❯ python3 --version
Python 3.9.7
```

### Pip 
Check you have the correct verion of pip

```
❯ pip3 --version
pip 21.3.1 from /usr/local/lib/python3.9/site-packages/pip (python 3.9)

❯ pip --version
pip 21.3.1 from /usr/local/lib/python3.9/site-packages/pip (python 3.9)

```
If you use a different version of pip to pip3 ( not linked ) then you will need to substitute `pip` with `pip3`

### Project specific

Each project should have a requirements.txt within the directory, so before running type:

```pip install -r requirements.txt```
