function bigrams = compute_bi_grams(terms)

% Compute the bi-grams given a cell array of words

% Input: 
%   terms: the cell array of words
%
% Output:
%   bigrams: The cell array of bigrams computed from the input

num_elems = length(terms);
bigrams = cell(num_elems,1);
for i = 1:num_elems-1

bigram =  {[terms{i},' ', terms{i+1}]};
bigrams(i,1) = bigram;

end

bigrams(num_elems,1) = {' '};
end
