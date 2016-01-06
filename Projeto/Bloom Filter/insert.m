% Diogo Ferreira e Fábio Cunha, 2015
function [ filter ] = insert(filter, key)
    
    % Inserts key on filter table
    % If number of arguments is <2, function returns without doing anything
    if nargin<2
        return
    end
    
    % Assignments to filter table
    filter(1+rem(string2hash(key, 'djb2'),length(filter)))=1;
    filter(1+rem(string2hash(key, 'sdbm'),length(filter)))=1;
    % 127 is a Mersenne Prime Number (like 3, 7, 31,...)
    filter(1+rem(DJB31MA(key,127),length(filter)))=1;
end

