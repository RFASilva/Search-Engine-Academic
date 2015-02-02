function [terms, tf, idf, tdm] = build_tdm(collection)

% Compute the term-document matrix based on a specified collection,
% using the tf-idf weight scheme. The term-document matrix contains
% unigrams and bigrams
%
% Output (each entry refers a term in the follow matrices/vectors):
%   terms: Cell array of terms. 
%   tf: Term frequency matrix
%   idf: Inverse document frequency
%   tdm: Term-document matrix

[unigrams, uni_tf, uni_idf, uni_tdm] = build_tdm_gram(collection, 1);
[bigrams, bi_tf, bi_idf, bi_tdm] = build_tdm_gram(collection, 2);

terms = [unigrams; bigrams];
tf = [uni_tf; bi_tf];
idf = [uni_idf; bi_idf];
tdm = [uni_tdm; bi_tdm];

end


function [ngrams, tf, idf, tdm] = build_tdm_gram(collection, n)

[r c] = size(collection);

% Compute all unique terms that are in the collection
ngrams = [];
for i = 1:c
    ngrams = [ngrams; collection(i).title(:,n); collection(i).body(:,n)];
end

ngrams = unique(ngrams);

% Initialize the tdm and tf matrices
tdm = zeros(length(ngrams), c);
tf = zeros(length(ngrams), c);
idf = zeros(length(ngrams), 1);

for i = 1:length(ngrams)
    
    % Use the tf-idf weight scheme: for each term compute the tf-idf value
    % for each document
    [tf_termi, idf_termi, wtd_termi] = tf_idf(ngrams{i}, collection, n); 
    tf(i,:) = tf_termi;
    tdm(i,:) = wtd_termi;
    idf(i,1) = idf_termi;
        
end


end