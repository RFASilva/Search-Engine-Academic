function my_plot(vectors, labels) 

% Plot points in 2D

% Input: 
%   vectors: points to be plotted
%   labels: labels to associated to each point


axis([-8 1 -7 1]);
scatter(vectors(1,:), vectors(2,:),'r*');
for i=1:8
    text(vectors(1,i) + 0.03, vectors(2,i), labels{i});
    display(i);
end

end