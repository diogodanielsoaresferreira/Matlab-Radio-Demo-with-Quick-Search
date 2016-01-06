udata=load('u2.data');  % Carrega o ficheiro dos dados dos filmes
% Fica apenas com as duas primeiras colunas
u= udata(1:end,1:2);

[tusers, Set]=Movies(udata);

% Lista de utilizadores
users = unique(u(:,1));     % Extrai os IDs dos utilizadores
Nu= length(users)-100;          % Numero de utilizadores
finalusers=zeros(1,100);
for i=1:100
    x=floor(1+rand()*length(users));
    finalusers(1,i)=x;
    users(x)=[];
end

J = JaccardDistance(finalusers, Set);

SimilarUsers=SimilarItems(finalusers,J,0.6);
fprintf('Número de pares similares:%d \n',length(SimilarUsers));
for i=1:length(SimilarUsers)
    fprintf('id1: %d id2: %d distância: %f \n',SimilarUsers(i,1),SimilarUsers(i,2),SimilarUsers(i,3));
end