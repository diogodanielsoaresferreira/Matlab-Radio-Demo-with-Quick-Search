% Diogo Ferreira e Fábio Cunha, 2015
% Teste ao Bloom Filter aplicado às músicas.

[b, musics]=readMp3Files('F:\Music\Top');
% Probabilidade de falsos positiovs experimental
fp=1-sum(b.size/length(musics));
% Probabilidade de falsos positiovs teórica
fpt=ProbFalsePositive(length(musics),1e6,b.numHash);

[b, musics]=readMp3Files('F:\Music\Favoritos');
% Probabilidade de falsos positiovs experimental
fp2=1-sum(b.size/length(musics));
% Probabilidade de falsos positiovs teórica
fpt2=ProbFalsePositive(length(musics),1e6,b.numHash);


[b, musics]=readMp3Files('F:\Music');
% Probabilidade de falsos positiovs experimental
fp3=1-sum(b.size/length(musics));
% Probabilidade de falsos positiovs teórica
fpt3=ProbFalsePositive(length(musics),1e6,b.numHash);

% Verificar uniformidade do Bloom Filter
plot(1:1e6,b.filter);

figure(2)
subplot(1,2,1)
bar([1, 2, 3], [fp, fp2, fp3])
subplot(1,2,2)
bar([1, 2, 3], [fpt, fpt2, fpt3])

% Descomentar para testar com música.
%PlayMusic(musics{1,randi([1,length(musics)])},10);