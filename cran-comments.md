30.06.2020

- mention 'suppressMessages' in the documentation, as all output to the console is provided with "message()", this can easily be suppressed.
- improve examples so that they show the full range of functions. Therefore I wrote the function "makeExampleDB", which carries out building the example database until a certain point, so that not everything has to be typed in.
- use tempdir() in 'makeExampleDB'.

19.06.2020

- most examples require \dontrun{} as they build on one-another, i.e., setPath() is run to specify a location where the database should be established and only then setVariables() can be run to create the respective index and translation tables. Same with regDataseries(), regGeometry() and regTable(), which store the information into the respective folders and with the norm*() functions, which pick up those data and normalise them. To ensure that all functions are tested properly, I set up unit-tests that go through this whole procedure. As a simple example, this would be too much, as it would require for each functions deeper into the process an increasingly longer list of code, and it would anyway take (much) longer than 5 seconds to execture.

29.05.2020

- set 'arealDB' in DESCRIPTION in single quotes
- change format of arXiv reference in DESCRIPTION
- be more explicit about what the function returns for 'setPath', 'setVariables', 'normGeometry', 'normTable' and 'translateTerms'
- use on.exit(oldOptions) in 'setPath' to reset options to the status of before this function was called.
- 