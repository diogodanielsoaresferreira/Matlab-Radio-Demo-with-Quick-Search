% Diogo Ferreira e F�bio Cunha, 2015
function [ minh, a, c ] = musicMinHash( musics, nhash )
    % Fun��o que calcula e devolve a tabela de minHash.
    % Fun��o otimizada (n�mero de for's significativamente diminu�do).
    % No entanto, ainda � algo lenta.
    
    if nargin==1
        nhash=100;
    end
    
    %% Separa os nomes das m�sicas num set de shingles.
    shingles=cell(1,length(musics));
    
    % Vari�vel de controlo para armazenar numa cell a posi��o de cada
    % shingle
    j=1;
    % "Greedy" Cell para guardar posi��es do shingle de cada m�sica.
    % 50 � tamanho default. Se precisar, � aumentada automaticamente.
    shingleslength=cell(length(musics),50);
    shinglesname=cell(1,1);
    
    h=waitbar(0,'A criar shingles...');
    x=0;
    for i=1:length(musics)
        waitbar(i/length(musics), h)
    
        if ischar(musics{1,i})
            name=strsplit(musics{1,i},'\');
            % Divide o nome de cada m�sica em shingles.
            shingles{:,i}=strsplit(name{length(strsplit(musics{1,i},'\'))},{' ','-','.','','(',')','_'});
            
            % Cada shingle � colocado na cell shinglesname, e a sua posi��o
            % � armazenada em shingleslength.
            % Shinglesname e Shingleslength s�o do tipo cell, logo n�o se pode fazer opera��es
            % vetoriais, pelo que trabalhar com for's pode ficar bastante lento neste caso.
            for k=1:length(shingles{:,i})
                % Elimina todos os .mp3, ou se a cell estiver vazia.
                if not(isequal(shingles{1,i}(k),cellstr('mp3')) || isempty(shingles{1,i}(k)))
                    % Procura nos shingles pelo shingle novo. Caso
                    % n�o exista, cria-o. Caso contr�rio, apenas guarda rm
                    % shigleslength a sua posi��o.
                    % ATUALIZA��O : Eliminado um for, para procurar na
                    % cell, agora feito com c�lculo vetorial. Ainda assim,
                    % este processo atrasa bastante o tempo para calcular a
                    % minHash, apesar de libertar espa�o de mem�ria e de ser mais preciso.
                    % Caso esteja a trabalhar com bases de dados pequenas, ou necessite de mais precis�o,
                    % pode "descomentar" abaixo e comentar a parte seguinte. Neste
                    % caso, n�o haver� shingles repetidos.
                    
                    % Retire os coment�rios desde aqui.
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
                    
                    % Retire os coment�rios at� aqui.
                    % Comente desde aqui.
                    
                    shinglesname{j,1}=shingles{1,i}(k);
                    shingleslength{i,k}=j;
                    j=j+1;
                    % Comente at� aqui.
                end
            end
        end
    end
    delete(h)
    
    h=waitbar(0,'A criar hashcodes...');
    
    %% Calcula Hash para cada shingle.
    
    % N�mero primo>10^7
    p=10000019;
    hash=zeros(length(shinglesname),nhash);
    
    % Par�metros das fun��es de hash.
    % Ser�o posteriormente devolvidos para outras fun��es que precisem de
    % gerar minHash.
    a=randi([2,p-2],1,nhash);
    c=randi([2,p-1],1,nhash);
    
    k=0;
    
    % ATUALIZA��O: Eliminado um for para os hashcodes.
    for j=1:length(shinglesname)
        k=k+1;
        waitbar(k/length(shinglesname), h)
        hash(j,:)=mod(a(1,:)*sum(double(lower(shinglesname{j,1}{1})))+c(1,:),p);
    end

    delete(h);
    
    %% C�lculo do minHash
    
    h=waitbar(0,'A calcular minHash...');
    
    step=0;
    % Cria matriz de "infinito".
    minh=Inf(length(musics),nhash);
    l=1;
    
    % ATUALIZA��O: Eliminado for para hashcodes.
    for j=1:length(musics)
        step=step+1;
        waitbar(step/(length(musics)), h)
        k=1;
        % K vai de 1 at� ao fim da linha, que pode conter matrizes vazias.
        while k<max(sum(cellfun('length',shingleslength),2)) && not(isempty(shingleslength{j,k}))
            minh(j,:)=min(hash(shingleslength{j,k},:), minh(j,:));
            k=k+1;
            l=l+1;
         end
    end
    minh=minh';
    delete(h)
end
