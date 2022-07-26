/*--------------------------------------------------------------
-- Module : LabP2021
-- Developer : Flores Sofía
--
-- Programacion III - Laboratorio Prolog 2021
----------------------------------------------------------------
PARTE 1. ARITMETICA
Ejercicio 1.1 Definir la relación maximo(+X, +Y, ?Z) que se verifique si Z es el
máximo de X e Y. Por ejemplo,
?- maximo(2,3,X).
X = 3
?- maximo(3,2,X).
X = 3
*/

maximo(X,Y,Resultado):- X > Y, Resultado is X.
maximo(X,Y,Resultado):- not(X > Y), Resultado is Y.
  
maximoE(X,Y,Resultado):- X > Y,!, Resultado is X. 
maximoE(X,Y,Resultado):- not(X > Y), Resultado is Y.

/*
Ejercicio 1.2 Definir la relación factorial(+X,?Y) que se verifique si Y es el factorial
de X. Por ejemplo,
?- factorial(3,X).
X = 6
*/

factorial(X,_):- X < 0, !, fail.
factorial(0,1):- !.
factorial(X,Y):- X1 is X-1, factorial(X1,Y1), Y is Y1*X.

/*
Ejercicio 1.3 Definir la relación suma_lista(+L, ?X) que se verifique si X es la suma
de los elementos de la lista de numeros L. Por ejemplo,
?- suma_lista([1,3,5], X).
X = 9
*/

suma_lista([],_):- !, fail.
suma_lista([A],A).
suma_lista([A|L],X):- suma_lista(L,X1), X is X1+A.

/*
PARTE 2. OPERACIONES CON LISTAS
Una lista es la lista vacía o se compone de un primer elemento y un resto, que es una
lista. En Prolog, la lista vacía se representa por [ ] y las listas no vacías son de la
forma [X | L] donde X es la cabeza y L es el resto.
Ejercicio 2.1 (cabeza)
a) Definir la relación primero(?L,?X) que se verifique si X es el primer elemento de la
 lista L. Por ejemplo:
?- primero([a,b,c], X).
X = a
*/

primero([],_):- !,fail.
primero([X|L],X).

/*
b) Obtener las respuestas a las siguientes preguntas:
?- primero([X,b,c], a). Error
?- primero([X,Y], a). Error
?- primero(X,a). False
Ejercicio 2.2 (cola)
a) Definir la relación cola(?L1,?L2) que se verifique si L2 es la lista obtenida a partir
 de la lista L1 suprimiendo el primer elemento. Por ejemplo:
?- cola([a,b,c],L).
L = [b,c]
*/

cola([],_):- !,fail.
cola([A|L],L2):- L = L2. 

/*
b) Obtener las respuestas a las siguientes preguntas:
?- cola([a|L],[b,c]). L = [b,c]
?- cola(L,[b,c]). False
Ejercicio 2.3 (constructor)
a) Definir la relación cons(?X,?L1,?L2) que se verifique si L2 es la lista obtenida
 añadiéndole X a L1 como primer elemento. Por ejemplo:
?- cons(a,[b,c],L).
L = [a,b,c]
*/

cons(X,L1,[]):- !, fail.
cons(X,L1,L2):- append([X],L1,L3), L3 = L2. 

/*
b) Obtener las respuestas a las siguientes preguntas:
?- cons(X,[b,c],[a,b,c]). X = a
?- cons(a,L,[a,b,c]). L = [b,c]
?- cons(b,L,[a,b,c]). False
?- cons(X,L,[a,b,c]). X = a , L = [b,c]

Para los ejercicios que siguen, proponer soluciones recursivas y soluciones recursivas
con acumulador. En caso de no realizar la solución con acumulador, justificar. Hacer
el árbol de resolución SLD (Selective Linear Definite clause resolution) para las
consultas resaltadas en amarillo.

Ejercicio 2.4 (pertenencia o membresía)
a) Definir la relación pertenece(?X,?L) que se verifique si X es un elemento de la
 lista L. Por ejemplo,
?- pertenece(b,[a,b,c]). % arbol
Yes
?- pertenece(d,[a,b,c]).
No
*/

%Recursión sin acumulador

pertenece(X,[X|Xs]):- !.
pertenece(X,[Y|Ys]):- pertenece(X,Ys).

/*No tiene sentido hacer la recursión con acumulador porque ya se tiene una recursión
de cola*/

/*
b) Generar las consultas que permitan utilizar la relación definida para responder a las
siguientes cuestiones:
1. ¿Es c un elemento de [a,c,b,c]?

pertenece(c,[a,c,b,c]).

2. ¿Cuáles son los elementos de [a,b,a] ?

pertenece(X,[a,b,a]).

3. ¿Cuáles son los elementos comunes de [a,b,c], y [d,c,b] ?

pertenece(X,[a,b,c]),pertenece(X,[d,c,b]).

Leer 1 y 2 complementario

Ejercicio 2.5 (concatenación)
a) Definir la relación conc(?L1,?L2,?L3) que se verifique si L3 es la lista obtenida
escribiendo los elementos L2 de a continuación de los elementos de L1. Por ejemplo,
?- conc([a,b],[c,d,e],L). % arbol
L = [a,b,c,d,e]
*/

