# Sahana Eden

Sahana Eden is a RAD (Rapid Application Development) Kit to build
web based applications for Humanitarian and Emergency Management.

# Who is Sahana Eden for?

Sahana Eden is for application developers and service providers.

# What about documentation?

The developer handbook is included in the repository, or you can
read it on [ReadTheDocs](https://eden-asp.readthedocs.io).

Documentation about the project, including how to contribute, can be found on our [wiki](https://eden.sahanafoundation.org).

You can also ask questions on our [mailing list](https://groups.google.com/g/eden-asp).

## Unit Test Coverage

To collect coverage for the Eden unit test suite, install the `coverage`
package in your Python environment and run:

```bash
cd web2py/applications/eden
python3 -m pip install coverage
./tests/run_coverage.sh
```

The script runs `modules/unit_tests/suite.py` via `web2py.py` and writes:

- `coverage_html/index.html`
- `coverage.xml`
