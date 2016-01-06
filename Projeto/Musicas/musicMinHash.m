% Diogo Ferreira e Fábio Cunha, 2015
function [ minh, a, c ] = musicMinHash( musics, nhash )
    % Função que calcula e devolve a tabela de minHash.
    % Função otimizada (número de for's significativamente diminuído).
    % No entanto, ainda é algo lenta.
    
    if nargin==1
        nhash=100;
    end
    
    %% Separa os nomes das músicas num set de shingles.
    shingles=cell(1,length(musics));
    
    % Variável de controlo para armazenar numa cell a posição de cada
    % shingle
    j=1;
    % "Greedy" Cell para guardar posições do shingle de cada música.
    % 50 é tamanho default. Se precisar, é aumentada automaticamente.
    shingleslength=cell(length(musics),50);
    shinglesname=cell(1,1);
    
    h=waitbar(0,'A criar shingles...');
    x=0;
    for i=1:length(musics)
        waitbar(i/length(musics), h)
    
        if ischar(musics{1,i})
            name=strsplit(musics{1,i},'\');
            % Divide o nome de cada música em shingles.
            shingles{:,i}=strsplit(name{length(strsplit(musics{1,i},'\'))},{' ','-','.','','(',')','_'});
            
            % Cada shingle é colocado na cell shinglesname, e a sua posição
            % é armazenada em shingleslength.
            % Shinglesname e Shingleslength são do tipo cell, logo não se pode fazer operações
            % vetoriais, pelo que trabalhar com for's pode ficar bastante lento neste caso.
            for k=1:length(shingles{:,i})
                % Elimina todos os .mp3, ou se a cell estiver vazia.
                if not(isequal(shingles{1,i}(k),cellstr('mp3')) || isempty(shingles{1,i}(k)))
                    % Procura nos shingles pelo shingle novo. Caso
                    % não exista, cria-o. Caso contrário, apenas guarda rm
                    % shigleslength a sua posição.
                    % ATUALIZAÇÃO : Eliminado um for, para procurar na
                    % cell, agora feito com cálculo vetorial. Ainda assim,
                    % este processo atrasa bastante o tempo para calcular a
                    % minHash, apesar de libertar espaço de memória e de ser mais preciso.
                    % Caso esteja a trabalhar com bases de dados pequenas, ou necessite de mais precisão,
                    % pode "descomentar" abaixo e comentar a parte seguinte. Neste
                    % caso, não haverá shingles repetidos.
                    
                    % Retire os comentários desde aqui.
                    %
                    % if iscell([shinglesname{:}])
                    %     ind=find(strcmp([shinglesname{:}], shingles{1,i}{k}));
                    %     if isempty(ind)
                    %         shinglesname{j-x,1}=shingles{1,i}(k);
                    %         shingleslength{i,k}=j-x;
                    %     else
                    %         shingleslength{i,k}=ind;
                    %         x=x+1;
                    %     end
                    % else
                    %     shinglesname{j-x,1}=shingles{1,i}(k);
                    %     shingleslength{i,k}=j-x;
                    % end
                    
                    % Retire os comentários até aqui.
                    % Comente desde aqui.
                    
                    shinglesname{j,1}=shingles{1,i}(k);
                    shingleslength{i,k}=j;
                    j=j+1;
                    % Comente até aqui.
                end
            end
        end
    end
    delete(h)
    
    h=waitbar(0,'A criar hashcodes...');
    
    %% Calcula Hash para cada shingle.
    
    % Número primo>10^7
    p=10000019;
    hash=zeros(length(shinglesname),nhash);
    
    % Parâmetros das funções de hash.
    % Serão posteriormente devolvidos para outras funções que precisem de
    % gerar minHash.
    a=randi([2,p-2],1,nhash);
    c=randi([2,p-1],1,nhash);
    
    k=0;
    
    % ATUALIZAÇÃO: Eliminado um for para os hashcodes.
    for j=1:length(shinglesname)
        k=k+1;
        waitbar(k/length(shinglesname), h)
        hash(j,:)=mod(a(1,:)*sum(double(lower(shinglesname{j,1}{1})))+c(1,:),p);
    end

    delete(h);
    
    %% Cálculo do minHash
    
    h=waitbar(0,'A calcular minHash...');
    
    step=0;
    % Cria matriz de "infinito".
    minh=Inf(length(musics),nhash);
    l=1;
    
    % ATUALIZAÇÃO: Eliminado for para hashcodes.
    for j=1:length(musics)
        step=step+1;
        waitbar(step/(length(musics)), h)
        k=1;
        % K vai de 1 até ao fim da linha, que pode conter matrizes vazias.
        while k<max(sum(cellfun('length',shingleslength),2)) && not(isempty(shingleslength{j,k}))
            minh(j,:)=min(hash(shingleslength{j,k},:), minh(j,:));
            k=k+1;
            l=l+1;
         end
    end
    minh=minh';
    delete(h)
end
