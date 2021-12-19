---
title: Python 
nav_order: 20
---

# Python 


## Requirements

* [Install Python](https://docs.python.org/3/index.html)
* [Install arduino-cli and configure](/arduino.md)

## Configure

We will be using python3 so check:

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


