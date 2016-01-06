% Diogo Ferreira e Fábio Cunha, 2015
%% Teste à função musicMinHash

[b, musics]=readMp3Files('F:\Music\Top');
[ minh, a, c ] = musicMinHash( musics );

sim=minHashDist(minh);

% Imprime os mais similares
for i=1:length(musics)
    for j=i+1:length(musics)
        if sim(i,j)>0.2
            fprintf('\n%s e %s: %f\n',musics{i},musics{j},sim(i,j));
        end
    end
end