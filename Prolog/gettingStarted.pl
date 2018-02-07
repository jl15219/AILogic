alpha(a,b).
alpha(a,c).

% element(X,Ys) <- X is an element of the list Ys
element(X,[X|_]).
element(X,[_|Ys]):-
    element(X,Ys).

% element(X,Ys,Zs) <- X is an element of the list Ys and Zs is Ys without X
element(X,[X|Ys],Ys).
element(X,[Z|Ys],[Z|Zs]):-
    element(X,Ys,Zs).

% subset(Xs,Ys) <- every element of list Xs occurs in list Ys
subset([],A) :- A \= [].
subset([X|Xs],Ys):-
    element(X,Ys),
    subset(Xs,Ys).

% subset(Xs,Ys) <- every element of list Xs occurs in list Ys
subset([],_,_).
subset([X|Xs],Ys,Zs):-
    element2(X,Ys,Ks),
    subset(Xs,Ks,Zs).

% element2(Xs,Ys,Ks) <- Stores only elements past the given first
element2(X,[X|Ys],Ys).
element2(X,[_|Ys],Zs) :- element2(X,Ys,Zs).

subset2([],_,B) :- B \= [].
subset2([X|Xs],[X|Ys],B) :- subset2(Xs,Ys,B).
subset2([X|Xs],[Y|Ys],B) :- subset2([X|Xs],Ys,[Y|B]).

% subseq1(Xs,Ys) <- every element of list Xs occurs in the same order and contiguously in list Ys
subseq1([],_).
subseq1(B,ABC) :-
        B \= [],
        append(_,BC,ABC),
        append(B,_,BC).

% subseq2(Xs,Ys) <- every element of list Xs occurs in the same order and contiguously in list Ys
subseq2([],_).
subseq2(Xs,Ys):-
        Xs \= [],
        append(Xs,_,Ys).
subseq2(Xs,[_|Ys]):-
        Xs \= [],
        subseq2(Xs,Ys).

diff(x,x,1).
diff(-U,x,-R) :- diff(U,x,R).
diff(U+V,x,RU + RV) :- diff(U,x,RU), diff(V,x,RV).
diff(U-V,x,RU - RV) :- diff(U,x,RU), diff(V,x,RV).
diff(U*V,x,(U*RV) + (V*RU)) :- diff(U,x,RU), diff(V,x,RV).


simp(U,V) :- simp2(U,V).
simp(A+B,V) :- simp(A,X), simp(B,Y), (\+ A=X ; \+ B = Y), simp(X+Y,V).
simp(A*B,V) :- simp(A,X), simp(B,Y), (\+ A=X ; \+ B = Y), simp(X*Y,V).
simp(A-B,V) :- simp(A,X), simp(B,Y), (\+ A=X ; \+ B = Y), simp(X-Y,V).
simp(A+B,V) :- simp2(B+A,V).
simp(A*B,V) :- simp2(B*A,V).
simp(U,U).

simp2(U*1,V) :- simp(U,V).
simp2(U+0,V) :- simp(U,V).
simp2(U+U,W) :- simp(U,V), simp(2*V,W).
simp2(U-U,0).
