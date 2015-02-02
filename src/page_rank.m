function [scores, rank, vector] = page_rank(web_graph, alpha) 

% Compute the pagerank

% Input:
%   - webgraph: The adjacency matrix of the web graph is defined as
%               follows: if there is a hyperlink from page i to page j,
%               then Mij = 1, otherwise Mij = 0.
%   - alpha: the probability of the teleport operation
%
% Output:
%   - scores: the list of documents scores
%   - rank: the list of documents in descending order
%   - vector: the list of documents scores. The position give the document
%   id

% Compute transition probability matrix
tpm = transition_probability_m(web_graph,alpha);

[n c] = size(tpm);
error = 0.00000001;
previous_vector  = rand(1,n);

vector = previous_vector*tpm;
vector = vector./norm(vector,1);

% Power iteration
while(sum(abs(vector - previous_vector)) > error)
    previous_vector = vector;
    vector = vector*tpm;
    vector = vector./norm(vector,1);
end

[scores rank] = sort(vector, 'descend');

end

function tpm = transition_probability_m(webgraph, alpha)

[r c] = size(webgraph);
tpm = webgraph;

% First Step
for i=1:c
    if length(find(webgraph(i,:) == 0)) == c
        tpm(i,:) = 1/c;
    end
end

% Second Step
for i=1:c
    indexes = find(webgraph(i,:) == 1);

    n_ones = length(indexes);
    tpm(i,indexes) = tpm(i,indexes)./n_ones;
end

% Third Step
tpm = tpm.*(1-alpha);

% Fourth Step
tpm = tpm+(alpha/c);
end