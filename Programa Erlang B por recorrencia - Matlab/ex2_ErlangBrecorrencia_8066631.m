% Eduardo de Almeida
% No USP: 8066631
% Exercicios da aula forma de recorrencia
close all; 
clear all; 
clc;
%pede-se que o programa calcule o numero de recursos
%em funcao do trafego em Erlangs.(assim como na parte inicial do primeiro
%problema em sala ES1)
%No entanto, opta-se por uma abordagem
%mais interessante computacionalmente no matlab, evitando-se o uso de
%exponenciais e fatorias por meio da implementacao
%da formula de recorrencia do tipo:
%               
% Y(n+1) = (X . Yn)/[(n+1) +( X . Y_n)]
%          


prompt = 'Digite o trafego em erlangs: ';
A = input(prompt);
b = 0.02; %mesma taxa de bloqueio do primeiro exercicio, de 2%(parte1ES1).
Y_n = A./(1+A); %elemento aposteriori em funcao do trafego
n = 1; %def canl
Y_n1 = 1; %inicial apriori
while Y_n1 > b %taxa de bloqueio > elemento apriori
    Y_n1 = A.*Y_n./((n+1) + A.*Y_n); %iteracao
    Y_n = Y_n1; %atribuicao elem. aposterio a priori.
    n = n+1; %continuicao do laco iterativo
end
N = n