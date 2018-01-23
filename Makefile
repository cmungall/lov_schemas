OBO = http://purl.obolibrary.org/obo

all: all_rdf gen

ONTS = uniprot-core prov ssn faldo dcterms sio
all_rdf: $(patsubst %,ontologies/%.rdf,$(ONTS))

CURL = curl -L  -H 'Content-Type: text/turtle'
W = > $@.tmp && mv $@.tmp $@

ontologies/uniprot-core.rdf: 
	$(CURL) http://purl.uniprot.org/core/ $(W)
ontologies/prov.rdf: 
	$(CURL) http://www.w3.org/ns/prov-o $(W)
ontologies/ssn.rdf: 
	$(CURL) http://www.w3.org/ns/ssn/ $(W)
ontologies/faldo.rdf: 
	$(CURL) http://biohackathon.org/resource/faldo.rdf $(W)
ontologies/dcterms.rdf: 
	$(CURL) http://purl.org/dc/terms/ $(W)
ontologies/sio.rdf: 
	$(CURL) http://semanticscience.org/ontology/sio.owl $(W)


gen:
	swipl -l generate -g wall,halt

test: test-obo_ro test-obo_metadata test-obo_core
test-%:
	(cd $* && swipl -l tests/tests.pl -g run_tests,halt)
