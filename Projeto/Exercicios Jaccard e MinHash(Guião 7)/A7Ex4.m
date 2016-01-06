udata=load('u.data');  % Carrega o ficheiro dos dados dos filmes
% Fica apenas com as duas primeiras colunas
u= udata(1:end,1:2);

[tusers, Set, totMovies]=Movies(udata);

% Neste caso, não seria necessário formar shingles.
% Forma tabela com linhas totMovies(i) e colunas tusers(j)
% sh=Shingles(totMovies, tusers,Set);


% Calcula tabela com minHashes
t=minHash(tusers,totMovies,Set);

% Calcula diferença de colunas com base no minHash
t=MinHashToDist(t);
t=1-t;
threshold=0.4;
for i=1:length(t)
    for j=i+1:length(t)
        if(t(i,j)<threshold)
            fprintf('id1: %d id2: %d distância: %f \n',tusers(i),tusers(j),t(i,j));
        end
    end
end