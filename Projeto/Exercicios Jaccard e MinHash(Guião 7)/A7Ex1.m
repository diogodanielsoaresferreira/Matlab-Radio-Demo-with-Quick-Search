% Codigo base para guiao PL07 MPEI 2015-2016

udata=load('u2.data');  % Carrega o ficheiro dos dados dos filmes
% Fica apenas com as duas primeiras colunas
u= udata(1:end,1:2); clear udata;

% Lista de utilizadores
users = unique(u(:,1));     % Extrai os IDs dos utilizadores
Nu= length(users);          % Numero de utilizadores

% Constroi a lista de filmes para cada utilizador
Set= cell(Nu,1);            % Usa celulas
time1=tic;
for n = 1:Nu,  % Para cada utilizador
    % Obtem os filmes de cada um
    ind = find(u(:,1) == users(n));
    % E guarda num array. Usa celulas porque utilizador tem um numero
    % diferente de filmes. Se fossem iguais podia ser um array
    Set{n} = [Set{n} u(ind,2)];
end

time1=toc(time1);

%% Calcula a distancia de Jaccard entre todos os pares pela definicao.
J=zeros(Nu,Nu);  % array para guardar distancias

h= waitbar(0,'Calculating');

time2=tic;
for n1= 1:Nu,
    waitbar(n1/Nu,h);
    for n2= n1+1:Nu,
        %%  distância de Jaccard
        int=intersect(Set{n1},Set{n2});
        un=union(Set{n1},Set{n2});
        J(n1,n2)=1-(length(int)/length(un));
        
    end
end
time2=toc(time2);
delete (h)

%%  Com base na distancia, determina pares com
%%  distancia inferior a um limiar pre-definido

threshold =0.4;  % limiar de decisao
% Array para guardar pares similares (user1, user2, distancia)
SimilarUsers= zeros(1,3);
k= 1;
for n1= 1:Nu,
    for n2= n1+1:Nu,
         if  J(n1,n2)<threshold
             SimilarUsers(k,:)= [users(n1) users(n2) J(n1,n2)];
             k= k+1;
         end
    end
end
 fprintf('Número de pares similares:%d \n',length(SimilarUsers));
for i=1:length(SimilarUsers)
    fprintf('id1: %d id2: %d distância: %f \n',SimilarUsers(i,1),SimilarUsers(i,2),SimilarUsers(i,3));
end
disp(time1)
disp(time2)
disp(cputime)
save('JaccardDistance.mat','J')