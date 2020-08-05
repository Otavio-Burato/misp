# O Processador MIPS

![Imagem de um processador misp](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Toshiba_TC86R4400MC-200_9636YJA_top.jpg/300px-Toshiba_TC86R4400MC-200_9636YJA_top.jpg)<br>
**Toshiba TC86R4400MC-200 9636YJA**

O MIPS é o nome de uma arquitetura de processadores baseados no uso de registradores. As suas instruções tem à disposição um conjunto de 32 registradores para realizar as operações.

Processadores MIPS são do tipo **RISC** (Reduced Instruction Set Computer - ou seja, Computadores com Conjunto de Instruções Reduzidas). Isso significa que existe um conjunto bastante pequeno de instruções que o processador sabe fazer. Combinando este pequeno número, podemos criar todas as demais operações.

# Onde é usado?

Os processadores MIPS são usados em sistemas embarcados, como portoes residenciais e roteadores, Originalmente, o MIPS foi projetado para computação de uso geral. Durante as décadas de 1980 e 1990, os processadores MIPS para computadores pessoais, estações de trabalho e servidores foram usados por muitas empresas.

Historicamente, os consoles de videogame como Nintendo 64, Sony PlayStation, PlayStation 2 e PlayStation Portable usavam processadores MIPS.

![processador](https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Sony_EmotionEngine_CXD9615GB_top.jpg/600px-Sony_EmotionEngine_CXD9615GB_top.jpg)

processador Sony CXD9615GB 'Emotion Engine' usado no ps2 e baseado no processador MIPS R5900

# Filosofia

- A simplicidade favorece a regularidade.
- O menor é (quase sempre) mais rápido.
- Um bom projeto demanda compromissos.
- O caso comum DEVE ser mais rápido.

## Lei de Amdahl

