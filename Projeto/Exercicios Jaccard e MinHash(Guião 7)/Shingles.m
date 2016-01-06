function [ shingleMatrix ] = Shingles( allMovies, finalUsers, Set )

    shingleMatrix=zeros(length(allMovies), length(finalUsers));
    % Forma tabela bin�ria com os filmes(Shingles) nas linhas e os
    % utilizadores nas colunas. Sempre que o utilizador possui um filme, a
    % posi��o fica '1'.
    for i=1:length(allMovies)
        for j=1:length(finalUsers)
            if find(Set{j}==allMovies(i))
                shingleMatrix(i,j)=1;
            end
        end
    end

end

