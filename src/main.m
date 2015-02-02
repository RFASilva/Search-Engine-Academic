%
% Author: Ricardo Silva
%

clear all;
clc;

%% Initialize collection
collection = init('documents.xml');

%% Build term-document matrix for the collection of documents
[terms, tf, idf, tdm] = build_tdm(collection);

%% Compute the Latent Semantic Indexing representation of the documents
[svd_docs, svd_terms, u, s, v] = lsi(tdm,2);

%% Compute the cosine similarity among all documents
similarity = sim_all(tdm);

%% Compute the Pagerank given a web graph
webgraph = [0 0 1 1 0 0 0 0;
            1 0 0 0 0 1 0 0;
            0 1 0 1 0 0 0 0;
            0 0 0 0 0 0 1 0;
            0 0 0 0 0 0 0 0;
            0 0 0 0 1 0 0 0;
            0 0 0 0 1 0 0 0;
            1 0 0 0 0 0 1 0];
[scores_pr rank_pr scores_pr_unordered] = page_rank(webgraph, 0.1);


%% Query = 'cristiano'
query = 'cristiano';
% Compute the cosine rank given a query q
[scores rank] = cosine_rank(query, tdm, terms, collection);

% Compute the BM-25 rank given a query q
k = 2;
b = 0.75;
[scores2 rank2 scores2_unordered] = bm25_rank(query, tdm, tf, terms, collection, k, b);

% Compute the LSI rank given a query q
[scores3 rank3 query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u, s);

% Compute the rank through a new proposed function that combines bm25 and
% pagerank
[scores4 rank4] = bm25pr(scores2_unordered,scores_pr_unordered);


%% Query = 'stones'
query = 'stones';
% Compute the cosine rank given a query q
[scores rank] = cosine_rank(query, tdm, terms, collection);

% Compute the BM-25 rank given a query q
[scores2 rank2 scores2_unordered] = bm25_rank(query, tdm, tf, terms, collection, k, b);

% Compute the LSI rank given a query q
[scores3 rank3 query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u, s);

% Compute the rank through a new proposed function that combines bm25 and
% pagerank
[scores4 rank4] = bm25pr(scores2_unordered,scores_pr_unordered);


%% Query = 'police'
query = 'police';
% Compute the cosine rank given a query q
[scores rank] = cosine_rank(query, tdm, terms, collection);

% Compute the BM-25 rank given a query q
[scores2 rank2 scores2_unordered] = bm25_rank(query, tdm, tf, terms, collection, k, b);

% Compute the LSI rank given a query q
[scores3 rank3 query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u, s);

% Compute the rank through a new proposed function that combines bm25 and
% pagerank
[scores4 rank4] = bm25pr(scores2_unordered,scores_pr_unordered);


%% Query = 'media'
query = 'media';
% Compute the cosine rank given a query q
[scores rank] = cosine_rank(query, tdm, terms, collection);

% Compute the BM-25 rank given a query q
[scores2 rank2 scores2_unordered] = bm25_rank(query, tdm, tf, terms, collection, k, b);

% Compute the LSI rank given a query q
[scores3 rank3 query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u, s);

% Compute the rank through a new proposed function that combines bm25 and
% pagerank
[scores4 rank4] = bm25pr(scores2_unordered,scores_pr_unordered);


%% Query = 'health'
query = 'health';
% Compute the cosine rank given a query q
[scores rank] = cosine_rank(query, tdm, terms, collection);

% Compute the BM-25 rank given a query q
[scores2 rank2 scores2_unordered] = bm25_rank(query, tdm, tf, terms, collection, k, b);

% Compute the LSI rank given a query q
[scores3 rank3 query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u, s);

% Compute the rank through a new proposed function that combines bm25 and
% pagerank
[scores4 rank4] = bm25pr(scores2_unordered,scores_pr_unordered);