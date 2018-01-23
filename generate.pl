:- use_module(library(semweb/rdf11)).
:- use_module(library(semweb/rdf_turtle)).
:- use_module(library(rdfs2pl)).

src(up, 'uniprot-core.rdf',xml,'prolog/lov_schemas/uniprot.pl',[uniprot]).
src(prov, 'prov.rdf',turtle,'prolog/lov_schemas/prov.pl',[prov]).
src(ssrn, 'ssn.rdf',turtle,'prolog/lov_schemas/ssn.pl',[ssn]).
src(faldo, 'faldo.rdf',xml,'prolog/lov_schemas/faldo.pl',[faldo]).
src(dcterms, 'dcterms.rdf',xml,'prolog/lov_schemas/dcterms.pl',[dcterms]).
src(sio, 'sio.rdf',xml,'prolog/lov_schemas/sio.pl',[dcterms]).

w(Name,RdfFile,Fmt,PlFile,_) :-
        unload,
        rdf_load(RdfFile,[format(Fmt)]),
        tell(PlFile),
        write_schema(Name,[use_labels(true), reify(true), reify_owl(true)]),
        !,
        told.

unload :-
        rdf(_,_,_,G),
        rdf_unload_graph(G),
        fail.
unload.

wall :-
        src(Name,RdfFile,Fmt,PlFile,Prefixes),
        atom_concat('ontologies/',RdfFile,In),
        w(Name,In,Fmt,PlFile,Prefixes),
        fail.
wall.
