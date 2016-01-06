% Diogo Ferreira e Fábio Cunha, 2015
function [ b, musics ] = readMp3Files(dir)
    % Lê todas as músicas presentes nos subdiretórios desde dir.
    % Devolve um Bloom Filter com todas as músicas, e um Set com os nomes
    % de todas as músicas presentes.
    allsongs=rdir(strcat(dir,('*\**\*.mp3')));
    musics=cell(1,length(allsongs));
    b = BloomFilter(1e6,length(allsongs));
    
    h=waitbar(0,'0 novas inserções.');
    j=0;
    for i=1:length(allsongs)
        str=strsplit(allsongs(i).name,'\');
        waitbar(i/length(allsongs), h,strcat(strcat(num2str(i),' músicas adicionadas; '),strcat(num2str(j),' novas inserções.')))
        if not(b.isMember(str{length(str)}))
            j=j+1;
            % Insere nome da música no Bloom Filter.
            b.insert(str{length(str)});

            % Insere músicas na base de dados.
            musics{1,i}=allsongs(i).name;    
        end
    end
    delete(h);
end