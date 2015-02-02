function [svd_docs, svd_terms, u, s, v] = lsi(tdm, k)

% Compute the Latent Semantic Indexing representation of the documents

% Input:
%   - tdm: term-document matrix 
%   - k: parameter to perform the low-rank approximation
%
% Output:
%   - scores: the list of documents scores
%   - rank: the list of documents in descending order

[rows cols] = size(tdm);

% SVD decomposition  
[u s v] = svd(tdm);

% Force low-rank
for i=k+1:cols
    s(i,i) = 0;
end

% Terms decomposition into the SVD space
svd_terms = u*sqrt(s(:,1:k));

% Terms decomposition into the SVD space
svd_docs = sqrt(s(1:k,:))*v';
end