%Recursivo sin acumulador
conc1([],L,L):- !.
conc1([X|L1],L2,[X|L3]):- conc1(L1,L2,L3).

%Recursivo con acumulador
conc2(L1,L2,L3):- conc3(L1,L2,L3,L1).
conc3(X,[],Res,Res):- !.
conc3(X,[Y|Ys],Z,Res):- append(Res,[Y],Acc),conc3(X,Ys,Z,Acc).

/*
b) Generar las consultas que permitan utilizar la relación definida para responder a las
siguientes cuestiones:
 1. ¿Qué lista hay que añadirle a la lista [a,b] para obtener [a,b,c,d]?

conc1([a,b],Y,[a,b,c,d]).

2. ¿Qué listas hay que concatenar para obtener [a,b]?

conc1(X,Y,[a,b]).

3. ¿Pertenece b a la lista [a,b,c]?

conc1([a,X,c],[],[a,b,c]).

4. ¿Es [b,c] una sublista de [a,b,c,d]?

conc1(_,[b,c|_],[a,b,c,d]).

5. ¿Es [b,d] una sublista de [a,b,c,d]?

conc1(_,[b,d|_],[a,b,c,d]).

6. ¿Cuál es el último elemento de [b,a,c,d]?

conc1([b,a,c],X,[b,a,c,d]).

Ejercicio 2.6 Un palíndromo es una palabra que se lee igual en los dos sentidos, por
ejemplo “oso”. Definir la relación palindromo(+L) que se verifique si la lista L es un
palíndromo. Por ejemplo,
?- palindromo([o,s,o]). % arbol
Yes
?- palindromo([o,s,a]).
No
*/

%Palíndromo sin acumulador

palindromo(X):- reverse(X,X).

palindromo1([X]):- !.
palindromo1([X|Xs]):- last(Xs,X), reverse(Xs,[L|Ls]), palindromo1(Ls).

%Palíndromo con acumulador

palindromo2(X):- palindromo3(X,[]).
palindromo3([],Res):- !.
palindromo3([X|Xs],Res):- append([X],Res,Acc), palindromo3(Xs,Acc).

/*
Ejercicio 2.7 (duplica)
a) Definir la relación duplica(?L1,?L2) que se verifique si L2 es la lista obtenida
escribiendo cada elemento de L1 dos veces. Por ejemplo,
?- duplica([1,2,3],L). % arbol
L = [1,1,2,2,3,3]
*/

%Recursión sin acumulador
duplica1([],[]):- !.
duplica1([X|Xs],[X,X|Ys]):- duplica1(Xs,Ys).

%Recursión con acumulador
duplica2(X,Y):- duplica3(X,Y,[]).
duplica3([],Y,Y):- !.
duplica3([X|Xs],Y,Res):- append(Res,[X,X],Acc),duplica3(Xs,Y,Acc).

/*
b) Generar las consultas que permitan utilizar la relación definida para responder a las
siguientes cuestiones:
1. ¿Qué lista hay que añadirle a la lista [1,2] para obtener [1,1,2,2,3,3]?

duplica1([1,2|X],[1,1,2,2,3,3]).

2. ¿Pertenece 2 a la lista [1,1,2,2,3,3]?

duplica1([1,X,3],[1,1,2,2,3,3]).

3. ¿Es [2,3] una sublista de [1,2,3,4]?

duplica1([_2,3|_],[1,1,2,2,3,3,4,4]).


4. ¿Es [1,3] una sublista de [1,2,3,4]?

duplica1([_1,3|_],[1,1,2,2,3,3,4,4]).

Ejercicio 2.8 (longitud)
a) Definir la relación longitud(+X,?L) que se verifique si L es la longitud de la lista X.
 Por ejemplo:
?- longitud([a,b,c],3). % arbol
Yes
?- longitud ([a,b,c],X).
X=3.
*/

%Recursion sin acumulador
longitud1([],0):- !.
longitud1([X|Xs],Res):- longitud1(Xs,A),Res is A+1.

%Recursion con acumulador
longitud2(X,L):- longitud3(X,L,0).
longitud3([],L,L):- !.
longitud3([X|Xs],L,Res):- Acc is Res+1, longitud3(Xs,L,Acc).


