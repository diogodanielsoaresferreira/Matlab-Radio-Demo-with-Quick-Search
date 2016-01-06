% Diogo Ferreira e Fábio Cunha, 2015

% Teste de tempo para diferentes tamanhos de bases de dados.

size=zeros(5,2);

x=tic;
[b, musics]=readMp3Files('F:\Music\Top');
[ minh, a, c ] = musicMinHash( musics );
sim=minHashDist(minh);
t=toc(x);
size(1,1)=b.size;
size(1,2)=t;

y=tic;
[b, musics]=readMp3Files('F:\Music\Favoritos');
[ minh, a, c ] = musicMinHash( musics );
sim=minHashDist(minh);
t=toc(y);
size(2,1)=b.size;
size(2,2)=t;

g=tic;
[b, musics]=readMp3Files('F:\cd''s');
[ minh, a, c ] = musicMinHash( musics );
sim=minHashDist(minh);
t=toc(g);
size(3,1)=b.size;
size(3,2)=t;

z=tic;
[b, musics]=readMp3Files('F:\Music\cd''s');
[ minh, a, c ] = musicMinHash( musics );
sim=minHashDist(minh);
t=toc(z);
size(4,1)=b.size;
size(4,2)=t;

l=tic;
[b, musics]=readMp3Files('F:\Music\');
[ minh, a, c ] = musicMinHash( musics );
sim=minHashDist(minh);
t=toc(l);
size(5,1)=b.size;
size(5,2)=t;

x=size(:,1);
y=size(:,2);
createFit(x,y);