function [scores, rank, query_svd] = lsi_rank(query, tdm, terms, tf, svd_docs, u,s)

% Computes the rank based on lsi representation

% Input:
%   - query: the query perform
%   - tdm: term-document matrix 
%   - terms: cell array of terms. 
%   - tf: term frequency matrix
%   - svd_docs: documents representation in lsi space
%   - u: eigenvectors
%   - s: singular values
%   - collection: the structure storing information about the collection
%   - k, b: parameters of the bm25 function
%
% Output:
%   - scores: the list of documents scores
%   - rank: the list of documents in descending order

[r c] = size(tdm);

wtdq = build_query_vector(query, tf, terms,c);

% Query into svd space
query_svd = ( wtdq*u*sqrt(s(:,1:2)) )';
query_svd = query_svd./norm(query_svd,2);

% Length normalization
for i = 1:c
    norm_value = norm(svd_docs(:,i),2);
    svd_docs(:,i) = svd_docs(:,i)./norm_value;
end

for j=1:c
    scores(1,j) = sum(query_svd.*svd_docs(:,j));
end

[scores rank] = sort(scores, 'descend');

end


function q = build_query_vector(query, tf, terms, c)

% Tokenize the query
terms_query = split(' ', query);

% Apply the porterStemmer to the tokens of the query
for n=1:length(terms_query)
    terms_query{n} = porterStemmer(terms_query{n});
end

terms_query = [terms_query; compute_bi_grams(terms_query)];
terms_query = unique(terms_query);

% Initialize the query vectors
tfq = zeros(1,length(terms));
idfq = zeros(1,length(terms));

% Apply the porterStemmer to the tokens of the query
for i=1:length(terms_query)  
    % Find the indices of terms that are in the query
    index = find(ismember(terms, terms_query(i))==1);
    
    tfq(index) = tfq(index) + 1;
    
    % Document frequency term
    df = length(find((tf(index,:) > 0)==1));
    if df==0
        idfq(index) = 0;
    else
        % Inverse document frequency
        idfq(index) = log(c./df);
    end
    
end

q = tfq.*idfq;

end