/*
Parte 3. Estructuras
En este apartado vamos a trabajar con una base de datos familiar.
Se desea representar la información relativa a las siguientes familias:
• En la primera familia,
- el padre es Tomás García Pérez, nacido el 7 de Mayo de 1960, trabaja de profesor y
gana 60 pesos diarios;
- la madre es Ana López Ruiz, nacida el 10 de marzo de 1962, trabaja de médica y
gana 90 pesos diarios;
- el hijo es Juan García López, nacido el 5 de Enero de 1980, estudiante; 
- la hija es María García López, nacida el 12 de Abril de 1992, estudiante.
• En la segunda familia,
- el padre es José Pérez Ruiz, nacido el 6 de Marzo de 1963, trabaja de pintor y gana
120 pesos diarios;
- la madre es Luisa Gálvez Pérez, nacida el 12 de Mayo de 1964, trabaja de médica y
gana 90 pesos diarios;
- un hijo es Juan Luis Pérez Pérez, nacido el 5 de Febrero de 1990, estudiante;
- una hija es María José Pérez Pérez, nacida el 12 de Junio de 1992, estudiante;
- otro hijo es José María Pérez Pérez, nacido el 12 de Julio de 1994, estudiante.

Ejercicio 3.1: Analizar las siguientes estructuras en Prolog que permiten almacenar
los datos de las familias y discutir las ventajas /desventajas de cada una de estas
implementaciones con sus compañeros. Resumir en una tabla las conclusiones
obtenidas.
*/
% Estructura 1
familia(
 persona([tomas, garcia, perez], fecha(7, mayo, 1960), trabajo(profesor,60)),
 persona( [ana, lopez, ruiz], fecha(10,marzo,1962), trabajo(medica,90)),
 [ persona([juan, garcia, lopez], fecha(5,enero,1990), estudiante),
 persona([maria, garcia, lopez], fecha(12,abril,1992), estudiante)
 ]
 ).
familia(
 persona([jose, perez, ruiz], fecha(6,marzo,1963),trabajo(pintor,120)),
 persona([luisa, galvez, perez], fecha(12,mayo,1964), trabajo(medica,90)),
 [ persona([juan_luis, perez, perez], fecha(5,febrero,1990), estudiante),
 persona([maria_jose, perez, perez], fecha(12,junio,1992), estudiante),
 persona([jose_maria, perez, perez], fecha(12,julio,1994), estudiante)
 ]
 ).
/*
Estructura 2
familia(
[ persona( [tomas, garcia, perez], fecha(7, mayo, 1960), trabajo(profesor,60)),
 persona( [ana, lopez, ruiz], fecha(10,marzo,1962), trabajo(medica,90)),
 persona([juan, garcia, lopez], fecha(5,enero,1990), estudiante),
 persona([maria, garcia, lopez], fecha(12,abril,1992), estudiante)
 ]
 ).
familia(
[ persona([jose, perez, ruiz], fecha(6,marzo,1963),trabajo(pintor,120)),
 persona([luisa, galvez, perez], fecha(12,mayo,1964), trabajo(medica,90)),
 persona([juan_luis, perez, perez], fecha(5,febrero,1990), estudiante),
 persona([maria_jose, perez, perez], fecha(12,junio,1992), estudiante),
 persona([jose_maria, perez, perez], fecha(12,julio,1994), estudiante) 
]
 ).
 
%El análisis está en ANEXO2.pdf
 
Para los ejercicios que siguen asumir que se utiliza la Estructura 1
Ejercicio 3.2: Realizar las siguientes consultas:
• ¿existe familia sin hijos?

familia(_,_,[]).

• ¿existe familia con un hijo?

familia(_,_,[X]).

• ¿existe familia con dos hijos?

familia(_,_,[X,Y]).

• ¿existe familia con tres hijos?

familia(_,_,[X,Y,Z]).

• ¿existe familia con cuatro hijos.?

familia(_,_,[X,Y,Z,K]).

Ejercicio 3.3: Buscar los nombres de los padres de familia con tres hijos.

familia(persona(K,_,_),persona(J,_,_),[X,Y,Z]).

Ejercicio 3.4: Definir la relación casada(X) que se verifique si X es una mujer casada.
*/

casada(X):-familia(_,persona(X,_,_),_).

/*
Ejercicio 3.5: Preguntar por las mujeres casadas.

casada(X).

Ejercicio 3.6: Determinar el nombre de todas las mujeres casadas que trabajan.

familia(_,persona(X,_,trabajo(_,_)),_).

Ejercicio 3.7: Definir la relación persona(X) que se verifique si X es una persona
existente en la base de datos.
*/

persona(X):- familia(persona(X,_,_),_,_);familia(_,persona(X,_,_),_);familia(_,_,L),member(persona(X,_,_),L).

/*
Ejercicio 3.8: Preguntar por los nombres y apellidos de todas las personas existentes
en la base de datos.
*/

persona(X).

/*
Ejercicio 3.9: Definir la relación sueldo(X,Y) que se verifique si el sueldo de la
persona X es Y.
*/

sueldo(X,Y):- familia(persona(X,_,trabajo(_,Y)),_,_);familia(_,persona(X,_,trabajo(_,Y)),_).

/*
Ejercicio 3.10: Definir la relación total(L,Y) de forma que si L es una lista de
personas, entonces Y es la suma de los sueldos de las personas de la lista L.
*/

total([],0):-!.
total([L|Ls],Y):-total(Ls,Aux), sueldo(L,S), Y is Aux + S.