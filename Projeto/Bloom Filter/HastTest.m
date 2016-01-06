% Diogo Ferreira e Fábio Cunha, 2015
% Script that checks hash functions
hash1=zeros(1,1000);
hash2=zeros(1,1000);
hash3=zeros(1,1000);
for i=1:1e4
    str=getRanStr;
    hash1(1,i)=1+rem(string2hash(str, 'djb2'),1000);
    hash2(1,i)=1+rem(string2hash(str, 'sdbm'),1000);
    hash3(1,i)=1+rem(DJB31MA(str,127),1000);
end

% If histogram is not +- uniform, hash function is probably bad for this
% particular case.
subplot(2,2,1)
hist(hash1)
title({'HashFunction nº 1'})
subplot(2,2,2)
hist(hash2)
title({'HashFunction nº 2'})
subplot(2,2,3)
hist(hash3)
title({'HashFunction nº 3'})

% Corrcoef (1,2) & Corrcoef(2,1) must be equal and <0.05
corrcoef(hash1,hash2)
corrcoef(hash1,hash3)
corrcoef(hash2,hash3)