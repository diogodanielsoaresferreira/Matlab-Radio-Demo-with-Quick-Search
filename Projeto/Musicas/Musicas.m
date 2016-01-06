% Diogo Ferreira e F�bio Cunha, 2015
%% Aplica��o para r�dio.

% NOTA: A aplica��o foi desenhada para funcionar em ambiente Windows. Caso
% deseje executar em ambiente Unix, por favor mude todos os '\' para '/'
% neste programa e nas fun��es necess�rias.

% Devolve Bloom Filter com m�sicas e todas as m�sicas.
[b, musics]=readMp3Files('F:\Music\Top');

% Devolve minHash com as m�sicas e os par�metros a e c para hashfunctions.
[ minh, a, c ] = musicMinHash( musics, 1000);

% Devolve matriz com dist�ncias de Jaccard.
% N�o seria preciso faz�-lo agora, mas poupa-nos tempo mais tarde,
% quando precisarmos de ouvir uma m�sica, para n�o estarmos a calcular e a esperar 
% sempre que ouvirmos uma m�sica.
sim=minHashDist(minh);

while 1==1
    fprintf('\n----Menu----');
    fprintf('\n1 - Tocar m�sica por �ndice');
    fprintf('\n2 - Pesquisar �ndice de m�sica por nome');
    fprintf('\n3 - Limpar base de dados inteira e adicionar todas as m�sicas novamente');
    fprintf('\n4 - Tocar m�sica aleat�ria')
    fprintf('\n5 - Iniciar r�dio com base em nome recebido')
    str = input('\nEscolha -> ');
    switch(str)
        case 1
            i=length(musics)+1;
            while i>length(musics) || i<0
                fprintf('Escolha o �ndice desde 1 a %d',length(musics));
                i = input(': ');
            end
            fprintf('Insira o tempo (em segundos) que deseja ouvir a m�sica, ou insira uma letra para ouvir a m�sica inteira');
            t = input(': ','s');
            [num, status] = str2num(t);
            s=SimilarMusics(i, minh, sim);
            if (~isempty(s(1,:)))
                for j=1:length(s(1,:))
                    fprintf('\n�ndice: %d; Nome: %s',s(1,j),pathToName(musics{s(1,j)}));
                end
            else
                fprintf('\nN�o foram encontradas m�sicas com nome similar.');
            end
            if status==1
                PlayMusic(musics{1,i},num);
            else
                PlayMusic(musics{1,i});
            end
            
        case 2
            t = input('Insira o nome da m�sica que deseja pesquisar: ','s');
            s = searchMusic(t, minh, a, c);
            if (~isempty(s(1,:)))
                fprintf('\nM�sicas com nome mais parecido: ');
                for i=1:length(s(1,:))
                    fprintf('\n�ndice: %d; Nome: %s',s(1,i),pathToName(musics{s(1,i)}));
                end
            else
                fprintf('\nN�o foram encontradas m�sicas com nome similar.');
            end
        case 3
            fprintf('\nVerificando arquivos...');
            t = input('\nInsira o endere�o que deseja ter como base para a sua base de dados: ','s');
            if exist(t, 'file')==0
                fprintf('\nO endere�o n�o foi reconhecido v�lido.');
            else
                [b, musics]=readMp3Files(t);
				[ minh, a, c ] = musicMinHash( musics, 1000);
				sim=minHashDist(minh);
                fprintf('\nVerifica��o feita com sucesso!');
            end
         case 4
            fprintf('Insira o tempo (em segundos) que deseja ouvir a m�sica, ou insira uma letra para ouvir a m�sica inteira');
            t = input(': ','s');
            [num, status] = str2num(t);
            i=randi([1,length(musics)]);
            s=SimilarMusics(i, minh, sim);
            if (~isempty(s(1,:)))
                for j=1:length(s(1,:))
                    fprintf('\n�ndice: %d; Nome: %s',s(1,j),pathToName(musics{s(1,j)}));
                end
            else
                fprintf('\nN�o foram encontradas m�sicas com nome similar.');
            end
            
            if status==1
                PlayMusic(musics{1,i},num);
            else
                PlayMusic(musics{1,i});
            end
            
        case 5
            t = input('Insira o nome da m�sica para iniciar o r�dio: ','s');
            fprintf('Insira o tempo (em segundos) que deseja ouvir as m�sicas, ou insira uma letra para ouvir as m�sicas inteiras');
            time = input(': ','s');
            [num, status] = str2num(time);
            while 1==1
                s = searchMusic(t, minh, a, c);
                if ~isempty(s)
                    i=1;
                    while i<=length(s(1,:))
                        if status==1
                            PlayMusic(musics{1,s(1,i)},num);
                        else
                            PlayMusic(musics{1,s(1,i)});
                        end
                        i=i+1;
                    end
                end
                i=randi([1,length(musics)]);
                t=musics{1,i};
            end
        
        otherwise
            fprintf('\nEscolha inv�lida!');
    end
end