PYTHON := python3
MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
VENV_PY := venv/bin/python
VENV_ACT := . venv/bin/activate

.PHONY: all setup build export clean

all: setup build export

setup:
	cd $(MAKEFILE_DIR) && \
	$(PYTHON) -m ensurepip --upgrade && \
	$(PYTHON) -m pip install --upgrade setuptools wheel && \
	$(PYTHON) -m venv venv && \
	$(VENV_PY) -m pip install -r requirements.txt

build:
	$(VENV_PY) -m nuitka --follow-imports Cifra.py -o passwordManager

export:
	mkdir -p export && \
	cp dist/* export/

clean:
	rm -rf venv dist build __pycache__ export
