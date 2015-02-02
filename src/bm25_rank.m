function [scores, rank, vector] = bm25_rank(query, tdm, tf, terms, collection, k, b) 

% Calculate the rank matching documents according to their relevance to a
% given query, using the bm25 ranking function

% Input:
%   - query: the query perform
%   - tdm: term-document matrix 
%   - terms: cell array of terms. 
%   - collection: the structure storing information about the collection
%   - k, b: parameters of the bm25 function
%
% Output:
%   - scores: the list of documents scores
%   - rank: the list of documents in descending order
%   - vector: the list of documents scores. The position gives the document
%   id

[r c] = size(tdm);

% Tokenize the query
terms_query = split(' ', query);

% Apply the porterStemmer to the tokens of the query
for n=1:length(terms_query)
    terms_query{n} = porterStemmer(terms_query{n});
end

terms_query = [terms_query; compute_bi_grams(terms_query)];
terms_query = unique(terms_query);

idf_qi = zeros(1,length(terms_query));

for i=1:length(terms_query)
    % Find the indices of terms that are in the query
    index = find(ismember(terms, terms_query(i))==1);
    
    % nq_i: the number of documents containing ith query term
    nq_i = length(find(tf(index, :) > 0 ));
    
    idf_qi(i) = log(c - nq_i + 0.5 / nq_i + 0.5);
end

% Find the indices of terms that are in the query
index = find(ismember(terms, terms_query(:))==1);
size_index = length(index);

numerator = tf(index,:).*(k+1);

[length_words, avgdl] = number_words(collection);
denominator = tf(index,:) + repmat((k.*(1-b + (b.*(length_words./avgdl)) )),size_index,1);

temp = numerator./denominator;

for i=1:length(terms_query)
    scores = idf_qi(i).*temp;
end

vector = sum(scores,1);
[scores rank] = sort(vector, 'descend');

end

function [length_words, avgdl] = number_words(collection)

[r c] = size(collection);

length_words = zeros(1,c);
for i=1:c
    length_words(i) = length(collection(i).title) + length(collection(i).body);
end

avgdl = sum(length_words)/c;

end