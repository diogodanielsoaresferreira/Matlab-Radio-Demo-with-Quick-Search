% Diogo Ferreira e Fábio Cunha, 2015
function [ isM ] = isMember(filter, key)
    % Checks if key is member of filter table
    % If number of arguments is <2, function returns without doing anything
    if nargin<2
        return
    end
    
    isM=filter(1+rem(string2hash(key,'djb2'),length(filter)))==1;
    
    % If hash 1 exists, test hash 2. Otherwise, return false.
    if isM==1
        isM=filter(1+rem(string2hash(key,'sdbm'),length(filter)))==1;
    end
     % If hash 1 and hash 2 exists, test hash 3. Otherwise, return false.
    if isM==1
        isM=filter(1+rem(DJB31MA(key,127),length(filter)))==1;
    end
end