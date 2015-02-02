function [scores, rank] = cosine_rank(query, tdm, terms, collection) 

% Calculate the rank matching documents according to their relevance to a
% given query, using the cosine method

% The algorithm implemented is the fast cosine score described in chapter 7
% in the follow book:
% 
% Christopher D. Manning, Prabhakar Raghavan and Hinrich Schütze, 
% Introduction to Information Retrieval, Cambridge University Press. 2008.
%
% Input:
%   - query: the query perform
%   - tdm: term-document matrix 
%   - terms: cell array of terms. 
%   - collection: the structure storing information about the collection
%
% Output:
%   - scores: the list of documents scores
%   - rank: the list of documents in descending order

% Tokenize the query
terms_query = split(' ', query);

% Apply the porterStemmer to the tokens of the query
for n=1:length(terms_query)
    terms_query{n} = porterStemmer(terms_query{n});
end

terms_query = [terms_query; compute_bi_grams(terms_query)];
terms_query = unique(terms_query);

% Find the indices of terms that are in the query
index_terms = find(ismember(terms, terms_query(:))==1);
temp = tdm(index_terms, :);
scores = sum(temp,1);

for i=1:length(scores)
    scores(i) = scores(i)/(length(collection(i).title(:,1)) + length(collection(i).body(:,1)) );
end

[scores rank] = sort(scores, 'descend');

end