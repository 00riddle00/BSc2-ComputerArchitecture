# This file is a draft for trying to make sense of ESC codes

1101 1 xxx mod yyy r/m [offset]  | ESC command, register/memory

# mod = 00

## mod = 00, r/m < 110
<pre>
1101 1 000  00 000 000 - 1101 1 111  00 111 101
D    8      0    0     - D    F      3    D
55,296 (decimal)       - 57,149 (decimal)
</pre>

### Data from Online Dissasembler (ODA) 
### (https://onlinedisassembler.com/odaweb/), arch=i8086
### the ODA dissasembled commands are different than that of TASM

```
D800: FADDS [BX+SI]
D801: FADDS [BX+DI]
D802: FADDS [BP+SI]
D803: FADDS [BP+DI]
D804: FADDS [SI]
D805: FADDS [DI]

D807: FADDS [BX]

D808: FMULS [BX+SI]
D809: FMULS ...
D80A: FMULS ...
D80B: FMULS ...
D80C: FMULS ...
D80D: FMULS ...

D80F: FMULS [BX]

D810: FCOMS [BX+SI]
D811: FCOMS ...
D812: FCOMS ...
D813: FCOMS ...
D814: FCOMS ...
D815: FCOMS ...

D817: FCOMS [BX]

D818: FCOMPS [BX+SI]
D819: FCOMPS ...
D81A: FCOMPS ...
D81B: FCOMPS ...
D81C: FCOMPS ...
D81D: FCOMPS ...

D81F: FCOMPS [BX]

D820: FSUBS  [BX+SI]
D821: FSUBS  ...
D822: FSUBS  ...
D823: FSUBS  ...
D824: FSUBS  ...
D825: FSUBS  ...

D827: FSUBS  [BX]

D828: FSUBRS [BX+SI]

...
...
```

## mod = 00, r/m = 110 (+2 bytes direct address)
<pre>
1101 1 000  00 000 110 - 1101 1 111  00 111 110
D    8      0    6     - D    F      3    E
55,302                 - 57,150
</pre>

### Data from ODA

```
D806: FADDS  [DIRECT_ADDRESS]
D80E: FMULS  [DIRECT_ADDRESS]
D816: FCOMS  [DIRECT_ADDRESS]
D81D: FCOMPS [DIRECT_ADDRESS]
D826: FSUBS  [DIRECT_ADDRESS]
...
...
...
```

## mod = 00, r/m > 110
<pre>
1101 1 111  00 111 111
D    F      3    F
57,151
</pre>

### Data from ODA

```
FISTPLL [BX]
```

# mod = 01 (+1 byte offset)
<pre>
1101 1 000  01 000 000 - 1101 1 111  01 111 111
D    8      4    0       D    F      7    F
55,360                 - 57,215
</pre>

### Data from ODA

```
D840: FADDS [BX+SI+offset_1_byte]
...
...
```
 
# mod = 10 (+2 bytes offset)
<pre>
1101 1 000  10 000 000 - 1101 1 111  10 111 111
D    8      8    0       D    F      B    F
55,424                 - 57,279
</pre>

### Data from ODA

```
D880: FADDS [BX+SI+offset_2_bytes]
...
...
```

# mod = 11
<pre>
1101 1 000  11 000 000 - 1101 1 111  11 111 111 
D    8      C    0     - D    F      F    F
55,488                 - 57,343
</pre>

```
D8C0: FADD ST, ST(0)
...
...
```