![Grafico](https://upload.wikimedia.org/wikipedia/commons/e/ea/AmdahlsLaw.svg)

### A lei de Amdahl

Também conhecida como argumento de Amdahl, é usada para encontrar a máxima melhora esperada para um sistema em geral quando apenas uma única parte do mesmo é melhorada. Isto é frequentemente usado em computação paralela para prever o máximo speedup teórico usando múltiplos processadores. A lei possui o nome do Arquiteto computacional Gene Amdahl, e foi apresentada a AFIPS na Conferência Conjunta de Informática na primavera de 1967.

### Speedup

Speedup pode ser definido como a relação entre o tempo gasto para executar uma tarefa com um único processador e o tempo gasto com N processadores, ou seja, Speedup é a Medida do ganho em tempo.

### Relação?

A arquitetura Misp tem o propósito de ser leve rápida e optimizar as instruções que são mais usadas durante a execução.<br>
ou seja é muito melhor tornar uma instrução que é usada 90% do tempo 10% mais rápida do que fazer com que uma instrução usada em 10% das vezes torne-se 90% mais rápida. 
# Instruções e registradores

As instruções seguem a forma **"instrução" "registrador final", "primeiro", "segundo"**

seguindo essa lógica se usarmos 

``` asm
add $t0, $t1, $t2
```
estamos somando $t2 a $t1 e armazenando o resultado em $t0

### Instruções Aritméticas Simples

Instrução de adição
``` asm
add $r1, $r2, $r3
```

Instrução de subtração
``` asm
sub $r1, $r2, $r3
```

### Instruções de Operadores Lógicos

Instrução AND bit a bit
``` asm
and $r1, $r2, $r3
```

Instrução OR bit a bit
``` asm
or $r1, $r2, $r3 
```

### Instruções de Uso de memória

Essa instrução é usada para carregar valores dentro de um vetor.

(estrutura de 4 bytes)
``` asm
lw $r1, 4($r2)
```

(estrutura de 2 bytes)
``` asm
lh $r1, 6($r3)
```

(estrutura de 16 bytes)
``` asm
lb $r1, 16($r2)
```

### Instruções de Controle de Fluxo

As instruções **Branch** são usadas para controle de fluxo como "if" ou "for".<br>
para entender melhor os [mnemônicos](https://pt.wikipedia.org/wiki/Mnem%C3%B3nica) basta pensar na sua abreviação

- beq -> branch if equals **==**
- bne -> branch if not a equals **!=**
- bgt -> branch if greater than **>**
- bge -> branch if greater or equals **>=**
- blt -> branch if less than **<**
- ble -> branch if less or equals **<=**

para usar essas instruções é necessário usar **label**, rótulos no código que define um destino.<br>
junto da instrução "j", jump, essa instrução vai para o rótulo sem a necessidade de uma condição.

``` asm
.data
	msg1:.asciiz"\nthen"
	msg2:.asciiz"\nelse"
.text 
main:
	#branch beq, bne, bgt, bge, blt, ble
	# branch op1, op2, label
	li $t1, 2
	li $t2, 2
	
	beq $t0, $t2, then: # essa condição verifica se $t0 é igual a $t2 se sim vai para "then:"
	j else # caso contrário a instrução segue em diante e pula para else.
	
then:
	li $v0, 4
	la $a0, msg1
	syscall
	j end

else:
	li $v0, 4
	la $a0, msg2
	syscall
	
end:
```

No exemplo acima os rotolo *else* são destino da branch **beq**

### Instruções de Comparações

Instrução de comparação de $r2 e $r3, a diferença aqui é que a comparação não pula para um rótulo e sim armazena 0 ou 1 no registrador $r1.
``` asm
slt $r1, $r2, $r3
```

# Instruções e seus tipos

A arquitetura misp reconhece 3 tipos de instruções.

- As Instruções Tipo R
- As Instruções Tipo I
- As Instruções Tipo J

<table>
<thead>
  <tr>
    <th>Tipo</th>
    <th colspan="6">formato (bits)</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>R</td>
    <td>opcode (6)</td>
    <td>rs (5)</td>
    <td>rt (5)</td>
    <td>rd (5)</td>
    <td>shamt (5)</td>
    <td>funct (6)</td>
  </tr>
  <tr>
    <td>I</td>
    <td>opcode (6)</td>
    <td>rs (5)</td>
    <td>rt (5)</td>
    <td colspan="3">immediate (16)</td>
  </tr>
  <tr>
    <td>J</td>
    <td>opcode (6)</td>
    <td colspan="5">address (26)</td>
  </tr>
</tbody>
</table>

# Pseudo-Instruções

A linguagem Assembly de uma máquina costuma ser um reflexo direto de como são implementadas as instruções de um determinado processador. Entretanto, nem todas as instruções que temos à disposição quando programamos em Assembly são instruções verdadeiras para o processador. Algumas delas são na verdade pseudo-instruções.

Pseudo-instruções costumam ser substituídas pelo montador ao gerar instruções para o computador na forma de Lingüagem de Máquina. Pseudo-Instruções são na verdade combinações de mais de uma instrução.

`move $r1, $r2` Ela é na verdade implementada da seguinte forma `addu $r1, $r0, $r2`

Ou seja adiciona 0 ao registrador e coloca o resultado no destino.

# As Etapas Necessárias para Invocar Funções.

### Convenções

Quando queremos chamar uma função, as seguintes etapas devem ser cumpridas:

- O programa principal deve colocar os parâmetros da função em um local que ela possa acessar.
- O programa principal deve ceder o controle para a função.
- A função deve coletar todos os parâmetros deixados pelo programa principal.
- A função deve executar a tarefa desejada.
- A função deve armazenar seus resultados em um lugar em que o programa principal possa acessar.
- A função deve retornar o fluxo do código para o ponto imediatamente após ser chamada.

Para que estes requisitos sejam cumpridos, as seguintes convenções fora criadas:

- Os registradores $r4, $r5, $r6 e $r7 seriam usados para armazenar parâmetros de funções. Por causa desta funcionalidade, tais registradores podem ser chamados pelos seus "apelidos": $a0, $a1, $a2 e $a3.
- Os registradores $r2 e $r3 seriam usados para as funções armazenarem seus valores de retorno para o programa principal. Por isso, eles costumam ser chamados de $v0 e $v1.

Além dos registradores convencionados acima, o registrador $r31 também tem um papel importante. Ele sempre armazena o endereço de retorno para o qual a última função chamada deve retornar. Por ter uma função tão importante, este registrador é mais conhecido pelo apelido $ra.

### Instruções de Uso de Funções: jal e jr

instrução `jal` ou jump and link é usado da seguinte forma, jal endereço

instrução `jr` ou jump register é usado da seguinte forma, jr $ra

como exemplo vamos usar a seguinte função em C

``` c
int example(int a, int b){
   int f;
   
   f = a + b;
   return f;
}
```

em misp fica da seguinte forma

``` asm
example:
          add $v0, $a0, $a1
          jr $ra
```

# Referência

[Misp book](https://pt.wikibooks.org/wiki/Introdu%C3%A7%C3%A3o_%C3%A0_Arquitetura_de_Computadores/O_que_%C3%A9_o_MIPS%3F)

[Misp wiki](https://pt.wikipedia.org/wiki/Arquitetura_MIPS)

[Lei de Amdahl](https://pt.wikipedia.org/wiki/Lei_de_Amdahl)

# O Processador MIPS

![Imagem de um processador misp](https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Toshiba_TC86R4400MC-200_9636YJA_top.jpg/300px-Toshiba_TC86R4400MC-200_9636YJA_top.jpg)<br>
**Toshiba TC86R4400MC-200 9636YJA**

O MIPS é o nome de uma arquitetura de processadores baseados no uso de registradores. As suas instruções tem à disposição um conjunto de 32 registradores para realizar as operações.

Processadores MIPS são do tipo **RISC** (Reduced Instruction Set Computer - ou seja, Computadores com Conjunto de Instruções Reduzidas). Isso significa que existe um conjunto bastante pequeno de instruções que o processador sabe fazer. Combinando este pequeno número, podemos criar todas as demais operações.

# Onde é usado?

Os processadores MIPS são usados em sistemas embarcados, como portões residenciais e roteadores, Originalmente, o MIPS foi projetado para computação de uso geral. Durante as décadas de 1980 e 1990, os processadores MIPS para computadores pessoais, estações de trabalho e servidores foram usados por muitas empresas.

Historicamente, os consoles de videogame como Nintendo 64, Sony PlayStation, PlayStation 2 e PlayStation Portable usavam processadores MIPS.

[processador](https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Sony_EmotionEngine_CXD9615GB_top.jpg/600px-Sony_EmotionEngine_CXD9615GB_top.jpg)

processador Sony CXD9615GB 'Emotion Engine' usado no ps2 e baseado no processador MIPS R5900

# Filosofia

- A simplicidade favorece a regularidade.
- O menor é (quase sempre) mais rápido.
- Um bom projeto demanda compromissos.
- O caso comum DEVE ser mais rápido.

## Lei de Amdahl

![Grafico](https://upload.wikimedia.org/wikipedia/commons/e/ea/AmdahlsLaw.svg)

### A lei de Amdahl

Também conhecida como argumento de Amdahl, é usada para encontrar a máxima melhora esperada para um sistema em geral quando apenas uma única parte do mesmo é melhorada. Isto é frequentemente usado em computação paralela para prever o máximo speedup teórico usando múltiplos processadores. A lei possui o nome do Arquiteto computacional Gene Amdahl, e foi apresentada a AFIPS na Conferência Conjunta de Informática na primavera de 1967.

### Speedup

Speedup pode ser definido como a relação entre o tempo gasto para executar uma tarefa com um único processador e o tempo gasto com N processadores, ou seja, Speedup é a Medida do ganho em tempo.

### Relação?

A arquitetura Misp tem o propósito de ser leve rápida e optimizar as instruções que são mais usadas durante a execução.

# Instruções e registradores

As instruções seguem a forma **"instrução" "registrador final", "primeiro", "segundo"**

seguindo essa lógica se usarmos 

``` asm
add $t0, $t1, $t2
```
estamos somando $t2 a $t1 e armazenando o resultado em $t0

### Instruções Aritméticas Simples

Instrução de adição
``` asm
add $r1, $r2, $r3
```

Instrução de subtração
``` asm
sub $r1, $r2, $r3
```

### Instruções de Operadores Lógicos

Instrução AND bit a bit
``` asm
and $r1, $r2, $r3
```

Instrução OR bit a bit
``` asm
or $r1, $r2, $r3 
```

### Instruções de Uso de memória

Essa instrução é usada para carregar valores dentro de um vetor.

(estrutura de 4 bytes)
``` asm
lw $r1, 4($r2)
```

(estrutura de 2 bytes)
``` asm
lh $r1, 6($r3)
```

(estrutura de 16 bytes)
``` asm
lb $r1, 16($r2)
```

### Instruções de Controle de Fluxo

As instruções **Branch** são usadas para controle de fluxo como "if" ou "for".<br>
para entender melhor os [mnemônicos](https://pt.wikipedia.org/wiki/Mnem%C3%B3nica) basta pensar na sua abreviação

- beq -> branch if equals **==**
- bne -> branch if not a equals **!=**
- bgt -> branch if greater than **>**
- bge -> branch if greater or equals **>=**
- blt -> branch if less than **<**
- ble -> branch if less or equals **<=**

para usar essas instruções é necessário usar **label**, rótulos no código que define um destino.<br>
junto da instrução "j", jump, essa instrução vai para o rótulo sem a necessidade de uma condição.

``` asm
.data
	msg1:.asciiz"\nthen"
	msg2:.asciiz"\nelse"
.text 
main:
	#branch beq, bne, bgt, bge, blt, ble
	# branch op1, op2, label
	li $t1, 2
	li $t2, 2
	
	beq $t0, $t2, then: # essa condição verifica se $t0 é igual a $t2 se sim vai para "then:"
	j else # caso contrário a instrução segue em diante e pula para else.
	
then:
	li $v0, 4
	la $a0, msg1
	syscall
	j end

else:
	li $v0, 4
	la $a0, msg2
	syscall
	
end:
```

No exemplo acima os rotolo *else* são destino da branch **beq**

### Instruções de Comparações

Instrução de comparação de $r2 e $r3, a diferença aqui é que a comparação não pula para um rótulo e sim armazena 0 ou 1 no registrador $r1.
``` asm
slt $r1, $r2, $r3
```

# Instruções e seus tipos

A arquitetura misp reconhece 3 tipos de instruções.

- As Instruções Tipo R
- As Instruções Tipo I
- As Instruções Tipo J

<table>
<thead>
  <tr>
    <th>Tipo</th>
    <th colspan="6">formato (bits)</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>R</td>
    <td>opcode (6)</td>
    <td>rs (5)</td>
    <td>rt (5)</td>
    <td>rd (5)</td>
    <td>shamt (5)</td>
    <td>funct (6)</td>
  </tr>
  <tr>
    <td>I</td>
    <td>opcode (6)</td>
    <td>rs (5)</td>
    <td>rt (5)</td>
    <td colspan="3">immediate (16)</td>
  </tr>
  <tr>
    <td>J</td>
    <td>opcode (6)</td>
    <td colspan="5">address (26)</td>
  </tr>
</tbody>
</table>

[opcode](https://pt.wikipedia.org/wiki/C%C3%B3digo_de_opera%C3%A7%C3%A3o)

# Pseudo-Instruções

A linguagem Assembly de uma máquina costuma ser um reflexo direto de como são implementadas as instruções de um determinado processador. Entretanto, nem todas as instruções que temos à disposição quando programamos em Assembly são instruções verdadeiras para o processador. Algumas delas são na verdade pseudo-instruções.

Pseudo-instruções costumam ser substituídas pelo montador ao gerar instruções para o computador na forma de Lingüagem de Máquina. Pseudo-Instruções são na verdade combinações de mais de uma instrução.

`move $r1, $r2` Ela é na verdade implementada da seguinte forma `addu $r1, $r0, $r2`

Ou seja adiciona 0 ao registrador e coloca o resultado no destino.

# As Etapas Necessárias para Invocar Funções.

### Convenções

Quando queremos chamar uma função, as seguintes etapas devem ser cumpridas:

- O programa principal deve colocar os parâmetros da função em um local que ela possa acessar.
- O programa principal deve ceder o controle para a função.
- A função deve coletar todos os parâmetros deixados pelo programa principal.
- A função deve executar a tarefa desejada.
- A função deve armazenar seus resultados em um lugar em que o programa principal possa acessar.
- A função deve retornar o fluxo do código para o ponto imediatamente após ser chamada.

Para que estes requisitos sejam cumpridos, as seguintes convenções fora criadas:

- Os registradores $r4, $r5, $r6 e $r7 seriam usados para armazenar parâmetros de funções. Por causa desta funcionalidade, tais registradores podem ser chamados pelos seus "apelidos": $a0, $a1, $a2 e $a3.
- Os registradores $r2 e $r3 seriam usados para as funções armazenarem seus valores de retorno para o programa principal. Por isso, eles costumam ser chamados de $v0 e $v1.

Além dos registradores convencionados acima, o registrador $r31 também tem um papel importante. Ele sempre armazena o endereço de retorno para o qual a última função chamada deve retornar. Por ter uma função tão importante, este registrador é mais conhecido pelo apelido $ra.

### Instruções de Uso de Funções: jal e jr

instrução `jal` ou jump and link é usado da seguinte forma, jal endereço

instrução `jr` ou jump register é usado da seguinte forma, jr $ra

como exemplo vamos usar a seguinte função em C

``` c
int example(int a, int b){
   int f;
   
   f = a + b;
   return f;
}
```

em misp fica da seguinte forma

``` asm
example:
          add $v0, $a0, $a1
          jr $ra
```

# Referência

[Misp book](https://pt.wikibooks.org/wiki/Introdu%C3%A7%C3%A3o_%C3%A0_Arquitetura_de_Computadores/O_que_%C3%A9_o_MIPS%3F)

[Misp wiki](https://pt.wikipedia.org/wiki/Arquitetura_MIPS)

[Lei de Amdahl](https://pt.wikipedia.org/wiki/Lei_de_Amdahl)

[Misp en](https://en.wikipedia.org/wiki/MIPS_architecture)

[Playstation](https://pt.wikipedia.org/wiki/PlayStation_2)

[Opcode](https://pt.wikipedia.org/wiki/C%C3%B3digo_de_opera%C3%A7%C3%A3o)
