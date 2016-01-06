% Diogo Ferreira e Fábio Cunha, 2015
function [ X ] = getRanStr()

    % Generates random string with 40 chars(letters and numeric digits).
    l=40;
    alphab= 'qwertyuiopasdfghjklçzxcvbnm1234567890QWERTYUIOPÇLKJHGFDSAZXCVBNM';
    X='aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
    for i=1:l
        idx=1+floor(rand(1,1)*64);
        X(i)=alphab(idx);
    end
end

