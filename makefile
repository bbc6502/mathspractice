.venv:
	python3.13 -m virtualenv .venv

clean:
	rm -fr *.egg-info dist .coverage .venv
	find . -depth -type d -name .pytest_cache -exec rm -fr {} \;
	find . -depth -type d -name __pycache__ -exec rm -fr {} \;

requirements: .venv
	.venv/bin/python -m pip install --upgrade pip -r requirements.txt

run: .venv
	DEBUG=TRUE .venv/bin/python -m mathspractice

build: .venv
	rm -fr dist *.egg-info
	.venv/bin/python -m build

build-view: build
	tar -zvtf dist/mathspractice*.tar.gz

upload-test: build
	.venv/bin/python -m twine upload --repository testpypi dist/*

upload-prod: build
	.venv/bin/python -m twine upload dist/*

merge-branch:
	git checkout main
	git merge 0.0.10

tag-build:
	git tag 0.0.10
