udata=load('u.data');  % Carrega o ficheiro dos dados dos filmes
% Fica apenas com as duas primeiras colunas
time=tic;
u= udata(1:end,1:2);

[tusers, Set]=Movies(udata);

% Lista de utilizadores
users = unique(u(:,1));     % Extrai os IDs dos utilizadores
Nu= length(users);          % Numero de utilizadores


J = JaccardDistance(users, Set);

SimilarUsers=SimilarItems(users,J,0.4);
time=toc(time);
fprintf('Número de pares similares:%d \n',length(SimilarUsers));
for i=1:length(SimilarUsers)
    fprintf('id1: %d id2: %d distância: %f \n',SimilarUsers(i,1),SimilarUsers(i,2),SimilarUsers(i,3));
end
% Pares similares:3
%
% id1: 328 id2: 788 distância: 0.327044 
% id1: 408 id2: 898 distância: 0.161290 
% id1: 489 id2: 587 distância: 0.370079 
% time: 612.9975