.PHONY: venv
venv:
	echo "Create virtual environment using $(python -V)" && \
	python -m venv .venv && \
	source .venv/bin/activate && \
	pip install --upgrade pip

.PHONY: install
install: venv
	pip install -r requirements.txt

.PHONY: test
test:
	PYTHONPATH=src python -m unittest discover -s tests -v
