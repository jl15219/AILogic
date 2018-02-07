% released_since(M,Y) <- movie M was released after year X
released_since(M,Y) :- movie(M,K),K > Y.

% released_between(M,Y1,Y2) <- movie M was released between year X and year Y inclusive
released_between(M,Y1,Y2) :- movie(M,K), K >= Y1, Y2 >= K.

% same_year_as(M1,M2) <- movie M1 was released in the same year as movie M2
same_year_as(M1,M2) :- movie(M1,Y),movie(M2,Y).

% newer(M1,M2) <- movie M1 was released after movie M2
newer(M1,M2) :- movie(M1,Y1),movie(M2,Y2), Y1 > Y2.

% cast_member(A,M) <- person A was an actor or actress in movie M
% (Give as a two predicates)
cast_member(A,M) :- actor(M,A,_).
cast_member(A,M) :- actress(M,A,_).

% cast_member2(A,M) <- person A was an actor or actress in movie M
% (Give as a single predicate using the ; disjunction predicate)
cast_member2(A,M) :- actor(M,A,_) ; actress(M,A,_).

% directed_by(X,Y) <- person X has been in a movie directed by Y
% (Hint: re-use your cast_member/2 predicate)
directed_by(A,D) :- cast_member(A,M), director(M,D).

% the first query with give every combination of the two possible movies
% the second query will not give any cases where the movies are teh same
% the thrid query will only list results where M1 is smaller than M2 lexagraphically

% these give multiple answers as the _ are trying every possibility and giving a result on every possibility
