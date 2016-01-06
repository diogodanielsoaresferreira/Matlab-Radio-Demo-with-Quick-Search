% Diogo Ferreira e Fábio Cunha, 2015
%% Teste à função musicSingleMinHash

musicname='4';

[b, musics]=readMp3Files('F:\Music\Top');
[ minh, a, c ] = musicMinHash( musics );
minh2=musicSingleMinHash(musicname, a, c);

sim=minHashSingleDist(minh, minh2);


% Imprime os mais similares
for i=1:length(sim)
    if sim(i,1)>0.2
    	fprintf('\n%s e %s: %f\n',musics{i},musicname,sim(i,1));
    end
end