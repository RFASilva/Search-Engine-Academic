function sim_matrix = sim_all(tdm) 

% Compute the cosine similarity among all documents

% Input: 
%   tdm: term-document matrix
% Output:
%   sim_matrix: matrix with the similarities values between the documents

vectors = tdm;
[r c] = size(tdm);

% Init result matrix
sim_matrix = zeros(c);

% Length normalization
for i = 1:c
    norm_value = norm(vectors(:,i),2);
    vectors(:,i) = vectors(:,i)./norm_value;
end

for i = 1:c
    for j = 1:c
        % Compute the dot product
        sim_matrix(i,j) = sum(vectors(:,i).*vectors(:,j));
    end
end

end