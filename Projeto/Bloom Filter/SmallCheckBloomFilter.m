% Diogo Ferreira e Fábio Cunha, 2015

% Little check to Bloom Filter
n=100;
% Number of Hash Functions
k=3;
% Number of Insertions
i=5;

filter=initializeFilter(n);
filter=insert(filter, 'Aveiro');
filter=insert(filter, 'Braga');
filter=insert(filter, 'Lisboa');
filter=insert(filter, 'Porto');
filter=insert(filter, 'Minho');
find(filter==1)

isMember(filter, 'Aveiro')
isMember(filter, 'Braga')
isMember(filter, 'Lisboa')
isMember(filter, 'Porto')
isMember(filter, 'Minho')
isMember(filter, 'Algarve')
isMember(filter, 'Alentejo')
isMember(filter, 'Zambujeira do Mar')
isMember(filter, 'Oeiras')
isMember(filter, 'Paredes de Coura')

% Calculates collisions
colisions=i*k-sum(filter);