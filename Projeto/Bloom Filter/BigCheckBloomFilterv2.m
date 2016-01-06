% Diogo Ferreira e Fábio Cunha, 2015

% Test for BloomFilter and Hash Function
% This function usually takes some time to run(~3/4 minutes)

% Number of hash functions
n=15;

% Initializing filter
filter=zeros(n,8000);
step=0;
h=waitbar(0,'A inserir Strings...');
% For each hash function
for i=1:n
    % For each key (Random String generated) insert hashcode on filter
    for j=1:1000
        step=step+1;
        waitbar(step/((n*1000)+(n*10000)),h);
        str=getRanStr();
        filter(i,:)=insertk(filter(i,:),str,i);
    end
end
figure(1)
bar(1:15,sum(filter,2))
xlabel({'Nº de HashFunctions usadas para filtro'})
ylabel({'Nº de posições preenchidas'})
title({'Gráfico das posições do filtro'})

waitbar(step/((n*1000)+(n*10000)),h,'A testar novas strings...');

% Testing if 10000 random strings belong to filter
p=zeros(1,n);
isM=zeros(n,10000);
for j=1:n
    for i=1:10000
        step=step+1;
        waitbar(step/((n*1000)+(n*10000)),h);
        % Assuming that any random string do not belong to filter
        % if isMemberK returns 1, is false positive
        isM(j,i)=isMemberK(filter(j,:),getRanStr(),j);
    end
    % Theorical probability of false positives
    p(1,j)=ProbFalsePositive(1000,8000,j);
end

delete(h)

% Experimental probability must be higher because we are assuming that all
% random strings generated do not belong to the filter (which can be false)
figure(2)
hold on
bar(1:15,sum(isM,2)/8000,0.5,'FaceColor',[0.2 0.2 0.5])
bar(1:15,p(1,:),0.25,'FaceColor',[0 0.7 0.7])
hold off
xlabel({'Número de funções de hash'})
ylabel('Probabilidade de falso positivo')
legend({'Valor experimental','Valor teórico'})
title({'Falsos positivos'})
axis([0 16 0 max(sum(isM,2))/8000+0.05])