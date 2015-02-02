function [scores, rank] = bm25pr(bm25_scores, pr_scores)

% Compute the rank integrating the scores of bm25 ranking function and
% the scores computed through the pagerank
%
% Input:
%   - bm25_scores: BM25 scores. Each entry corresponds to a document
%   - pr_scores: Pagerank scores. Each entry corresponds to a document
%
% Output:
%   - scores: the list of documents scores
%   - rank: the list of documents in descending order

scores = bm25_scores+(pr_scores./1+pr_scores);
[scores rank] = sort(scores, 'descend');

end