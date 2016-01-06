% Diogo Ferreira e Fábio Cunha, 2015

% Teste ao tempo que demora o minHash para diferentes número de hash
% functions para diferentes tamanhos de bases de dados

[b, musics]=readMp3Files('F:\Music\Top');

time=zeros(1,10);
j=1;
for i=100:100:1000
    x=tic;
    [ minh, a, c ] = musicMinHash( musics,i);
    t=toc(x);
    time(1,j)=t;
    j=j+1;
end
subplot(2,2,1)
title([strcat('Base de dados com ',num2str(length(musics)),' músicas')])
xlabel(['Número de hash functions'])
ylabel(['Tempo (segundos)'])
scatter(100:100:1000,time(1,:));

[b, musics]=readMp3Files('F:\Music\Favoritos');

time=zeros(1,10);
j=1;
for i=100:100:1000
    x=tic;
    [ minh, a, c ] = musicMinHash( musics,i);
    t=toc(x);
    time(1,j)=t;
    j=j+1;
end
subplot(2,2,2)
title([strcat('Base de dados com ',num2str(length(musics)),' músicas')])
xlabel(['Número de hash functions'])
ylabel(['Tempo (segundos)'])
scatter(100:100:1000,time(1,:));

[b, musics]=readMp3Files('F:\Music\cd''s');

time=zeros(1,10);
j=1;
for i=100:100:1000
    x=tic;
    [ minh, a, c ] = musicMinHash( musics,i);
    t=toc(x);
    time(1,j)=t;
    j=j+1;
end
subplot(2,2,3)
title([strcat('Base de dados com ',num2str(length(musics)),' músicas')])
xlabel(['Número de hash functions'])
ylabel(['Tempo (segundos)'])
scatter(100:100:1000,time(1,:));

[b, musics]=readMp3Files('F:\Music\');

time=zeros(1,10);
j=1;
for i=100:100:1000
    x=tic;
    [ minh, a, c ] = musicMinHash( musics,i);
    t=toc(x);
    time(1,j)=t;
    j=j+1;
end
subplot(2,2,4)
title([strcat('Base de dados com ',num2str(length(musics)),' músicas')])
xlabel(['Número de hash functions'])
ylabel(['Tempo (segundos)'])
scatter(100:100:1000,time(1,:));