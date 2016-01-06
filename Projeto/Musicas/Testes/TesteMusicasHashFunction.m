[b, musics]=readMp3Files('F:\Music');

p=10000019;
hash=zeros(length(musics),100);

a=randi([2,p-2],1,100);
c=randi([2,p-1],1,100);

for j=1:length(musics)
    hash(j,:)=mod(a(1,:)*sum(double(lower(musics{1,j})))+c(1,:),p);
end

hist(hash(:,:))
xlabel(['N�mero criado pela hash function'])
ylabel(['Frequ�ncia de cada n�mero criado pela hash function'])