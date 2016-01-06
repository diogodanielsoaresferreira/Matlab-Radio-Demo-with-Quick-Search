% Diogo Ferreira e F�bio Cunha, 2015
function [ b, musics ] = readMp3Files(dir)
    % L� todas as m�sicas presentes nos subdiret�rios desde dir.
    % Devolve um Bloom Filter com todas as m�sicas, e um Set com os nomes
    % de todas as m�sicas presentes.
    allsongs=rdir(strcat(dir,('*\**\*.mp3')));
    musics=cell(1,length(allsongs));
    b = BloomFilter(1e6,length(allsongs));
    
    h=waitbar(0,'0 novas inser��es.');
    j=0;
    for i=1:length(allsongs)
        str=strsplit(allsongs(i).name,'\');
        waitbar(i/length(allsongs), h,strcat(strcat(num2str(i),' m�sicas adicionadas; '),strcat(num2str(j),' novas inser��es.')))
        if not(b.isMember(str{length(str)}))
            j=j+1;
            % Insere nome da m�sica no Bloom Filter.
            b.insert(str{length(str)});

            % Insere m�sicas na base de dados.
            musics{1,i}=allsongs(i).name;    
        end
    end
    delete(h);
end