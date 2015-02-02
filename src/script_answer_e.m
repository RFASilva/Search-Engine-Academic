% Represent the queries and the documents in the LSI space

query_svds =[];

figure
hold on
my_plot(svd_docs, {'1', '2','3', '4', '5', '6', '7', '8'});

query = 'cristiano';

[scores3 rank3 query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u, s);

scatter(query_svd(1,1), query_svd(2,1), 60, [0 1 0], 'filled');
text(query_svd(1,1), query_svd(2,1), query);

query = 'stones';
[scores3 rank3 query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u, s);
scatter(query_svd(1,1), query_svd(2,1), 60, [0 1 1], 'filled');
text(query_svd(1,1), query_svd(2,1), query);

query = 'police';
[scores3 rank3 query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u, s);
scatter(query_svd(1,1), query_svd(2,1), 60, [1 0 1], 'filled');
text(query_svd(1,1), query_svd(2,1), query);

query = 'media';
[scores3 rank3 query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u, s);
scatter(query_svd(1,1), query_svd(2,1), 60, [0.5 0.5 0.5], 'filled');
text(query_svd(1,1), query_svd(2,1), query);

hold off

