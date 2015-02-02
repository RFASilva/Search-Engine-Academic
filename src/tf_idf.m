function [tf_term, idf_term, wtd_term] = tf_idf(term, collection, n)

% Compute the tf–idf weight (term frequency–inverse document frequency) for
% each document, given a term
%
% Input: 
%   term: the term
%   collection: collection of documents
%   n: indicates the term type n-gram
%
% Output:
%   tf_term: Term frequency vector
%   wtd_term: Tf–idf vector

[r c] = size(collection);
wtd_term = zeros(1,c);
tf_term = zeros(1,c);

% Term frequency
for i = 1:c
    n_title = length(find(ismember(collection(i).title(:,n), term)==1)); 
    n_body = length(find(ismember(collection(i).body(:,n), term)==1));
    
    tf_term(i) = n_title + n_body;
end

% Normalize the term frequency
%tf_term = tf_term./sum(tf_term);

% Document frequency   
df = length(find(tf_term > 0)==1);
if df == 0
    idf_term = 0;
else
    % Inverse document frequency
    idf_term = log(c./df);
end

wtd_term = tf_term.*idf_term;

end