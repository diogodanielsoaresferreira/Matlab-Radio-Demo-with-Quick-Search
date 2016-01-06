% Diogo Ferreira e Fábio Cunha, 2015
%% Aplicação para rádio.

% NOTA: A aplicação foi desenhada para funcionar em ambiente Windows. Caso
% deseje executar em ambiente Unix, por favor mude todos os '\' para '/'
% neste programa e nas funções necessárias.

% Devolve Bloom Filter com músicas e todas as músicas.
[b, musics]=readMp3Files('F:\Music\Top');

% Devolve minHash com as músicas e os parâmetros a e c para hashfunctions.
[ minh, a, c ] = musicMinHash( musics, 1000);

% Devolve matriz com distâncias de Jaccard.
% Não seria preciso fazê-lo agora, mas poupa-nos tempo mais tarde,
% quando precisarmos de ouvir uma música, para não estarmos a calcular e a esperar 
% sempre que ouvirmos uma música.
sim=minHashDist(minh);

while 1==1
    fprintf('\n----Menu----');
    fprintf('\n1 - Tocar música por índice');
    fprintf('\n2 - Pesquisar índice de música por nome');
    fprintf('\n3 - Limpar base de dados inteira e adicionar todas as músicas novamente');
    fprintf('\n4 - Tocar música aleatória')
    fprintf('\n5 - Iniciar rádio com base em nome recebido')
    str = input('\nEscolha -> ');
    switch(str)
        case 1
            i=length(musics)+1;
            while i>length(musics) || i<0
                fprintf('Escolha o índice desde 1 a %d',length(musics));
                i = input(': ');
            end
            fprintf('Insira o tempo (em segundos) que deseja ouvir a música, ou insira uma letra para ouvir a música inteira');
            t = input(': ','s');
            [num, status] = str2num(t);
            s=SimilarMusics(i, minh, sim);
            if (~isempty(s(1,:)))
                for j=1:length(s(1,:))
                    fprintf('\nÍndice: %d; Nome: %s',s(1,j),pathToName(musics{s(1,j)}));
                end
            else
                fprintf('\nNão foram encontradas músicas com nome similar.');
            end
            if status==1
                PlayMusic(musics{1,i},num);
            else
                PlayMusic(musics{1,i});
            end
            
        case 2
            t = input('Insira o nome da música que deseja pesquisar: ','s');
            s = searchMusic(t, minh, a, c);
            if (~isempty(s(1,:)))
                fprintf('\nMúsicas com nome mais parecido: ');
                for i=1:length(s(1,:))
                    fprintf('\nÍndice: %d; Nome: %s',s(1,i),pathToName(musics{s(1,i)}));
                end
            else
                fprintf('\nNão foram encontradas músicas com nome similar.');
            end
        case 3
            fprintf('\nVerificando arquivos...');
            t = input('\nInsira o endereço que deseja ter como base para a sua base de dados: ','s');
            if exist(t, 'file')==0
                fprintf('\nO endereço não foi reconhecido válido.');
            else
                [b, musics]=readMp3Files(t);
				[ minh, a, c ] = musicMinHash( musics, 1000);
				sim=minHashDist(minh);
                fprintf('\nVerificação feita com sucesso!');
            end
         case 4
            fprintf('Insira o tempo (em segundos) que deseja ouvir a música, ou insira uma letra para ouvir a música inteira');
            t = input(': ','s');
            [num, status] = str2num(t);
            i=randi([1,length(musics)]);
            s=SimilarMusics(i, minh, sim);
            if (~isempty(s(1,:)))
                for j=1:length(s(1,:))
                    fprintf('\nÍndice: %d; Nome: %s',s(1,j),pathToName(musics{s(1,j)}));
                end
            else
                fprintf('\nNão foram encontradas músicas com nome similar.');
            end
            
            if status==1
                PlayMusic(musics{1,i},num);
            else
                PlayMusic(musics{1,i});
            end
            
        case 5
            t = input('Insira o nome da música para iniciar o rádio: ','s');
            fprintf('Insira o tempo (em segundos) que deseja ouvir as músicas, ou insira uma letra para ouvir as músicas inteiras');
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
            fprintf('\nEscolha inválida!');
    end
end