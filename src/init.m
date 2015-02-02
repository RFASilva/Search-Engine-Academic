function collection = init(file)
% Initialize and pre-process the collection of documents

% Read xml file that contains information about the documents (title, body 
% and url) and create a struct with the information associated to 
% them (title, body, url). The body and title are pre-processed
% removing the all punctuation, and the words are stemmed.
%
% Input: 
%   file: xml document with the description of web documents
% Output:
%   collection: a struct with the collection of documents pre-processed is
%   created
%   Example: 
%    - in collection(id_document).body(:,1) are all unigrams present
%    in the body
%    - in collection(1).body(:,2) are all bigrams present in the body

struct = parseXML(file);
[rows, columns] = size(struct.Children);

i = 1;
    for k = 2:2:columns
        title = lower(struct.Children(1,k).Children(1,2).Children.Data);
        body = lower(struct.Children(1,k).Children(1,4).Children.Data);
        url = struct.Children(1,k).Children(1,6).Children.Data;
              
        unigrams = pre_process(title);
        bigrams = compute_bi_grams(unigrams);
        
        uni_size = length(unigrams);
        bi_size = length(bigrams);      
        
        collection(i).title = cell(max([uni_size bi_size]),2);
        collection(i).title(1:uni_size,1) = unigrams';
        collection(i).title(1:bi_size,2) = bigrams';
        
        unigrams = pre_process(body);
        bigrams = compute_bi_grams(unigrams);
        
        uni_size = length(unigrams);
        bi_size = length(bigrams);      
        
        collection(i).body = cell(max([uni_size bi_size]),2);
        collection(i).body(1:uni_size,1) = unigrams';
        collection(i).body(1:bi_size,2) = bigrams';
        
        collection(i).url = url;
        i = i+1;

    end

end

function words = pre_process(s)

% Input: 
%   s: string to be processed
% Output:
%   words: cell array where each entry is a term stemmed

%regexprep function remove all punctuation
s = regexprep(s,'[‘\n\t\r]',' ');
s = regexprep(s,'[^a-zA-Z0-9 ]',' ');

% Stem the body text with the Porter stemmer
s = split(' ', s);
words = {};
for n=1:length(s)
    words{n} = porterStemmer(s{n});
end

words(length(words)) = [];

end
