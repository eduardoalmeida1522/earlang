%Eduardo de Almeida
%8066631
%Exercicio sobre Earlang C

%A formulacao para Erlang C expressa a probabilidade de uma solicitação 
%ser enfileirada quando da falta de recursos para atendimento expressando 
%a prob atribuição á fila.
%O Codigo abaixo calcula a probabilidade de enfileiramento, ou atraso 
%condicional, bem como o tempo medio de ocupacao. 
%Tendo como entrada a quantidade de tráfego disponivel, bem como 
%quantidade de recursos disponivel.
%supoem-se que as chamadas bloqueadas permaneçam no sistema até que possam 
%ser manipuladas.
%considerando-se ainda que o atraso maior que zero:
close all;
clear all; 
clc;

 prompt = 'Digite o trafego em erlangs? ';
 A = input(prompt); %E
 
 prompt = 'Informe a quantidade de recursos: ';
 C = input(prompt);

numerador = A.^C;

k = 0;
sum = 0;
while k < C
   sum = sum + (A.^k)./factorial(k);
   k = k+1;
end
%Calcular o trafego em funcao do numero de recursos por Erlang C.
denominador = A.^C + (factorial(C) * (1 - A./C) * sum);
prob_atraso = numerador ./ denominador;

% atraso maior que t dado atraso:

num_medio_chamadas_por_tempo = 1; %chamadas por hora
traf_por_usuario = 0.029; %E por micro segundos
tempo_medio_de_ocup = (traf_por_usuario ./ num_medio_chamadas_por_tempo) .* 3600 %em segundos
tempo_de_espera_max = 10; %dado em segundos
prob_atraso_cond = exp((A - C) .* (tempo_de_espera_max ./ tempo_medio_de_ocup))
prob_atraso_maior_t = prob_atraso .* prob_atraso_cond; %