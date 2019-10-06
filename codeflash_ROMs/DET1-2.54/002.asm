; Disassembly of the file "002.rom"
;
; Created with dZ80 v1.31
;
; on Saturday, 20 of April 2002 at 07:05 PM
;

4000  00 01 02 03 04 05 06 07    Main  Back  Print F1    F2    F3    F4    F5
4008  00 00 00 08 09 0a 48 19    Main  Main  Main  @     Size  Spell Email PgUp
4010  0b 0c 0d 0e 0f 10 11 12    `     1     2     3     4     5     6     7
4018  13 14 15 16 17 18 27 28    8     9     0     -     =     Delet |     PgDn
4020  1a 1b 1c 1d 1e 1f 20 21    Tab   Q     W     E     R     T     Y     U
4028  22 23 24 25 26 33 34 35    I     O     P     [     ]     ;     '     Enter
4030  29 2a 2b 2c 2d 2e 2f 30    Caps  A     S     D     F     G     H     J
4038  31 32 3e 3f 40 42 47 46    K     L     ,     .     /     Up    Down  Right
4040  36 37 38 39 3a 3b 3c 3d    Shift Z     X     C     V     B     N     M
4048  43 00 00 44 00 00 41 45    Fn    Main  Main  Space Main  Main  Shift Left
4050  49 00 00 00 00 00 00 00    On/Of Main  Main  Main  Main  Main  Main  Main

' char *KeyNames[74] = { "Main", "Back", ...etc... );
4058  ec40
405a  f140
405c  f640
405e  fc40
4060  ff40
4062  0241
4064  0541
4066  0841
4068  0b41
406a  0d41
406c  1241
406e  1b41
4070  1d41
4072  1f41
4074  2141
4076  2341
4078  2541
407a  2741
407c  2941
407e  2b41
4080  2d41
4082  2f41
4084  3141
4086  3341
4088  3541
408a  3841
408c  3d41
408e  4141
4090  4341
4092  4541
4094  4741
4096  4941
4098  4b41
409a  4d41
409c  4f41
409e  5141
40a0  5341
40a2  5541
40a4  5741
40a6  5941
40a8  5b41
40aa  6041
40ac  6541
40ae  6741
40b0  6941
40b2  6b41
40b4  6d41
40b6  6f41
40b8  7141
40ba  7341
40bc  7541
40be  7741
40c0  7941
40c2  7b41
40c4  8141
40c6  8741
40c8  8941
40ca  8b41
40cc  8d41
40ce  8f41
40d0  9141
40d2  9341
40d4  9541
40d6  9741
40d8  9941
40da  9b41
40dc  a141
40de  a441
40e0  a741
40e2  a941
40e4  ae41
40e6  b441
40e8  b941
40ea  c041

40ec  Main\0
40f1  Back\0
40f6  Print\0
40fc  F1\0
40ff  F2\0
4102  F3\0
4105  F4\0
4108  F5\0
410b  @\0
410d  Size\0
4112  Spelling\0
411b  `\0
411d  1\0
411f  2\0
4121  3\0
4123  4\0
4125  5\0
4127  6\0
4129  7\0
412b  8\0
412d  9\0
412f  0\0
4131  -\0
4133  =\0
4135  <-\0
4138  PgUp\0
413d  TAB\0
4141  Q\0
4143  W\0
4145  E\0
4147  R\0
4149  T\0
414b  Y\0
414d  U\0
414f  I\0
4151  O\0
4153  P\0
4155  [\0
4157  ]\0
4159  |\0
415b  PgDn
4160  CAPS\0
4165  A\0
4167  S\0
4169  D\0
416b  F\0
416d  G\0
416f  H\0
4171  J\0
4173  K\0
4175  L\0
4177  ;\0
4179  '\0
417b  ENTER\0
4181  Shift\0
4187  Z\0
4189  X\0
418b  C\0
418d  V\0
418f  B\0
4191  N\0
4193  M\0
4195  ,\0
4197  .\0
4199  /\0
419b  Shift\0
41a1  up\0
41a4  Fn\0
41a7   \0   'Space Null
41a9  left\0
41ae  right\0
41b4  down\0
41b9  E-mail\0
41c0  On/Off\0

'
' X = 0 - 319 left to right
' Y = 0 - 127 Top to Bottom
' Outline of key is 14 pixels high
' Struct { Xs, Y, Xe } KeyLocation [74];

  2,  36,  32
 33,  36,  67
 68,  36, 102
103,  36, 123
124,  36, 144

41c7  0200
41c9  2400
41cb  2000

41cd  2100
41cf  2400
41d1  4300

41d3  4400
41d5  2400
41d7  6600

41d9  6700
41db  2400
41dd  7b00

41df  7c00
41e1  2400
41e3  9000

41e5  9100
41e7  2400
41e9  a500

41eb  a600
41ed  2400
41ef  ba00

41f1  bb00
41f3  2400
41f5  cf00

41f7  d000
41f9  2400
41fb  df00

41fd  e000
41ff  2400
4201  fe00

4203  ff00
4205  2400
4207  3d01

4209  0200
420b  3300
420d  1300

420f  1400
4211  3300
4213  2500

4215  2600
4217  3300
4219  3700

421b  3800
421d  3300
421f  4900

4221  4a00
4223  3300
4225  5b00

4227  5c00
4229  3300
422b  6d00

422d  6e00
422f  3300
4231  7f00

4233  8000
4235  3300
4237  9100

4239  9200
423b  3300
423d  a300

423f  a400
4241  3300
4243  b500

4245  b600
4247  3300
4249  c700

424b  c800
424d  3300
424f  d900

4251  da00
4253  3300
4255  eb00

4257  ec00
4259  3300
425b  0601

425d  07        rlca    
425e  013300    ld      bc,#0033
4261  3d        dec     a
4262  010200    ld      bc,#0002
4265  42        ld      b,d
4266  00        nop     
4267  23        inc     hl
4268  00        nop     
4269  24        inc     h
426a  00        nop     
426b  42        ld      b,d
426c  00        nop     
426d  35        dec     (hl)
426e  00        nop     
426f  3600      ld      (hl),#00
4271  42        ld      b,d
4272  00        nop     
4273  47        ld      b,a
4274  00        nop     
4275  48        ld      c,b
4276  00        nop     
4277  42        ld      b,d
4278  00        nop     
4279  59        ld      e,c
427a  00        nop     
427b  5a        ld      e,d
427c  00        nop     
427d  42        ld      b,d
427e  00        nop     
427f  6b        ld      l,e
4280  00        nop     
4281  6c        ld      l,h
4282  00        nop     
4283  42        ld      b,d
4284  00        nop     
4285  7d        ld      a,l
4286  00        nop     
4287  7e        ld      a,(hl)
4288  00        nop     
4289  42        ld      b,d
428a  00        nop     
428b  8f        adc     a,a
428c  00        nop     
428d  90        sub     b
428e  00        nop     
428f  42        ld      b,d
4290  00        nop     
4291  a1        and     c
4292  00        nop     
4293  a2        and     d
4294  00        nop     
4295  42        ld      b,d
4296  00        nop     
4297  b3        or      e
4298  00        nop     
4299  b4        or      h
429a  00        nop     
429b  42        ld      b,d
429c  00        nop     
429d  c5        push    bc
429e  00        nop     
429f  c600      add     a,#00
42a1  42        ld      b,d
42a2  00        nop     
42a3  d7        rst     #10
42a4  00        nop     
42a5  d8        ret     c
42a6  00        nop     
42a7  42        ld      b,d
42a8  00        nop     
42a9  e9        jp      (hl)
42aa  00        nop     
42ab  ea0042    jp      pe,#4200
42ae  00        nop     
42af  fb        ei      
42b0  00        nop     
42b1  fc0042    call    m,#4200
42b4  00        nop     
42b5  0d        dec     c
42b6  010e01    ld      bc,#010e
42b9  42        ld      b,d
42ba  00        nop     
42bb  3d        dec     a
42bc  010200    ld      bc,#0002
42bf  51        ld      d,c
42c0  00        nop     
42c1  29        add     hl,hl
42c2  00        nop     
42c3  2a0051    ld      hl,(#5100)
42c6  00        nop     
42c7  3b        dec     sp
42c8  00        nop     
42c9  3c        inc     a
42ca  00        nop     
42cb  51        ld      d,c
42cc  00        nop     
42cd  4d        ld      c,l
42ce  00        nop     
42cf  4e        ld      c,(hl)
42d0  00        nop     
42d1  51        ld      d,c
42d2  00        nop     
42d3  5f        ld      e,a
42d4  00        nop     
42d5  60        ld      h,b
42d6  00        nop     
42d7  51        ld      d,c
42d8  00        nop     
42d9  71        ld      (hl),c
42da  00        nop     
42db  72        ld      (hl),d
42dc  00        nop     
42dd  51        ld      d,c
42de  00        nop     
42df  83        add     a,e
42e0  00        nop     
42e1  84        add     a,h
42e2  00        nop     
42e3  51        ld      d,c
42e4  00        nop     
42e5  95        sub     l
42e6  00        nop     
42e7  96        sub     (hl)
42e8  00        nop     
42e9  51        ld      d,c
42ea  00        nop     
42eb  a7        and     a
42ec  00        nop     
42ed  a8        xor     b
42ee  00        nop     
42ef  51        ld      d,c
42f0  00        nop     
42f1  ba        cp      d
42f2  00        nop     
42f3  bb        cp      e
42f4  00        nop     
42f5  51        ld      d,c
42f6  00        nop     
42f7  cc00cd    call    z,#cd00
42fa  00        nop     
42fb  51        ld      d,c
42fc  00        nop     
42fd  de00      sbc     a,#00
42ff  df        rst     #18
4300  00        nop     
4301  51        ld      d,c
4302  00        nop     
4303  f1        pop     af
4304  00        nop     
4305  f20051    jp      p,#5100
4308  00        nop     
4309  3d        dec     a
430a  010200    ld      bc,#0002
430d  60        ld      h,b
430e  00        nop     
430f  2e00      ld      l,#00
4311  2f        cpl     
4312  00        nop     
4313  60        ld      h,b
4314  00        nop     
4315  40        ld      b,b
4316  00        nop     
4317  41        ld      b,c
4318  00        nop     
4319  60        ld      h,b
431a  00        nop     
431b  52        ld      d,d
431c  00        nop     
431d  53        ld      d,e
431e  00        nop     
431f  60        ld      h,b
4320  00        nop     
4321  64        ld      h,h
4322  00        nop     
4323  65        ld      h,l
4324  00        nop     
4325  60        ld      h,b
4326  00        nop     
4327  76        halt    
4328  00        nop     
4329  77        ld      (hl),a
432a  00        nop     
432b  60        ld      h,b
432c  00        nop     
432d  88        adc     a,b
432e  00        nop     
432f  89        adc     a,c
4330  00        nop     
4331  60        ld      h,b
4332  00        nop     
4333  9a        sbc     a,d
4334  00        nop     
4335  9b        sbc     a,e
4336  00        nop     
4337  60        ld      h,b
4338  00        nop     
4339  ac        xor     h
433a  00        nop     
433b  ad        xor     l
433c  00        nop     
433d  60        ld      h,b
433e  00        nop     
433f  be        cp      (hl)
4340  00        nop     
4341  bf        cp      a
4342  00        nop     
4343  60        ld      h,b
4344  00        nop     
4345  d0        ret     nc
4346  00        nop     
4347  d1        pop     de
4348  00        nop     
4349  60        ld      h,b
434a  00        nop     
434b  e200e3    jp      po,#e300
434e  00        nop     
434f  60        ld      h,b
4350  00        nop     
4351  0f        rrca    
4352  011001    ld      bc,#0110
4355  60        ld      h,b
4356  00        nop     
4357  3d        dec     a
4358  010200    ld      bc,#0002
435b  6f        ld      l,a
435c  00        nop     
435d  2e00      ld      l,#00
435f  2f        cpl     
4360  00        nop     
4361  6f        ld      l,a
4362  00        nop     
4363  e200e3    jp      po,#e300
4366  00        nop     
4367  6f        ld      l,a
4368  00        nop     
4369  fc00fd    call    m,#fd00
436c  00        nop     
436d  6f        ld      l,a
436e  00        nop     
436f  1d
4370  011e01
4373  6f
4374  00
4375  3d
4376  010101
4379  0a
437a  00
437b  3d
437c  01ca00
437f  0a
4380  00
4381  f7
4382  00

4383  8543
4385  RAM  TESTING\0

4392  9443
4394  ROM  TESTING\0

43a1  a343
43a3  Rom Checksum:\0



' DisplayKeyboard()
43b1  11feff    ld      de,#fffe
43b4  cd6b05    call    #056b

' Clear Display Buffer
43b7  cd6424    call    #2464

' v9 = 0
43ba  210900    ld      hl,#0009
43bd  39        add     hl,sp
43be  3600      ld      (hl),#00

43c0  182b      jr      #43ed           ; (43)

' v8 = 0
43c2  2b        dec     hl
43c3  3600      ld      (hl),#00
43c5  1813      jr      #43da           ; (19)

' DrawKey(v9, v8)
43c7  d5        push    de
43c8  23        inc     hl
43c9  5e        ld      e,(hl)
43ca  d5        push    de
43cb  cdf943    call    #43f9
43ce  d1        pop     de
43cf  d1        pop     de

' v8 = v8 + 1
43d0  210800    ld      hl,#0008
43d3  39        add     hl,sp
43d4  e5        push    hl
43d5  6e        ld      l,(hl)
43d6  23        inc     hl
43d7  eb        ex      de,hl
43d8  e1        pop     hl
43d9  73        ld      (hl),e

' if v8 < 8 goto 43c7
43da  210800    ld      hl,#0008
43dd  39        add     hl,sp
43de  5e        ld      e,(hl)
43df  1600      ld      d,#00
43e1  7e        ld      a,(hl)
43e2  fe08      cp      #08
43e4  38e1      jr      c,#43c7         ; (-31)

' v9 = v9 + 1
43e6  23        inc     hl
43e7  e5        push    hl
43e8  6e        ld      l,(hl)
43e9  23        inc     hl
43ea  eb        ex      de,hl
43eb  e1        pop     hl
43ec  73        ld      (hl),e

' if v9 >= 11 goto 2473
43ed  210900    ld      hl,#0009
43f0  39        add     hl,sp
43f1  7e        ld      a,(hl)
43f2  fe0b      cp      #0b

' When Done Write Display Buffer to LCD
43f4  d27324    jp      nc,#2473

43f7  18c9      jr      #43c2           ; (-55)



' DrawKey(b1, b2) b1=0-10 b2=0-7
43f9  11f6ff    ld      de,#fff6
43fc  cd6b05    call    #056b

' v10 = 0
43ff  211000    ld      hl,#0010
4402  39        add     hl,sp
4403  3600      ld      (hl),#00

' v18 = b2
4405  211800    ld      hl,#0018
4408  39        add     hl,sp
4409  5e        ld      e,(hl)
440a  1600      ld      d,#00
440c  d5        push    de

' v16 * 8
440d  2b        dec     hl
440e  2b        dec     hl
440f  5e        ld      e,(hl)
4410  eb        ex      de,hl
4411  29        add     hl,hl
4412  29        add     hl,hl
4413  29        add     hl,hl

' + v18
4414  d1        pop     de
4415  19        add     hl,de

' v11 = table(b1, b2)   b1 * 8 + b2
4416  110040    ld      de,#4000
4419  19        add     hl,de
441a  5e        ld      e,(hl)
441b  211100    ld      hl,#0011
441e  39        add     hl,sp
441f  73        ld      (hl),e

' HL = HL * DE
4420  1600      ld      d,#00
4422  210600    ld      hl,#0006
4425  cdfb04    call    #04fb

' v8 = Xs
4428  11c741    ld      de,#41c7
442b  19        add     hl,de
442c  5e        ld      e,(hl)
442d  23        inc     hl
442e  56        ld      d,(hl)
442f  210800    ld      hl,#0008
4432  39        add     hl,sp
4433  73        ld      (hl),e
4434  23        inc     hl
4435  72        ld      (hl),d

4436  211100    ld      hl,#0011
4439  39        add     hl,sp
443a  5e        ld      e,(hl)
443b  1600      ld      d,#00
443d  210600    ld      hl,#0006
4440  cdfb04    call    #04fb
4443  11c941    ld      de,#41c9
4446  19        add     hl,de
4447  5e        ld      e,(hl)
4448  23        inc     hl
4449  56        ld      d,(hl)

' Va = Y
444a  210a00    ld      hl,#000a
444d  39        add     hl,sp
444e  73        ld      (hl),e
444f  23        inc     hl
4450  72        ld      (hl),d

4451  211100    ld      hl,#0011
4454  39        add     hl,sp
4455  5e        ld      e,(hl)
4456  1600      ld      d,#00
4458  210600    ld      hl,#0006
445b  cdfb04    call    #04fb
445e  11cb41    ld      de,#41cb
4461  19        add     hl,de
4462  5e        ld      e,(hl)
4463  23        inc     hl
4464  56        ld      d,(hl)

' Vc = Xe
4465  210c00    ld      hl,#000c
4468  39        add     hl,sp
4469  73        ld      (hl),e
446a  23        inc     hl
446b  72        ld      (hl),d

446c  211100    ld      hl,#0011
446f  39        add     hl,sp
4470  5e        ld      e,(hl)
4471  1600      ld      d,#00
4473  210600    ld      hl,#0006
4476  cdfb04    call    #04fb
4479  11c941    ld      de,#41c9
447c  19        add     hl,de
447d  5e        ld      e,(hl)
447e  23        inc     hl
447f  56        ld      d,(hl)
4480  210e00    ld      hl,#000e
4483  19        add     hl,de
4484  eb        ex      de,hl

' Ve = Y + 14
4485  210e00    ld      hl,#000e
4488  39        add     hl,sp
4489  73        ld      (hl),e
448a  23        inc     hl
448b  72        ld      (hl),d

448c  2b        dec     hl
448d  5e        ld      e,(hl)
448e  d5        push    de
448f  2b        dec     hl
4490  56        ld      d,(hl)
4491  2b        dec     hl
4492  5e        ld      e,(hl)
4493  d5        push    de
4494  2b        dec     hl
4495  56        ld      d,(hl)
4496  2b        dec     hl
4497  5e        ld      e,(hl)
4498  d5        push    de
4499  2b        dec     hl
449a  56        ld      d,(hl)
449b  2b        dec     hl
449c  5e        ld      e,(hl)
449d  d5        push    de
449e  21be77    ld      hl,#77be
44a1  e5        push    hl
44a2  210100    ld      hl,#0001
44a5  e5        push    hl

' Func05ed(1, 77beH, Xs, Xe, Ys, Ye) - Draw Square
44a6  cded05    call    #05ed
44a9  210c00    ld      hl,#000c
44ac  39        add     hl,sp
44ad  f9        ld      sp,hl

' v8 = v8 + 4
44ae  210800    ld      hl,#0008
44b1  39        add     hl,sp
44b2  5e        ld      e,(hl)
44b3  23        inc     hl
44b4  56        ld      d,(hl)
44b5  210400    ld      hl,#0004
44b8  19        add     hl,de
44b9  eb        ex      de,hl
44ba  210800    ld      hl,#0008
44bd  39        add     hl,sp
44be  73        ld      (hl),e
44bf  23        inc     hl
44c0  72        ld      (hl),d

' va = va + 4
44c1  23        inc     hl
44c2  5e        ld      e,(hl)
44c3  23        inc     hl
44c4  56        ld      d,(hl)
44c5  210400    ld      hl,#0004
44c8  19        add     hl,de
44c9  eb        ex      de,hl
44ca  210a00    ld      hl,#000a
44cd  39        add     hl,sp
44ce  73        ld      (hl),e
44cf  23        inc     hl
44d0  72        ld      (hl),d

' DisplayText(KeyName, x, y, 0)
44d1  210000    ld      hl,#0000
44d4  e5        push    hl
44d5  210c00    ld      hl,#000c
44d8  39        add     hl,sp
44d9  5e        ld      e,(hl)
44da  23        inc     hl
44db  56        ld      d,(hl)
44dc  d5        push    de
44dd  2b        dec     hl
44de  2b        dec     hl
44df  56        ld      d,(hl)
44e0  2b        dec     hl
44e1  5e        ld      e,(hl)
44e2  d5        push    de
44e3  211700    ld      hl,#0017
44e6  39        add     hl,sp
44e7  5e        ld      e,(hl)
44e8  1600      ld      d,#00
44ea  eb        ex      de,hl
44eb  29        add     hl,hl
44ec  115840    ld      de,#4058
44ef  19        add     hl,de
44f0  5e        ld      e,(hl)
44f1  23        inc     hl
44f2  56        ld      d,(hl)
44f3  d5        push    de
44f4  cd8d4c    call    #4c8d
44f7  210800    ld      hl,#0008
44fa  39        add     hl,sp
44fb  f9        ld      sp,hl

44fc  c9        ret     


' EraseKey(b1, b2) b1=0-10 b2=0-7
44fd  11f6ff    ld      de,#fff6
4500  cd6b05    call    #056b

4503  211800    ld      hl,#0018
4506  39        add     hl,sp
4507  5e        ld      e,(hl)
4508  1600      ld      d,#00
450a  d5        push    de

450b  2b        dec     hl
450c  2b        dec     hl
450d  5e        ld      e,(hl)
450e  eb        ex      de,hl
450f  29        add     hl,hl
4510  29        add     hl,hl
4511  29        add     hl,hl
4512  d1        pop     de
4513  19        add     hl,de
4514  110040    ld      de,#4000
4517  19        add     hl,de
4518  5e        ld      e,(hl)

4519  211100    ld      hl,#0011
451c  39        add     hl,sp
451d  73        ld      (hl),e
451e  1600      ld      d,#00

4520  210600    ld      hl,#0006
4523  cdfb04    call    #04fb
4526  11c741    ld      de,#41c7
4529  19        add     hl,de
452a  5e        ld      e,(hl)
452b  23        inc     hl
452c  56        ld      d,(hl)
452d  210800    ld      hl,#0008
4530  39        add     hl,sp
4531  73        ld      (hl),e
4532  23        inc     hl
4533  72        ld      (hl),d
4534  211100    ld      hl,#0011
4537  39        add     hl,sp
4538  5e        ld      e,(hl)
4539  1600      ld      d,#00
453b  210600    ld      hl,#0006
453e  cdfb04    call    #04fb
4541  11c941    ld      de,#41c9
4544  19        add     hl,de
4545  5e        ld      e,(hl)
4546  23        inc     hl
4547  56        ld      d,(hl)
4548  210a00    ld      hl,#000a
454b  39        add     hl,sp
454c  73        ld      (hl),e
454d  23        inc     hl
454e  72        ld      (hl),d
454f  211100    ld      hl,#0011
4552  39        add     hl,sp
4553  5e        ld      e,(hl)
4554  1600      ld      d,#00
4556  210600    ld      hl,#0006
4559  cdfb04    call    #04fb
455c  11cb41    ld      de,#41cb
455f  19        add     hl,de
4560  5e        ld      e,(hl)
4561  23        inc     hl
4562  56        ld      d,(hl)
4563  210c00    ld      hl,#000c
4566  39        add     hl,sp
4567  73        ld      (hl),e
4568  23        inc     hl
4569  72        ld      (hl),d
456a  211100    ld      hl,#0011
456d  39        add     hl,sp
456e  5e        ld      e,(hl)
456f  1600      ld      d,#00
4571  210600    ld      hl,#0006
4574  cdfb04    call    #04fb
4577  11c941    ld      de,#41c9
457a  19        add     hl,de
457b  5e        ld      e,(hl)
457c  23        inc     hl
457d  56        ld      d,(hl)
457e  210e00    ld      hl,#000e
4581  19        add     hl,de
4582  eb        ex      de,hl
4583  210e00    ld      hl,#000e
4586  39        add     hl,sp
4587  73        ld      (hl),e
4588  23        inc     hl
4589  72        ld      (hl),d
458a  2b        dec     hl
458b  5e        ld      e,(hl)
458c  eb        ex      de,hl
458d  23        inc     hl
458e  e5        push    hl
458f  eb        ex      de,hl
4590  2b        dec     hl
4591  56        ld      d,(hl)
4592  2b        dec     hl
4593  5e        ld      e,(hl)
4594  d5        push    de
4595  2b        dec     hl
4596  56        ld      d,(hl)
4597  2b        dec     hl
4598  5e        ld      e,(hl)
4599  d5        push    de
459a  2b        dec     hl
459b  56        ld      d,(hl)
459c  2b        dec     hl
459d  5e        ld      e,(hl)
459e  d5        push    de

' Call ClearSquare
459f  cd8a20    call    #208a
45a2  210800    ld      hl,#0008
45a5  39        add     hl,sp
45a6  f9        ld      sp,hl

' When Done Write Display Buffer to LCD
45a7  cd7324    call    #2473
45aa  c9        ret     

' Keyboard Test
45ab  11f5ff    ld      de,#fff5
45ae  cd6b05    call    #056b

' ve = 255
45b1  210e00    ld      hl,#000e
45b4  39        add     hl,sp
45b5  36ff      ld      (hl),#ff
45b7  23        inc     hl
45b8  3600      ld      (hl),#00

; Led(on)
45ba  210100    ld      hl,#0001
45bd  e5        push    hl
45be  cd770a    call    #0a77
45c1  d1        pop     de

' Display Keyboard
45c2  cdb143    call    #43b1

' v11 = 0
45c5  211100    ld      hl,#0011
45c8  39        add     hl,sp
45c9  3600      ld      (hl),#00
45cb  23        inc     hl
45cc  3600      ld      (hl),#00

' v10 = 1
45ce  2b        dec     hl
45cf  2b        dec     hl
45d0  3601      ld      (hl),#01

' v11 = v11 + 1
45d2  211100    ld      hl,#0011
45d5  39        add     hl,sp
45d6  5e        ld      e,(hl)
45d7  23        inc     hl
45d8  56        ld      d,(hl)
45d9  13        inc     de
45da  72        ld      (hl),d
45db  2b        dec     hl
45dc  73        ld      (hl),e
45dd  23        inc     hl

' ???
45de  56        ld      d,(hl)
45df  213cf6    ld      hl,#f63c
45e2  19        add     hl,de
45e3  3022      jr      nc,#4607        ; (34)

' v11 = 0
45e5  211100    ld      hl,#0011
45e8  39        add     hl,sp
45e9  3600      ld      (hl),#00
45eb  23        inc     hl
45ec  3600      ld      (hl),#00

' v10 = 1 - v10
45ee  2b        dec     hl
45ef  2b        dec     hl
45f0  7e        ld      a,(hl)
45f1  b7        or      a
45f2  2804      jr      z,#45f8         ; (4)
45f4  2e00      ld      l,#00
45f6  1802      jr      #45fa           ; (2)
45f8  2e01      ld      l,#01
45fa  eb        ex      de,hl
45fb  211000    ld      hl,#0010
45fe  39        add     hl,sp
45ff  73        ld      (hl),e
4600  1600      ld      d,#00

' Led(v10)
4602  d5        push    de
4603  cd770a    call    #0a77
4606  d1        pop     de

' Call func05ed(1, 55f4, &ve) - Get Keyboard input ?
4607  210e00    ld      hl,#000e
460a  39        add     hl,sp
460b  e5        push    hl
460c  21f455    ld      hl,#55f4
460f  e5        push    hl
4610  210100    ld      hl,#0001
4613  e5        push    hl
4614  cded05    call    #05ed
4617  d1        pop     de
4618  d1        pop     de
4619  d1        pop     de

461a  2b        dec     hl
461b  7c        ld      a,h
461c  b5        or      l
461d  202a      jr      nz,#4649        ; (42)

' Delay(30)
461f  211e00    ld      hl,#001e
4622  e5        push    hl
4623  cd5c0a    call    #0a5c
4626  d1        pop     de

' Call func05ed(1, 79a4)
4627  21a479    ld      hl,#79a4
462a  e5        push    hl
462b  210100    ld      hl,#0001
462e  e5        push    hl
462f  cded05    call    #05ed
4632  d1        pop     de
4633  d1        pop     de

4634  11feff    ld      de,#fffe
4637  7c        ld      a,h
4638  aa        xor     d
4639  07        rlca    
463a  19        add     hl,de
463b  ce00      adc     a,#00
463d  0f        rrca    
463e  3809      jr      c,#4649         ; (9)

' ve = 255
4640  210e00    ld      hl,#000e
4643  39        add     hl,sp
4644  36ff      ld      (hl),#ff
4646  23        inc     hl
4647  3600      ld      (hl),#00

' if ve <> 15 goto 4672 - power key
4649  210e00    ld      hl,#000e
464c  39        add     hl,sp
464d  5e        ld      e,(hl)
464e  23        inc     hl
464f  56        ld      d,(hl)
4650  21f1ff    ld      hl,#fff1
4653  19        add     hl,de
4654  7c        ld      a,h
4655  b5        or      l
4656  201a      jr      nz,#4672        ; (26)

' Led(Off)
4658  210000    ld      hl,#0000
465b  e5        push    hl
465c  cd770a    call    #0a77
465f  d1        pop     de

' Clear Display and bit map buffer
4660  cd850a    call    #0a85

' Delay(100)
4663  216400    ld      hl,#0064
4666  e5        push    hl
4667  cd5c0a    call    #0a5c
466a  d1        pop     de

466b  cd9d0a    call    #0a9d
466e  210100    ld      hl,#0001
4671  c9        ret     

' if ve = 255 goto 45d2 - no key
4672  210e00    ld      hl,#000e
4675  39        add     hl,sp
4676  5e        ld      e,(hl)
4677  23        inc     hl
4678  56        ld      d,(hl)
4679  2101ff    ld      hl,#ff01
467c  19        add     hl,de
467d  7c        ld      a,h
467e  b5        or      l
467f  cad245    jp      z,#45d2

4682  eb        ex      de,hl
4683  7d        ld      a,l
4684  e6f0      and     #f0
4686  1f        rra     
4687  1f        rra     
4688  1f        rra     
4689  1f        rra     
468a  e60f      and     #0f
468c  210b00    ld      hl,#000b
468f  39        add     hl,sp
4690  77        ld      (hl),a
4691  23        inc     hl
4692  23        inc     hl
4693  23        inc     hl
4694  7e        ld      a,(hl)
4695  e60f      and     #0f
4697  5f        ld      e,a
4698  2b        dec     hl
4699  2b        dec     hl
469a  77        ld      (hl),a
469b  1600      ld      d,#00
469d  d5        push    de
469e  2b        dec     hl
469f  5e        ld      e,(hl)
46a0  d5        push    de
46a1  cdfd44    call    #44fd - erase key
46a4  d1        pop     de
46a5  d1        pop     de
46a6  c3d245    jp      #45d2

46a9  ab46
46ab  FLASH TESTING\0

46b9  11ecff    ld      de,#ffec
46bc  cd6b05    call    #056b
46bf  212000    ld      hl,#0020
46c2  39        add     hl,sp
46c3  7e        ld      a,(hl)
46c4  fe02      cp      #02
46c6  2010      jr      nz,#46d8        ; (16)
46c8  3a59f6    ld      a,(#f659)
46cb  fe01      cp      #01
46cd  2004      jr      nz,#46d3        ; (4)
46cf  210100    ld      hl,#0001
46d2  c9        ret     

46d3  3e01      ld      a,#01
46d5  3259f6    ld      (#f659),a
46d8  3a32d6    ld      a,(#d632)
46db  210900    ld      hl,#0009
46de  39        add     hl,sp
46df  77        ld      (hl),a
46e0  23        inc     hl
46e1  3600      ld      (hl),#00
46e3  3e08      ld      a,#08
46e5  3232d6    ld      (#d632),a
46e8  3e00      ld      a,#00
46ea  3250f6    ld      (#f650),a

' DisplayText("FLASH TESTING", 110, 40, 1)
46ed  210100    ld      hl,#0001
46f0  e5        push    hl
46f1  2e28      ld      l,#28
46f3  e5        push    hl
46f4  2e6e      ld      l,#6e
46f6  e5        push    hl
46f7  2aa946    ld      hl,(#46a9)
46fa  e5        push    hl
46fb  cd8d4c    call    #4c8d
46fe  210800    ld      hl,#0008
4701  39        add     hl,sp
4702  f9        ld      sp,hl

4703  216400    ld      hl,#0064
4706  e5        push    hl
4707  210801    ld      hl,#0108
470a  e5        push    hl
470b  215a00    ld      hl,#005a
470e  e5        push    hl
470f  2e46      ld      l,#46
4711  e5        push    hl
4712  21be77    ld      hl,#77be
4715  e5        push    hl
4716  210100    ld      hl,#0001
4719  e5        push    hl
471a  cded05    call    #05ed
471d  210c00    ld      hl,#000c
4720  39        add     hl,sp
4721  f9        ld      sp,hl

4722  cd7324    call    #2473
4725  211600    ld      hl,#0016
4728  39        add     hl,sp
4729  36fe      ld      (hl),#fe
472b  23        inc     hl
472c  3607      ld      (hl),#07
472e  2168e8    ld      hl,#e868
4731  e5        push    hl
4732  210001    ld      hl,#0100
4735  e5        push    hl
4736  25        dec     h
4737  e5        push    hl
4738  211c00    ld      hl,#001c
473b  39        add     hl,sp
473c  5e        ld      e,(hl)
473d  23        inc     hl
473e  56        ld      d,(hl)
473f  d5        push    de
4740  cd0537    call    #3705
4743  210800    ld      hl,#0008
4746  39        add     hl,sp
4747  f9        ld      sp,hl
4748  1600      ld      d,#00
474a  211a00    ld      hl,#001a
474d  39        add     hl,sp
474e  3600      ld      (hl),#00
4750  23        inc     hl
4751  3600      ld      (hl),#00
4753  210800    ld      hl,#0008
4756  39        add     hl,sp
4757  5e        ld      e,(hl)
4758  d5        push    de
4759  211c00    ld      hl,#001c
475c  39        add     hl,sp
475d  5e        ld      e,(hl)
475e  23        inc     hl
475f  56        ld      d,(hl)
4760  2168e7    ld      hl,#e768
4763  19        add     hl,de
4764  d1        pop     de
4765  73        ld      (hl),e
4766  210800    ld      hl,#0008
4769  39        add     hl,sp
476a  e5        push    hl
476b  6e        ld      l,(hl)
476c  23        inc     hl
476d  eb        ex      de,hl
476e  e1        pop     hl
476f  73        ld      (hl),e
4770  211a00    ld      hl,#001a
4773  39        add     hl,sp
4774  5e        ld      e,(hl)
4775  23        inc     hl
4776  56        ld      d,(hl)
4777  13        inc     de
4778  72        ld      (hl),d
4779  2b        dec     hl
477a  73        ld      (hl),e
477b  23        inc     hl
477c  56        ld      d,(hl)
477d  2100ff    ld      hl,#ff00
4780  19        add     hl,de
4781  30d0      jr      nc,#4753        ; (-48)
4783  2168e7    ld      hl,#e768
4786  e5        push    hl
4787  210001    ld      hl,#0100
478a  e5        push    hl
478b  25        dec     h
478c  e5        push    hl
478d  211c00    ld      hl,#001c
4790  39        add     hl,sp
4791  5e        ld      e,(hl)
4792  23        inc     hl
4793  56        ld      d,(hl)
4794  d5        push    de
4795  cd0c36    call    #360c
4798  210800    ld      hl,#0008
479b  39        add     hl,sp
479c  f9        ld      sp,hl
479d  2168e7    ld      hl,#e768
47a0  e5        push    hl
47a1  210001    ld      hl,#0100
47a4  e5        push    hl
47a5  25        dec     h
47a6  e5        push    hl
47a7  211c00    ld      hl,#001c
47aa  39        add     hl,sp
47ab  5e        ld      e,(hl)
47ac  23        inc     hl
47ad  56        ld      d,(hl)
47ae  d5        push    de
47af  cd0537    call    #3705
47b2  210800    ld      hl,#0008
47b5  39        add     hl,sp
47b6  f9        ld      sp,hl
47b7  211a00    ld      hl,#001a
47ba  39        add     hl,sp
47bb  3600      ld      (hl),#00
47bd  23        inc     hl
47be  3600      ld      (hl),#00
47c0  210800    ld      hl,#0008
47c3  39        add     hl,sp
47c4  5e        ld      e,(hl)
47c5  1600      ld      d,#00
47c7  d5        push    de
47c8  211c00    ld      hl,#001c
47cb  39        add     hl,sp
47cc  5e        ld      e,(hl)
47cd  23        inc     hl
47ce  56        ld      d,(hl)
47cf  2168e7    ld      hl,#e768
47d2  19        add     hl,de
47d3  5e        ld      e,(hl)
47d4  e1        pop     hl
47d5  7d        ld      a,l
47d6  bb        cp      e
47d7  280c      jr      z,#47e5         ; (12)
47d9  211800    ld      hl,#0018
47dc  39        add     hl,sp
47dd  3601      ld      (hl),#01
47df  23        inc     hl
47e0  3600      ld      (hl),#00
47e2  c3564a    jp      #4a56
47e5  210800    ld      hl,#0008
47e8  39        add     hl,sp
47e9  e5        push    hl
47ea  6e        ld      l,(hl)
47eb  23        inc     hl
47ec  eb        ex      de,hl
47ed  e1        pop     hl
47ee  73        ld      (hl),e
47ef  211a00    ld      hl,#001a
47f2  39        add     hl,sp
47f3  5e        ld      e,(hl)
47f4  23        inc     hl
47f5  56        ld      d,(hl)
47f6  13        inc     de
47f7  72        ld      (hl),d
47f8  2b        dec     hl
47f9  73        ld      (hl),e
47fa  23        inc     hl
47fb  56        ld      d,(hl)
47fc  2100ff    ld      hl,#ff00
47ff  19        add     hl,de
4800  30be      jr      nc,#47c0        ; (-66)
4802  211600    ld      hl,#0016
4805  39        add     hl,sp
4806  5e        ld      e,(hl)
4807  23        inc     hl
4808  56        ld      d,(hl)
4809  2102f8    ld      hl,#f802
480c  19        add     hl,de
480d  7c        ld      a,h
480e  b5        or      l
480f  202a      jr      nz,#483b        ; (42)
4811  211a00    ld      hl,#001a
4814  39        add     hl,sp
4815  3600      ld      (hl),#00
4817  23        inc     hl
4818  3600      ld      (hl),#00
481a  211a00    ld      hl,#001a
481d  39        add     hl,sp
481e  5e        ld      e,(hl)
481f  23        inc     hl
4820  56        ld      d,(hl)
4821  2168e8    ld      hl,#e868
4824  19        add     hl,de
4825  1e00      ld      e,#00
4827  73        ld      (hl),e
4828  211a00    ld      hl,#001a
482b  39        add     hl,sp
482c  5e        ld      e,(hl)
482d  23        inc     hl
482e  56        ld      d,(hl)
482f  13        inc     de
4830  72        ld      (hl),d
4831  2b        dec     hl
4832  73        ld      (hl),e
4833  23        inc     hl
4834  56        ld      d,(hl)
4835  21faff    ld      hl,#fffa
4838  19        add     hl,de
4839  30df      jr      nc,#481a        ; (-33)
483b  2168e8    ld      hl,#e868
483e  e5        push    hl
483f  210001    ld      hl,#0100
4842  e5        push    hl
4843  25        dec     h
4844  e5        push    hl
4845  211c00    ld      hl,#001c
4848  39        add     hl,sp
4849  5e        ld      e,(hl)
484a  23        inc     hl
484b  56        ld      d,(hl)
484c  d5        push    de
484d  cd0c36    call    #360c
4850  210800    ld      hl,#0008
4853  39        add     hl,sp
4854  f9        ld      sp,hl
4855  211600    ld      hl,#0016
4858  39        add     hl,sp
4859  5e        ld      e,(hl)
485a  23        inc     hl
485b  56        ld      d,(hl)
485c  13        inc     de
485d  72        ld      (hl),d
485e  2b        dec     hl
485f  73        ld      (hl),e
4860  23        inc     hl
4861  56        ld      d,(hl)
4862  2100f8    ld      hl,#f800
4865  19        add     hl,de
4866  d22e47    jp      nc,#472e
4869  211800    ld      hl,#0018
486c  39        add     hl,sp
486d  3634      ld      (hl),#34
486f  23        inc     hl
4870  3600      ld      (hl),#00
4872  2b        dec     hl
4873  2b        dec     hl
4874  3600      ld      (hl),#00
4876  2b        dec     hl
4877  3600      ld      (hl),#00
4879  211600    ld      hl,#0016
487c  39        add     hl,sp
487d  5e        ld      e,(hl)
487e  23        inc     hl
487f  eb        ex      de,hl
4880  7d        ld      a,l
4881  e67f      and     #7f
4883  eb        ex      de,hl
4884  23        inc     hl
4885  23        inc     hl
4886  23        inc     hl
4887  77        ld      (hl),a
4888  23        inc     hl
4889  3600      ld      (hl),#00
488b  2b        dec     hl
488c  7e        ld      a,(hl)
488d  23        inc     hl
488e  b6        or      (hl)
488f  203e      jr      nz,#48cf        ; (62)
4891  216200    ld      hl,#0062
4894  e5        push    hl
4895  211a00    ld      hl,#001a
4898  39        add     hl,sp
4899  5e        ld      e,(hl)
489a  23        inc     hl
489b  56        ld      d,(hl)
489c  211800    ld      hl,#0018
489f  19        add     hl,de
48a0  e5        push    hl
48a1  215c00    ld      hl,#005c
48a4  e5        push    hl
48a5  211e00    ld      hl,#001e
48a8  39        add     hl,sp
48a9  5e        ld      e,(hl)
48aa  23        inc     hl
48ab  56        ld      d,(hl)
48ac  211400    ld      hl,#0014
48af  19        add     hl,de
48b0  e5        push    hl
48b1  cd3c21    call    #213c
48b4  210800    ld      hl,#0008
48b7  39        add     hl,sp
48b8  f9        ld      sp,hl
48b9  cd7324    call    #2473
48bc  211800    ld      hl,#0018
48bf  39        add     hl,sp
48c0  5e        ld      e,(hl)
48c1  23        inc     hl
48c2  56        ld      d,(hl)
48c3  210600    ld      hl,#0006
48c6  19        add     hl,de
48c7  eb        ex      de,hl
48c8  211800    ld      hl,#0018
48cb  39        add     hl,sp
48cc  73        ld      (hl),e
48cd  23        inc     hl
48ce  72        ld      (hl),d
48cf  211600    ld      hl,#0016
48d2  39        add     hl,sp
48d3  5e        ld      e,(hl)
48d4  210800    ld      hl,#0008
48d7  39        add     hl,sp
48d8  73        ld      (hl),e
48d9  1600      ld      d,#00
48db  211a00    ld      hl,#001a
48de  39        add     hl,sp
48df  3600      ld      (hl),#00
48e1  23        inc     hl
48e2  3600      ld      (hl),#00
48e4  210800    ld      hl,#0008
48e7  39        add     hl,sp
48e8  5e        ld      e,(hl)
48e9  d5        push    de
48ea  211c00    ld      hl,#001c
48ed  39        add     hl,sp
48ee  5e        ld      e,(hl)
48ef  23        inc     hl
48f0  56        ld      d,(hl)
48f1  2168e7    ld      hl,#e768
48f4  19        add     hl,de
48f5  d1        pop     de
48f6  73        ld      (hl),e
48f7  210800    ld      hl,#0008
48fa  39        add     hl,sp
48fb  e5        push    hl
48fc  6e        ld      l,(hl)
48fd  23        inc     hl
48fe  eb        ex      de,hl
48ff  e1        pop     hl
4900  73        ld      (hl),e
4901  211a00    ld      hl,#001a
4904  39        add     hl,sp
4905  5e        ld      e,(hl)
4906  23        inc     hl
4907  56        ld      d,(hl)
4908  13        inc     de
4909  72        ld      (hl),d
490a  2b        dec     hl
490b  73        ld      (hl),e
490c  23        inc     hl
490d  56        ld      d,(hl)
490e  2100ff    ld      hl,#ff00
4911  19        add     hl,de
4912  30d0      jr      nc,#48e4        ; (-48)
4914  2168e7    ld      hl,#e768
4917  e5        push    hl
4918  210001    ld      hl,#0100
491b  e5        push    hl
491c  25        dec     h
491d  e5        push    hl
491e  211c00    ld      hl,#001c
4921  39        add     hl,sp
4922  5e        ld      e,(hl)
4923  23        inc     hl
4924  56        ld      d,(hl)
4925  d5        push    de
4926  cd0c36    call    #360c
4929  210800    ld      hl,#0008
492c  39        add     hl,sp
492d  f9        ld      sp,hl
492e  211600    ld      hl,#0016
4931  39        add     hl,sp
4932  5e        ld      e,(hl)
4933  23        inc     hl
4934  56        ld      d,(hl)
4935  13        inc     de
4936  72        ld      (hl),d
4937  2b        dec     hl
4938  73        ld      (hl),e
4939  23        inc     hl
493a  56        ld      d,(hl)
493b  2102f8    ld      hl,#f802
493e  19        add     hl,de
493f  d27948    jp      nc,#4879
4942  211600    ld      hl,#0016
4945  39        add     hl,sp
4946  3600      ld      (hl),#00
4948  23        inc     hl
4949  3600      ld      (hl),#00
494b  211600    ld      hl,#0016
494e  39        add     hl,sp
494f  5e        ld      e,(hl)
4950  23        inc     hl
4951  eb        ex      de,hl
4952  7d        ld      a,l
4953  e67f      and     #7f
4955  eb        ex      de,hl
4956  23        inc     hl
4957  23        inc     hl
4958  23        inc     hl
4959  77        ld      (hl),a
495a  23        inc     hl
495b  3600      ld      (hl),#00
495d  2b        dec     hl
495e  7e        ld      a,(hl)
495f  23        inc     hl
4960  b6        or      (hl)
4961  203e      jr      nz,#49a1        ; (62)
4963  216200    ld      hl,#0062
4966  e5        push    hl
4967  211a00    ld      hl,#001a
496a  39        add     hl,sp
496b  5e        ld      e,(hl)
496c  23        inc     hl
496d  56        ld      d,(hl)
496e  211800    ld      hl,#0018
4971  19        add     hl,de
4972  e5        push    hl
4973  215c00    ld      hl,#005c
4976  e5        push    hl
4977  211e00    ld      hl,#001e
497a  39        add     hl,sp
497b  5e        ld      e,(hl)
497c  23        inc     hl
497d  56        ld      d,(hl)
497e  211400    ld      hl,#0014
4981  19        add     hl,de
4982  e5        push    hl
4983  cd3c21    call    #213c
4986  210800    ld      hl,#0008
4989  39        add     hl,sp
498a  f9        ld      sp,hl
498b  cd7324    call    #2473
498e  211800    ld      hl,#0018
4991  39        add     hl,sp
4992  5e        ld      e,(hl)
4993  23        inc     hl
4994  56        ld      d,(hl)
4995  210600    ld      hl,#0006
4998  19        add     hl,de
4999  eb        ex      de,hl
499a  211800    ld      hl,#0018
499d  39        add     hl,sp
499e  73        ld      (hl),e
499f  23        inc     hl
49a0  72        ld      (hl),d
49a1  2168e7    ld      hl,#e768
49a4  e5        push    hl
49a5  210001    ld      hl,#0100
49a8  e5        push    hl
49a9  25        dec     h
49aa  e5        push    hl
49ab  211c00    ld      hl,#001c
49ae  39        add     hl,sp
49af  5e        ld      e,(hl)
49b0  23        inc     hl
49b1  56        ld      d,(hl)
49b2  d5        push    de
49b3  cd0537    call    #3705
49b6  210800    ld      hl,#0008
49b9  39        add     hl,sp
49ba  f9        ld      sp,hl
49bb  211600    ld      hl,#0016
49be  39        add     hl,sp
49bf  5e        ld      e,(hl)
49c0  210800    ld      hl,#0008
49c3  39        add     hl,sp
49c4  73        ld      (hl),e
49c5  211a00    ld      hl,#001a
49c8  39        add     hl,sp
49c9  3600      ld      (hl),#00
49cb  23        inc     hl
49cc  3600      ld      (hl),#00
49ce  210800    ld      hl,#0008
49d1  39        add     hl,sp
49d2  5e        ld      e,(hl)
49d3  1600      ld      d,#00
49d5  d5        push    de
49d6  211c00    ld      hl,#001c
49d9  39        add     hl,sp
49da  5e        ld      e,(hl)
49db  23        inc     hl
49dc  56        ld      d,(hl)
49dd  2168e7    ld      hl,#e768
49e0  19        add     hl,de
49e1  5e        ld      e,(hl)
49e2  e1        pop     hl
49e3  7d        ld      a,l
49e4  bb        cp      e
49e5  280b      jr      z,#49f2         ; (11)
49e7  211800    ld      hl,#0018
49ea  39        add     hl,sp
49eb  3601      ld      (hl),#01
49ed  23        inc     hl
49ee  3600      ld      (hl),#00
49f0  1864      jr      #4a56           ; (100)
49f2  210800    ld      hl,#0008
49f5  39        add     hl,sp
49f6  e5        push    hl
49f7  6e        ld      l,(hl)
49f8  23        inc     hl
49f9  eb        ex      de,hl
49fa  e1        pop     hl
49fb  73        ld      (hl),e
49fc  211a00    ld      hl,#001a
49ff  39        add     hl,sp
4a00  5e        ld      e,(hl)
4a01  23        inc     hl
4a02  56        ld      d,(hl)
4a03  13        inc     de
4a04  72        ld      (hl),d
4a05  2b        dec     hl
4a06  73        ld      (hl),e
4a07  23        inc     hl
4a08  56        ld      d,(hl)
4a09  2100ff    ld      hl,#ff00
4a0c  19        add     hl,de
4a0d  30bf      jr      nc,#49ce        ; (-65)
4a0f  210001    ld      hl,#0100
4a12  e5        push    hl
4a13  25        dec     h
4a14  e5        push    hl
4a15  2168e7    ld      hl,#e768
4a18  e5        push    hl
4a19  cda805    call    #05a8
4a1c  d1        pop     de
4a1d  d1        pop     de
4a1e  d1        pop     de
4a1f  2168e7    ld      hl,#e768
4a22  e5        push    hl
4a23  210001    ld      hl,#0100
4a26  e5        push    hl
4a27  25        dec     h
4a28  e5        push    hl
4a29  211c00    ld      hl,#001c
4a2c  39        add     hl,sp
4a2d  5e        ld      e,(hl)
4a2e  23        inc     hl
4a2f  56        ld      d,(hl)
4a30  d5        push    de
4a31  cd0c36    call    #360c
4a34  210800    ld      hl,#0008
4a37  39        add     hl,sp
4a38  f9        ld      sp,hl
4a39  211600    ld      hl,#0016
4a3c  39        add     hl,sp
4a3d  5e        ld      e,(hl)
4a3e  23        inc     hl
4a3f  56        ld      d,(hl)
4a40  13        inc     de
4a41  72        ld      (hl),d
4a42  2b        dec     hl
4a43  73        ld      (hl),e
4a44  23        inc     hl
4a45  56        ld      d,(hl)
4a46  2102f8    ld      hl,#f802
4a49  19        add     hl,de
4a4a  d24b49    jp      nc,#494b
4a4d  211800    ld      hl,#0018
4a50  39        add     hl,sp
4a51  3600      ld      (hl),#00
4a53  23        inc     hl
4a54  3600      ld      (hl),#00
4a56  217800    ld      hl,#0078
4a59  e5        push    hl
4a5a  214001    ld      hl,#0140
4a5d  e5        push    hl
4a5e  214600    ld      hl,#0046
4a61  e5        push    hl
4a62  6c        ld      l,h
4a63  e5        push    hl
4a64  cd8a20    call    #208a
4a67  210800    ld      hl,#0008
4a6a  39        add     hl,sp
4a6b  f9        ld      sp,hl
4a6c  211800    ld      hl,#0018
4a6f  39        add     hl,sp
4a70  5e        ld      e,(hl)
4a71  23        inc     hl
4a72  56        ld      d,(hl)
4a73  1b        dec     de
4a74  7a        ld      a,d
4a75  b3        or      e
4a76  2038      jr      nz,#4ab0        ; (56)
4a78  3a50f6    ld      a,(#f650)
4a7b  e6fd      and     #fd
4a7d  3250f6    ld      (#f650),a
4a80  210a00    ld      hl,#000a
4a83  e5        push    hl
4a84  210d00    ld      hl,#000d
4a87  39        add     hl,sp
4a88  e5        push    hl
4a89  211a00    ld      hl,#001a
4a8c  39        add     hl,sp
4a8d  5e        ld      e,(hl)
4a8e  23        inc     hl
4a8f  56        ld      d,(hl)
4a90  d5        push    de
4a91  cdb507    call    #07b5
4a94  d1        pop     de
4a95  d1        pop     de
4a96  d1        pop     de

'DisplayText(???, 200, 90, 0)
4a97  210000    ld      hl,#0000
4a9a  e5        push    hl
4a9b  2e5a      ld      l,#5a
4a9d  e5        push    hl
4a9e  2ec8      ld      l,#c8
4aa0  e5        push    hl
4aa1  211100    ld      hl,#0011
4aa4  39        add     hl,sp
4aa5  e5        push    hl
4aa6  cd8d4c    call    #4c8d
4aa9  210800    ld      hl,#0008
4aac  39        add     hl,sp

4aad  f9        ld      sp,hl
4aae  1808      jr      #4ab8           ; (8)
4ab0  3a50f6    ld      a,(#f650)
4ab3  f602      or      #02
4ab5  3250f6    ld      (#f650),a
4ab8  3a50f6    ld      a,(#f650)
4abb  f601      or      #01
4abd  3250f6    ld      (#f650),a
4ac0  cd7324    call    #2473
4ac3  210900    ld      hl,#0009
4ac6  39        add     hl,sp
4ac7  7e        ld      a,(hl)
4ac8  3232d6    ld      (#d632),a
4acb  211800    ld      hl,#0018
4ace  39        add     hl,sp
4acf  7e        ld      a,(hl)
4ad0  23        inc     hl
4ad1  b6        or      (hl)
4ad2  2804      jr      z,#4ad8         ; (4)
4ad4  2e00      ld      l,#00
4ad6  1802      jr      #4ada           ; (2)
4ad8  2e01      ld      l,#01
4ada  2600      ld      h,#00
4adc  c9        ret     

4add  55        ld      d,l
4ade  aa        xor     d
4adf  07        rlca    
4ae0  0655      ld      b,#55
4ae2  aa        xor     d
4ae3  cd04c9    call    #c904
4ae6  04        inc     b
4ae7  4d        ld      c,l
4ae8  04        inc     b
4ae9  cd008d    call    #8d00
4aec  04        inc     b
4aed  cc04c5    call    z,#c504
4af0  04        inc     b
4af1  320322    ld      (#2203),a
4af4  03        inc     bc
4af5  320232    ld      (#3202),a
4af8  011203    ld      bc,#0312
4afb  3003      jr      nc,#4b00        ; (3)
4afd  00        nop     
4afe  00        nop     
4aff  11fbff    ld      de,#fffb
4b02  cd6b05    call    #056b
4b05  210001    ld      hl,#0100
4b08  e5        push    hl
4b09  25        dec     h
4b0a  e5        push    hl
4b0b  2168e7    ld      hl,#e768
4b0e  e5        push    hl
4b0f  cda805    call    #05a8
4b12  d1        pop     de
4b13  d1        pop     de
4b14  d1        pop     de
4b15  2168e7    ld      hl,#e768
4b18  e5        push    hl
4b19  210600    ld      hl,#0006
4b1c  e5        push    hl
4b1d  6c        ld      l,h
4b1e  e5        push    hl
4b1f  21fe07    ld      hl,#07fe
4b22  e5        push    hl
4b23  cd0c36    call    #360c
4b26  210800    ld      hl,#0008
4b29  39        add     hl,sp
4b2a  f9        ld      sp,hl
4b2b  210a00    ld      hl,#000a
4b2e  39        add     hl,sp
4b2f  3600      ld      (hl),#00
4b31  c3764c    jp      #4c76
4b34  2b        dec     hl
4b35  3600      ld      (hl),#00
4b37  1847      jr      #4b80           ; (71)
4b39  210900    ld      hl,#0009
4b3c  39        add     hl,sp
4b3d  5e        ld      e,(hl)
4b3e  eb        ex      de,hl
4b3f  29        add     hl,hl
4b40  e5        push    hl
4b41  eb        ex      de,hl
4b42  23        inc     hl
4b43  5e        ld      e,(hl)
4b44  1600      ld      d,#00
4b46  210e00    ld      hl,#000e
4b49  cdfb04    call    #04fb
4b4c  d1        pop     de
4b4d  19        add     hl,de
4b4e  11e34a    ld      de,#4ae3
4b51  19        add     hl,de
4b52  5e        ld      e,(hl)
4b53  23        inc     hl
4b54  56        ld      d,(hl)
4b55  210b00    ld      hl,#000b
4b58  39        add     hl,sp
4b59  73        ld      (hl),e
4b5a  23        inc     hl
4b5b  72        ld      (hl),d
4b5c  2168e7    ld      hl,#e768
4b5f  e5        push    hl
4b60  210001    ld      hl,#0100
4b63  e5        push    hl
4b64  25        dec     h
4b65  e5        push    hl
4b66  211100    ld      hl,#0011
4b69  39        add     hl,sp
4b6a  5e        ld      e,(hl)
4b6b  23        inc     hl
4b6c  56        ld      d,(hl)
4b6d  d5        push    de
4b6e  cd0c36    call    #360c
4b71  210800    ld      hl,#0008
4b74  39        add     hl,sp
4b75  f9        ld      sp,hl
4b76  210900    ld      hl,#0009
4b79  39        add     hl,sp
4b7a  e5        push    hl
4b7b  6e        ld      l,(hl)
4b7c  23        inc     hl
4b7d  eb        ex      de,hl
4b7e  e1        pop     hl
4b7f  73        ld      (hl),e
4b80  210a00    ld      hl,#000a
4b83  39        add     hl,sp
4b84  5e        ld      e,(hl)
4b85  1600      ld      d,#00
4b87  21df4a    ld      hl,#4adf
4b8a  19        add     hl,de
4b8b  5e        ld      e,(hl)
4b8c  d5        push    de
4b8d  210b00    ld      hl,#000b
4b90  39        add     hl,sp
4b91  5e        ld      e,(hl)
4b92  e1        pop     hl
4b93  7d        ld      a,l
4b94  1c        inc     e
4b95  2803      jr      z,#4b9a         ; (3)
4b97  bb        cp      e
4b98  309f      jr      nc,#4b39        ; (-97)
4b9a  210a00    ld      hl,#000a
4b9d  39        add     hl,sp
4b9e  5e        ld      e,(hl)
4b9f  21dd4a    ld      hl,#4add
4ba2  19        add     hl,de
4ba3  5e        ld      e,(hl)
4ba4  210800    ld      hl,#0008
4ba7  39        add     hl,sp
4ba8  73        ld      (hl),e
4ba9  e5        push    hl
4baa  210100    ld      hl,#0001
4bad  e5        push    hl
4bae  210e00    ld      hl,#000e
4bb1  39        add     hl,sp
4bb2  5e        ld      e,(hl)
4bb3  21e14a    ld      hl,#4ae1
4bb6  19        add     hl,de
4bb7  5e        ld      e,(hl)
4bb8  d5        push    de
4bb9  211000    ld      hl,#0010
4bbc  39        add     hl,sp
4bbd  5e        ld      e,(hl)
4bbe  210e00    ld      hl,#000e
4bc1  cdfb04    call    #04fb
4bc4  11e34a    ld      de,#4ae3
4bc7  19        add     hl,de
4bc8  5e        ld      e,(hl)
4bc9  23        inc     hl
4bca  56        ld      d,(hl)
4bcb  d5        push    de
4bcc  cd0c36    call    #360c
4bcf  210800    ld      hl,#0008
4bd2  39        add     hl,sp
4bd3  f9        ld      sp,hl
4bd4  210900    ld      hl,#0009
4bd7  39        add     hl,sp
4bd8  3601      ld      (hl),#01
4bda  1875      jr      #4c51           ; (117)
4bdc  210800    ld      hl,#0008
4bdf  39        add     hl,sp
4be0  3600      ld      (hl),#00
4be2  23        inc     hl
4be3  5e        ld      e,(hl)
4be4  eb        ex      de,hl
4be5  29        add     hl,hl
4be6  e5        push    hl
4be7  eb        ex      de,hl
4be8  23        inc     hl
4be9  5e        ld      e,(hl)
4bea  1600      ld      d,#00
4bec  210e00    ld      hl,#000e
4bef  cdfb04    call    #04fb
4bf2  d1        pop     de
4bf3  19        add     hl,de
4bf4  11e34a    ld      de,#4ae3
4bf7  19        add     hl,de
4bf8  5e        ld      e,(hl)
4bf9  23        inc     hl
4bfa  56        ld      d,(hl)
4bfb  210b00    ld      hl,#000b
4bfe  39        add     hl,sp
4bff  73        ld      (hl),e
4c00  23        inc     hl
4c01  72        ld      (hl),d
4c02  210800    ld      hl,#0008
4c05  39        add     hl,sp
4c06  e5        push    hl
4c07  210100    ld      hl,#0001
4c0a  e5        push    hl
4c0b  210e00    ld      hl,#000e
4c0e  39        add     hl,sp
4c0f  5e        ld      e,(hl)
4c10  1600      ld      d,#00
4c12  21e14a    ld      hl,#4ae1
4c15  19        add     hl,de
4c16  5e        ld      e,(hl)
4c17  d5        push    de
4c18  211100    ld      hl,#0011
4c1b  39        add     hl,sp
4c1c  5e        ld      e,(hl)
4c1d  23        inc     hl
4c1e  56        ld      d,(hl)
4c1f  d5        push    de
4c20  cd0537    call    #3705
4c23  210800    ld      hl,#0008
4c26  39        add     hl,sp
4c27  f9        ld      sp,hl
4c28  210a00    ld      hl,#000a
4c2b  39        add     hl,sp
4c2c  5e        ld      e,(hl)
4c2d  1600      ld      d,#00
4c2f  21dd4a    ld      hl,#4add
4c32  19        add     hl,de
4c33  5e        ld      e,(hl)
4c34  d5        push    de
4c35  210a00    ld      hl,#000a
4c38  39        add     hl,sp
4c39  5e        ld      e,(hl)
4c3a  e1        pop     hl
4c3b  7d        ld      a,l
4c3c  bb        cp      e
4c3d  2008      jr      nz,#4c47        ; (8)
4c3f  210800    ld      hl,#0008
4c42  39        add     hl,sp
4c43  3600      ld      (hl),#00
4c45  183d      jr      #4c84           ; (61)
4c47  210900    ld      hl,#0009
4c4a  39        add     hl,sp
4c4b  e5        push    hl
4c4c  6e        ld      l,(hl)
4c4d  23        inc     hl
4c4e  eb        ex      de,hl
4c4f  e1        pop     hl
4c50  73        ld      (hl),e
4c51  210a00    ld      hl,#000a
4c54  39        add     hl,sp
4c55  5e        ld      e,(hl)
4c56  1600      ld      d,#00
4c58  21df4a    ld      hl,#4adf
4c5b  19        add     hl,de
4c5c  5e        ld      e,(hl)
4c5d  d5        push    de
4c5e  210b00    ld      hl,#000b
4c61  39        add     hl,sp
4c62  5e        ld      e,(hl)
4c63  e1        pop     hl
4c64  7d        ld      a,l
4c65  1c        inc     e
4c66  2804      jr      z,#4c6c         ; (4)
4c68  bb        cp      e
4c69  d2dc4b    jp      nc,#4bdc
4c6c  210a00    ld      hl,#000a
4c6f  39        add     hl,sp
4c70  e5        push    hl
4c71  6e        ld      l,(hl)
4c72  23        inc     hl
4c73  eb        ex      de,hl
4c74  e1        pop     hl
4c75  73        ld      (hl),e
4c76  210a00    ld      hl,#000a
4c79  39        add     hl,sp
4c7a  7e        ld      a,(hl)
4c7b  fe02      cp      #02
4c7d  da344b    jp      c,#4b34
4c80  2b        dec     hl
4c81  2b        dec     hl
4c82  3601      ld      (hl),#01
4c84  210800    ld      hl,#0008
4c87  39        add     hl,sp
4c88  5e        ld      e,(hl)
4c89  1600      ld      d,#00
4c8b  eb        ex      de,hl
4c8c  c9        ret     

' DisplayText(s, x, y, size)
4c8d  1193ff    ld      de,#ff93
4c90  cd6b05    call    #056b
4c93  217b00    ld      hl,#007b
4c96  39        add     hl,sp
4c97  5e        ld      e,(hl)
4c98  23        inc     hl
4c99  56        ld      d,(hl)
4c9a  216c00    ld      hl,#006c
4c9d  39        add     hl,sp
4c9e  73        ld      (hl),e
4c9f  23        inc     hl
4ca0  72        ld      (hl),d
4ca1  217d00    ld      hl,#007d
4ca4  39        add     hl,sp
4ca5  5e        ld      e,(hl)
4ca6  23        inc     hl
4ca7  56        ld      d,(hl)
4ca8  216e00    ld      hl,#006e
4cab  39        add     hl,sp
4cac  73        ld      (hl),e
4cad  23        inc     hl
4cae  72        ld      (hl),d
4caf  23        inc     hl
4cb0  363f      ld      (hl),#3f
4cb2  23        inc     hl
4cb3  3601      ld      (hl),#01
4cb5  23        inc     hl
4cb6  367f      ld      (hl),#7f
4cb8  23        inc     hl
4cb9  3600      ld      (hl),#00
4cbb  217f00    ld      hl,#007f
4cbe  39        add     hl,sp
4cbf  5e        ld      e,(hl)
4cc0  217400    ld      hl,#0074
4cc3  39        add     hl,sp
4cc4  73        ld      (hl),e
4cc5  217900    ld      hl,#0079
4cc8  39        add     hl,sp
4cc9  5e        ld      e,(hl)
4cca  23        inc     hl
4ccb  56        ld      d,(hl)
4ccc  d5        push    de
4ccd  210a00    ld      hl,#000a
4cd0  39        add     hl,sp
4cd1  e5        push    hl
4cd2  cdc605    call    #05c6
4cd5  d1        pop     de
4cd6  d1        pop     de
4cd7  217900    ld      hl,#0079
4cda  39        add     hl,sp
4cdb  5e        ld      e,(hl)
4cdc  23        inc     hl
4cdd  56        ld      d,(hl)
4cde  d5        push    de
4cdf  cdcc05    call    #05cc
4ce2  d1        pop     de
4ce3  2600      ld      h,#00
4ce5  e5        push    hl
4ce6  210a00    ld      hl,#000a
4ce9  39        add     hl,sp
4cea  e5        push    hl
4ceb  217000    ld      hl,#0070
4cee  39        add     hl,sp
4cef  e5        push    hl
4cf0  cd7a1e    call    #1e7a
4cf3  d1        pop     de
4cf4  d1        pop     de
4cf5  d1        pop     de
4cf6  c9        ret     

4cf7  f94c
4cf9  LCD TEST\0

4d02  11f5ff    ld      de,#fff5
4d05  cd6b05    call    #056b
4d08  210a00    ld      hl,#000a
4d0b  39        add     hl,sp
4d0c  3601      ld      (hl),#01
4d0e  cd850a    call    #0a85
4d11  210a00    ld      hl,#000a
4d14  39        add     hl,sp
4d15  5e        ld      e,(hl)
4d16  1600      ld      d,#00
4d18  21f5ff    ld      hl,#fff5
4d1b  19        add     hl,de
4d1c  daf44e    jp      c,#4ef4
4d1f  21294d    ld      hl,#4d29
4d22  19        add     hl,de
4d23  19        add     hl,de
4d24  5e        ld      e,(hl)
4d25  23        inc     hl
4d26  56        ld      d,(hl)
4d27  eb        ex      de,hl
4d28  e9        jp      (hl)

4d29  f44e
4d2b  3f4d
4d2d  5f4d
4d2f  9d4d
4d31  db4d
4d33  1a4e
4d35  594e
4d37  694e
4d39  784e
4d3b  d94e
4d3d  f04e

4d3f  218000    ld      hl,#0080
4d42  e5        push    hl
4d43  214001    ld      hl,#0140
4d46  e5        push    hl
4d47  210000    ld      hl,#0000
4d4a  e5        push    hl
4d4b  e5        push    hl
4d4c  21be77    ld      hl,#77be
4d4f  e5        push    hl
4d50  210100    ld      hl,#0001
4d53  e5        push    hl
4d54  cded05    call    #05ed
4d57  210c00    ld      hl,#000c
4d5a  39        add     hl,sp
4d5b  f9        ld      sp,hl
4d5c  c3f44e    jp      #4ef4

4d5f  210f00    ld      hl,#000f
4d62  39        add     hl,sp
4d63  3600      ld      (hl),#00
4d65  23        inc     hl
4d66  3600      ld      (hl),#00
4d68  23        inc     hl
4d69  3600      ld      (hl),#00
4d6b  23        inc     hl
4d6c  3600      ld      (hl),#00
4d6e  218000    ld      hl,#0080
4d71  e5        push    hl
4d72  211100    ld      hl,#0011
4d75  39        add     hl,sp
4d76  5e        ld      e,(hl)
4d77  23        inc     hl
4d78  56        ld      d,(hl)
4d79  d5        push    de
4d7a  23        inc     hl
4d7b  5e        ld      e,(hl)
4d7c  23        inc     hl
4d7d  56        ld      d,(hl)
4d7e  d5        push    de
4d7f  cd8823    call    #2388
4d82  d1        pop     de
4d83  d1        pop     de
4d84  d1        pop     de
4d85  211100    ld      hl,#0011
4d88  39        add     hl,sp
4d89  5e        ld      e,(hl)
4d8a  23        inc     hl
4d8b  56        ld      d,(hl)
4d8c  13        inc     de
4d8d  13        inc     de
4d8e  2b        dec     hl
4d8f  73        ld      (hl),e
4d90  23        inc     hl
4d91  72        ld      (hl),d
4d92  2b        dec     hl
4d93  5e        ld      e,(hl)
4d94  21c0fe    ld      hl,#fec0
4d97  19        add     hl,de
4d98  30d4      jr      nc,#4d6e        ; (-44)
4d9a  c3f44e    jp      #4ef4

4d9d  210f00    ld      hl,#000f
4da0  39        add     hl,sp
4da1  3600      ld      (hl),#00
4da3  23        inc     hl
4da4  3600      ld      (hl),#00
4da6  23        inc     hl
4da7  3601      ld      (hl),#01
4da9  23        inc     hl
4daa  3600      ld      (hl),#00
4dac  218000    ld      hl,#0080
4daf  e5        push    hl
4db0  211100    ld      hl,#0011
4db3  39        add     hl,sp
4db4  5e        ld      e,(hl)
4db5  23        inc     hl
4db6  56        ld      d,(hl)
4db7  d5        push    de
4db8  23        inc     hl
4db9  5e        ld      e,(hl)
4dba  23        inc     hl
4dbb  56        ld      d,(hl)
4dbc  d5        push    de
4dbd  cd8823    call    #2388
4dc0  d1        pop     de
4dc1  d1        pop     de
4dc2  d1        pop     de
4dc3  211100    ld      hl,#0011
4dc6  39        add     hl,sp
4dc7  5e        ld      e,(hl)
4dc8  23        inc     hl
4dc9  56        ld      d,(hl)
4dca  13        inc     de
4dcb  13        inc     de
4dcc  2b        dec     hl
4dcd  73        ld      (hl),e
4dce  23        inc     hl
4dcf  72        ld      (hl),d
4dd0  2b        dec     hl
4dd1  5e        ld      e,(hl)
4dd2  21c0fe    ld      hl,#fec0
4dd5  19        add     hl,de
4dd6  30d4      jr      nc,#4dac        ; (-44)
4dd8  c3f44e    jp      #4ef4
4ddb  211100    ld      hl,#0011
4dde  39        add     hl,sp
4ddf  3600      ld      (hl),#00
4de1  23        inc     hl
4de2  3600      ld      (hl),#00
4de4  2b        dec     hl
4de5  2b        dec     hl
4de6  3600      ld      (hl),#00
4de8  2b        dec     hl
4de9  3600      ld      (hl),#00
4deb  214001    ld      hl,#0140
4dee  e5        push    hl
4def  211100    ld      hl,#0011
4df2  39        add     hl,sp
4df3  5e        ld      e,(hl)
4df4  23        inc     hl
4df5  56        ld      d,(hl)
4df6  d5        push    de
4df7  23        inc     hl
4df8  5e        ld      e,(hl)
4df9  23        inc     hl
4dfa  56        ld      d,(hl)
4dfb  d5        push    de
4dfc  cdd123    call    #23d1
4dff  d1        pop     de
4e00  d1        pop     de
4e01  d1        pop     de
4e02  210f00    ld      hl,#000f
4e05  39        add     hl,sp
4e06  5e        ld      e,(hl)
4e07  23        inc     hl
4e08  56        ld      d,(hl)
4e09  13        inc     de
4e0a  13        inc     de
4e0b  2b        dec     hl
4e0c  73        ld      (hl),e
4e0d  23        inc     hl
4e0e  72        ld      (hl),d
4e0f  2b        dec     hl
4e10  5e        ld      e,(hl)
4e11  2180ff    ld      hl,#ff80
4e14  19        add     hl,de
4e15  30d4      jr      nc,#4deb        ; (-44)
4e17  c3f44e    jp      #4ef4

4e1a  211100    ld      hl,#0011
4e1d  39        add     hl,sp
4e1e  3600      ld      (hl),#00
4e20  23        inc     hl
4e21  3600      ld      (hl),#00
4e23  2b        dec     hl
4e24  2b        dec     hl
4e25  3600      ld      (hl),#00
4e27  2b        dec     hl
4e28  3601      ld      (hl),#01
4e2a  214001    ld      hl,#0140
4e2d  e5        push    hl
4e2e  211100    ld      hl,#0011
4e31  39        add     hl,sp
4e32  5e        ld      e,(hl)
4e33  23        inc     hl
4e34  56        ld      d,(hl)
4e35  d5        push    de
4e36  23        inc     hl
4e37  5e        ld      e,(hl)
4e38  23        inc     hl
4e39  56        ld      d,(hl)
4e3a  d5        push    de
4e3b  cdd123    call    #23d1
4e3e  d1        pop     de
4e3f  d1        pop     de
4e40  d1        pop     de
4e41  210f00    ld      hl,#000f
4e44  39        add     hl,sp
4e45  5e        ld      e,(hl)
4e46  23        inc     hl
4e47  56        ld      d,(hl)
4e48  13        inc     de
4e49  13        inc     de
4e4a  2b        dec     hl
4e4b  73        ld      (hl),e
4e4c  23        inc     hl
4e4d  72        ld      (hl),d
4e4e  2b        dec     hl
4e4f  5e        ld      e,(hl)
4e50  2180ff    ld      hl,#ff80
4e53  19        add     hl,de
4e54  30d4      jr      nc,#4e2a        ; (-44)
4e56  c3f44e    jp      #4ef4

4e59  219477    ld      hl,#7794
4e5c  e5        push    hl
4e5d  210100    ld      hl,#0001
4e60  e5        push    hl
4e61  cded05    call    #05ed
4e64  d1        pop     de
4e65  d1        pop     de
4e66  c3f44e    jp      #4ef4

4e69  21a977    ld      hl,#77a9
4e6c  e5        push    hl
4e6d  210100    ld      hl,#0001
4e70  e5        push    hl
4e71  cded05    call    #05ed
4e74  d1        pop     de
4e75  d1        pop     de
4e76  187c      jr      #4ef4           ; (124)

4e78  210f00    ld      hl,#000f
4e7b  39        add     hl,sp
4e7c  360a      ld      (hl),#0a
4e7e  23        inc     hl
4e7f  3600      ld      (hl),#00
4e81  211100    ld      hl,#0011
4e84  39        add     hl,sp
4e85  3624      ld      (hl),#24
4e87  23        inc     hl
4e88  3600      ld      (hl),#00
4e8a  212800    ld      hl,#0028
4e8d  e5        push    hl
4e8e  211100    ld      hl,#0011
4e91  39        add     hl,sp
4e92  5e        ld      e,(hl)
4e93  23        inc     hl
4e94  56        ld      d,(hl)
4e95  d5        push    de
4e96  23        inc     hl
4e97  5e        ld      e,(hl)
4e98  23        inc     hl
4e99  56        ld      d,(hl)
4e9a  d5        push    de
4e9b  cdd123    call    #23d1
4e9e  d1        pop     de
4e9f  d1        pop     de
4ea0  d1        pop     de
4ea1  211100    ld      hl,#0011
4ea4  39        add     hl,sp
4ea5  5e        ld      e,(hl)
4ea6  23        inc     hl
4ea7  56        ld      d,(hl)
4ea8  214800    ld      hl,#0048
4eab  19        add     hl,de
4eac  eb        ex      de,hl
4ead  211100    ld      hl,#0011
4eb0  39        add     hl,sp
4eb1  73        ld      (hl),e
4eb2  23        inc     hl
4eb3  72        ld      (hl),d
4eb4  2b        dec     hl
4eb5  5e        ld      e,(hl)
4eb6  21c0fe    ld      hl,#fec0
4eb9  19        add     hl,de
4eba  30ce      jr      nc,#4e8a        ; (-50)
4ebc  210f00    ld      hl,#000f
4ebf  39        add     hl,sp
4ec0  5e        ld      e,(hl)
4ec1  23        inc     hl
4ec2  56        ld      d,(hl)
4ec3  210a00    ld      hl,#000a
4ec6  19        add     hl,de
4ec7  eb        ex      de,hl
4ec8  210f00    ld      hl,#000f
4ecb  39        add     hl,sp
4ecc  73        ld      (hl),e
4ecd  23        inc     hl
4ece  72        ld      (hl),d
4ecf  2b        dec     hl
4ed0  5e        ld      e,(hl)
4ed1  2180ff    ld      hl,#ff80
4ed4  19        add     hl,de
4ed5  30aa      jr      nc,#4e81        ; (-86)
4ed7  181b      jr      #4ef4           ; (27)

4ed9  218000    ld      hl,#0080
4edc  e5        push    hl
4edd  214001    ld      hl,#0140
4ee0  e5        push    hl
4ee1  210000    ld      hl,#0000
4ee4  e5        push    hl
4ee5  e5        push    hl
4ee6  cd3c21    call    #213c
4ee9  210800    ld      hl,#0008
4eec  39        add     hl,sp
4eed  f9        ld      sp,hl
4eee  1804      jr      #4ef4           ; (4)

4ef0  210100    ld      hl,#0001
4ef3  c9        ret     

4ef4  cd7324    call    #2473
4ef7  211700    ld      hl,#0017
4efa  39        add     hl,sp
4efb  7e        ld      a,(hl)
4efc  b7        or      a
4efd  2804      jr      z,#4f03         ; (4)
4eff  fe02      cp      #02
4f01  204f      jr      nz,#4f52        ; (79)
4f03  210d00    ld      hl,#000d
4f06  39        add     hl,sp
4f07  3600      ld      (hl),#00
4f09  23        inc     hl
4f0a  3600      ld      (hl),#00
4f0c  210800    ld      hl,#0008
4f0f  39        add     hl,sp
4f10  e5        push    hl
4f11  21f455    ld      hl,#55f4
4f14  e5        push    hl
4f15  210100    ld      hl,#0001
4f18  e5        push    hl
4f19  cded05    call    #05ed
4f1c  d1        pop     de
4f1d  d1        pop     de
4f1e  d1        pop     de
4f1f  210800    ld      hl,#0008
4f22  39        add     hl,sp
4f23  5e        ld      e,(hl)
4f24  23        inc     hl
4f25  56        ld      d,(hl)
4f26  21aeff    ld      hl,#ffae
4f29  19        add     hl,de
4f2a  7c        ld      a,h
4f2b  b5        or      l
4f2c  2004      jr      nz,#4f32        ; (4)
4f2e  21ff00    ld      hl,#00ff
4f31  c9        ret     

4f32  210d00    ld      hl,#000d
4f35  39        add     hl,sp
4f36  5e        ld      e,(hl)
4f37  23        inc     hl
4f38  56        ld      d,(hl)
4f39  13        inc     de
4f3a  72        ld      (hl),d
4f3b  2b        dec     hl
4f3c  73        ld      (hl),e
4f3d  23        inc     hl
4f3e  56        ld      d,(hl)
4f3f  21f0d8    ld      hl,#d8f0
4f42  19        add     hl,de
4f43  30c7      jr      nc,#4f0c        ; (-57)
4f45  cd850a    call    #0a85
4f48  216400    ld      hl,#0064
4f4b  e5        push    hl
4f4c  cd5c0a    call    #0a5c
4f4f  d1        pop     de
4f50  184c      jr      #4f9e           ; (76)
4f52  210a00    ld      hl,#000a
4f55  39        add     hl,sp
4f56  7e        ld      a,(hl)
4f57  fe0a      cp      #0a
4f59  2827      jr      z,#4f82         ; (39)
4f5b  3e00      ld      a,#00
4f5d  3252f6    ld      (#f652),a
4f60  210800    ld      hl,#0008
4f63  39        add     hl,sp
4f64  e5        push    hl
4f65  21f455    ld      hl,#55f4
4f68  e5        push    hl
4f69  210100    ld      hl,#0001
4f6c  e5        push    hl
4f6d  cded05    call    #05ed
4f70  d1        pop     de
4f71  d1        pop     de
4f72  d1        pop     de
4f73  28eb      jr      z,#4f60         ; (-21)
4f75  210800    ld      hl,#0008
4f78  39        add     hl,sp
4f79  7e        ld      a,(hl)
4f7a  fe01      cp      #01
4f7c  2004      jr      nz,#4f82        ; (4)
4f7e  210000    ld      hl,#0000
4f81  c9        ret     

4f82  210a00    ld      hl,#000a
4f85  39        add     hl,sp
4f86  7e        ld      a,(hl)
4f87  fe09      cp      #09
4f89  2013      jr      nz,#4f9e        ; (19)
4f8b  211700    ld      hl,#0017
4f8e  39        add     hl,sp
4f8f  7e        ld      a,(hl)
4f90  fe01      cp      #01
4f92  200a      jr      nz,#4f9e        ; (10)
4f94  210a00    ld      hl,#000a
4f97  39        add     hl,sp
4f98  e5        push    hl
4f99  6e        ld      l,(hl)
4f9a  23        inc     hl
4f9b  eb        ex      de,hl
4f9c  e1        pop     hl
4f9d  73        ld      (hl),e
4f9e  210a00    ld      hl,#000a
4fa1  39        add     hl,sp
4fa2  e5        push    hl
4fa3  6e        ld      l,(hl)
4fa4  23        inc     hl
4fa5  eb        ex      de,hl
4fa6  e1        pop     hl
4fa7  73        ld      (hl),e
4fa8  210a00    ld      hl,#000a
4fab  39        add     hl,sp
4fac  7e        ld      a,(hl)
4fad  fe0b      cp      #0b
4faf  da0e4d    jp      c,#4d0e
4fb2  3601      ld      (hl),#01
4fb4  c30e4d    jp      #4d0e

' Data ???
4fb7  02        ld      (bc),a
4fb8  00        nop     
4fb9  0a        ld      a,(bc)
4fba  05        dec     b
4fbb  0607      ld      b,#07
4fbd  010304    ld      bc,#0403
4fc0  08        ex      af,af'
4fc1  05        dec     b
4fc2  0607      ld      b,#07
4fc4  09        add     hl,bc
4fc5  010002    ld      bc,#0200
4fc8  03        inc     bc
4fc9  04        inc     b
4fca  08        ex      af,af'

4fcb  11fcff    ld      de,#fffc
4fce  cd6b05    call    #056b
4fd1  cd6424    call    #2464
4fd4  211000    ld      hl,#0010
4fd7  39        add     hl,sp
4fd8  5e        ld      e,(hl)
4fd9  210b00    ld      hl,#000b
4fdc  39        add     hl,sp
4fdd  73        ld      (hl),e
4fde  211200    ld      hl,#0012
4fe1  39        add     hl,sp
4fe2  7e        ld      a,(hl)
4fe3  b7        or      a
4fe4  281b      jr      z,#5001         ; (27)
4fe6  2b        dec     hl
4fe7  2b        dec     hl
4fe8  5e        ld      e,(hl)
4fe9  1600      ld      d,#00
4feb  d5        push    de
4fec  23        inc     hl
4fed  23        inc     hl
4fee  5e        ld      e,(hl)
4fef  210a00    ld      hl,#000a
4ff2  cdfb04    call    #04fb
4ff5  d1        pop     de
4ff6  19        add     hl,de
4ff7  11ad4f    ld      de,#4fad
4ffa  19        add     hl,de
4ffb  5e        ld      e,(hl)
4ffc  210b00    ld      hl,#000b
4fff  39        add     hl,sp
5000  73        ld      (hl),e
5001  210b00    ld      hl,#000b
5004  39        add     hl,sp
5005  5e        ld      e,(hl)
5006  1600      ld      d,#00
5008  21f4ff    ld      hl,#fff4
500b  19        add     hl,de
500c  da2751    jp      c,#5127
500f  211950    ld      hl,#5019
5012  19        add     hl,de
5013  19        add     hl,de
5014  5e        ld      e,(hl)
5015  23        inc     hl
5016  56        ld      d,(hl)
5017  eb        ex      de,hl
5018  e9        jp      (hl)

' Data???
5019  3150
501b  5050
501d  6550
501f  8450
5021  9050
5023  a550
5025  b050
5027  c450
5029  d850
502b  f650
502d  0a51 - Keyboard Test
502f  1551

5031  211200    ld      hl,#0012
5034  39        add     hl,sp
5035  5e        ld      e,(hl)
5036  1600      ld      d,#00
5038  d5        push    de
5039  213d73    ld      hl,#733d
503c  e5        push    hl
503d  210100    ld      hl,#0001
5040  e5        push    hl
5041  cded05    call    #05ed
5044  d1        pop     de
5045  d1        pop     de
5046  d1        pop     de
5047  eb        ex      de,hl
5048  210a00    ld      hl,#000a
504b  39        add     hl,sp
504c  73        ld      (hl),e
504d  c32751    jp      #5127

5050  211200    ld      hl,#0012
5053  39        add     hl,sp
5054  5e        ld      e,(hl)
5055  1600      ld      d,#00
5057  d5        push    de
5058  cd0862    call    #6208
505b  d1        pop     de
505c  eb        ex      de,hl
505d  210a00    ld      hl,#000a
5060  39        add     hl,sp
5061  73        ld      (hl),e
5062  c32751    jp      #5127

5065  211200    ld      hl,#0012
5068  39        add     hl,sp
5069  5e        ld      e,(hl)
506a  1600      ld      d,#00
506c  d5        push    de
506d  21c171    ld      hl,#71c1
5070  e5        push    hl
5071  210100    ld      hl,#0001
5074  e5        push    hl
5075  cded05    call    #05ed
5078  d1        pop     de
5079  d1        pop     de
507a  d1        pop     de
507b  eb        ex      de,hl
507c  210a00    ld      hl,#000a
507f  39        add     hl,sp
5080  73        ld      (hl),e
5081  c32751    jp      #5127

5084  cd4661    call    #6146
5087  eb        ex      de,hl
5088  210a00    ld      hl,#000a
508b  39        add     hl,sp
508c  73        ld      (hl),e
508d  c32751    jp      #5127

5090  211200    ld      hl,#0012
5093  39        add     hl,sp
5094  5e        ld      e,(hl)
5095  1600      ld      d,#00
5097  d5        push    de
5098  cde85b    call    #5be8
509b  d1        pop     de
509c  eb        ex      de,hl
509d  210a00    ld      hl,#000a
50a0  39        add     hl,sp
50a1  73        ld      (hl),e
50a2  c32751    jp      #5127

50a5  cd865f    call    #5f86
50a8  eb        ex      de,hl
50a9  210a00    ld      hl,#000a
50ac  39        add     hl,sp
50ad  73        ld      (hl),e
50ae  1877      jr      #5127           ; (119)

50b0  211200    ld      hl,#0012
50b3  39        add     hl,sp
50b4  5e        ld      e,(hl)
50b5  1600      ld      d,#00
50b7  d5        push    de
50b8  cdf25f    call    #5ff2
50bb  d1        pop     de
50bc  eb        ex      de,hl
50bd  210a00    ld      hl,#000a
50c0  39        add     hl,sp
50c1  73        ld      (hl),e
50c2  1863      jr      #5127           ; (99)

50c4  211200    ld      hl,#0012
50c7  39        add     hl,sp
50c8  5e        ld      e,(hl)
50c9  1600      ld      d,#00
50cb  d5        push    de
50cc  cdb946    call    #46b9
50cf  d1        pop     de
50d0  eb        ex      de,hl
50d1  210a00    ld      hl,#000a
50d4  39        add     hl,sp
50d5  73        ld      (hl),e
50d6  184f      jr      #5127           ; (79)

50d8  211200    ld      hl,#0012
50db  39        add     hl,sp
50dc  5e        ld      e,(hl)
50dd  1600      ld      d,#00
50df  d5        push    de
50e0  215770    ld      hl,#7057
50e3  e5        push    hl
50e4  210100    ld      hl,#0001
50e7  e5        push    hl
50e8  cded05    call    #05ed
50eb  d1        pop     de
50ec  d1        pop     de
50ed  d1        pop     de
50ee  eb        ex      de,hl
50ef  210a00    ld      hl,#000a
50f2  39        add     hl,sp
50f3  73        ld      (hl),e
50f4  1831      jr      #5127           ; (49)

50f6  211200    ld      hl,#0012
50f9  39        add     hl,sp
50fa  5e        ld      e,(hl)
50fb  1600      ld      d,#00
50fd  d5        push    de
50fe  cd024d    call    #4d02
5101  d1        pop     de
5102  eb        ex      de,hl
5103  210a00    ld      hl,#000a
5106  39        add     hl,sp
5107  73        ld      (hl),e
5108  181d      jr      #5127           ; (29)

' Do Keyboard Test
510a  cdab45    call    #45ab
510d  eb        ex      de,hl
510e  210a00    ld      hl,#000a
5111  39        add     hl,sp
5112  73        ld      (hl),e
5113  1812      jr      #5127           ; (18)

5115  211200    ld      hl,#0012
5118  39        add     hl,sp
5119  5e        ld      e,(hl)
511a  1600      ld      d,#00
511c  d5        push    de
511d  cdfd67    call    #67fd
5120  d1        pop     de
5121  eb        ex      de,hl
5122  210a00    ld      hl,#000a
5125  39        add     hl,sp
5126  73        ld      (hl),e
5127  210a00    ld      hl,#000a
512a  39        add     hl,sp
512b  5e        ld      e,(hl)
512c  1600      ld      d,#00
512e  eb        ex      de,hl
512f  c9        ret     

5130  3251
5132  ATH1\r\0
5138  3a51
513a  ATH0\r\0
5140  4251
5142  AT#CLS=8\r\0
514c  4e51
514e  AT#VTS={9,40}\r\0
515d  5f51
515f  ATA\r\0

' ModemOut(s)
5164  11ecff    ld      de,#ffec
5167  cd6b05    call    #056b
516a  212000    ld      hl,#0020
516d  39        add     hl,sp
516e  5e        ld      e,(hl)
516f  23        inc     hl
5170  56        ld      d,(hl)
5171  d5        push    de
5172  210a00    ld      hl,#000a
5175  39        add     hl,sp
5176  e5        push    hl
5177  cdc605    call    #05c6
517a  d1        pop     de
517b  d1        pop     de
517c  210800    ld      hl,#0008
517f  39        add     hl,sp
5180  e5        push    hl
5181  cdcc05    call    #05cc
5184  d1        pop     de
5185  e5        push    hl
5186  210a00    ld      hl,#000a
5189  39        add     hl,sp
518a  e5        push    hl
518b  cd8108    call    #0881
518e  d1        pop     de
518f  d1        pop     de
5190  c9        ret     

5191  2a3051    ld      hl,(#5130)
5194  e5        push    hl
5195  cd6451    call    #5164
5198  d1        pop     de
5199  c9        ret     

519a  2a3851    ld      hl,(#5138)
519d  e5        push    hl
519e  cd6451    call    #5164
51a1  d1        pop     de
51a2  c9        ret     

51a3  2a4051    ld      hl,(#5140)
51a6  e5        push    hl
51a7  cd6451    call    #5164
51aa  d1        pop     de
51ab  218813    ld      hl,#1388
51ae  e5        push    hl
51af  cd5c0a    call    #0a5c
51b2  d1        pop     de
51b3  2a3051    ld      hl,(#5130)
51b6  e5        push    hl
51b7  cd6451    call    #5164
51ba  d1        pop     de
51bb  218813    ld      hl,#1388
51be  e5        push    hl
51bf  cd5c0a    call    #0a5c
51c2  d1        pop     de
51c3  2a4c51    ld      hl,(#514c)
51c6  e5        push    hl
51c7  cd6451    call    #5164
51ca  d1        pop     de
51cb  217017    ld      hl,#1770
51ce  e5        push    hl
51cf  cd5c0a    call    #0a5c
51d2  d1        pop     de
51d3  2a3851    ld      hl,(#5138)
51d6  e5        push    hl
51d7  cd6451    call    #5164
51da  d1        pop     de
51db  c9        ret     

51dc  f451
51de  fd51
51e0  0852
51e2  1552
51e4  1e52
51e6  2952
51e8  3852
51ea  4152
51ec  5152
51ee  5f52
51f0  6852
51f2  7652

51f4  EMI TEST\0
51fd  MODEM PORT\0
5208  PRINTER PORT\0
5215  LCD PORT\0
521e  Waiting...\0
5229  Connect Failed\0
5238  Time Out\0
5241  NORMAL RUN TEST\0
5251  MTBF RUN TEST\0
525f  RUN IDLE\0
5268  RUN MODEM OFF\0
5276  RUN MODEM ON\0

5283  02        ld      (bc),a
5284  03        inc     bc
5285  010021    ld      bc,#2100
5288  02        ld      (bc),a
5289  00        nop     
528a  39        add     hl,sp
528b  7e        ld      a,(hl)
528c  fe07      cp      #07
528e  3819      jr      c,#52a9         ; (25)
5290  213e00    ld      hl,#003e
5293  e5        push    hl
5294  212c01    ld      hl,#012c
5297  e5        push    hl
5298  213000    ld      hl,#0030
529b  e5        push    hl
529c  2e64      ld      l,#64
529e  e5        push    hl
529f  cd8a20    call    #208a
52a2  210800    ld      hl,#0008
52a5  39        add     hl,sp
52a6  f9        ld      sp,hl
52a7  1815      jr      #52be           ; (21)
52a9  216e00    ld      hl,#006e
52ac  e5        push    hl
52ad  214001    ld      hl,#0140
52b0  e5        push    hl
52b1  210000    ld      hl,#0000
52b4  e5        push    hl
52b5  e5        push    hl
52b6  cd8a20    call    #208a
52b9  210800    ld      hl,#0008
52bc  39        add     hl,sp
52bd  f9        ld      sp,hl

' DisplayText(???, 0x6e, 0x32, 1)
52be  210100    ld      hl,#0001
52c1  e5        push    hl
52c2  2e32      ld      l,#32
52c4  e5        push    hl
52c5  2e6e      ld      l,#6e
52c7  e5        push    hl
52c8  210800    ld      hl,#0008
52cb  39        add     hl,sp
52cc  5e        ld      e,(hl)
52cd  1600      ld      d,#00
52cf  eb        ex      de,hl
52d0  29        add     hl,hl
52d1  11dc51    ld      de,#51dc
52d4  19        add     hl,de
52d5  5e        ld      e,(hl)
52d6  23        inc     hl
52d7  56        ld      d,(hl)
52d8  d5        push    de
52d9  cd8d4c    call    #4c8d
52dc  210800    ld      hl,#0008
52df  39        add     hl,sp
52e0  f9        ld      sp,hl

52e1  cd7324    call    #2473
52e4  c9        ret     

52e5  e752
52e7  ATDT123\r\0

52f0  f852
52f2  0353
52f4  0a53
52f6  1353

52f8  1. PRINTER\0
5303  2. LCD\0
530a  3. MODEM\0
5313  4. MODEM-PTR-LCD\0

5324  02
5325  03
5326  01
5327  04

5328  2a53
532a  Please check peripheral installation.\0
5350  5253
5352  Put the paper into printer\0
536d  6f53
536f  H\0

'EMI Test
5371  11eaff    ld      de,#ffea
5374  cd6b05    call    #056b

5377  cd6424    call    #2464
537a  211a00    ld      hl,#001a
537d  39        add     hl,sp
537e  361e      ld      (hl),#1e
5380  23        inc     hl
5381  3600      ld      (hl),#00
5383  210a00    ld      hl,#000a
5386  39        add     hl,sp
5387  3600      ld      (hl),#00
5389  1846      jr      #53d1           ; (70)

' DisplayText("1.PRINTER" or "2.LCD", , , 1)
538b  210100    ld      hl,#0001
538e  e5        push    hl
538f  211c00    ld      hl,#001c
5392  39        add     hl,sp
5393  5e        ld      e,(hl)
5394  23        inc     hl
5395  56        ld      d,(hl)
5396  d5        push    de
5397  216e00    ld      hl,#006e
539a  e5        push    hl
539b  211000    ld      hl,#0010
539e  39        add     hl,sp
539f  5e        ld      e,(hl)
53a0  1600      ld      d,#00
53a2  eb        ex      de,hl
53a3  29        add     hl,hl
53a4  11f052    ld      de,#52f0
53a7  19        add     hl,de
53a8  5e        ld      e,(hl)
53a9  23        inc     hl
53aa  56        ld      d,(hl)
53ab  d5        push    de
53ac  cd8d4c    call    #4c8d
53af  210800    ld      hl,#0008
53b2  39        add     hl,sp
53b3  f9        ld      sp,hl

53b4  211a00    ld      hl,#001a
53b7  39        add     hl,sp
53b8  5e        ld      e,(hl)
53b9  23        inc     hl
53ba  56        ld      d,(hl)
53bb  210f00    ld      hl,#000f
53be  19        add     hl,de
53bf  eb        ex      de,hl
53c0  211a00    ld      hl,#001a
53c3  39        add     hl,sp
53c4  73        ld      (hl),e
53c5  23        inc     hl
53c6  72        ld      (hl),d
53c7  210a00    ld      hl,#000a
53ca  39        add     hl,sp
53cb  e5        push    hl
53cc  6e        ld      l,(hl)
53cd  23        inc     hl
53ce  eb        ex      de,hl
53cf  e1        pop     hl
53d0  73        ld      (hl),e

53d1  210a00    ld      hl,#000a
53d4  39        add     hl,sp
53d5  7e        ld      a,(hl)
53d6  fe04      cp      #04
53d8  38b1      jr      c,#538b         ; (-79)

' DisplayText("Please check peripheral installation.", 10, 105, 0)
53da  210000    ld      hl,#0000
53dd  e5        push    hl
53de  2e69      ld      l,#69
53e0  e5        push    hl
53e1  2e0a      ld      l,#0a
53e3  e5        push    hl
53e4  2a2853    ld      hl,(#5328)
53e7  e5        push    hl
53e8  cd8d4c    call    #4c8d
53eb  210800    ld      hl,#0008
53ee  39        add     hl,sp
53ef  f9        ld      sp,hl

' DisplayText("Put the paper into printer", 10, 115, 0)
53f0  210000    ld      hl,#0000
53f3  e5        push    hl
53f4  2e73      ld      l,#73
53f6  e5        push    hl
53f7  2e0a      ld      l,#0a
53f9  e5        push    hl
53fa  2a5053    ld      hl,(#5350)
53fd  e5        push    hl
53fe  cd8d4c    call    #4c8d
5401  210800    ld      hl,#0008
5404  39        add     hl,sp
5405  f9        ld      sp,hl

5406  cd7324    call    #2473
5409  211c00    ld      hl,#001c
540c  39        add     hl,sp
540d  e5        push    hl
540e  21f455    ld      hl,#55f4
5411  e5        push    hl
5412  210100    ld      hl,#0001
5415  e5        push    hl
5416  cded05    call    #05ed
5419  d1        pop     de
541a  d1        pop     de
541b  d1        pop     de
541c  211c00    ld      hl,#001c
541f  39        add     hl,sp
5420  5e        ld      e,(hl)
5421  23        inc     hl
5422  56        ld      d,(hl)
5423  1b        dec     de
5424  7a        ld      a,d
5425  b3        or      e
5426  c8        ret     z

5427  210400    ld      hl,#0004
542a  e5        push    hl
542b  211e00    ld      hl,#001e
542e  39        add     hl,sp
542f  5e        ld      e,(hl)
5430  23        inc     hl
5431  56        ld      d,(hl)
5432  d5        push    de
5433  212f51    ld      hl,#512f
5436  e5        push    hl
5437  210100    ld      hl,#0001
543a  e5        push    hl
543b  cded05    call    #05ed
543e  eb        ex      de,hl
543f  210800    ld      hl,#0008
5442  39        add     hl,sp
5443  f9        ld      sp,hl
5444  211c00    ld      hl,#001c
5447  39        add     hl,sp
5448  73        ld      (hl),e
5449  23        inc     hl
544a  72        ld      (hl),d
544b  2b        dec     hl
544c  5e        ld      e,(hl)
544d  2101ff    ld      hl,#ff01
5450  19        add     hl,de
5451  7c        ld      a,h
5452  b5        or      l
5453  28b4      jr      z,#5409         ; (-76)
5455  211c00    ld      hl,#001c
5458  39        add     hl,sp
5459  5e        ld      e,(hl)
545a  23        inc     hl
545b  56        ld      d,(hl)
545c  1b        dec     de
545d  72        ld      (hl),d
545e  2b        dec     hl
545f  73        ld      (hl),e
5460  23        inc     hl
5461  56        ld      d,(hl)
5462  212453    ld      hl,#5324
5465  19        add     hl,de
5466  5e        ld      e,(hl)
5467  210800    ld      hl,#0008
546a  39        add     hl,sp
546b  73        ld      (hl),e
546c  7b        ld      a,e
546d  fe04      cp      #04
546f  2806      jr      z,#5477         ; (6)
5471  7e        ld      a,(hl)
5472  fe01      cp      #01
5474  c23c55    jp      nz,#553c
5477  cd0561    call    #6105
547a  211600    ld      hl,#0016
547d  39        add     hl,sp
547e  3601      ld      (hl),#01
5480  210400    ld      hl,#0004
5483  e5        push    hl
5484  cd8752    call    #5287
5487  d1        pop     de
5488  2ae552    ld      hl,(#52e5)
548b  e5        push    hl
548c  210e00    ld      hl,#000e
548f  39        add     hl,sp
5490  e5        push    hl
5491  cdc605    call    #05c6
5494  d1        pop     de
5495  d1        pop     de
5496  210c00    ld      hl,#000c
5499  39        add     hl,sp
549a  e5        push    hl
549b  cdcc05    call    #05cc
549e  d1        pop     de
549f  e5        push    hl
54a0  210e00    ld      hl,#000e
54a3  39        add     hl,sp
54a4  e5        push    hl
54a5  cd8108    call    #0881
54a8  d1        pop     de
54a9  d1        pop     de
54aa  211a00    ld      hl,#001a
54ad  39        add     hl,sp
54ae  3600      ld      (hl),#00
54b0  23        inc     hl
54b1  3600      ld      (hl),#00
54b3  210a00    ld      hl,#000a
54b6  39        add     hl,sp
54b7  3600      ld      (hl),#00
54b9  216971    ld      hl,#7169
54bc  e5        push    hl
54bd  210600    ld      hl,#0006
54c0  e5        push    hl
54c1  cded05    call    #05ed
54c4  d1        pop     de
54c5  d1        pop     de
54c6  eb        ex      de,hl
54c7  210900    ld      hl,#0009
54ca  39        add     hl,sp
54cb  73        ld      (hl),e
54cc  7b        ld      a,e
54cd  b7        or      a
54ce  281d      jr      z,#54ed         ; (29)
54d0  7e        ld      a,(hl)
54d1  fe01      cp      #01
54d3  2867      jr      z,#553c         ; (103)
54d5  210500    ld      hl,#0005
54d8  e5        push    hl
54d9  cd8752    call    #5287
54dc  d1        pop     de
54dd  21b80b    ld      hl,#0bb8
54e0  e5        push    hl
54e1  cd5c0a    call    #0a5c
54e4  d1        pop     de
54e5  211600    ld      hl,#0016
54e8  39        add     hl,sp
54e9  3600      ld      (hl),#00
54eb  184f      jr      #553c           ; (79)
54ed  211a00    ld      hl,#001a
54f0  39        add     hl,sp
54f1  5e        ld      e,(hl)
54f2  23        inc     hl
54f3  56        ld      d,(hl)
54f4  13        inc     de
54f5  72        ld      (hl),d
54f6  2b        dec     hl
54f7  73        ld      (hl),e
54f8  23        inc     hl
54f9  56        ld      d,(hl)
54fa  eb        ex      de,hl
54fb  cdde04    call    #04de
54fe  cd1102    call    #0211
5501  60        ld      h,b
5502  ea0000    jp      pe,#0000
5505  cda804    call    #04a8
5508  2813      jr      z,#551d         ; (19)
550a  210a00    ld      hl,#000a
550d  39        add     hl,sp
550e  e5        push    hl
550f  6e        ld      l,(hl)
5510  23        inc     hl
5511  eb        ex      de,hl
5512  e1        pop     hl
5513  73        ld      (hl),e
5514  211a00    ld      hl,#001a
5517  39        add     hl,sp
5518  3600      ld      (hl),#00
551a  23        inc     hl
551b  3600      ld      (hl),#00
551d  210a00    ld      hl,#000a
5520  39        add     hl,sp
5521  7e        ld      a,(hl)
5522  fe04      cp      #04
5524  3893      jr      c,#54b9         ; (-109)
5526  210600    ld      hl,#0006
5529  e5        push    hl
552a  cd8752    call    #5287
552d  d1        pop     de
552e  21b80b    ld      hl,#0bb8
5531  e5        push    hl
5532  cd5c0a    call    #0a5c
5535  d1        pop     de
5536  211600    ld      hl,#0016
5539  39        add     hl,sp
553a  3600      ld      (hl),#00
553c  210800    ld      hl,#0008
553f  39        add     hl,sp
5540  7e        ld      a,(hl)
5541  fe01      cp      #01
5543  2009      jr      nz,#554e        ; (9)
5545  211600    ld      hl,#0016
5548  39        add     hl,sp
5549  7e        ld      a,(hl)
554a  b7        or      a
554b  ca7753    jp      z,#5377
554e  211a00    ld      hl,#001a
5551  39        add     hl,sp
5552  3600      ld      (hl),#00
5554  23        inc     hl
5555  3600      ld      (hl),#00
5557  2b        dec     hl
5558  2b        dec     hl
5559  3600      ld      (hl),#00
555b  2b        dec     hl
555c  3600      ld      (hl),#00
555e  210b00    ld      hl,#000b
5561  39        add     hl,sp
5562  3600      ld      (hl),#00
5564  211700    ld      hl,#0017
5567  39        add     hl,sp
5568  3604      ld      (hl),#04
556a  cd6424    call    #2464
556d  211c00    ld      hl,#001c
5570  39        add     hl,sp
5571  5e        ld      e,(hl)
5572  23        inc     hl
5573  56        ld      d,(hl)
5574  218352    ld      hl,#5283
5577  19        add     hl,de
5578  5e        ld      e,(hl)
5579  1600      ld      d,#00
557b  d5        push    de
557c  cd8752    call    #5287
557f  d1        pop     de
5580  cd7324    call    #2473
5583  211c00    ld      hl,#001c
5586  39        add     hl,sp
5587  e5        push    hl
5588  21f455    ld      hl,#55f4
558b  e5        push    hl
558c  210100    ld      hl,#0001
558f  e5        push    hl
5590  cded05    call    #05ed
5593  d1        pop     de
5594  d1        pop     de
5595  d1        pop     de
5596  211c00    ld      hl,#001c
5599  39        add     hl,sp
559a  5e        ld      e,(hl)
559b  23        inc     hl
559c  56        ld      d,(hl)
559d  1b        dec     de
559e  7a        ld      a,d
559f  b3        or      e
55a0  2006      jr      nz,#55a8        ; (6)
55a2  cd6608    call    #0866
55a5  c37753    jp      #5377
55a8  211700    ld      hl,#0017
55ab  39        add     hl,sp
55ac  7e        ld      a,(hl)
55ad  eb        ex      de,hl
55ae  3d        dec     a
55af  2831      jr      z,#55e2         ; (49)
55b1  3d        dec     a
55b2  286b      jr      z,#561f         ; (107)
55b4  3d        dec     a
55b5  ca8156    jp      z,#5681
55b8  3d        dec     a
55b9  c21b57    jp      nz,#571b
55bc  210800    ld      hl,#0008
55bf  39        add     hl,sp
55c0  7e        ld      a,(hl)
55c1  fe04      cp      #04
55c3  2014      jr      nz,#55d9        ; (20)
55c5  211600    ld      hl,#0016
55c8  39        add     hl,sp
55c9  7e        ld      a,(hl)
55ca  b7        or      a
55cb  2806      jr      z,#55d3         ; (6)
55cd  23        inc     hl
55ce  3601      ld      (hl),#01
55d0  c31b57    jp      #571b
55d3  23        inc     hl
55d4  3602      ld      (hl),#02
55d6  c31b57    jp      #571b
55d9  5e        ld      e,(hl)
55da  211700    ld      hl,#0017
55dd  39        add     hl,sp
55de  73        ld      (hl),e
55df  c31b57    jp      #571b
55e2  212657    ld      hl,#5726
55e5  e5        push    hl
55e6  210e00    ld      hl,#000e
55e9  39        add     hl,sp
55ea  e5        push    hl
55eb  cdc605    call    #05c6
55ee  d1        pop     de
55ef  d1        pop     de
55f0  210c00    ld      hl,#000c
55f3  39        add     hl,sp

55f4  e5        push    hl
55f5  cdcc05    call    #05cc
55f8  d1        pop     de
55f9  e5        push    hl
55fa  210e00    ld      hl,#000e
55fd  39        add     hl,sp
55fe  e5        push    hl
55ff  cd8108    call    #0881
5602  d1        pop     de
5603  d1        pop     de
5604  210800    ld      hl,#0008
5607  39        add     hl,sp
5608  7e        ld      a,(hl)
5609  fe04      cp      #04
560b  2009      jr      nz,#5616        ; (9)
560d  211700    ld      hl,#0017
5610  39        add     hl,sp
5611  3602      ld      (hl),#02
5613  c31b57    jp      #571b
5616  211700    ld      hl,#0017
5619  39        add     hl,sp
561a  3601      ld      (hl),#01
561c  c31b57    jp      #571b
561f  210a00    ld      hl,#000a
5622  39        add     hl,sp
5623  3648      ld      (hl),#48
5625  5e        ld      e,(hl)
5626  1600      ld      d,#00
5628  d5        push    de
5629  cd505b    call    #5b50
562c  d1        pop     de
562d  210100    ld      hl,#0001
5630  e5        push    hl
5631  cd5c0a    call    #0a5c
5634  d1        pop     de
5635  210a00    ld      hl,#000a
5638  39        add     hl,sp
5639  5e        ld      e,(hl)
563a  1600      ld      d,#00
563c  d5        push    de
563d  cd505b    call    #5b50
5640  d1        pop     de
5641  210b00    ld      hl,#000b
5644  39        add     hl,sp
5645  5e        ld      e,(hl)
5646  1600      ld      d,#00
5648  13        inc     de
5649  13        inc     de
564a  73        ld      (hl),e
564b  7b        ld      a,e
564c  fe50      cp      #50
564e  3816      jr      c,#5666         ; (22)
5650  210d00    ld      hl,#000d
5653  e5        push    hl
5654  cd505b    call    #5b50
5657  d1        pop     de
5658  210a00    ld      hl,#000a
565b  e5        push    hl
565c  cd505b    call    #5b50
565f  d1        pop     de
5660  210b00    ld      hl,#000b
5663  39        add     hl,sp
5664  3600      ld      (hl),#00
5666  210800    ld      hl,#0008
5669  39        add     hl,sp
566a  7e        ld      a,(hl)
566b  fe04      cp      #04
566d  2009      jr      nz,#5678        ; (9)
566f  211700    ld      hl,#0017
5672  39        add     hl,sp
5673  3603      ld      (hl),#03
5675  c31b57    jp      #571b
5678  211700    ld      hl,#0017
567b  39        add     hl,sp
567c  3602      ld      (hl),#02
567e  c31b57    jp      #571b

' DisplayText("H", ?, ?, 0)
5681  210000    ld      hl,#0000
5684  e5        push    hl
5685  eb        ex      de,hl
5686  23        inc     hl
5687  5e        ld      e,(hl)
5688  23        inc     hl
5689  56        ld      d,(hl)
568a  d5        push    de
568b  23        inc     hl
568c  5e        ld      e,(hl)
568d  23        inc     hl
568e  56        ld      d,(hl)
568f  d5        push    de
5690  2a6d53    ld      hl,(#536d)
5693  e5        push    hl
5694  cd8d4c    call    #4c8d
5697  210800    ld      hl,#0008
569a  39        add     hl,sp
569b  f9        ld      sp,hl

569c  210a00    ld      hl,#000a
569f  e5        push    hl
56a0  211a00    ld      hl,#001a
56a3  39        add     hl,sp
56a4  5e        ld      e,(hl)
56a5  23        inc     hl
56a6  56        ld      d,(hl)
56a7  d5        push    de
56a8  23        inc     hl
56a9  5e        ld      e,(hl)
56aa  23        inc     hl
56ab  56        ld      d,(hl)
56ac  d5        push    de
56ad  cdb724    call    #24b7
56b0  d1        pop     de
56b1  d1        pop     de
56b2  d1        pop     de
56b3  211a00    ld      hl,#001a
56b6  39        add     hl,sp
56b7  5e        ld      e,(hl)
56b8  23        inc     hl
56b9  56        ld      d,(hl)
56ba  210600    ld      hl,#0006
56bd  19        add     hl,de
56be  eb        ex      de,hl
56bf  211a00    ld      hl,#001a
56c2  39        add     hl,sp
56c3  73        ld      (hl),e
56c4  23        inc     hl
56c5  72        ld      (hl),d
56c6  2b        dec     hl
56c7  5e        ld      e,(hl)
56c8  21c0fe    ld      hl,#fec0
56cb  19        add     hl,de
56cc  301a      jr      nc,#56e8        ; (26)
56ce  211a00    ld      hl,#001a
56d1  39        add     hl,sp
56d2  3600      ld      (hl),#00
56d4  23        inc     hl
56d5  3600      ld      (hl),#00
56d7  2b        dec     hl
56d8  2b        dec     hl
56d9  56        ld      d,(hl)
56da  2b        dec     hl
56db  5e        ld      e,(hl)
56dc  210a00    ld      hl,#000a
56df  19        add     hl,de
56e0  eb        ex      de,hl
56e1  211800    ld      hl,#0018
56e4  39        add     hl,sp
56e5  73        ld      (hl),e
56e6  23        inc     hl
56e7  72        ld      (hl),d
56e8  211800    ld      hl,#0018
56eb  39        add     hl,sp
56ec  5e        ld      e,(hl)
56ed  23        inc     hl
56ee  56        ld      d,(hl)
56ef  2188ff    ld      hl,#ff88
56f2  19        add     hl,de
56f3  300f      jr      nc,#5704        ; (15)
56f5  cd6424    call    #2464
56f8  cd7324    call    #2473
56fb  211800    ld      hl,#0018
56fe  39        add     hl,sp
56ff  3600      ld      (hl),#00
5701  23        inc     hl
5702  3600      ld      (hl),#00
5704  210800    ld      hl,#0008
5707  39        add     hl,sp
5708  7e        ld      a,(hl)
5709  fe04      cp      #04
570b  2008      jr      nz,#5715        ; (8)
570d  211700    ld      hl,#0017
5710  39        add     hl,sp
5711  3604      ld      (hl),#04
5713  1806      jr      #571b           ; (6)
5715  211700    ld      hl,#0017
5718  39        add     hl,sp
5719  3603      ld      (hl),#03
571b  210a00    ld      hl,#000a
571e  e5        push    hl
571f  cd5c0a    call    #0a5c
5722  d1        pop     de
5723  c38355    jp      #5583
5726  48        ld      c,b
5727  48        ld      c,b
5728  00        nop     
5729  11ceff    ld      de,#ffce
572c  cd6b05    call    #056b
572f  3e00      ld      a,#00
5731  322ae6    ld      (#e62a),a
5734  3229e6    ld      (#e629),a
5737  cdea35    call    #35ea
573a  3e00      ld      a,#00
573c  3228e6    ld      (#e628),a
573f  214000    ld      hl,#0040
5742  39        add     hl,sp
5743  7e        ld      a,(hl)
5744  b7        or      a
5745  2010      jr      nz,#5757        ; (16)
5747  21af57    ld      hl,#57af
574a  e5        push    hl
574b  210a00    ld      hl,#000a
574e  39        add     hl,sp
574f  e5        push    hl
5750  cdc605    call    #05c6
5753  d1        pop     de
5754  d1        pop     de
5755  180e      jr      #5765           ; (14)
5757  21b657    ld      hl,#57b6
575a  e5        push    hl
575b  210a00    ld      hl,#000a
575e  39        add     hl,sp
575f  e5        push    hl
5760  cdc605    call    #05c6
5763  d1        pop     de
5764  d1        pop     de
5765  213e00    ld      hl,#003e
5768  39        add     hl,sp
5769  5e        ld      e,(hl)
576a  23        inc     hl
576b  56        ld      d,(hl)
576c  d5        push    de
576d  210a00    ld      hl,#000a
5770  39        add     hl,sp
5771  e5        push    hl
5772  cdba05    call    #05ba
5775  d1        pop     de
5776  d1        pop     de
5777  21bb57    ld      hl,#57bb
577a  e5        push    hl
577b  210a00    ld      hl,#000a
577e  39        add     hl,sp
577f  e5        push    hl
5780  cdba05    call    #05ba
5783  d1        pop     de
5784  d1        pop     de
5785  210800    ld      hl,#0008
5788  39        add     hl,sp
5789  e5        push    hl
578a  cdcc05    call    #05cc
578d  d1        pop     de
578e  e5        push    hl
578f  210a00    ld      hl,#000a
5792  39        add     hl,sp
5793  e5        push    hl
5794  cd8108    call    #0881
5797  d1        pop     de
5798  d1        pop     de
5799  210100    ld      hl,#0001
579c  e5        push    hl
579d  e5        push    hl
579e  217d6b    ld      hl,#6b7d
57a1  e5        push    hl
57a2  210600    ld      hl,#0006
57a5  e5        push    hl
57a6  cded05    call    #05ed
57a9  210800    ld      hl,#0008
57ac  39        add     hl,sp
57ad  f9        ld      sp,hl
57ae  c9        ret     

57af  ATX0DT\0
57b6  ATDT\0
57bb  \r\0

57bd  bf57
57bf  Dial:\0
57c5  c757
57c7  T: DTMF\0
57cf  d157
57d1  D: DTMF9\0
57da  dc57
57dc  123456789*0#123456789*0#123456789*0#1234\0

5805  11d2ff    ld      de,#ffd2
5808  cd6b05    call    #056b
580b  cd0561    call    #6105

' DisplayText("Dial:", 0x28, 0x32, 1)
580e  210100    ld      hl,#0001
5811  e5        push    hl
5812  2e32      ld      l,#32
5814  e5        push    hl
5815  2e28      ld      l,#28
5817  e5        push    hl
5818  2abd57    ld      hl,(#57bd)
581b  e5        push    hl
581c  cd8d4c    call    #4c8d
581f  210800    ld      hl,#0008
5822  39        add     hl,sp
5823  f9        ld      sp,hl

5824  210000    ld      hl,#0000
5827  e5        push    hl
5828  210166    ld      hl,#6601
582b  e5        push    hl
582c  210100    ld      hl,#0001
582f  e5        push    hl
5830  cded05    call    #05ed
5833  d1        pop     de
5834  d1        pop     de
5835  d1        pop     de
5836  217f00    ld      hl,#007f
5839  e5        push    hl
583a  2eb4      ld      l,#b4
583c  e5        push    hl
583d  2e6f      ld      l,#6f
583f  e5        push    hl
5840  2e78      ld      l,#78
5842  e5        push    hl
5843  cd8a20    call    #208a
5846  210800    ld      hl,#0008
5849  39        add     hl,sp
584a  f9        ld      sp,hl

' DisplayText("T: DTMF", 128, 116, 0)
584b  210000    ld      hl,#0000
584e  e5        push    hl
584f  2e74      ld      l,#74
5851  e5        push    hl
5852  2e80      ld      l,#80
5854  e5        push    hl
5855  2ac557    ld      hl,(#57c5)
5858  e5        push    hl
5859  cd8d4c    call    #4c8d
585c  210800    ld      hl,#0008
585f  39        add     hl,sp
5860  f9        ld      sp,hl

5861  217e00    ld      hl,#007e
5864  e5        push    hl
5865  2ea6      ld      l,#a6
5867  e5        push    hl
5868  2e71      ld      l,#71
586a  e5        push    hl
586b  2e7d      ld      l,#7d
586d  e5        push    hl
586e  cdee21    call    #21ee

5871  210800    ld      hl,#0008
5874  39        add     hl,sp
5875  f9        ld      sp,hl

' DisplayText("D: DTMF9", 178, 116, 0)
5876  210000    ld      hl,#0000
5879  e5        push    hl
587a  2e74      ld      l,#74
587c  e5        push    hl
587d  2eb2      ld      l,#b2
587f  e5        push    hl
5880  2acf57    ld      hl,(#57cf)
5883  e5        push    hl
5884  cd8d4c    call    #4c8d
5887  210800    ld      hl,#0008
588a  39        add     hl,sp
588b  f9        ld      sp,hl

588c  217e00    ld      hl,#007e
588f  e5        push    hl
5890  2ede      ld      l,#de
5892  e5        push    hl
5893  2e71      ld      l,#71
5895  e5        push    hl
5896  2eb0      ld      l,#b0
5898  e5        push    hl
5899  cdee21    call    #21ee
589c  210800    ld      hl,#0008
589f  39        add     hl,sp
58a0  f9        ld      sp,hl
58a1  cd7324    call    #2473
58a4  210a00    ld      hl,#000a
58a7  39        add     hl,sp
58a8  36ff      ld      (hl),#ff
58aa  210800    ld      hl,#0008
58ad  39        add     hl,sp
58ae  e5        push    hl
58af  21f455    ld      hl,#55f4
58b2  e5        push    hl
58b3  210100    ld      hl,#0001
58b6  e5        push    hl
58b7  cded05    call    #05ed
58ba  d1        pop     de
58bb  d1        pop     de
58bc  d1        pop     de
58bd  3a58f6    ld      a,(#f658)
58c0  b7        or      a
58c1  2831      jr      z,#58f4         ; (49)
58c3  210800    ld      hl,#0008
58c6  39        add     hl,sp
58c7  5e        ld      e,(hl)
58c8  23        inc     hl
58c9  56        ld      d,(hl)
58ca  21ddff    ld      hl,#ffdd
58cd  19        add     hl,de
58ce  7c        ld      a,h
58cf  b5        or      l
58d0  2009      jr      nz,#58db        ; (9)
58d2  210a00    ld      hl,#000a
58d5  39        add     hl,sp
58d6  3623      ld      (hl),#23
58d8  c39959    jp      #5999
58db  210800    ld      hl,#0008
58de  39        add     hl,sp
58df  5e        ld      e,(hl)
58e0  23        inc     hl
58e1  56        ld      d,(hl)
58e2  21d0ff    ld      hl,#ffd0
58e5  19        add     hl,de
58e6  7c        ld      a,h
58e7  b5        or      l
58e8  c29959    jp      nz,#5999
58eb  210a00    ld      hl,#000a
58ee  39        add     hl,sp
58ef  362a      ld      (hl),#2a
58f1  c39959    jp      #5999
58f4  210800    ld      hl,#0008
58f7  39        add     hl,sp
58f8  5e        ld      e,(hl)
58f9  23        inc     hl
58fa  56        ld      d,(hl)
58fb  1b        dec     de
58fc  7a        ld      a,d
58fd  b3        or      e
58fe  ca6608    jp      z,#0866
5901  56        ld      d,(hl)
5902  2b        dec     hl
5903  5e        ld      e,(hl)
5904  21afff    ld      hl,#ffaf
5907  19        add     hl,de
5908  7c        ld      a,h
5909  b5        or      l
590a  200c      jr      nz,#5918        ; (12)
590c  cd9151    call    #5191
590f  210a00    ld      hl,#000a
5912  39        add     hl,sp
5913  36ff      ld      (hl),#ff
5915  c39959    jp      #5999
5918  210800    ld      hl,#0008
591b  39        add     hl,sp
591c  5e        ld      e,(hl)
591d  23        inc     hl
591e  56        ld      d,(hl)
591f  219cff    ld      hl,#ff9c
5922  19        add     hl,de
5923  7c        ld      a,h
5924  b5        or      l
5925  200b      jr      nz,#5932        ; (11)
5927  cd9a51    call    #519a
592a  210a00    ld      hl,#000a
592d  39        add     hl,sp
592e  36ff      ld      (hl),#ff
5930  1867      jr      #5999           ; (103)
5932  210800    ld      hl,#0008
5935  39        add     hl,sp
5936  5e        ld      e,(hl)
5937  23        inc     hl
5938  56        ld      d,(hl)
5939  219dff    ld      hl,#ff9d
593c  19        add     hl,de
593d  7c        ld      a,h
593e  b5        or      l
593f  200e      jr      nz,#594f        ; (14)
5941  cda351    call    #51a3
5944  cd9d0a    call    #0a9d
5947  210a00    ld      hl,#000a
594a  39        add     hl,sp
594b  36ff      ld      (hl),#ff
594d  184a      jr      #5999           ; (74)
594f  210800    ld      hl,#0008
5952  39        add     hl,sp
5953  5e        ld      e,(hl)
5954  23        inc     hl
5955  56        ld      d,(hl)
5956  21bbff    ld      hl,#ffbb
5959  19        add     hl,de
595a  7c        ld      a,h
595b  b5        or      l
595c  2008      jr      nz,#5966        ; (8)
595e  210a00    ld      hl,#000a
5961  39        add     hl,sp
5962  3600      ld      (hl),#00
5964  1833      jr      #5999           ; (51)
5966  210a00    ld      hl,#000a
5969  e5        push    hl
596a  39        add     hl,sp
596b  5e        ld      e,(hl)
596c  23        inc     hl
596d  56        ld      d,(hl)
596e  d5        push    de
596f  212f51    ld      hl,#512f
5972  e5        push    hl
5973  210100    ld      hl,#0001
5976  e5        push    hl
5977  cded05    call    #05ed
597a  eb        ex      de,hl
597b  210800    ld      hl,#0008
597e  39        add     hl,sp
597f  f9        ld      sp,hl
5980  210a00    ld      hl,#000a
5983  39        add     hl,sp
5984  73        ld      (hl),e
5985  7b        ld      a,e
5986  feff      cp      #ff
5988  280f      jr      z,#5999         ; (15)
598a  7e        ld      a,(hl)
598b  fe0a      cp      #0a
598d  2002      jr      nz,#5991        ; (2)
598f  3600      ld      (hl),#00
5991  210a00    ld      hl,#000a
5994  39        add     hl,sp
5995  7e        ld      a,(hl)
5996  c630      add     a,#30
5998  77        ld      (hl),a
5999  210a00    ld      hl,#000a
599c  39        add     hl,sp
599d  7e        ld      a,(hl)
599e  feff      cp      #ff
59a0  caaa58    jp      z,#58aa
59a3  b7        or      a
59a4  2010      jr      nz,#59b6        ; (16)
59a6  2ada57    ld      hl,(#57da)
59a9  e5        push    hl
59aa  210e00    ld      hl,#000e
59ad  39        add     hl,sp
59ae  e5        push    hl
59af  cdc605    call    #05c6
59b2  d1        pop     de
59b3  d1        pop     de
59b4  1816      jr      #59cc           ; (22)
59b6  21565a    ld      hl,#5a56
59b9  e5        push    hl
59ba  210e00    ld      hl,#000e
59bd  39        add     hl,sp
59be  e5        push    hl
59bf  cdc605    call    #05c6
59c2  d1        pop     de
59c3  d1        pop     de
59c4  210a00    ld      hl,#000a
59c7  39        add     hl,sp
59c8  5e        ld      e,(hl)
59c9  23        inc     hl
59ca  23        inc     hl
59cb  73        ld      (hl),e
59cc  213c00    ld      hl,#003c
59cf  e5        push    hl
59d0  214001    ld      hl,#0140
59d3  e5        push    hl
59d4  213000    ld      hl,#0030
59d7  e5        push    hl
59d8  2e3f      ld      l,#3f
59da  e5        push    hl
59db  cd8a20    call    #208a
59de  210800    ld      hl,#0008
59e1  39        add     hl,sp
59e2  f9        ld      sp,hl

' DisplayText(???, 65, 50, 1)
59e3  210100    ld      hl,#0001
59e6  e5        push    hl
59e7  2e32      ld      l,#32
59e9  e5        push    hl
59ea  2e41      ld      l,#41
59ec  e5        push    hl
59ed  211200    ld      hl,#0012
59f0  39        add     hl,sp
59f1  e5        push    hl
59f2  cd8d4c    call    #4c8d
59f5  210800    ld      hl,#0008
59f8  39        add     hl,sp
59f9  f9        ld      sp,hl

59fa  cd7324    call    #2473
59fd  210000    ld      hl,#0000
5a00  e5        push    hl
5a01  210e00    ld      hl,#000e
5a04  39        add     hl,sp
5a05  e5        push    hl
5a06  cd2957    call    #5729
5a09  d1        pop     de
5a0a  d1        pop     de
5a0b  210a00    ld      hl,#000a
5a0e  39        add     hl,sp
5a0f  7e        ld      a,(hl)
5a10  b7        or      a
5a11  200a      jr      nz,#5a1d        ; (10)
5a13  213075    ld      hl,#7530
5a16  e5        push    hl
5a17  cd5c0a    call    #0a5c
5a1a  d1        pop     de
5a1b  1808      jr      #5a25           ; (8)
5a1d  21983a    ld      hl,#3a98
5a20  e5        push    hl
5a21  cd5c0a    call    #0a5c
5a24  d1        pop     de
5a25  cd9a51    call    #519a
5a28  210a00    ld      hl,#000a
5a2b  39        add     hl,sp
5a2c  36ff      ld      (hl),#ff
5a2e  216400    ld      hl,#0064
5a31  e5        push    hl
5a32  cd5c0a    call    #0a5c
5a35  d1        pop     de
5a36  cd9d0a    call    #0a9d
5a39  213c00    ld      hl,#003c
5a3c  e5        push    hl
5a3d  214001    ld      hl,#0140
5a40  e5        push    hl
5a41  213000    ld      hl,#0030
5a44  e5        push    hl
5a45  2e3f      ld      l,#3f
5a47  e5        push    hl
5a48  cd8a20    call    #208a
5a4b  210800    ld      hl,#0008
5a4e  39        add     hl,sp
5a4f  f9        ld      sp,hl
5a50  cd7324    call    #2473
5a53  c3aa58    jp      #58aa

5a56   \0    'Space Null
5a58  5a5a
5a5a  QA TEST MENU\0

5a67  11feff    ld      de,#fffe
5a6a  cd6b05    call    #056b
5a6d  cd6424    call    #2464

' DisplayText("QA TEST MENU", 120, 5, 1)
5a70  210100    ld      hl,#0001
5a73  e5        push    hl
5a74  2e05      ld      l,#05
5a76  e5        push    hl
5a77  2e78      ld      l,#78
5a79  e5        push    hl
5a7a  2a585a    ld      hl,(#5a58)
5a7d  e5        push    hl
5a7e  cd8d4c    call    #4c8d
5a81  210800    ld      hl,#0008
5a84  39        add     hl,sp
5a85  f9        ld      sp,hl

5a86  211200    ld      hl,#0012
5a89  e5        push    hl
5a8a  214001    ld      hl,#0140
5a8d  e5        push    hl
5a8e  210000    ld      hl,#0000
5a91  e5        push    hl
5a92  e5        push    hl
5a93  cdee21    call    #21ee
5a96  210800    ld      hl,#0008
5a99  39        add     hl,sp
5a9a  f9        ld      sp,hl
5a9b  210100    ld      hl,#0001
5a9e  e5        push    hl
5a9f  2e19      ld      l,#19
5aa1  e5        push    hl
5aa2  2e28      ld      l,#28
5aa4  e5        push    hl
5aa5  2e64      ld      l,#64
5aa7  e5        push    hl
5aa8  2e0a      ld      l,#0a
5aaa  e5        push    hl
5aab  21fa5a    ld      hl,#5afa
5aae  e5        push    hl
5aaf  210100    ld      hl,#0001
5ab2  e5        push    hl
5ab3  cded05    call    #05ed
5ab6  210e00    ld      hl,#000e
5ab9  39        add     hl,sp
5aba  f9        ld      sp,hl
5abb  cd7324    call    #2473
5abe  210800    ld      hl,#0008
5ac1  39        add     hl,sp
5ac2  e5        push    hl
5ac3  21f455    ld      hl,#55f4
5ac6  e5        push    hl
5ac7  210100    ld      hl,#0001
5aca  e5        push    hl
5acb  cded05    call    #05ed
5ace  d1        pop     de
5acf  d1        pop     de
5ad0  d1        pop     de
5ad1  210800    ld      hl,#0008
5ad4  39        add     hl,sp
5ad5  5e        ld      e,(hl)
5ad6  23        inc     hl
5ad7  56        ld      d,(hl)
5ad8  1b        dec     de
5ad9  7a        ld      a,d
5ada  b3        or      e
5adb  c8        ret     z

5adc  210500    ld      hl,#0005
5adf  e5        push    hl
5ae0  210a00    ld      hl,#000a
5ae3  39        add     hl,sp
5ae4  5e        ld      e,(hl)
5ae5  23        inc     hl
5ae6  56        ld      d,(hl)
5ae7  d5        push    de
5ae8  212f51    ld      hl,#512f
5aeb  e5        push    hl
5aec  210100    ld      hl,#0001
5aef  e5        push    hl
5af0  cded05    call    #05ed
5af3  eb        ex      de,hl
5af4  210800    ld      hl,#0008
5af7  39        add     hl,sp
5af8  f9        ld      sp,hl
5af9  210800    ld      hl,#0008
5afc  39        add     hl,sp
5afd  73        ld      (hl),e
5afe  23        inc     hl
5aff  72        ld      (hl),d
5b00  2b        dec     hl
5b01  5e        ld      e,(hl)
5b02  2101ff    ld      hl,#ff01
5b05  19        add     hl,de
5b06  7c        ld      a,h
5b07  b5        or      l
5b08  28b4      jr      z,#5abe         ; (-76)
5b0a  210800    ld      hl,#0008
5b0d  39        add     hl,sp
5b0e  7e        ld      a,(hl)
5b0f  23        inc     hl
5b10  b6        or      (hl)
5b11  28ab      jr      z,#5abe         ; (-85)
5b13  56        ld      d,(hl)
5b14  2b        dec     hl
5b15  5e        ld      e,(hl)
5b16  23        inc     hl
5b17  1b        dec     de
5b18  72        ld      (hl),d
5b19  2b        dec     hl
5b1a  73        ld      (hl),e
5b1b  cd6424    call    #2464
5b1e  210800    ld      hl,#0008
5b21  39        add     hl,sp
5b22  5e        ld      e,(hl)
5b23  23        inc     hl
5b24  56        ld      d,(hl)
5b25  eb        ex      de,hl
5b26  cd6901    call    #0169

5b29  0300
5b2b  0000

5b2d  395b
5b2f  0100

5b31  3f5b
5b33  0200

5b35  455b
5b37  6d5a

'EMI
5b39  cd7153    call    #5371
5b3c  c36d5a    jp      #5a6d

'DTMF
5b3f  cd0558    call    #5805
5b42  c36d5a    jp      #5a6d

'MODEM TEST
5b45  210500    ld      hl,#0005
5b48  e5        push    hl
5b49  cdfd67    call    #67fd
5b4c  d1        pop     de
5b4d  c36d5a    jp      #5a6d

5b50  11fdff    ld      de,#fffd
5b53  cd6b05    call    #056b
5b56  cd1f1a    call    #1a1f
5b59  eb        ex      de,hl
5b5a  210a00    ld      hl,#000a
5b5d  39        add     hl,sp
5b5e  73        ld      (hl),e
5b5f  7b        ld      a,e
5b60  e620      and     #20
5b62  2005      jr      nz,#5b69        ; (5)
5b64  7e        ld      a,(hl)
5b65  e608      and     #08
5b67  2004      jr      nz,#5b6d        ; (4)
5b69  210000    ld      hl,#0000
5b6c  c9        ret     

5b6d  210f00    ld      hl,#000f
5b70  39        add     hl,sp
5b71  5e        ld      e,(hl)
5b72  1600      ld      d,#00
5b74  d5        push    de
5b75  cd131a    call    #1a13
5b78  d1        pop     de
5b79  210800    ld      hl,#0008
5b7c  39        add     hl,sp
5b7d  3600      ld      (hl),#00
5b7f  23        inc     hl
5b80  3600      ld      (hl),#00
5b82  cd1f1a    call    #1a1f
5b85  7d        ld      a,l
5b86  e680      and     #80
5b88  2817      jr      z,#5ba1         ; (23)
5b8a  210800    ld      hl,#0008
5b8d  39        add     hl,sp
5b8e  5e        ld      e,(hl)
5b8f  23        inc     hl
5b90  56        ld      d,(hl)
5b91  13        inc     de
5b92  72        ld      (hl),d
5b93  2b        dec     hl
5b94  73        ld      (hl),e
5b95  23        inc     hl
5b96  56        ld      d,(hl)
5b97  21dfb1    ld      hl,#b1df
5b9a  19        add     hl,de
5b9b  30e5      jr      nc,#5b82        ; (-27)
5b9d  210000    ld      hl,#0000
5ba0  c9        ret     

5ba1  210e00    ld      hl,#000e
5ba4  e5        push    hl
5ba5  cd281a    call    #1a28
5ba8  d1        pop     de
5ba9  210100    ld      hl,#0001
5bac  e5        push    hl
5bad  cd5c0a    call    #0a5c
5bb0  d1        pop     de
5bb1  210f00    ld      hl,#000f
5bb4  e5        push    hl
5bb5  cd281a    call    #1a28
5bb8  d1        pop     de
5bb9  210100    ld      hl,#0001
5bbc  c9        ret     

5bbd  bf5b
5bbf  PRINTER TESTING\0
5bcf  d15b
5bd1  Maybe have some error!\0

5be8  11f5ff    ld      de,#fff5
5beb  cd6b05    call    #056b
5bee  3e00      ld      a,#00
5bf0  324df6    ld      (#f64d),a
5bf3  cd6424    call    #2464

' DisplayText("PRINTER TESTING", 90, 50, 1)
5bf6  210100    ld      hl,#0001
5bf9  e5        push    hl
5bfa  2e32      ld      l,#32
5bfc  e5        push    hl
5bfd  2e5a      ld      l,#5a
5bff  e5        push    hl
5c00  2abd5b    ld      hl,(#5bbd)
5c03  e5        push    hl
5c04  cd8d4c    call    #4c8d
5c07  210800    ld      hl,#0008
5c0a  39        add     hl,sp
5c0b  f9        ld      sp,hl

5c0c  cd7324    call    #2473

5c0f  212179    ld      hl,#7921
5c12  e5        push    hl
5c13  210100    ld      hl,#0001
5c16  e5        push    hl
5c17  cded05    call    #05ed
5c1a  d1        pop     de
5c1b  d1        pop     de

5c1c  eb        ex      de,hl
5c1d  211000    ld      hl,#0010
5c20  39        add     hl,sp
5c21  73        ld      (hl),e
5c22  7b        ld      a,e
5c23  b7        or      a
5c24  200a      jr      nz,#5c30        ; (10)
5c26  3a4df6    ld      a,(#f64d)
5c29  f602      or      #02
5c2b  324df6    ld      (#f64d),a
5c2e  184c      jr      #5c7c           ; (76)

' DisplayText("Maybe have some error!", 90, 80, 1)
5c30  210100    ld      hl,#0001
5c33  e5        push    hl
5c34  2e50      ld      l,#50
5c36  e5        push    hl
5c37  2e5a      ld      l,#5a
5c39  e5        push    hl
5c3a  2acf5b    ld      hl,(#5bcf)
5c3d  e5        push    hl
5c3e  cd8d4c    call    #4c8d
5c41  210800    ld      hl,#0008
5c44  39        add     hl,sp
5c45  f9        ld      sp,hl

5c46  210a00    ld      hl,#000a
5c49  e5        push    hl
5c4a  39        add     hl,sp
5c4b  e5        push    hl
5c4c  211400    ld      hl,#0014
5c4f  39        add     hl,sp
5c50  5e        ld      e,(hl)
5c51  1600      ld      d,#00
5c53  d5        push    de
5c54  cdb507    call    #07b5
5c57  d1        pop     de
5c58  d1        pop     de
5c59  d1        pop     de

' DisplayText(???, 230, 80, 1)
5c5a  210100    ld      hl,#0001
5c5d  e5        push    hl
5c5e  2e50      ld      l,#50
5c60  e5        push    hl
5c61  2ee6      ld      l,#e6
5c63  e5        push    hl
5c64  210e00    ld      hl,#000e
5c67  39        add     hl,sp
5c68  e5        push    hl
5c69  cd8d4c    call    #4c8d
5c6c  210800    ld      hl,#0008
5c6f  39        add     hl,sp
5c70  f9        ld      sp,hl

5c71  cd7324    call    #2473
5c74  218813    ld      hl,#1388
5c77  e5        push    hl
5c78  cd5c0a    call    #0a5c
5c7b  d1        pop     de

5c7c  3a4df6    ld      a,(#f64d)
5c7f  f601      or      #01
5c81  324df6    ld      (#f64d),a
5c84  211000    ld      hl,#0010
5c87  39        add     hl,sp
5c88  7e        ld      a,(hl)
5c89  b7        or      a
5c8a  2804      jr      z,#5c90         ; (4)
5c8c  2e00      ld      l,#00
5c8e  1802      jr      #5c92           ; (2)
5c90  2e01      ld      l,#01
5c92  2600      ld      h,#00
5c94  c9        ret     

5c95  11faff    ld      de,#fffa
5c98  cd6b05    call    #056b
5c9b  cd6424    call    #2464

' DisplayText("PRINTER TESTING", 90, 50, 1)
5c9e  210100    ld      hl,#0001
5ca1  e5        push    hl
5ca2  2e32      ld      l,#32
5ca4  e5        push    hl
5ca5  2e5a      ld      l,#5a
5ca7  e5        push    hl
5ca8  2abd5b    ld      hl,(#5bbd)
5cab  e5        push    hl
5cac  cd8d4c    call    #4c8d
5caf  210800    ld      hl,#0008
5cb2  39        add     hl,sp
5cb3  f9        ld      sp,hl

5cb4  cd7324    call    #2473
5cb7  210d00    ld      hl,#000d
5cba  e5        push    hl
5cbb  cd505b    call    #5b50
5cbe  d1        pop     de
5cbf  210a00    ld      hl,#000a
5cc2  e5        push    hl
5cc3  cd505b    call    #5b50
5cc6  d1        pop     de
5cc7  210a00    ld      hl,#000a
5cca  39        add     hl,sp
5ccb  3600      ld      (hl),#00
5ccd  23        inc     hl
5cce  3621      ld      (hl),#21
5cd0  1874      jr      #5d46           ; (116)
5cd2  23        inc     hl
5cd3  e5        push    hl
5cd4  21f455    ld      hl,#55f4
5cd7  e5        push    hl
5cd8  210100    ld      hl,#0001
5cdb  e5        push    hl
5cdc  cded05    call    #05ed
5cdf  d1        pop     de
5ce0  d1        pop     de
5ce1  d1        pop     de
5ce2  210c00    ld      hl,#000c
5ce5  39        add     hl,sp
5ce6  5e        ld      e,(hl)
5ce7  23        inc     hl
5ce8  56        ld      d,(hl)
5ce9  21aeff    ld      hl,#ffae
5cec  19        add     hl,de
5ced  7c        ld      a,h
5cee  b5        or      l
5cef  2004      jr      nz,#5cf5        ; (4)
5cf1  21ff00    ld      hl,#00ff
5cf4  c9        ret     

5cf5  210b00    ld      hl,#000b
5cf8  39        add     hl,sp
5cf9  5e        ld      e,(hl)
5cfa  1600      ld      d,#00
5cfc  d5        push    de
5cfd  cd505b    call    #5b50
5d00  d1        pop     de
5d01  eb        ex      de,hl
5d02  210c00    ld      hl,#000c
5d05  39        add     hl,sp
5d06  73        ld      (hl),e
5d07  23        inc     hl
5d08  3600      ld      (hl),#00
5d0a  2b        dec     hl
5d0b  7e        ld      a,(hl)
5d0c  23        inc     hl
5d0d  b6        or      (hl)
5d0e  2004      jr      nz,#5d14        ; (4)
5d10  210000    ld      hl,#0000
5d13  c9        ret     

5d14  2b        dec     hl
5d15  2b        dec     hl
5d16  2b        dec     hl
5d17  e5        push    hl
5d18  6e        ld      l,(hl)
5d19  23        inc     hl
5d1a  eb        ex      de,hl
5d1b  e1        pop     hl
5d1c  73        ld      (hl),e
5d1d  210a00    ld      hl,#000a
5d20  39        add     hl,sp
5d21  7e        ld      a,(hl)
5d22  fe46      cp      #46
5d24  2016      jr      nz,#5d3c        ; (22)
5d26  210d00    ld      hl,#000d
5d29  e5        push    hl
5d2a  cd505b    call    #5b50
5d2d  d1        pop     de
5d2e  210a00    ld      hl,#000a
5d31  e5        push    hl
5d32  cd505b    call    #5b50
5d35  d1        pop     de
5d36  210a00    ld      hl,#000a
5d39  39        add     hl,sp
5d3a  3600      ld      (hl),#00
5d3c  210b00    ld      hl,#000b
5d3f  39        add     hl,sp
5d40  e5        push    hl
5d41  6e        ld      l,(hl)
5d42  23        inc     hl
5d43  eb        ex      de,hl
5d44  e1        pop     hl
5d45  73        ld      (hl),e
5d46  210b00    ld      hl,#000b
5d49  39        add     hl,sp
5d4a  7e        ld      a,(hl)
5d4b  fe7f      cp      #7f
5d4d  3883      jr      c,#5cd2         ; (-125)
5d4f  210d00    ld      hl,#000d
5d52  e5        push    hl
5d53  cd505b    call    #5b50
5d56  d1        pop     de
5d57  210a00    ld      hl,#000a
5d5a  e5        push    hl
5d5b  cd505b    call    #5b50
5d5e  d1        pop     de
5d5f  211200    ld      hl,#0012
5d62  39        add     hl,sp
5d63  7e        ld      a,(hl)
5d64  fe01      cp      #01
5d66  2076      jr      nz,#5dde        ; (118)
5d68  210a00    ld      hl,#000a
5d6b  39        add     hl,sp
5d6c  3600      ld      (hl),#00
5d6e  181a      jr      #5d8a           ; (26)
5d70  210d00    ld      hl,#000d
5d73  e5        push    hl
5d74  cd505b    call    #5b50
5d77  d1        pop     de
5d78  210a00    ld      hl,#000a
5d7b  e5        push    hl
5d7c  cd505b    call    #5b50
5d7f  d1        pop     de
5d80  210a00    ld      hl,#000a
5d83  39        add     hl,sp
5d84  e5        push    hl
5d85  6e        ld      l,(hl)
5d86  23        inc     hl
5d87  eb        ex      de,hl
5d88  e1        pop     hl
5d89  73        ld      (hl),e
5d8a  210a00    ld      hl,#000a
5d8d  39        add     hl,sp
5d8e  7e        ld      a,(hl)
5d8f  fe09      cp      #09
5d91  38dd      jr      c,#5d70         ; (-35)
5d93  3600      ld      (hl),#00
5d95  183e      jr      #5dd5           ; (62)
5d97  210a00    ld      hl,#000a
5d9a  e5        push    hl
5d9b  cd5c0a    call    #0a5c
5d9e  d1        pop     de
5d9f  210800    ld      hl,#0008
5da2  39        add     hl,sp
5da3  e5        push    hl
5da4  21f455    ld      hl,#55f4
5da7  e5        push    hl
5da8  210100    ld      hl,#0001
5dab  e5        push    hl
5dac  cded05    call    #05ed
5daf  d1        pop     de
5db0  d1        pop     de
5db1  d1        pop     de
5db2  210800    ld      hl,#0008
5db5  39        add     hl,sp
5db6  5e        ld      e,(hl)
5db7  23        inc     hl
5db8  56        ld      d,(hl)
5db9  21a9ff    ld      hl,#ffa9
5dbc  19        add     hl,de
5dbd  7c        ld      a,h
5dbe  b5        or      l
5dbf  200a      jr      nz,#5dcb        ; (10)
5dc1  210c00    ld      hl,#000c
5dc4  e5        push    hl
5dc5  cd505b    call    #5b50
5dc8  d1        pop     de
5dc9  1813      jr      #5dde           ; (19)
5dcb  210a00    ld      hl,#000a
5dce  39        add     hl,sp
5dcf  e5        push    hl
5dd0  6e        ld      l,(hl)
5dd1  23        inc     hl
5dd2  eb        ex      de,hl
5dd3  e1        pop     hl
5dd4  73        ld      (hl),e
5dd5  210a00    ld      hl,#000a
5dd8  39        add     hl,sp
5dd9  7e        ld      a,(hl)
5dda  fefb      cp      #fb
5ddc  38b9      jr      c,#5d97         ; (-71)
5dde  210100    ld      hl,#0001
5de1  c9        ret     

5de2  11f3ff    ld      de,#fff3
5de5  cd6b05    call    #056b
5de8  210d00    ld      hl,#000d
5deb  39        add     hl,sp
5dec  3600      ld      (hl),#00
5dee  23        inc     hl
5def  3600      ld      (hl),#00
5df1  2b        dec     hl
5df2  2b        dec     hl
5df3  3600      ld      (hl),#00
5df5  2b        dec     hl
5df6  3600      ld      (hl),#00
5df8  2b        dec     hl
5df9  2b        dec     hl
5dfa  2b        dec     hl
5dfb  3601      ld      (hl),#01
5dfd  210f00    ld      hl,#000f
5e00  39        add     hl,sp
5e01  3600      ld      (hl),#00
5e03  c3b75e    jp      #5eb7
5e06  210900    ld      hl,#0009
5e09  39        add     hl,sp
5e0a  e5        push    hl
5e0b  21f455    ld      hl,#55f4
5e0e  e5        push    hl
5e0f  210100    ld      hl,#0001
5e12  e5        push    hl
5e13  cded05    call    #05ed
5e16  d1        pop     de
5e17  d1        pop     de
5e18  d1        pop     de
5e19  210900    ld      hl,#0009
5e1c  39        add     hl,sp
5e1d  5e        ld      e,(hl)
5e1e  23        inc     hl
5e1f  56        ld      d,(hl)
5e20  21aeff    ld      hl,#ffae
5e23  19        add     hl,de
5e24  7c        ld      a,h
5e25  b5        or      l
5e26  2004      jr      nz,#5e2c        ; (4)
5e28  21ff00    ld      hl,#00ff
5e2b  c9        ret     

5e2c  210f00    ld      hl,#000f
5e2f  39        add     hl,sp
5e30  5e        ld      e,(hl)
5e31  1600      ld      d,#00
5e33  d5        push    de
5e34  cd3127    call    #2731
5e37  d1        pop     de
5e38  eb        ex      de,hl
5e39  210900    ld      hl,#0009
5e3c  39        add     hl,sp
5e3d  73        ld      (hl),e
5e3e  23        inc     hl
5e3f  72        ld      (hl),d
5e40  210f00    ld      hl,#000f
5e43  39        add     hl,sp
5e44  5e        ld      e,(hl)
5e45  1600      ld      d,#00
5e47  d5        push    de
5e48  cd3127    call    #2731
5e4b  d1        pop     de
5e4c  eb        ex      de,hl
5e4d  210b00    ld      hl,#000b
5e50  39        add     hl,sp
5e51  73        ld      (hl),e
5e52  23        inc     hl
5e53  72        ld      (hl),d
5e54  2b        dec     hl
5e55  2b        dec     hl
5e56  56        ld      d,(hl)
5e57  2b        dec     hl
5e58  5e        ld      e,(hl)
5e59  23        inc     hl
5e5a  23        inc     hl
5e5b  7e        ld      a,(hl)
5e5c  23        inc     hl
5e5d  66        ld      h,(hl)
5e5e  6f        ld      l,a
5e5f  a7        and     a
5e60  ed52      sbc     hl,de
5e62  2806      jr      z,#5e6a         ; (6)
5e64  210800    ld      hl,#0008
5e67  39        add     hl,sp
5e68  3600      ld      (hl),#00
5e6a  210d00    ld      hl,#000d
5e6d  39        add     hl,sp
5e6e  5e        ld      e,(hl)
5e6f  23        inc     hl
5e70  56        ld      d,(hl)
5e71  210900    ld      hl,#0009
5e74  39        add     hl,sp
5e75  7e        ld      a,(hl)
5e76  23        inc     hl
5e77  66        ld      h,(hl)
5e78  6f        ld      l,a
5e79  19        add     hl,de
5e7a  eb        ex      de,hl
5e7b  210d00    ld      hl,#000d
5e7e  39        add     hl,sp
5e7f  73        ld      (hl),e
5e80  23        inc     hl
5e81  72        ld      (hl),d
5e82  211900    ld      hl,#0019
5e85  39        add     hl,sp
5e86  7e        ld      a,(hl)
5e87  b7        or      a
5e88  2023      jr      nz,#5ead        ; (35)
5e8a  213f00    ld      hl,#003f
5e8d  e5        push    hl
5e8e  211100    ld      hl,#0011
5e91  39        add     hl,sp
5e92  5e        ld      e,(hl)
5e93  1600      ld      d,#00
5e95  d5        push    de
5e96  213400    ld      hl,#0034
5e99  e5        push    hl
5e9a  2ebe      ld      l,#be
5e9c  e5        push    hl
5e9d  21f854    ld      hl,#54f8
5ea0  e5        push    hl
5ea1  210100    ld      hl,#0001
5ea4  e5        push    hl
5ea5  cded05    call    #05ed
5ea8  210c00    ld      hl,#000c
5eab  39        add     hl,sp
5eac  f9        ld      sp,hl
5ead  210f00    ld      hl,#000f
5eb0  39        add     hl,sp
5eb1  e5        push    hl
5eb2  6e        ld      l,(hl)
5eb3  23        inc     hl
5eb4  eb        ex      de,hl
5eb5  e1        pop     hl
5eb6  73        ld      (hl),e
5eb7  210f00    ld      hl,#000f
5eba  39        add     hl,sp
5ebb  7e        ld      a,(hl)
5ebc  fe40      cp      #40
5ebe  da065e    jp      c,#5e06
5ec1  211400    ld      hl,#0014
5ec4  39        add     hl,sp
5ec5  3600      ld      (hl),#00
5ec7  210f00    ld      hl,#000f
5eca  39        add     hl,sp
5ecb  3604      ld      (hl),#04
5ecd  1862      jr      #5f31           ; (98)
5ecf  2b        dec     hl
5ed0  2b        dec     hl
5ed1  7e        ld      a,(hl)
5ed2  e60f      and     #0f
5ed4  210900    ld      hl,#0009
5ed7  39        add     hl,sp
5ed8  77        ld      (hl),a
5ed9  23        inc     hl
5eda  3600      ld      (hl),#00
5edc  2b        dec     hl
5edd  7e        ld      a,(hl)
5ede  fe0a      cp      #0a
5ee0  381d      jr      c,#5eff         ; (29)
5ee2  5e        ld      e,(hl)
5ee3  23        inc     hl
5ee4  56        ld      d,(hl)
5ee5  21f6ff    ld      hl,#fff6
5ee8  19        add     hl,de
5ee9  eb        ex      de,hl
5eea  210900    ld      hl,#0009
5eed  39        add     hl,sp
5eee  73        ld      (hl),e
5eef  23        inc     hl
5ef0  72        ld      (hl),d
5ef1  2b        dec     hl
5ef2  5e        ld      e,(hl)
5ef3  211100    ld      hl,#0011
5ef6  19        add     hl,de
5ef7  eb        ex      de,hl
5ef8  210900    ld      hl,#0009
5efb  39        add     hl,sp
5efc  73        ld      (hl),e
5efd  23        inc     hl
5efe  72        ld      (hl),d
5eff  210900    ld      hl,#0009
5f02  39        add     hl,sp
5f03  5e        ld      e,(hl)
5f04  23        inc     hl
5f05  56        ld      d,(hl)
5f06  213000    ld      hl,#0030
5f09  19        add     hl,de
5f0a  e5        push    hl
5f0b  211100    ld      hl,#0011
5f0e  39        add     hl,sp
5f0f  5e        ld      e,(hl)
5f10  1600      ld      d,#00
5f12  19        add     hl,de
5f13  d1        pop     de
5f14  73        ld      (hl),e
5f15  210d00    ld      hl,#000d
5f18  39        add     hl,sp
5f19  5e        ld      e,(hl)
5f1a  23        inc     hl
5f1b  56        ld      d,(hl)
5f1c  210400    ld      hl,#0004
5f1f  cd3705    call    #0537
5f22  eb        ex      de,hl
5f23  210d00    ld      hl,#000d
5f26  39        add     hl,sp
5f27  73        ld      (hl),e
5f28  23        inc     hl
5f29  72        ld      (hl),d
5f2a  23        inc     hl
5f2b  e5        push    hl
5f2c  6e        ld      l,(hl)
5f2d  2b        dec     hl
5f2e  eb        ex      de,hl
5f2f  e1        pop     hl
5f30  73        ld      (hl),e
5f31  210f00    ld      hl,#000f
5f34  39        add     hl,sp
5f35  7e        ld      a,(hl)
5f36  b7        or      a
5f37  2096      jr      nz,#5ecf        ; (-106)
5f39  211900    ld      hl,#0019
5f3c  39        add     hl,sp
5f3d  7e        ld      a,(hl)
5f3e  fe06      cp      #06
5f40  2019      jr      nz,#5f5b        ; (25)

' DisplayText(???, 100, 94, 1)
5f42  210100    ld      hl,#0001
5f45  e5        push    hl
5f46  2e5e      ld      l,#5e
5f48  e5        push    hl
5f49  2e64      ld      l,#64
5f4b  e5        push    hl
5f4c  211600    ld      hl,#0016
5f4f  39        add     hl,sp
5f50  e5        push    hl
5f51  cd8d4c    call    #4c8d
5f54  210800    ld      hl,#0008
5f57  39        add     hl,sp
5f58  f9        ld      sp,hl

5f59  1817      jr      #5f72           ; (23)

' DisplayText(???, 190, 80, 0)
5f5b  210000    ld      hl,#0000
5f5e  e5        push    hl
5f5f  2e50      ld      l,#50
5f61  e5        push    hl
5f62  2ebe      ld      l,#be
5f64  e5        push    hl
5f65  211600    ld      hl,#0016
5f68  39        add     hl,sp
5f69  e5        push    hl
5f6a  cd8d4c    call    #4c8d
5f6d  210800    ld      hl,#0008
5f70  39        add     hl,sp

5f71  f9        ld      sp,hl
5f72  cd7324    call    #2473
5f75  218813    ld      hl,#1388
5f78  e5        push    hl
5f79  cd5c0a    call    #0a5c
5f7c  d1        pop     de
5f7d  210800    ld      hl,#0008
5f80  39        add     hl,sp
5f81  5e        ld      e,(hl)
5f82  1600      ld      d,#00
5f84  eb        ex      de,hl
5f85  c9        ret     

5f86  11ffff    ld      de,#ffff
5f89  cd6b05    call    #056b
5f8c  3e00      ld      a,#00
5f8e  324ef6    ld      (#f64e),a

' DisplayText("ROM Testing", 90, 50, 1)
5f91  210100    ld      hl,#0001
5f94  e5        push    hl
5f95  2e32      ld      l,#32
5f97  e5        push    hl
5f98  2e5a      ld      l,#5a
5f9a  e5        push    hl
5f9b  2a9243    ld      hl,(#4392)
5f9e  e5        push    hl
5f9f  cd8d4c    call    #4c8d
5fa2  210800    ld      hl,#0008
5fa5  39        add     hl,sp
5fa6  f9        ld      sp,hl

' DisplayText("Rom Checksum", 100, 80, 0)
5fa7  210000    ld      hl,#0000
5faa  e5        push    hl
5fab  2e50      ld      l,#50
5fad  e5        push    hl
5fae  2e64      ld      l,#64
5fb0  e5        push    hl
5fb1  2aa143    ld      hl,(#43a1)
5fb4  e5        push    hl
5fb5  cd8d4c    call    #4c8d
5fb8  210800    ld      hl,#0008
5fbb  39        add     hl,sp
5fbc  f9        ld      sp,hl

5fbd  210000    ld      hl,#0000
5fc0  e5        push    hl
5fc1  cde25d    call    #5de2
5fc4  d1        pop     de
5fc5  eb        ex      de,hl
5fc6  210800    ld      hl,#0008
5fc9  39        add     hl,sp
5fca  73        ld      (hl),e
5fcb  7b        ld      a,e
5fcc  fe01      cp      #01
5fce  2008      jr      nz,#5fd8        ; (8)
5fd0  3a4ef6    ld      a,(#f64e)
5fd3  f602      or      #02
5fd5  324ef6    ld      (#f64e),a
5fd8  210800    ld      hl,#0008
5fdb  39        add     hl,sp
5fdc  7e        ld      a,(hl)
5fdd  feff      cp      #ff
5fdf  2808      jr      z,#5fe9         ; (8)
5fe1  3a4ef6    ld      a,(#f64e)
5fe4  f601      or      #01
5fe6  324ef6    ld      (#f64e),a
5fe9  210800    ld      hl,#0008
5fec  39        add     hl,sp
5fed  5e        ld      e,(hl)
5fee  1600      ld      d,#00
5ff0  eb        ex      de,hl
5ff1  c9        ret     

5ff2  11f8ff    ld      de,#fff8
5ff5  cd6b05    call    #056b
5ff8  3e00      ld      a,#00
5ffa  324ff6    ld      (#f64f),a
5ffd  211400    ld      hl,#0014
6000  39        add     hl,sp
6001  7e        ld      a,(hl)
6002  fe06      cp      #06
6004  2816      jr      z,#601c         ; (22)

' DisplayText("RAM Testing", 90, 50, 1)
6006  210100    ld      hl,#0001
6009  e5        push    hl
600a  2e32      ld      l,#32
600c  e5        push    hl
600d  2e5a      ld      l,#5a
600f  e5        push    hl
6010  2a8343    ld      hl,(#4383)
6013  e5        push    hl
6014  cd8d4c    call    #4c8d
6017  210800    ld      hl,#0008
601a  39        add     hl,sp
601b  f9        ld      sp,hl

601c  cd7324    call    #2473
601f  210e00    ld      hl,#000e
6022  39        add     hl,sp
6023  36b6      ld      (hl),#b6
6025  23        inc     hl
6026  3600      ld      (hl),#00
6028  2b        dec     hl
6029  2b        dec     hl
602a  3600      ld      (hl),#00
602c  2b        dec     hl
602d  3634      ld      (hl),#34
602f  f3        di      
6030  2b        dec     hl
6031  3600      ld      (hl),#00
6033  2b        dec     hl
6034  3601      ld      (hl),#01
6036  210a00    ld      hl,#000a
6039  39        add     hl,sp
603a  5e        ld      e,(hl)
603b  23        inc     hl
603c  56        ld      d,(hl)
603d  d5        push    de
603e  210077    ld      hl,#7700
6041  e5        push    hl
6042  210100    ld      hl,#0001
6045  e5        push    hl
6046  cded05    call    #05ed
6049  d1        pop     de
604a  d1        pop     de
604b  d1        pop     de
604c  210a00    ld      hl,#000a
604f  39        add     hl,sp
6050  5e        ld      e,(hl)
6051  23        inc     hl
6052  56        ld      d,(hl)
6053  13        inc     de
6054  72        ld      (hl),d
6055  2b        dec     hl
6056  73        ld      (hl),e
6057  23        inc     hl
6058  56        ld      d,(hl)
6059  21f8ff    ld      hl,#fff8
605c  7a        ld      a,d
605d  ac        xor     h
605e  07        rlca    
605f  19        add     hl,de
6060  ce00      adc     a,#00
6062  0f        rrca    
6063  38d1      jr      c,#6036         ; (-47)
6065  210a00    ld      hl,#000a
6068  39        add     hl,sp
6069  3601      ld      (hl),#01
606b  23        inc     hl
606c  3600      ld      (hl),#00
606e  210a00    ld      hl,#000a
6071  39        add     hl,sp
6072  5e        ld      e,(hl)
6073  23        inc     hl
6074  56        ld      d,(hl)
6075  d5        push    de
6076  211d77    ld      hl,#771d
6079  e5        push    hl
607a  210100    ld      hl,#0001
607d  e5        push    hl
607e  cded05    call    #05ed
6081  d1        pop     de
6082  d1        pop     de
6083  d1        pop     de
6084  eb        ex      de,hl
6085  210800    ld      hl,#0008
6088  39        add     hl,sp
6089  73        ld      (hl),e
608a  23        inc     hl
608b  72        ld      (hl),d
608c  2b        dec     hl
608d  5e        ld      e,(hl)
608e  1b        dec     de
608f  7a        ld      a,d
6090  b3        or      e
6091  2817      jr      z,#60aa         ; (23)
6093  23        inc     hl
6094  23        inc     hl
6095  5e        ld      e,(hl)
6096  23        inc     hl
6097  56        ld      d,(hl)
6098  13        inc     de
6099  72        ld      (hl),d
609a  2b        dec     hl
609b  73        ld      (hl),e
609c  23        inc     hl
609d  56        ld      d,(hl)
609e  21f8ff    ld      hl,#fff8
60a1  7a        ld      a,d
60a2  ac        xor     h
60a3  07        rlca    
60a4  19        add     hl,de
60a5  ce00      adc     a,#00
60a7  0f        rrca    
60a8  38c4      jr      c,#606e         ; (-60)
60aa  210800    ld      hl,#0008
60ad  39        add     hl,sp
60ae  7e        ld      a,(hl)
60af  23        inc     hl
60b0  b6        or      (hl)
60b1  2015      jr      nz,#60c8        ; (21)
60b3  214577    ld      hl,#7745
60b6  e5        push    hl
60b7  210100    ld      hl,#0001
60ba  e5        push    hl
60bb  cded05    call    #05ed
60be  d1        pop     de
60bf  d1        pop     de
60c0  eb        ex      de,hl
60c1  210800    ld      hl,#0008
60c4  39        add     hl,sp
60c5  73        ld      (hl),e
60c6  23        inc     hl
60c7  72        ld      (hl),d
60c8  210800    ld      hl,#0008
60cb  39        add     hl,sp
60cc  7e        ld      a,(hl)
60cd  23        inc     hl
60ce  b6        or      (hl)
60cf  2008      jr      nz,#60d9        ; (8)
60d1  3a4ff6    ld      a,(#f64f)
60d4  f602      or      #02
60d6  324ff6    ld      (#f64f),a
60d9  3a4ff6    ld      a,(#f64f)
60dc  f601      or      #01
60de  324ff6    ld      (#f64f),a
60e1  fb        ei      
60e2  210800    ld      hl,#0008
60e5  39        add     hl,sp
60e6  7e        ld      a,(hl)
60e7  23        inc     hl
60e8  b6        or      (hl)
60e9  2804      jr      z,#60ef         ; (4)
60eb  2e00      ld      l,#00
60ed  1802      jr      #60f1           ; (2)
60ef  2e01      ld      l,#01
60f1  2600      ld      h,#00
60f3  c9        ret     

60f4  f660
60f6  Please Wait...\0

6105  cd6424    call    #2464

' DisplayText("Please Wait...", 120, 50, 1)
6108  210100    ld      hl,#0001
610b  e5        push    hl
610c  2e32      ld      l,#32
610e  e5        push    hl
610f  2e78      ld      l,#78
6111  e5        push    hl
6112  2af460    ld      hl,(#60f4)
6115  e5        push    hl
6116  cd8d4c    call    #4c8d
6119  210800    ld      hl,#0008
611c  39        add     hl,sp
611d  f9        ld      sp,hl

611e  cd7324    call    #2473
6121  cd6308    call    #0863
6124  21b80b    ld      hl,#0bb8
6127  e5        push    hl
6128  cd5c0a    call    #0a5c
612b  d1        pop     de
612c  cd6424    call    #2464
612f  c9        ret     

6130  3a321\0

6136  3861
6138  Email TESTING\0

6146  11ebff    ld      de,#ffeb
6149  cd6b05    call    #056b
614c  cd0561    call    #6105

' DisplayText("Email TESTING", 90, 50, 1)
614f  210100    ld      hl,#0001
6152  e5        push    hl
6153  2e32      ld      l,#32
6155  e5        push    hl
6156  2e5a      ld      l,#5a
6158  e5        push    hl
6159  2a3661    ld      hl,(#6136)
615c  e5        push    hl
615d  cd8d4c    call    #4c8d
6160  210800    ld      hl,#0008
6163  39        add     hl,sp
6164  f9        ld      sp,hl

6165  cd7324    call    #2473
6168  2a3061    ld      hl,(#6130)
616b  e5        push    hl
616c  210a00    ld      hl,#000a
616f  39        add     hl,sp
6170  e5        push    hl
6171  cdc605    call    #05c6
6174  d1        pop     de
6175  d1        pop     de
6176  210000    ld      hl,#0000
6179  e5        push    hl
617a  2c        inc     l
617b  e5        push    hl
617c  210c00    ld      hl,#000c
617f  39        add     hl,sp
6180  e5        push    hl
6181  cd6b6f    call    #6f6b
6184  d1        pop     de
6185  d1        pop     de
6186  d1        pop     de
6187  eb        ex      de,hl
6188  211c00    ld      hl,#001c
618b  39        add     hl,sp
618c  73        ld      (hl),e
618d  7b        ld      a,e
618e  fe01      cp      #01
6190  2008      jr      nz,#619a        ; (8)
6192  3a4cf6    ld      a,(#f64c)
6195  f602      or      #02
6197  324cf6    ld      (#f64c),a
619a  3a4cf6    ld      a,(#f64c)
619d  f601      or      #01
619f  324cf6    ld      (#f64c),a
61a2  cd6608    call    #0866
61a5  211c00    ld      hl,#001c
61a8  39        add     hl,sp
61a9  5e        ld      e,(hl)
61aa  1600      ld      d,#00
61ac  eb        ex      de,hl
61ad  c9        ret     

61ae  b061
61b0  Dialling :\0
61bb  bd61
61bd  123456789*0#\0
61ca  cc61
61cc  DTMF TESTING\0
61d9  db61
61db  The Modem Reset Error!\0
61f2  f461
61f4  The Modem Reset OK!\0

6208  11e5ff    ld      de,#ffe5
620b  cd6b05    call    #056b
620e  212700    ld      hl,#0027
6211  39        add     hl,sp
6212  7e        ld      a,(hl)
6213  fe06      cp      #06
6215  ca1863    jp      z,#6318
6218  cd0561    call    #6105
621b  3e00      ld      a,#00
621d  324af6    ld      (#f64a),a
6220  210300    ld      hl,#0003
6223  e5        push    hl
6224  cda233    call    #33a2
6227  d1        pop     de
6228  210e00    ld      hl,#000e
622b  39        add     hl,sp
622c  3600      ld      (hl),#00
622e  187b      jr      #62ab           ; (123)
6230  2b        dec     hl
6231  3600      ld      (hl),#00
6233  2b        dec     hl
6234  3600      ld      (hl),#00
6236  cd7d33    call    #337d
6239  eb        ex      de,hl
623a  210900    ld      hl,#0009
623d  39        add     hl,sp
623e  73        ld      (hl),e
623f  cd5b33    call    #335b
6242  eb        ex      de,hl
6243  210800    ld      hl,#0008
6246  39        add     hl,sp
6247  73        ld      (hl),e
6248  23        inc     hl
6249  7e        ld      a,(hl)
624a  b7        or      a
624b  2804      jr      z,#6251         ; (4)
624d  2e00      ld      l,#00
624f  1802      jr      #6253           ; (2)
6251  2e01      ld      l,#01
6253  7d        ld      a,l
6254  e620      and     #20
6256  2009      jr      nz,#6261        ; (9)
6258  210800    ld      hl,#0008
625b  39        add     hl,sp
625c  7e        ld      a,(hl)
625d  fe03      cp      #03
625f  282d      jr      z,#628e         ; (45)

' DisplayText("The Modem Reset Error!", 100, 95, 0)
6261  210000    ld      hl,#0000
6264  e5        push    hl
6265  2e5f      ld      l,#5f
6267  e5        push    hl
6268  2e64      ld      l,#64
626a  e5        push    hl
626b  2ad961    ld      hl,(#61d9)
626e  e5        push    hl
626f  cd8d4c    call    #4c8d
6272  210800    ld      hl,#0008
6275  39        add     hl,sp
6276  f9        ld      sp,hl

6277  cd7324    call    #2473
627a  218813    ld      hl,#1388
627d  e5        push    hl
627e  cd5c0a    call    #0a5c
6281  d1        pop     de
6282  3a4af6    ld      a,(#f64a)
6285  f601      or      #01
6287  324af6    ld      (#f64a),a
628a  210000    ld      hl,#0000
628d  c9        ret     

628e  210c00    ld      hl,#000c
6291  39        add     hl,sp
6292  5e        ld      e,(hl)
6293  23        inc     hl
6294  56        ld      d,(hl)
6295  13        inc     de
6296  72        ld      (hl),d
6297  2b        dec     hl
6298  73        ld      (hl),e
6299  23        inc     hl
629a  56        ld      d,(hl)
629b  21f0d8    ld      hl,#d8f0
629e  19        add     hl,de
629f  3095      jr      nc,#6236        ; (-107)
62a1  210e00    ld      hl,#000e
62a4  39        add     hl,sp
62a5  e5        push    hl
62a6  6e        ld      l,(hl)
62a7  23        inc     hl
62a8  eb        ex      de,hl
62a9  e1        pop     hl
62aa  73        ld      (hl),e
62ab  210e00    ld      hl,#000e
62ae  39        add     hl,sp
62af  7e        ld      a,(hl)
62b0  fe14      cp      #14
62b2  da3062    jp      c,#6230
62b5  210f00    ld      hl,#000f
62b8  e5        push    hl
62b9  cda233    call    #33a2
62bc  d1        pop     de

' DisplayText("The Modem Reset OK!", 100, 95, 0)
62bd  210000    ld      hl,#0000
62c0  e5        push    hl
62c1  2e5f      ld      l,#5f
62c3  e5        push    hl
62c4  2e64      ld      l,#64
62c6  e5        push    hl
62c7  2af261    ld      hl,(#61f2)
62ca  e5        push    hl
62cb  cd8d4c    call    #4c8d
62ce  210800    ld      hl,#0008
62d1  39        add     hl,sp
62d2  f9        ld      sp,hl

' DisplayText("DTMF TESTING", 110, 45, 1)
62d3  210100    ld      hl,#0001
62d6  e5        push    hl
62d7  2e2d      ld      l,#2d
62d9  e5        push    hl
62da  2e6e      ld      l,#6e
62dc  e5        push    hl
62dd  2aca61    ld      hl,(#61ca)
62e0  e5        push    hl
62e1  cd8d4c    call    #4c8d
62e4  210800    ld      hl,#0008
62e7  39        add     hl,sp
62e8  f9        ld      sp,hl

' DisplayText("Dialling :", 100, 80, 0)
62e9  210000    ld      hl,#0000
62ec  e5        push    hl
62ed  2e50      ld      l,#50
62ef  e5        push    hl
62f0  2e64      ld      l,#64
62f2  e5        push    hl
62f3  2aae61    ld      hl,(#61ae)
62f6  e5        push    hl
62f7  cd8d4c    call    #4c8d
62fa  210800    ld      hl,#0008
62fd  39        add     hl,sp
62fe  f9        ld      sp,hl

' DisplayText("123456789*0#", 140, 80, 0)
62ff  210000    ld      hl,#0000
6302  e5        push    hl
6303  2e50      ld      l,#50
6305  e5        push    hl
6306  2e8c      ld      l,#8c
6308  e5        push    hl
6309  2abb61    ld      hl,(#61bb)
630c  e5        push    hl
630d  cd8d4c    call    #4c8d
6310  210800    ld      hl,#0008
6313  39        add     hl,sp
6314  f9        ld      sp,hl

6315  cd7324    call    #2473
6318  2abb61    ld      hl,(#61bb)
631b  e5        push    hl
631c  211100    ld      hl,#0011
631f  39        add     hl,sp
6320  e5        push    hl
6321  cdc605    call    #05c6
6324  d1        pop     de
6325  d1        pop     de
6326  212700    ld      hl,#0027
6329  39        add     hl,sp
632a  7e        ld      a,(hl)
632b  fe02      cp      #02
632d  2010      jr      nz,#633f        ; (16)
632f  210000    ld      hl,#0000
6332  e5        push    hl
6333  211100    ld      hl,#0011
6336  39        add     hl,sp
6337  e5        push    hl
6338  cd2957    call    #5729
633b  d1        pop     de
633c  d1        pop     de
633d  180e      jr      #634d           ; (14)
633f  210100    ld      hl,#0001
6342  e5        push    hl
6343  211100    ld      hl,#0011
6346  39        add     hl,sp
6347  e5        push    hl
6348  cd2957    call    #5729
634b  d1        pop     de
634c  d1        pop     de
634d  212700    ld      hl,#0027
6350  39        add     hl,sp
6351  7e        ld      a,(hl)
6352  fe06      cp      #06
6354  200c      jr      nz,#6362        ; (12)
6356  21d007    ld      hl,#07d0
6359  e5        push    hl
635a  cd5c0a    call    #0a5c
635d  d1        pop     de
635e  21ff00    ld      hl,#00ff
6361  c9        ret     

6362  210c00    ld      hl,#000c
6365  39        add     hl,sp
6366  3600      ld      (hl),#00
6368  23        inc     hl
6369  3600      ld      (hl),#00
636b  1834      jr      #63a1           ; (52)
636d  210a00    ld      hl,#000a
6370  39        add     hl,sp
6371  e5        push    hl
6372  21f455    ld      hl,#55f4
6375  e5        push    hl
6376  210100    ld      hl,#0001
6379  e5        push    hl
637a  cded05    call    #05ed
637d  d1        pop     de
637e  d1        pop     de
637f  d1        pop     de
6380  210a00    ld      hl,#000a
6383  39        add     hl,sp
6384  5e        ld      e,(hl)
6385  23        inc     hl
6386  56        ld      d,(hl)
6387  21aeff    ld      hl,#ffae
638a  19        add     hl,de
638b  7c        ld      a,h
638c  b5        or      l
638d  2007      jr      nz,#6396        ; (7)
638f  cd6608    call    #0866
6392  21ff00    ld      hl,#00ff
6395  c9        ret     

6396  210c00    ld      hl,#000c
6399  39        add     hl,sp
639a  5e        ld      e,(hl)
639b  23        inc     hl
639c  56        ld      d,(hl)
639d  13        inc     de
639e  72        ld      (hl),d
639f  2b        dec     hl
63a0  73        ld      (hl),e
63a1  210c00    ld      hl,#000c
63a4  39        add     hl,sp
63a5  5e        ld      e,(hl)
63a6  23        inc     hl
63a7  56        ld      d,(hl)
63a8  eb        ex      de,hl
63a9  cdde04    call    #04de
63ac  cd1102    call    #0211
63af  60        ld      h,b
63b0  ea0000    jp      pe,#0000
63b3  cd9604    call    #0496
63b6  20b5      jr      nz,#636d        ; (-75)
63b8  cd6608    call    #0866
63bb  210100    ld      hl,#0001
63be  c9        ret     

63bf  00        nop     
63c0  00        nop     
63c1  00        nop     
63c2  00        nop     
63c3  48        ld      c,b
63c4  1b        dec     de
63c5  00        nop     
63c6  00        nop     

63c7  11feff    ld      de,#fffe
63ca  cd6b05    call    #056b
63cd  210e00    ld      hl,#000e
63d0  39        add     hl,sp
63d1  5e        ld      e,(hl)
63d2  1600      ld      d,#00
63d4  eb        ex      de,hl
63d5  29        add     hl,hl
63d6  29        add     hl,hl
63d7  11bf63    ld      de,#63bf
63da  19        add     hl,de
63db  cd2402    call    #0224
63de  cd3c02    call    #023c
63e1  211200    ld      hl,#0012
63e4  39        add     hl,sp
63e5  5e        ld      e,(hl)
63e6  1600      ld      d,#00
63e8  d5        push    de
63e9  210100    ld      hl,#0001
63ec  e5        push    hl
63ed  21b25f    ld      hl,#5fb2
63f0  e5        push    hl
63f1  212e00    ld      hl,#002e
63f4  e5        push    hl
63f5  cded05    call    #05ed
63f8  210c00    ld      hl,#000c
63fb  39        add     hl,sp
63fc  f9        ld      sp,hl
63fd  210800    ld      hl,#0008
6400  39        add     hl,sp
6401  e5        push    hl
6402  21f455    ld      hl,#55f4
6405  e5        push    hl
6406  210100    ld      hl,#0001
6409  e5        push    hl
640a  cded05    call    #05ed
640d  d1        pop     de
640e  d1        pop     de
640f  d1        pop     de
6410  28eb      jr      z,#63fd         ; (-21)
6412  210000    ld      hl,#0000
6415  e5        push    hl
6416  210a00    ld      hl,#000a
6419  39        add     hl,sp
641a  5e        ld      e,(hl)
641b  23        inc     hl
641c  56        ld      d,(hl)
641d  d5        push    de
641e  210800    ld      hl,#0008
6421  e5        push    hl
6422  21b25f    ld      hl,#5fb2
6425  e5        push    hl
6426  212e00    ld      hl,#002e
6429  e5        push    hl
642a  cded05    call    #05ed
642d  210a00    ld      hl,#000a
6430  39        add     hl,sp
6431  f9        ld      sp,hl
6432  20c9      jr      nz,#63fd        ; (-55)
6434  c9        ret     

6435  3764
6437  Don't press any key!\0
644c  4e64
644e  Please put down equipment.\0
6469  6b64
646b  Skip: [S]\0
6475  7764
6477  Please plug in\0
6486  8864
6488  Press [enter].\0

6497  a164
6499  a964
649b  af64
649d  be64
649f  c464
64a1  1.Flash\0
64a9  2.Key\0
64af  3.Printer Port\0
64be  4.RAM\0
64c4  5.ROM\0

64ca  d064
64cc  d664
64ce  db64
64d0  FALSE\0
64d6  PASS\0
64db  SKIP\0

64e0  e264
64e2  Error!\0

64e9  11faff    ld      de,#fffa
64ec  cd6b05    call    #056b
64ef  cd9d0a    call    #0a9d
64f2  210a00    ld      hl,#000a
64f5  39        add     hl,sp
64f6  3600      ld      (hl),#00
64f8  2b        dec     hl
64f9  361e      ld      (hl),#1e

' DisplayText("1.Flash" or "2.Key" etc..., , , 1)
64fb  210100    ld      hl,#0001
64fe  e5        push    hl
64ff  210b00    ld      hl,#000b
6502  39        add     hl,sp
6503  5e        ld      e,(hl)
6504  1600      ld      d,#00
6506  d5        push    de
6507  210f00    ld      hl,#000f
650a  e5        push    hl
650b  211000    ld      hl,#0010
650e  39        add     hl,sp
650f  5e        ld      e,(hl)
6510  eb        ex      de,hl
6511  29        add     hl,hl
6512  119764    ld      de,#6497
6515  19        add     hl,de
6516  5e        ld      e,(hl)
6517  23        inc     hl
6518  56        ld      d,(hl)
6519  d5        push    de
651a  cd8d4c    call    #4c8d
651d  210800    ld      hl,#0008
6520  39        add     hl,sp
6521  f9        ld      sp,hl

6522  cd7324    call    #2473
6525  217600    ld      hl,#0076
6528  e5        push    hl
6529  212c01    ld      hl,#012c
652c  e5        push    hl
652d  211e00    ld      hl,#001e
6530  e5        push    hl
6531  2e8c      ld      l,#8c
6533  e5        push    hl
6534  21be77    ld      hl,#77be
6537  e5        push    hl
6538  210100    ld      hl,#0001
653b  e5        push    hl
653c  cded05    call    #05ed
653f  210c00    ld      hl,#000c
6542  39        add     hl,sp
6543  f9        ld      sp,hl
6544  210a00    ld      hl,#000a
6547  39        add     hl,sp
6548  7e        ld      a,(hl)
6549  eb        ex      de,hl
654a  b7        or      a
654b  2812      jr      z,#655f         ; (18)
654d  3d        dec     a
654e  282b      jr      z,#657b         ; (43)
6550  3d        dec     a
6551  cad565    jp      z,#65d5
6554  3d        dec     a
6555  cadd65    jp      z,#65dd
6558  3d        dec     a
6559  caed65    jp      z,#65ed
655c  c3fb65    jp      #65fb

' Led(On)
655f  210100    ld      hl,#0001
6562  e5        push    hl
6563  cd770a    call    #0a77
6566  d1        pop     de

6567  cdff4a    call    #4aff
656a  eb        ex      de,hl
656b  210d00    ld      hl,#000d
656e  39        add     hl,sp
656f  73        ld      (hl),e

' Led(Off)
6570  210000    ld      hl,#0000
6573  e5        push    hl
6574  cd770a    call    #0a77
6577  d1        pop     de

6578  c3fb65    jp      #65fb

' DisplayText("Don't press any key!", 150, 40, 1)
657b  210100    ld      hl,#0001
657e  e5        push    hl
657f  2e28      ld      l,#28
6581  e5        push    hl
6582  2e96      ld      l,#96
6584  e5        push    hl
6585  2a3564    ld      hl,(#6435)
6588  e5        push    hl
6589  cd8d4c    call    #4c8d
658c  210800    ld      hl,#0008
658f  39        add     hl,sp
6590  f9        ld      sp,hl

' DisplayText("Please put down equipment.", 150, 60, 1)
6591  210100    ld      hl,#0001
6594  e5        push    hl
6595  2e3c      ld      l,#3c
6597  e5        push    hl
6598  2e96      ld      l,#96
659a  e5        push    hl
659b  2a4c64    ld      hl,(#644c)
659e  e5        push    hl
659f  cd8d4c    call    #4c8d
65a2  210800    ld      hl,#0008
65a5  39        add     hl,sp
65a6  f9        ld      sp,hl

' DisplayText("Skip: [S]", 150, 80, 1)
65a7  210100    ld      hl,#0001
65aa  e5        push    hl
65ab  2e50      ld      l,#50
65ad  e5        push    hl
65ae  2e96      ld      l,#96
65b0  e5        push    hl
65b1  2a6964    ld      hl,(#6469)
65b4  e5        push    hl
65b5  cd8d4c    call    #4c8d
65b8  210800    ld      hl,#0008
65bb  39        add     hl,sp
65bc  f9        ld      sp,hl

65bd  cd7324    call    #2473
65c0  216878    ld      hl,#7868
65c3  e5        push    hl
65c4  210100    ld      hl,#0001
65c7  e5        push    hl
65c8  cded05    call    #05ed
65cb  d1        pop     de
65cc  d1        pop     de
65cd  eb        ex      de,hl
65ce  210d00    ld      hl,#000d
65d1  39        add     hl,sp
65d2  73        ld      (hl),e
65d3  1826      jr      #65fb           ; (38)
65d5  eb        ex      de,hl
65d6  23        inc     hl
65d7  23        inc     hl
65d8  23        inc     hl
65d9  3602      ld      (hl),#02
65db  181e      jr      #65fb           ; (30)
65dd  210600    ld      hl,#0006
65e0  e5        push    hl
65e1  cdf25f    call    #5ff2
65e4  d1        pop     de
65e5  eb        ex      de,hl
65e6  210d00    ld      hl,#000d
65e9  39        add     hl,sp
65ea  73        ld      (hl),e
65eb  180e      jr      #65fb           ; (14)
65ed  210600    ld      hl,#0006
65f0  e5        push    hl
65f1  cde25d    call    #5de2
65f4  d1        pop     de
65f5  eb        ex      de,hl
65f6  210d00    ld      hl,#000d
65f9  39        add     hl,sp
65fa  73        ld      (hl),e
65fb  210a00    ld      hl,#000a
65fe  39        add     hl,sp
65ff  e5        push    hl
6600  6e        ld      l,(hl)
6601  23        inc     hl
6602  eb        ex      de,hl
6603  e1        pop     hl
6604  73        ld      (hl),e
6605  210a00    ld      hl,#000a
6608  39        add     hl,sp
6609  7e        ld      a,(hl)
660a  fe05      cp      #05
660c  3844      jr      c,#6652         ; (68)
660e  210100    ld      hl,#0001
6611  e5        push    hl
6612  21c171    ld      hl,#71c1
6615  e5        push    hl
6616  210100    ld      hl,#0001
6619  e5        push    hl
661a  cded05    call    #05ed
661d  d1        pop     de
661e  d1        pop     de
661f  d1        pop     de
6620  eb        ex      de,hl
6621  210d00    ld      hl,#000d
6624  39        add     hl,sp
6625  73        ld      (hl),e

' DisplayText("FALSE" or "PASS", or "SKIP", 140, 100, 1)
6626  210100    ld      hl,#0001
6629  e5        push    hl
662a  2e64      ld      l,#64
662c  e5        push    hl
662d  2e8c      ld      l,#8c
662f  e5        push    hl
6630  211300    ld      hl,#0013
6633  39        add     hl,sp
6634  5e        ld      e,(hl)
6635  1600      ld      d,#00
6637  eb        ex      de,hl
6638  29        add     hl,hl
6639  11ca64    ld      de,#64ca
663c  19        add     hl,de
663d  5e        ld      e,(hl)
663e  23        inc     hl
663f  56        ld      d,(hl)
6640  d5        push    de
6641  cd8d4c    call    #4c8d
6644  210800    ld      hl,#0008
6647  39        add     hl,sp
6648  f9        ld      sp,hl

6649  210d00    ld      hl,#000d
664c  39        add     hl,sp
664d  7e        ld      a,(hl)
664e  b7        or      a
664f  2869      jr      z,#66ba         ; (105)
6651  c9        ret     

6652  217500    ld      hl,#0075
6655  e5        push    hl
6656  212b01    ld      hl,#012b
6659  e5        push    hl
665a  211f00    ld      hl,#001f
665d  e5        push    hl
665e  2e8d      ld      l,#8d
6660  e5        push    hl
6661  cd8a20    call    #208a
6664  210800    ld      hl,#0008
6667  39        add     hl,sp
6668  f9        ld      sp,hl

' DisplayText("FALSE" or "PASS" or "SKIP", 100, ?, 1)
6669  210100    ld      hl,#0001
666c  e5        push    hl
666d  210b00    ld      hl,#000b
6670  39        add     hl,sp
6671  5e        ld      e,(hl)
6672  1600      ld      d,#00
6674  d5        push    de
6675  216400    ld      hl,#0064
6678  e5        push    hl
6679  211300    ld      hl,#0013
667c  39        add     hl,sp
667d  5e        ld      e,(hl)
667e  eb        ex      de,hl
667f  29        add     hl,hl
6680  11ca64    ld      de,#64ca
6683  19        add     hl,de
6684  5e        ld      e,(hl)
6685  23        inc     hl
6686  56        ld      d,(hl)
6687  d5        push    de
6688  cd8d4c    call    #4c8d
668b  210800    ld      hl,#0008
668e  39        add     hl,sp
668f  f9        ld      sp,hl

6690  cd7324    call    #2473
6693  210900    ld      hl,#0009
6696  39        add     hl,sp
6697  7e        ld      a,(hl)
6698  c610      add     a,#10
669a  77        ld      (hl),a
669b  210d00    ld      hl,#000d
669e  39        add     hl,sp
669f  7e        ld      a,(hl)
66a0  b7        or      a
66a1  c2fb64    jp      nz,#64fb

' DisplayText("Error!", 180, 60, 1)
66a4  210100    ld      hl,#0001
66a7  e5        push    hl
66a8  2e3c      ld      l,#3c
66aa  e5        push    hl
66ab  2eb4      ld      l,#b4
66ad  e5        push    hl
66ae  2ae064    ld      hl,(#64e0)
66b1  e5        push    hl
66b2  cd8d4c    call    #4c8d
66b5  210800    ld      hl,#0008
66b8  39        add     hl,sp
66b9  f9        ld      sp,hl

66ba  cd7324    call    #2473
66bd  210b00    ld      hl,#000b
66c0  39        add     hl,sp
66c1  e5        push    hl
66c2  21f455    ld      hl,#55f4
66c5  e5        push    hl
66c6  210100    ld      hl,#0001
66c9  e5        push    hl
66ca  cded05    call    #05ed
66cd  d1        pop     de
66ce  d1        pop     de
66cf  d1        pop     de
66d0  210b00    ld      hl,#000b
66d3  39        add     hl,sp
66d4  5e        ld      e,(hl)
66d5  23        inc     hl
66d6  56        ld      d,(hl)
66d7  1b        dec     de
66d8  7a        ld      a,d
66d9  b3        or      e
66da  c8        ret     z

66db  56        ld      d,(hl)
66dc  2b        dec     hl
66dd  5e        ld      e,(hl)
66de  21a9ff    ld      hl,#ffa9
66e1  19        add     hl,de
66e2  7c        ld      a,h
66e3  b5        or      l
66e4  c8        ret     z

66e5  18d6      jr      #66bd           ; (-42)

66e7  00        nop     
66e8  00        nop     
66e9  00        nop     
66ea  00        nop     
66eb  00        nop     
66ec  00        nop     
66ed  00        nop     
66ee  00        nop     
66ef  00        nop     
66f0  00        nop     
66f1  00        nop     
66f2  40        ld      b,b
66f3  00        nop     
66f4  00        nop     
66f5  00        nop     
66f6  00        nop     
66f7  60        ld      h,b
66f8  313233    ld      sp,#3332
66fb  34        inc     (hl)
66fc  35        dec     (hl)
66fd  3637      ld      (hl),#37
66ff  3839      jr      c,#673a         ; (57)
6701  302d      jr      nc,#6730        ; (45)
6703  3d        dec     a
6704  00        nop     
6705  5c        ld      e,h
6706  00        nop     
6707  00        nop     
6708  51        ld      d,c
6709  57        ld      d,a
670a  45        ld      b,l
670b  52        ld      d,d
670c  54        ld      d,h
670d  59        ld      e,c
670e  55        ld      d,l
670f  49        ld      c,c
6710  4f        ld      c,a
6711  50        ld      d,b
6712  5b        ld      e,e
6713  5d        ld      e,l
6714  3b        dec     sp
6715  27        daa     
6716  00        nop     
6717  00        nop     
6718  41        ld      b,c
6719  53        ld      d,e
671a  44        ld      b,h
671b  46        ld      b,(hl)
671c  47        ld      b,a
671d  48        ld      c,b
671e  4a        ld      c,d
671f  4b        ld      c,e
6720  4c        ld      c,h
6721  2c        inc     l
6722  2e2f      ld      l,#2f
6724  00        nop     
6725  00        nop     
6726  00        nop     
6727  00        nop     
6728  5a        ld      e,d
6729  58        ld      e,b
672a  43        ld      b,e
672b  56        ld      d,(hl)
672c  42        ld      b,d
672d  4e        ld      c,(hl)
672e  4d        ld      c,l
672f  00        nop     
6730  00        nop     
6731  00        nop     
6732  2000      jr      nz,#6734        ; (0)
6734  00        nop     
6735  00        nop     
6736  00        nop     
6737  00        nop     
6738  00        nop     
6739  00        nop     
673a  00        nop     
673b  00        nop     
673c  00        nop     
673d  00        nop     
673e  00        nop     
673f  00        nop     
6740  00        nop     
6741  00        nop     
6742  40        ld      b,b
6743  00        nop     
6744  00        nop     
6745  00        nop     
6746  00        nop     
6747  7e        ld      a,(hl)
6748  214023    ld      hl,#2340
674b  24        inc     h
674c  25        dec     h
674d  5e        ld      e,(hl)
674e  262a      ld      h,#2a
6750  2829      jr      z,#677b         ; (41)
6752  5f        ld      e,a
6753  2b        dec     hl
6754  00        nop     
6755  7c        ld      a,h
6756  00        nop     
6757  00        nop     
6758  71        ld      (hl),c
6759  77        ld      (hl),a
675a  65        ld      h,l
675b  72        ld      (hl),d
675c  74        ld      (hl),h
675d  79        ld      a,c
675e  75        ld      (hl),l
675f  69        ld      l,c
6760  6f        ld      l,a
6761  70        ld      (hl),b
6762  7b        ld      a,e
6763  7d        ld      a,l
6764  3a2200    ld      a,(#0022)
6767  00        nop     
6768  61        ld      h,c
6769  73        ld      (hl),e
676a  64        ld      h,h
676b  66        ld      h,(hl)
676c  67        ld      h,a
676d  68        ld      l,b
676e  6a        ld      l,d
676f  6b        ld      l,e
6770  6c        ld      l,h
6771  3c        inc     a
6772  3e3f      ld      a,#3f
6774  00        nop     
6775  00        nop     
6776  00        nop     
6777  00        nop     
6778  7a        ld      a,d
6779  78        ld      a,b
677a  63        ld      h,e
677b  76        halt    
677c  62        ld      h,d
677d  6e        ld      l,(hl)
677e  6d        ld      l,l
677f  00        nop     
6780  00        nop     
6781  00        nop     
6782  2000      jr      nz,#6784        ; (0)
6784  00        nop     
6785  00        nop     
6786  00        nop

6787  8967
6789  Modem  Reset  .....\0

679d  a967
679f  af67
67a1  b567
67a3  ba67
67a5  bf67
67a7  c467
67a9  38400\0
67af  19200\0
67b5  9600\0
67ba  7200\0
67bf  4800\0
67c4  2400\0

67c9  114cff    ld      de,#ff4c
67cc  cd6b05    call    #056b
67cf  21c200    ld      hl,#00c2
67d2  39        add     hl,sp
67d3  5e        ld      e,(hl)
67d4  23        inc     hl
67d5  56        ld      d,(hl)
67d6  d5        push    de
67d7  210a00    ld      hl,#000a
67da  39        add     hl,sp
67db  e5        push    hl
67dc  cdc605    call    #05c6
67df  d1        pop     de
67e0  d1        pop     de
67e1  21c400    ld      hl,#00c4
67e4  39        add     hl,sp
67e5  5e        ld      e,(hl)
67e6  1600      ld      d,#00
67e8  d5        push    de
67e9  210a00    ld      hl,#000a
67ec  39        add     hl,sp
67ed  e5        push    hl
67ee  21c400    ld      hl,#00c4
67f1  39        add     hl,sp
67f2  5e        ld      e,(hl)
67f3  23        inc     hl
67f4  56        ld      d,(hl)
67f5  d5        push    de
67f6  cd7a1e    call    #1e7a
67f9  d1        pop     de
67fa  d1        pop     de
67fb  d1        pop     de
67fc  c9        ret     

67fd  112cff    ld      de,#ff2c
6800  cd6b05    call    #056b
6803  21b300    ld      hl,#00b3
6806  39        add     hl,sp
6807  3600      ld      (hl),#00
6809  2b        dec     hl
680a  3601      ld      (hl),#01
680c  21ae00    ld      hl,#00ae
680f  39        add     hl,sp
6810  3601      ld      (hl),#01
6812  cd850a    call    #0a85
6815  215e00    ld      hl,#005e
6818  39        add     hl,sp
6819  3600      ld      (hl),#00
681b  2b        dec     hl
681c  3600      ld      (hl),#00
681e  21bd00    ld      hl,#00bd
6821  39        add     hl,sp
6822  3631      ld      (hl),#31
6824  23        inc     hl
6825  3632      ld      (hl),#32
6827  23        inc     hl
6828  3600      ld      (hl),#00
682a  210900    ld      hl,#0009
682d  39        add     hl,sp
682e  3600      ld      (hl),#00
6830  23        inc     hl
6831  3600      ld      (hl),#00
6833  210000    ld      hl,#0000
6836  e5        push    hl
6837  21b800    ld      hl,#00b8
683a  39        add     hl,sp
683b  e5        push    hl
683c  21c100    ld      hl,#00c1
683f  39        add     hl,sp
6840  e5        push    hl
6841  210000    ld      hl,#0000
6844  e5        push    hl
6845  cde06d    call    #6de0
6848  210800    ld      hl,#0008
684b  39        add     hl,sp
684c  f9        ld      sp,hl
684d  21d600    ld      hl,#00d6
6850  39        add     hl,sp
6851  3640      ld      (hl),#40
6853  23        inc     hl
6854  3601      ld      (hl),#01
6856  23        inc     hl
6857  3680      ld      (hl),#80
6859  23        inc     hl
685a  3600      ld      (hl),#00
685c  23        inc     hl
685d  3600      ld      (hl),#00
685f  cdea35    call    #35ea
6862  cdf435    call    #35f4
6865  c22c69    jp      nz,#692c
6868  21b100    ld      hl,#00b1
686b  39        add     hl,sp
686c  e5        push    hl
686d  cdce35    call    #35ce
6870  d1        pop     de
6871  21b100    ld      hl,#00b1
6874  39        add     hl,sp
6875  7e        ld      a,(hl)
6876  fe20      cp      #20
6878  3804      jr      c,#687e         ; (4)
687a  fe80      cp      #80
687c  3806      jr      c,#6884         ; (6)
687e  21b100    ld      hl,#00b1
6881  39        add     hl,sp
6882  362e      ld      (hl),#2e
6884  210900    ld      hl,#0009
6887  39        add     hl,sp
6888  1600      ld      d,#00
688a  7e        ld      a,(hl)
688b  fe29      cp      #29
688d  3849      jr      c,#68d8         ; (73)
688f  216400    ld      hl,#0064
6892  e5        push    hl
6893  214001    ld      hl,#0140
6896  e5        push    hl
6897  215000    ld      hl,#0050
689a  e5        push    hl
689b  6c        ld      l,h
689c  e5        push    hl
689d  cd8a20    call    #208a
68a0  210800    ld      hl,#0008
68a3  39        add     hl,sp
68a4  f9        ld      sp,hl
68a5  21d200    ld      hl,#00d2
68a8  39        add     hl,sp
68a9  3600      ld      (hl),#00
68ab  23        inc     hl
68ac  3600      ld      (hl),#00
68ae  23        inc     hl
68af  3650      ld      (hl),#50
68b1  23        inc     hl
68b2  3600      ld      (hl),#00
68b4  210a00    ld      hl,#000a
68b7  39        add     hl,sp
68b8  e5        push    hl
68b9  cdcc05    call    #05cc
68bc  d1        pop     de
68bd  2600      ld      h,#00
68bf  e5        push    hl
68c0  210c00    ld      hl,#000c
68c3  39        add     hl,sp
68c4  e5        push    hl
68c5  21d600    ld      hl,#00d6
68c8  39        add     hl,sp
68c9  e5        push    hl
68ca  cdc967    call    #67c9
68cd  d1        pop     de
68ce  d1        pop     de
68cf  d1        pop     de
68d0  110000    ld      de,#0000
68d3  210900    ld      hl,#0009
68d6  39        add     hl,sp
68d7  73        ld      (hl),e
68d8  21b100    ld      hl,#00b1
68db  39        add     hl,sp
68dc  5e        ld      e,(hl)
68dd  d5        push    de
68de  210b00    ld      hl,#000b
68e1  39        add     hl,sp
68e2  5e        ld      e,(hl)
68e3  23        inc     hl
68e4  19        add     hl,de
68e5  d1        pop     de
68e6  73        ld      (hl),e
68e7  210900    ld      hl,#0009
68ea  39        add     hl,sp
68eb  e5        push    hl
68ec  6e        ld      l,(hl)
68ed  23        inc     hl
68ee  eb        ex      de,hl
68ef  e1        pop     hl
68f0  73        ld      (hl),e
68f1  210900    ld      hl,#0009
68f4  39        add     hl,sp
68f5  5e        ld      e,(hl)
68f6  1600      ld      d,#00
68f8  23        inc     hl
68f9  19        add     hl,de
68fa  72        ld      (hl),d
68fb  21d200    ld      hl,#00d2
68fe  39        add     hl,sp
68ff  3600      ld      (hl),#00
6901  23        inc     hl
6902  3600      ld      (hl),#00
6904  23        inc     hl
6905  365a      ld      (hl),#5a
6907  23        inc     hl
6908  3600      ld      (hl),#00
690a  210a00    ld      hl,#000a
690d  39        add     hl,sp
690e  e5        push    hl
690f  cdcc05    call    #05cc
6912  d1        pop     de
6913  2600      ld      h,#00
6915  e5        push    hl
6916  210c00    ld      hl,#000c
6919  39        add     hl,sp
691a  e5        push    hl
691b  21d600    ld      hl,#00d6
691e  39        add     hl,sp
691f  e5        push    hl
6920  cdc967    call    #67c9
6923  d1        pop     de
6924  d1        pop     de
6925  d1        pop     de
6926  cd7324    call    #2473
6929  c36268    jp      #6862
692c  21b200    ld      hl,#00b2
692f  39        add     hl,sp
6930  7e        ld      a,(hl)
6931  b7        or      a
6932  cafa69    jp      z,#69fa
6935  3d        dec     a
6936  2807      jr      z,#693f         ; (7)
6938  d604      sub     #04
693a  285a      jr      z,#6996         ; (90)
693c  c3f469    jp      #69f4
693f  21d200    ld      hl,#00d2
6942  39        add     hl,sp
6943  3650      ld      (hl),#50
6945  23        inc     hl
6946  3600      ld      (hl),#00
6948  23        inc     hl
6949  3632      ld      (hl),#32
694b  23        inc     hl
694c  3600      ld      (hl),#00
694e  210100    ld      hl,#0001
6951  e5        push    hl
6952  cd0d6d    call    #6d0d
6955  d1        pop     de
6956  cdc26e    call    #6ec2
6959  2a8767    ld      hl,(#6787)
695c  e5        push    hl
695d  cdcc05    call    #05cc
6960  d1        pop     de
6961  2600      ld      h,#00
6963  e5        push    hl
6964  2a8767    ld      hl,(#6787)
6967  e5        push    hl
6968  21d600    ld      hl,#00d6
696b  39        add     hl,sp
696c  e5        push    hl
696d  cdc967    call    #67c9
6970  d1        pop     de
6971  d1        pop     de
6972  d1        pop     de
6973  cd7324    call    #2473
6976  cd6308    call    #0863
6979  cdc26e    call    #6ec2
697c  21b300    ld      hl,#00b3
697f  39        add     hl,sp
6980  5e        ld      e,(hl)
6981  1600      ld      d,#00
6983  d5        push    de
6984  cd0d6d    call    #6d0d
6987  d1        pop     de
6988  215d00    ld      hl,#005d
698b  39        add     hl,sp
698c  3600      ld      (hl),#00
698e  210900    ld      hl,#0009
6991  39        add     hl,sp
6992  3600      ld      (hl),#00
6994  185e      jr      #69f4           ; (94)
6996  210500    ld      hl,#0005
6999  e5        push    hl
699a  cd0d6d    call    #6d0d
699d  d1        pop     de
699e  cdc26e    call    #6ec2
69a1  213200    ld      hl,#0032
69a4  e5        push    hl
69a5  2e50      ld      l,#50
69a7  e5        push    hl
69a8  cd1c78    call    #781c
69ab  d1        pop     de
69ac  d1        pop     de
69ad  eb        ex      de,hl
69ae  21b400    ld      hl,#00b4
69b1  39        add     hl,sp
69b2  73        ld      (hl),e
69b3  23        inc     hl
69b4  72        ld      (hl),d
69b5  2b        dec     hl
69b6  5e        ld      e,(hl)
69b7  eb        ex      de,hl
69b8  7e        ld      a,(hl)
69b9  b7        or      a
69ba  280e      jr      z,#69ca         ; (14)
69bc  eb        ex      de,hl
69bd  23        inc     hl
69be  56        ld      d,(hl)
69bf  d5        push    de
69c0  21bf00    ld      hl,#00bf
69c3  39        add     hl,sp
69c4  e5        push    hl
69c5  cdc605    call    #05c6
69c8  d1        pop     de
69c9  d1        pop     de
69ca  210000    ld      hl,#0000
69cd  e5        push    hl
69ce  21b800    ld      hl,#00b8
69d1  39        add     hl,sp
69d2  e5        push    hl
69d3  21c100    ld      hl,#00c1
69d6  39        add     hl,sp
69d7  e5        push    hl
69d8  21b900    ld      hl,#00b9
69db  39        add     hl,sp
69dc  5e        ld      e,(hl)
69dd  1600      ld      d,#00
69df  d5        push    de
69e0  cde06d    call    #6de0
69e3  210800    ld      hl,#0008
69e6  39        add     hl,sp
69e7  f9        ld      sp,hl
69e8  215d00    ld      hl,#005d
69eb  39        add     hl,sp
69ec  3600      ld      (hl),#00
69ee  210900    ld      hl,#0009
69f1  39        add     hl,sp
69f2  3600      ld      (hl),#00
69f4  21b200    ld      hl,#00b2
69f7  39        add     hl,sp
69f8  3600      ld      (hl),#00
69fa  cd0d7a    call    #7a0d
69fd  eb        ex      de,hl
69fe  21db00    ld      hl,#00db
6a01  39        add     hl,sp
6a02  73        ld      (hl),e
6a03  7b        ld      a,e
6a04  feff      cp      #ff
6a06  ca6268    jp      z,#6862
6a09  21b300    ld      hl,#00b3
6a0c  39        add     hl,sp
6a0d  7e        ld      a,(hl)
6a0e  b7        or      a
6a0f  c26268    jp      nz,#6862
6a12  21db00    ld      hl,#00db
6a15  39        add     hl,sp
6a16  7e        ld      a,(hl)
6a17  3d        dec     a
6a18  cad46a    jp      z,#6ad4
6a1b  d602      sub     #02
6a1d  280e      jr      z,#6a2d         ; (14)
6a1f  3d        dec     a
6a20  2814      jr      z,#6a36         ; (20)
6a22  3d        dec     a
6a23  285b      jr      z,#6a80         ; (91)
6a25  d602      sub     #02
6a27  cacb6a    jp      z,#6acb
6a2a  c3d86a    jp      #6ad8
6a2d  21b200    ld      hl,#00b2
6a30  39        add     hl,sp
6a31  3601      ld      (hl),#01
6a33  c36268    jp      #6862
6a36  210200    ld      hl,#0002
6a39  e5        push    hl
6a3a  cd0d6d    call    #6d0d
6a3d  d1        pop     de
6a3e  cdc26e    call    #6ec2
6a41  21e000    ld      hl,#00e0
6a44  39        add     hl,sp
6a45  5e        ld      e,(hl)
6a46  1600      ld      d,#00
6a48  d5        push    de
6a49  62        ld      h,d
6a4a  6a        ld      l,d
6a4b  e5        push    hl
6a4c  21c100    ld      hl,#00c1
6a4f  39        add     hl,sp
6a50  e5        push    hl
6a51  cd6b6f    call    #6f6b
6a54  d1        pop     de
6a55  d1        pop     de
6a56  d1        pop     de
6a57  eb        ex      de,hl
6a58  21b100    ld      hl,#00b1
6a5b  39        add     hl,sp
6a5c  73        ld      (hl),e
6a5d  7b        ld      a,e
6a5e  fe03      cp      #03
6a60  2003      jr      nz,#6a65        ; (3)
6a62  23        inc     hl
6a63  3601      ld      (hl),#01
6a65  21b300    ld      hl,#00b3
6a68  39        add     hl,sp
6a69  5e        ld      e,(hl)
6a6a  1600      ld      d,#00
6a6c  d5        push    de
6a6d  cd0d6d    call    #6d0d
6a70  d1        pop     de
6a71  215d00    ld      hl,#005d
6a74  39        add     hl,sp
6a75  3600      ld      (hl),#00
6a77  210900    ld      hl,#0009
6a7a  39        add     hl,sp
6a7b  3600      ld      (hl),#00
6a7d  c36268    jp      #6862
6a80  210300    ld      hl,#0003
6a83  e5        push    hl
6a84  cd0d6d    call    #6d0d
6a87  d1        pop     de
6a88  cdc26e    call    #6ec2
6a8b  21e000    ld      hl,#00e0
6a8e  39        add     hl,sp
6a8f  5e        ld      e,(hl)
6a90  1600      ld      d,#00
6a92  d5        push    de
6a93  210100    ld      hl,#0001
6a96  e5        push    hl
6a97  21c100    ld      hl,#00c1
6a9a  39        add     hl,sp
6a9b  e5        push    hl
6a9c  cd6b6f    call    #6f6b
6a9f  d1        pop     de
6aa0  d1        pop     de
6aa1  d1        pop     de
6aa2  eb        ex      de,hl
6aa3  21b100    ld      hl,#00b1
6aa6  39        add     hl,sp
6aa7  73        ld      (hl),e
6aa8  7b        ld      a,e
6aa9  fe03      cp      #03
6aab  2003      jr      nz,#6ab0        ; (3)
6aad  23        inc     hl
6aae  3601      ld      (hl),#01
6ab0  21b300    ld      hl,#00b3
6ab3  39        add     hl,sp
6ab4  5e        ld      e,(hl)
6ab5  1600      ld      d,#00
6ab7  d5        push    de
6ab8  cd0d6d    call    #6d0d
6abb  d1        pop     de
6abc  215d00    ld      hl,#005d
6abf  39        add     hl,sp
6ac0  3600      ld      (hl),#00
6ac2  210900    ld      hl,#0009
6ac5  39        add     hl,sp
6ac6  3600      ld      (hl),#00
6ac8  c36268    jp      #6862
6acb  21b200    ld      hl,#00b2
6ace  39        add     hl,sp
6acf  3605      ld      (hl),#05
6ad1  c36268    jp      #6862
6ad4  210100    ld      hl,#0001
6ad7  c9        ret     

6ad8  21db00    ld      hl,#00db
6adb  39        add     hl,sp
6adc  7e        ld      a,(hl)
6add  fe57      cp      #57
6adf  c26e6b    jp      nz,#6b6e
6ae2  215d00    ld      hl,#005d
6ae5  39        add     hl,sp
6ae6  7e        ld      a,(hl)
6ae7  b7        or      a
6ae8  ca6268    jp      z,#6862
6aeb  21d200    ld      hl,#00d2
6aee  39        add     hl,sp
6aef  3600      ld      (hl),#00
6af1  23        inc     hl
6af2  3600      ld      (hl),#00
6af4  23        inc     hl
6af5  361e      ld      (hl),#1e
6af7  23        inc     hl
6af8  3600      ld      (hl),#00
6afa  213200    ld      hl,#0032
6afd  e5        push    hl
6afe  214001    ld      hl,#0140
6b01  e5        push    hl
6b02  211e00    ld      hl,#001e
6b05  e5        push    hl
6b06  6c        ld      l,h
6b07  e5        push    hl
6b08  cd8a20    call    #208a
6b0b  210800    ld      hl,#0008
6b0e  39        add     hl,sp
6b0f  f9        ld      sp,hl
6b10  215d00    ld      hl,#005d
6b13  39        add     hl,sp
6b14  5e        ld      e,(hl)
6b15  1600      ld      d,#00
6b17  d5        push    de
6b18  23        inc     hl
6b19  e5        push    hl
6b1a  21d600    ld      hl,#00d6
6b1d  39        add     hl,sp
6b1e  e5        push    hl
6b1f  cdc967    call    #67c9
6b22  d1        pop     de
6b23  d1        pop     de
6b24  d1        pop     de
6b25  cd7324    call    #2473
6b28  21956c    ld      hl,#6c95
6b2b  e5        push    hl
6b2c  216000    ld      hl,#0060
6b2f  39        add     hl,sp
6b30  e5        push    hl
6b31  cdcf05    call    #05cf
6b34  d1        pop     de
6b35  d1        pop     de
6b36  2816      jr      z,#6b4e         ; (22)
6b38  215d00    ld      hl,#005d
6b3b  39        add     hl,sp
6b3c  5e        ld      e,(hl)
6b3d  1600      ld      d,#00
6b3f  23        inc     hl
6b40  19        add     hl,de
6b41  1e0d      ld      e,#0d
6b43  73        ld      (hl),e
6b44  215d00    ld      hl,#005d
6b47  39        add     hl,sp
6b48  e5        push    hl
6b49  6e        ld      l,(hl)
6b4a  23        inc     hl
6b4b  eb        ex      de,hl
6b4c  e1        pop     hl
6b4d  73        ld      (hl),e
6b4e  215d00    ld      hl,#005d
6b51  39        add     hl,sp
6b52  5e        ld      e,(hl)
6b53  1600      ld      d,#00
6b55  23        inc     hl
6b56  19        add     hl,de
6b57  72        ld      (hl),d
6b58  215d00    ld      hl,#005d
6b5b  39        add     hl,sp
6b5c  5e        ld      e,(hl)
6b5d  d5        push    de
6b5e  23        inc     hl
6b5f  e5        push    hl
6b60  cd8108    call    #0881
6b63  d1        pop     de
6b64  d1        pop     de
6b65  215d00    ld      hl,#005d
6b68  39        add     hl,sp
6b69  3600      ld      (hl),#00
6b6b  c36268    jp      #6862
6b6e  fe35      cp      #35
6b70  2058      jr      nz,#6bca        ; (88)
6b72  215d00    ld      hl,#005d
6b75  39        add     hl,sp
6b76  7e        ld      a,(hl)
6b77  b7        or      a
6b78  2806      jr      z,#6b80         ; (6)
6b7a  e5        push    hl
6b7b  6e        ld      l,(hl)
6b7c  2b        dec     hl
6b7d  eb        ex      de,hl
6b7e  e1        pop     hl
6b7f  73        ld      (hl),e
6b80  215d00    ld      hl,#005d
6b83  39        add     hl,sp
6b84  5e        ld      e,(hl)
6b85  1600      ld      d,#00
6b87  23        inc     hl
6b88  19        add     hl,de
6b89  72        ld      (hl),d
6b8a  213200    ld      hl,#0032
6b8d  e5        push    hl
6b8e  214001    ld      hl,#0140
6b91  e5        push    hl
6b92  212800    ld      hl,#0028
6b95  e5        push    hl
6b96  6c        ld      l,h
6b97  e5        push    hl
6b98  cd8a20    call    #208a
6b9b  210800    ld      hl,#0008
6b9e  39        add     hl,sp
6b9f  f9        ld      sp,hl
6ba0  21d200    ld      hl,#00d2
6ba3  39        add     hl,sp
6ba4  3600      ld      (hl),#00
6ba6  23        inc     hl
6ba7  3600      ld      (hl),#00
6ba9  23        inc     hl
6baa  3628      ld      (hl),#28
6bac  23        inc     hl
6bad  3600      ld      (hl),#00
6baf  215d00    ld      hl,#005d
6bb2  39        add     hl,sp
6bb3  5e        ld      e,(hl)
6bb4  1600      ld      d,#00
6bb6  d5        push    de
6bb7  23        inc     hl
6bb8  e5        push    hl
6bb9  21d600    ld      hl,#00d6
6bbc  39        add     hl,sp
6bbd  e5        push    hl
6bbe  cdc967    call    #67c9
6bc1  d1        pop     de
6bc2  d1        pop     de
6bc3  d1        pop     de
6bc4  cd7324    call    #2473
6bc7  c36268    jp      #6862
6bca  e6f0      and     #f0
6bcc  1f        rra     
6bcd  1f        rra     
6bce  1f        rra     
6bcf  1f        rra     
6bd0  e60f      and     #0f
6bd2  215c00    ld      hl,#005c
6bd5  39        add     hl,sp
6bd6  77        ld      (hl),a
6bd7  21db00    ld      hl,#00db
6bda  39        add     hl,sp
6bdb  7e        ld      a,(hl)
6bdc  e60f      and     #0f
6bde  215b00    ld      hl,#005b
6be1  39        add     hl,sp
6be2  77        ld      (hl),a
6be3  3a58f6    ld      a,(#f658)
6be6  b7        or      a
6be7  2818      jr      z,#6c01         ; (24)
6be9  5e        ld      e,(hl)
6bea  1600      ld      d,#00
6bec  d5        push    de
6bed  23        inc     hl
6bee  5e        ld      e,(hl)
6bef  eb        ex      de,hl
6bf0  29        add     hl,hl
6bf1  29        add     hl,hl
6bf2  29        add     hl,hl
6bf3  d1        pop     de
6bf4  19        add     hl,de
6bf5  113767    ld      de,#6737
6bf8  19        add     hl,de
6bf9  5e        ld      e,(hl)
6bfa  21db00    ld      hl,#00db
6bfd  39        add     hl,sp
6bfe  73        ld      (hl),e
6bff  1816      jr      #6c17           ; (22)
6c01  5e        ld      e,(hl)
6c02  1600      ld      d,#00
6c04  d5        push    de
6c05  23        inc     hl
6c06  5e        ld      e,(hl)
6c07  eb        ex      de,hl
6c08  29        add     hl,hl
6c09  29        add     hl,hl
6c0a  29        add     hl,hl
6c0b  d1        pop     de
6c0c  19        add     hl,de
6c0d  11e766    ld      de,#66e7
6c10  19        add     hl,de
6c11  5e        ld      e,(hl)
6c12  21db00    ld      hl,#00db
6c15  39        add     hl,sp
6c16  73        ld      (hl),e
6c17  21db00    ld      hl,#00db
6c1a  39        add     hl,sp
6c1b  7e        ld      a,(hl)
6c1c  fe20      cp      #20
6c1e  da6268    jp      c,#6862
6c21  fe80      cp      #80
6c23  d26268    jp      nc,#6862
6c26  215d00    ld      hl,#005d
6c29  39        add     hl,sp
6c2a  1600      ld      d,#00
6c2c  7e        ld      a,(hl)
6c2d  fe4b      cp      #4b
6c2f  ca6268    jp      z,#6862
6c32  21db00    ld      hl,#00db
6c35  39        add     hl,sp
6c36  5e        ld      e,(hl)
6c37  d5        push    de
6c38  215f00    ld      hl,#005f
6c3b  39        add     hl,sp
6c3c  5e        ld      e,(hl)
6c3d  23        inc     hl
6c3e  19        add     hl,de
6c3f  d1        pop     de
6c40  73        ld      (hl),e
6c41  215d00    ld      hl,#005d
6c44  39        add     hl,sp
6c45  e5        push    hl
6c46  6e        ld      l,(hl)
6c47  23        inc     hl
6c48  eb        ex      de,hl
6c49  e1        pop     hl
6c4a  73        ld      (hl),e
6c4b  215d00    ld      hl,#005d
6c4e  39        add     hl,sp
6c4f  5e        ld      e,(hl)
6c50  1600      ld      d,#00
6c52  23        inc     hl
6c53  19        add     hl,de
6c54  72        ld      (hl),d
6c55  213200    ld      hl,#0032
6c58  e5        push    hl
6c59  214001    ld      hl,#0140
6c5c  e5        push    hl
6c5d  212800    ld      hl,#0028
6c60  e5        push    hl
6c61  6c        ld      l,h
6c62  e5        push    hl
6c63  cd8a20    call    #208a
6c66  210800    ld      hl,#0008
6c69  39        add     hl,sp
6c6a  f9        ld      sp,hl
6c6b  21d200    ld      hl,#00d2
6c6e  39        add     hl,sp
6c6f  3600      ld      (hl),#00
6c71  23        inc     hl
6c72  3600      ld      (hl),#00
6c74  23        inc     hl
6c75  3628      ld      (hl),#28
6c77  23        inc     hl
6c78  3600      ld      (hl),#00
6c7a  215d00    ld      hl,#005d
6c7d  39        add     hl,sp
6c7e  5e        ld      e,(hl)
6c7f  1600      ld      d,#00
6c81  d5        push    de
6c82  23        inc     hl
6c83  e5        push    hl
6c84  21d600    ld      hl,#00d6
6c87  39        add     hl,sp
6c88  e5        push    hl
6c89  cdc967    call    #67c9
6c8c  d1        pop     de
6c8d  d1        pop     de
6c8e  d1        pop     de
6c8f  cd7324    call    #2473
6c92  c36268    jp      #6862
6c95  +++\0
6c99  a76c
6c9b  a96c
6c9d  b46c
6c9f  c26c
6ca1  d16c
6ca3  df6c
6ca5  f06c
6ca7   \0 'Space Null
6ca9    -  Reset\0
6cb4    -  EMI Test\0
6cc2    -  Loop Test\0
6cd1    -  TAS Test\0
6cdf    -  Edit Number\0
6cf0    -  Baud Rate\0

6cff  016d
6d01  Modem  Test\0

6d0d  11b0ff    ld      de,#ffb0
6d10  cd6b05    call    #056b
6d13  210b00    ld      hl,#000b
6d16  e5        push    hl
6d17  214001    ld      hl,#0140
6d1a  e5        push    hl
6d1b  210000    ld      hl,#0000
6d1e  e5        push    hl
6d1f  e5        push    hl
6d20  cd8a20    call    #208a
6d23  210800    ld      hl,#0008
6d26  39        add     hl,sp
6d27  f9        ld      sp,hl
6d28  2aff6c    ld      hl,(#6cff)
6d2b  e5        push    hl
6d2c  210a00    ld      hl,#000a
6d2f  39        add     hl,sp
6d30  e5        push    hl
6d31  cdc605    call    #05c6
6d34  d1        pop     de
6d35  d1        pop     de
6d36  215c00    ld      hl,#005c
6d39  39        add     hl,sp
6d3a  5e        ld      e,(hl)
6d3b  1600      ld      d,#00
6d3d  eb        ex      de,hl
6d3e  29        add     hl,hl
6d3f  11996c    ld      de,#6c99
6d42  19        add     hl,de
6d43  5e        ld      e,(hl)
6d44  23        inc     hl
6d45  56        ld      d,(hl)
6d46  d5        push    de
6d47  210a00    ld      hl,#000a
6d4a  39        add     hl,sp
6d4b  e5        push    hl
6d4c  cdba05    call    #05ba
6d4f  d1        pop     de
6d50  d1        pop     de

' DisplayText(???, 100, 2, 0)
6d51  210000    ld      hl,#0000
6d54  e5        push    hl
6d55  2e02      ld      l,#02
6d57  e5        push    hl
6d58  2e64      ld      l,#64
6d5a  e5        push    hl
6d5b  210e00    ld      hl,#000e
6d5e  39        add     hl,sp
6d5f  e5        push    hl
6d60  cd8d4c    call    #4c8d
6d63  210800    ld      hl,#0008
6d66  39        add     hl,sp
6d67  f9        ld      sp,hl

6d68  210b00    ld      hl,#000b
6d6b  e5        push    hl
6d6c  214001    ld      hl,#0140
6d6f  e5        push    hl
6d70  210000    ld      hl,#0000
6d73  e5        push    hl
6d74  e5        push    hl
6d75  cdee21    call    #21ee
6d78  210800    ld      hl,#0008
6d7b  39        add     hl,sp
6d7c  f9        ld      sp,hl
6d7d  cd7324    call    #2473
6d80  c9        ret     

6d81  836d
6d83  F1- Reset\0
6d8d  8f6d
6d8f  F2- EMI Test\0
6d9c  9e6d
6d9e  F3- Loop Test\0
6dac  ae6d
6dae  F4- TAS Baud Rate : \0
6dc3  c56d
6dc5  F5- Number : \0
6dd3  d56d
6dd5  Back- Exit\0

6de0  11a7ff    ld      de,#ffa7
6de3  cd6b05    call    #056b
6de6  216500    ld      hl,#0065
6de9  39        add     hl,sp
6dea  5e        ld      e,(hl)
6deb  1600      ld      d,#00
6ded  d5        push    de
6dee  cd0d6d    call    #6d0d
6df1  d1        pop     de
6df2  218000    ld      hl,#0080
6df5  e5        push    hl
6df6  214001    ld      hl,#0140
6df9  e5        push    hl
6dfa  216800    ld      hl,#0068
6dfd  e5        push    hl
6dfe  6c        ld      l,h
6dff  e5        push    hl
6e00  cd8a20    call    #208a
6e03  210800    ld      hl,#0008
6e06  39        add     hl,sp
6e07  f9        ld      sp,hl
6e08  214001    ld      hl,#0140
6e0b  e5        push    hl
6e0c  216800    ld      hl,#0068
6e0f  e5        push    hl
6e10  6c        ld      l,h
6e11  e5        push    hl
6e12  cdd123    call    #23d1
6e15  d1        pop     de
6e16  d1        pop     de
6e17  d1        pop     de

' DisplayText("F1- Reset", 6, 108, 0)
6e18  210000    ld      hl,#0000
6e1b  e5        push    hl
6e1c  2e6c      ld      l,#6c
6e1e  e5        push    hl
6e1f  2e06      ld      l,#06
6e21  e5        push    hl
6e22  2a816d    ld      hl,(#6d81)
6e25  e5        push    hl
6e26  cd8d4c    call    #4c8d
6e29  210800    ld      hl,#0008
6e2c  39        add     hl,sp
6e2d  f9        ld      sp,hl

' DisplayText("Back- Exit", 4, 118, 0)
6e2e  210000    ld      hl,#0000
6e31  e5        push    hl
6e32  2e76      ld      l,#76
6e34  e5        push    hl
6e35  2e04      ld      l,#04
6e37  e5        push    hl
6e38  2ad36d    ld      hl,(#6dd3)
6e3b  e5        push    hl
6e3c  cd8d4c    call    #4c8d
6e3f  210800    ld      hl,#0008
6e42  39        add     hl,sp
6e43  f9        ld      sp,hl

' DisplayText("F2- EMI Test", 80, 108, 0)
6e44  210000    ld      hl,#0000
6e47  e5        push    hl
6e48  2e6c      ld      l,#6c
6e4a  e5        push    hl
6e4b  2e50      ld      l,#50
6e4d  e5        push    hl
6e4e  2a8d6d    ld      hl,(#6d8d)
6e51  e5        push    hl
6e52  cd8d4c    call    #4c8d
6e55  210800    ld      hl,#0008
6e58  39        add     hl,sp
6e59  f9        ld      sp,hl

' DisplayText("F3- Loop Test", 80, 118, 0)
6e5a  210000    ld      hl,#0000
6e5d  e5        push    hl
6e5e  2e76      ld      l,#76
6e60  e5        push    hl
6e61  2e50      ld      l,#50
6e63  e5        push    hl
6e64  2a9c6d    ld      hl,(#6d9c)
6e67  e5        push    hl
6e68  cd8d4c    call    #4c8d
6e6b  210800    ld      hl,#0008
6e6e  39        add     hl,sp
6e6f  f9        ld      sp,hl

' "F5- Number : "
6e70  2ac36d    ld      hl,(#6dc3)
6e73  e5        push    hl
6e74  211300    ld      hl,#0013
6e77  39        add     hl,sp
6e78  e5        push    hl
6e79  cdc605    call    #05c6
6e7c  d1        pop     de
6e7d  d1        pop     de
6e7e  216700    ld      hl,#0067
6e81  39        add     hl,sp
6e82  5e        ld      e,(hl)
6e83  23        inc     hl
6e84  56        ld      d,(hl)
6e85  d5        push    de
6e86  211300    ld      hl,#0013
6e89  39        add     hl,sp
6e8a  e5        push    hl
6e8b  cdba05    call    #05ba
6e8e  d1        pop     de
6e8f  d1        pop     de
6e90  217f00    ld      hl,#007f
6e93  e5        push    hl
6e94  213f01    ld      hl,#013f
6e97  e5        push    hl
6e98  217600    ld      hl,#0076
6e9b  e5        push    hl
6e9c  2ea0      ld      l,#a0
6e9e  e5        push    hl
6e9f  cd8a20    call    #208a
6ea2  210800    ld      hl,#0008
6ea5  39        add     hl,sp
6ea6  f9        ld      sp,hl

' DisplayText(?, 23, 118, 0)
6ea7  210000    ld      hl,#0000
6eaa  e5        push    hl
6eab  2e76      ld      l,#76
6ead  e5        push    hl
6eae  2ea0      ld      l,#a0
6eb0  e5        push    hl
6eb1  211700    ld      hl,#0017
6eb4  39        add     hl,sp
6eb5  e5        push    hl
6eb6  cd8d4c    call    #4c8d
6eb9  210800    ld      hl,#0008
6ebc  39        add     hl,sp
6ebd  f9        ld      sp,hl

6ebe  cd7324    call    #2473
6ec1  c9        ret     

6ec2  216700    ld      hl,#0067
6ec5  e5        push    hl
6ec6  214001    ld      hl,#0140
6ec9  e5        push    hl
6eca  210c00    ld      hl,#000c
6ecd  e5        push    hl
6ece  6c        ld      l,h
6ecf  e5        push    hl
6ed0  cd8a20    call    #208a
6ed3  210800    ld      hl,#0008
6ed6  39        add     hl,sp
6ed7  f9        ld      sp,hl
6ed8  cd7324    call    #2473
6edb  c9        ret     

6edc  de6e
6ede  > Dialling\0
6ee9  eb6e
6eeb  > Connect Ok\0
6ef8  fa6e
6efa  > Disconnect\0
6f07  096f
6f09  Send\0
6f0e  106f
6f10  Receive\0
6f18  1a6f
6f1a  > Sending\0
6f24  266f
6f26  >> Checksum Error  !!!\0
6f3d  3f6f
6f3f  >> Overtime  !!!\0
6f50  526f
6f52  > User Break\0
6f5f  616f
6f61  > Hang Up\0

6f6b  11a0ff    ld      de,#ffa0
6f6e  cd6b05    call    #056b
6f71  215000    ld      hl,#0050
6f74  39        add     hl,sp
6f75  3600      ld      (hl),#00
6f77  23        inc     hl
6f78  3600      ld      (hl),#00
6f7a  2b        dec     hl
6f7b  2b        dec     hl
6f7c  3600      ld      (hl),#00
6f7e  2b        dec     hl
6f7f  3600      ld      (hl),#00
6f81  216300    ld      hl,#0063
6f84  39        add     hl,sp
6f85  3640      ld      (hl),#40
6f87  23        inc     hl
6f88  3601      ld      (hl),#01
6f8a  23        inc     hl
6f8b  3680      ld      (hl),#80
6f8d  23        inc     hl
6f8e  3600      ld      (hl),#00
6f90  23        inc     hl
6f91  3600      ld      (hl),#00

' DisplayText("> Dialling", 0, 20, 0)
6f93  210000    ld      hl,#0000
6f96  e5        push    hl
6f97  2e14      ld      l,#14
6f99  e5        push    hl
6f9a  6c        ld      l,h
6f9b  e5        push    hl
6f9c  2adc6e    ld      hl,(#6edc)
6f9f  e5        push    hl
6fa0  cd8d4c    call    #4c8d
6fa3  210800    ld      hl,#0008
6fa6  39        add     hl,sp
6fa7  f9        ld      sp,hl

' DisplayText(?, 43, 20, 0)
6fa8  210000    ld      hl,#0000
6fab  e5        push    hl
6fac  2e14      ld      l,#14
6fae  e5        push    hl
6faf  2e2b      ld      l,#2b
6fb1  e5        push    hl
6fb2  217200    ld      hl,#0072
6fb5  39        add     hl,sp
6fb6  5e        ld      e,(hl)
6fb7  23        inc     hl
6fb8  56        ld      d,(hl)
6fb9  d5        push    de
6fba  cd8d4c    call    #4c8d
6fbd  210800    ld      hl,#0008
6fc0  39        add     hl,sp
6fc1  f9        ld      sp,hl

6fc2  cd7324    call    #2473
6fc5  210000    ld      hl,#0000
6fc8  222de6    ld      (#e62d),hl
6fcb  222fe6    ld      (#e62f),hl
6fce  212475    ld      hl,#7524
6fd1  e5        push    hl
6fd2  211400    ld      hl,#0014
6fd5  39        add     hl,sp
6fd6  e5        push    hl
6fd7  cdc605    call    #05c6
6fda  d1        pop     de
6fdb  d1        pop     de
6fdc  211200    ld      hl,#0012
6fdf  39        add     hl,sp
6fe0  e5        push    hl
6fe1  cdcc05    call    #05cc
6fe4  d1        pop     de
6fe5  e5        push    hl
6fe6  211400    ld      hl,#0014
6fe9  39        add     hl,sp
6fea  e5        push    hl
6feb  cd8108    call    #0881
6fee  d1        pop     de
6fef  d1        pop     de
6ff0  210a00    ld      hl,#000a
6ff3  39        add     hl,sp
6ff4  e5        push    hl
6ff5  215ed4    ld      hl,#d45e
6ff8  cd2402    call    #0224
6ffb  e1        pop     hl
6ffc  cd2f02    call    #022f
6fff  210800    ld      hl,#0008
7002  39        add     hl,sp
7003  3600      ld      (hl),#00
7005  23        inc     hl
7006  3600      ld      (hl),#00
7008  cd6908    call    #0869
700b  201e      jr      nz,#702b        ; (30)
700d  cd6f08    call    #086f
7010  e5        push    hl
7011  210a00    ld      hl,#000a
7014  39        add     hl,sp
7015  5e        ld      e,(hl)
7016  1600      ld      d,#00
7018  211400    ld      hl,#0014
701b  39        add     hl,sp
701c  19        add     hl,de
701d  d1        pop     de
701e  73        ld      (hl),e
701f  210800    ld      hl,#0008
7022  39        add     hl,sp
7023  e5        push    hl
7024  6e        ld      l,(hl)
7025  23        inc     hl
7026  eb        ex      de,hl
7027  e1        pop     hl
7028  73        ld      (hl),e
7029  18dd      jr      #7008           ; (-35)
702b  210800    ld      hl,#0008
702e  39        add     hl,sp
702f  7e        ld      a,(hl)
7030  fe1d      cp      #1d
7032  3066      jr      nc,#709a        ; (102)
7034  23        inc     hl
7035  7e        ld      a,(hl)
7036  fe03      cp      #03
7038  3060      jr      nc,#709a        ; (96)
703a  215ed4    ld      hl,#d45e
703d  cd2402    call    #0224
7040  210a00    ld      hl,#000a
7043  39        add     hl,sp
7044  cd1802    call    #0218
7047  cdd602    call    #02d6
704a  cd1102    call    #0211
704d  88        adc     a,b
704e  13        inc     de
704f  00        nop     
7050  00        nop     
7051  cdd404    call    #04d4
7054  28b2      jr      z,#7008         ; (-78)
7056  cd6308    call    #0863
7059  212a75    ld      hl,#752a
705c  e5        push    hl
705d  211400    ld      hl,#0014
7060  39        add     hl,sp
7061  e5        push    hl
7062  cdc605    call    #05c6
7065  d1        pop     de
7066  d1        pop     de
7067  211200    ld      hl,#0012
706a  39        add     hl,sp
706b  e5        push    hl
706c  cdcc05    call    #05cc
706f  d1        pop     de
7070  e5        push    hl
7071  211400    ld      hl,#0014
7074  39        add     hl,sp
7075  e5        push    hl
7076  cd8108    call    #0881
7079  d1        pop     de
707a  d1        pop     de
707b  210a00    ld      hl,#000a
707e  39        add     hl,sp
707f  e5        push    hl
7080  215ed4    ld      hl,#d45e
7083  cd2402    call    #0224
7086  e1        pop     hl
7087  cd2f02    call    #022f
708a  210800    ld      hl,#0008
708d  39        add     hl,sp
708e  3600      ld      (hl),#00
7090  23        inc     hl
7091  e5        push    hl
7092  6e        ld      l,(hl)
7093  23        inc     hl
7094  eb        ex      de,hl
7095  e1        pop     hl
7096  73        ld      (hl),e
7097  c30870    jp      #7008
709a  213075    ld      hl,#7530
709d  e5        push    hl
709e  211400    ld      hl,#0014
70a1  39        add     hl,sp
70a2  e5        push    hl
70a3  cdc305    call    #05c3
70a6  d1        pop     de
70a7  d1        pop     de
70a8  2810      jr      z,#70ba         ; (16)
70aa  213475    ld      hl,#7534
70ad  e5        push    hl
70ae  211400    ld      hl,#0014
70b1  39        add     hl,sp
70b2  e5        push    hl
70b3  cdc605    call    #05c6
70b6  d1        pop     de
70b7  d1        pop     de
70b8  180e      jr      #70c8           ; (14)
70ba  216975    ld      hl,#7569
70bd  e5        push    hl
70be  211400    ld      hl,#0014
70c1  39        add     hl,sp
70c2  e5        push    hl
70c3  cdc605    call    #05c6
70c6  d1        pop     de
70c7  d1        pop     de
70c8  216c00    ld      hl,#006c
70cb  39        add     hl,sp
70cc  5e        ld      e,(hl)
70cd  23        inc     hl
70ce  56        ld      d,(hl)
70cf  d5        push    de
70d0  211400    ld      hl,#0014
70d3  39        add     hl,sp
70d4  e5        push    hl
70d5  cdba05    call    #05ba
70d8  d1        pop     de
70d9  d1        pop     de
70da  218c75    ld      hl,#758c
70dd  e5        push    hl
70de  211400    ld      hl,#0014
70e1  39        add     hl,sp
70e2  e5        push    hl
70e3  cdba05    call    #05ba
70e6  d1        pop     de
70e7  d1        pop     de
70e8  211200    ld      hl,#0012
70eb  39        add     hl,sp
70ec  e5        push    hl
70ed  cdcc05    call    #05cc
70f0  d1        pop     de
70f1  e5        push    hl
70f2  211400    ld      hl,#0014
70f5  39        add     hl,sp
70f6  e5        push    hl
70f7  cd8108    call    #0881
70fa  d1        pop     de
70fb  d1        pop     de
70fc  215f00    ld      hl,#005f
70ff  39        add     hl,sp
7100  3600      ld      (hl),#00
7102  23        inc     hl
7103  3600      ld      (hl),#00
7105  23        inc     hl
7106  361e      ld      (hl),#1e
7108  23        inc     hl
7109  3600      ld      (hl),#00
710b  216971    ld      hl,#7169
710e  e5        push    hl
710f  210600    ld      hl,#0006
7112  e5        push    hl
7113  cded05    call    #05ed
7116  d1        pop     de
7117  d1        pop     de
7118  eb        ex      de,hl
7119  215e00    ld      hl,#005e
711c  39        add     hl,sp
711d  73        ld      (hl),e
711e  7b        ld      a,e
711f  b7        or      a
7120  201c      jr      nz,#713e        ; (28)
7122  cd0d7a    call    #7a0d
7125  eb        ex      de,hl
7126  215300    ld      hl,#0053
7129  39        add     hl,sp
712a  73        ld      (hl),e
712b  7b        ld      a,e
712c  fe03      cp      #03
712e  2005      jr      nz,#7135        ; (5)
7130  5e        ld      e,(hl)
7131  1600      ld      d,#00
7133  eb        ex      de,hl
7134  c9        ret     

7135  7e        ld      a,(hl)
7136  fe01      cp      #01
7138  20d1      jr      nz,#710b        ; (-47)
713a  21ff00    ld      hl,#00ff
713d  c9        ret     

713e  216971    ld      hl,#7169
7141  e5        push    hl
7142  210600    ld      hl,#0006
7145  e5        push    hl
7146  cded05    call    #05ed
7149  d1        pop     de
714a  d1        pop     de
714b  eb        ex      de,hl
714c  215300    ld      hl,#0053
714f  39        add     hl,sp
7150  73        ld      (hl),e
7151  7b        ld      a,e
7152  b7        or      a
7153  280c      jr      z,#7161         ; (12)
7155  cd0d7a    call    #7a0d
7158  7d        ld      a,l
7159  fe01      cp      #01
715b  20e1      jr      nz,#713e        ; (-31)
715d  21ff00    ld      hl,#00ff
7160  c9        ret     

7161  217000    ld      hl,#0070
7164  39        add     hl,sp
7165  7e        ld      a,(hl)
7166  fe05      cp      #05
7168  2816      jr      z,#7180         ; (22)
716a  214100    ld      hl,#0041
716d  e5        push    hl
716e  24        inc     h
716f  2d        dec     l
7170  e5        push    hl
7171  212d00    ld      hl,#002d
7174  e5        push    hl
7175  2e55      ld      l,#55
7177  e5        push    hl
7178  cd8a20    call    #208a
717b  210800    ld      hl,#0008
717e  39        add     hl,sp
717f  f9        ld      sp,hl
7180  215e00    ld      hl,#005e
7183  39        add     hl,sp
7184  7e        ld      a,(hl)
7185  fe01      cp      #01
7187  201f      jr      nz,#71a8        ; (31)
7189  2ae96e    ld      hl,(#6ee9)
718c  e5        push    hl
718d  cdcc05    call    #05cc
7190  d1        pop     de
7191  2600      ld      h,#00
7193  e5        push    hl
7194  2ae96e    ld      hl,(#6ee9)
7197  e5        push    hl
7198  216300    ld      hl,#0063
719b  39        add     hl,sp
719c  e5        push    hl
719d  cdc967    call    #67c9
71a0  d1        pop     de
71a1  d1        pop     de
71a2  d1        pop     de
71a3  cd7324    call    #2473
71a6  1821      jr      #71c9           ; (33)
71a8  2af86e    ld      hl,(#6ef8)
71ab  e5        push    hl
71ac  cdcc05    call    #05cc
71af  d1        pop     de
71b0  2600      ld      h,#00
71b2  e5        push    hl
71b3  2af86e    ld      hl,(#6ef8)
71b6  e5        push    hl
71b7  216300    ld      hl,#0063
71ba  39        add     hl,sp
71bb  e5        push    hl
71bc  cdc967    call    #67c9
71bf  d1        pop     de
71c0  d1        pop     de
71c1  d1        pop     de
71c2  cd7324    call    #2473
71c5  210000    ld      hl,#0000
71c8  c9        ret     

71c9  216e00    ld      hl,#006e
71cc  39        add     hl,sp
71cd  7e        ld      a,(hl)
71ce  fe01      cp      #01
71d0  2060      jr      nz,#7232        ; (96)
71d2  215f00    ld      hl,#005f
71d5  39        add     hl,sp
71d6  3614      ld      (hl),#14
71d8  23        inc     hl
71d9  3600      ld      (hl),#00
71db  23        inc     hl
71dc  362d      ld      (hl),#2d
71de  23        inc     hl
71df  3600      ld      (hl),#00
71e1  2a076f    ld      hl,(#6f07)
71e4  e5        push    hl
71e5  cdcc05    call    #05cc
71e8  d1        pop     de
71e9  2600      ld      h,#00
71eb  e5        push    hl
71ec  2a076f    ld      hl,(#6f07)
71ef  e5        push    hl
71f0  216300    ld      hl,#0063
71f3  39        add     hl,sp
71f4  e5        push    hl
71f5  cdc967    call    #67c9
71f8  d1        pop     de
71f9  d1        pop     de
71fa  d1        pop     de
71fb  215f00    ld      hl,#005f
71fe  39        add     hl,sp
71ff  3646      ld      (hl),#46
7201  23        inc     hl
7202  3600      ld      (hl),#00
7204  2a0e6f    ld      hl,(#6f0e)
7207  e5        push    hl
7208  cdcc05    call    #05cc
720b  d1        pop     de
720c  2600      ld      h,#00
720e  e5        push    hl
720f  2a0e6f    ld      hl,(#6f0e)
7212  e5        push    hl
7213  216300    ld      hl,#0063
7216  39        add     hl,sp
7217  e5        push    hl
7218  cdc967    call    #67c9
721b  d1        pop     de
721c  d1        pop     de
721d  d1        pop     de
721e  218200    ld      hl,#0082
7221  e5        push    hl
7222  2e37      ld      l,#37
7224  e5        push    hl
7225  6c        ld      l,h
7226  e5        push    hl
7227  cdd123    call    #23d1
722a  d1        pop     de
722b  d1        pop     de
722c  d1        pop     de
722d  cd7324    call    #2473
7230  1826      jr      #7258           ; (38)
7232  216100    ld      hl,#0061
7235  39        add     hl,sp
7236  3632      ld      (hl),#32
7238  23        inc     hl
7239  3600      ld      (hl),#00
723b  2a186f    ld      hl,(#6f18)
723e  e5        push    hl
723f  cdcc05    call    #05cc
7242  d1        pop     de
7243  2600      ld      h,#00
7245  e5        push    hl
7246  2a186f    ld      hl,(#6f18)
7249  e5        push    hl
724a  216300    ld      hl,#0063
724d  39        add     hl,sp
724e  e5        push    hl
724f  cdc967    call    #67c9
7252  d1        pop     de
7253  d1        pop     de
7254  d1        pop     de
7255  cd7324    call    #2473
7258  cd0d7a    call    #7a0d
725b  eb        ex      de,hl
725c  215300    ld      hl,#0053
725f  39        add     hl,sp
7260  73        ld      (hl),e
7261  7b        ld      a,e
7262  fe01      cp      #01
7264  ca0a74    jp      z,#740a
7267  216e00    ld      hl,#006e
726a  39        add     hl,sp
726b  7e        ld      a,(hl)
726c  fe01      cp      #01
726e  c2db73    jp      nz,#73db
7271  215a00    ld      hl,#005a
7274  e5        push    hl
7275  2e46      ld      l,#46
7277  e5        push    hl
7278  2e3c      ld      l,#3c
727a  e5        push    hl
727b  6c        ld      l,h
727c  e5        push    hl
727d  cd8a20    call    #208a
7280  210800    ld      hl,#0008
7283  39        add     hl,sp
7284  f9        ld      sp,hl
7285  215f00    ld      hl,#005f
7288  39        add     hl,sp
7289  3614      ld      (hl),#14
728b  23        inc     hl
728c  3600      ld      (hl),#00
728e  23        inc     hl
728f  363c      ld      (hl),#3c
7291  23        inc     hl
7292  3600      ld      (hl),#00
7294  215000    ld      hl,#0050
7297  39        add     hl,sp
7298  5e        ld      e,(hl)
7299  23        inc     hl
729a  56        ld      d,(hl)
729b  13        inc     de
729c  2b        dec     hl
729d  73        ld      (hl),e
729e  23        inc     hl
729f  72        ld      (hl),d
72a0  210a00    ld      hl,#000a
72a3  e5        push    hl
72a4  211400    ld      hl,#0014
72a7  39        add     hl,sp
72a8  e5        push    hl
72a9  215400    ld      hl,#0054
72ac  39        add     hl,sp
72ad  5e        ld      e,(hl)
72ae  23        inc     hl
72af  56        ld      d,(hl)
72b0  d5        push    de
72b1  cdb507    call    #07b5
72b4  d1        pop     de
72b5  d1        pop     de
72b6  d1        pop     de
72b7  211200    ld      hl,#0012
72ba  39        add     hl,sp
72bb  e5        push    hl
72bc  cdcc05    call    #05cc
72bf  d1        pop     de
72c0  2600      ld      h,#00
72c2  e5        push    hl
72c3  211400    ld      hl,#0014
72c6  39        add     hl,sp
72c7  e5        push    hl
72c8  216300    ld      hl,#0063
72cb  39        add     hl,sp
72cc  e5        push    hl
72cd  cdc967    call    #67c9
72d0  d1        pop     de
72d1  d1        pop     de
72d2  d1        pop     de
72d3  cd7324    call    #2473
72d6  cd9375    call    #7593
72d9  cd6f76    call    #766f
72dc  eb        ex      de,hl
72dd  215200    ld      hl,#0052
72e0  39        add     hl,sp
72e1  73        ld      (hl),e
72e2  217000    ld      hl,#0070
72e5  39        add     hl,sp
72e6  7e        ld      a,(hl)
72e7  fe05      cp      #05
72e9  2811      jr      z,#72fc         ; (17)
72eb  215300    ld      hl,#0053
72ee  39        add     hl,sp
72ef  3601      ld      (hl),#01
72f1  2b        dec     hl
72f2  7e        ld      a,(hl)
72f3  b7        or      a
72f4  2004      jr      nz,#72fa        ; (4)
72f6  3601      ld      (hl),#01
72f8  1802      jr      #72fc           ; (2)
72fa  3600      ld      (hl),#00
72fc  215200    ld      hl,#0052
72ff  39        add     hl,sp
7300  7e        ld      a,(hl)
7301  feff      cp      #ff
7303  2006      jr      nz,#730b        ; (6)
7305  23        inc     hl
7306  3601      ld      (hl),#01
7308  c30a74    jp      #740a
730b  b7        or      a
730c  2063      jr      nz,#7371        ; (99)
730e  215a00    ld      hl,#005a
7311  e5        push    hl
7312  2e82      ld      l,#82
7314  e5        push    hl
7315  2e3c      ld      l,#3c
7317  e5        push    hl
7318  2e46      ld      l,#46
731a  e5        push    hl
731b  cd8a20    call    #208a
731e  210800    ld      hl,#0008
7321  39        add     hl,sp
7322  f9        ld      sp,hl
7323  215f00    ld      hl,#005f
7326  39        add     hl,sp
7327  3646      ld      (hl),#46
7329  23        inc     hl
732a  3600      ld      (hl),#00
732c  214e00    ld      hl,#004e
732f  39        add     hl,sp
7330  5e        ld      e,(hl)
7331  23        inc     hl
7332  56        ld      d,(hl)
7333  13        inc     de
7334  2b        dec     hl
7335  73        ld      (hl),e
7336  23        inc     hl
7337  72        ld      (hl),d
7338  210a00    ld      hl,#000a
733b  e5        push    hl
733c  211400    ld      hl,#0014
733f  39        add     hl,sp
7340  e5        push    hl
7341  215200    ld      hl,#0052
7344  39        add     hl,sp
7345  5e        ld      e,(hl)
7346  23        inc     hl
7347  56        ld      d,(hl)
7348  d5        push    de
7349  cdb507    call    #07b5
734c  d1        pop     de
734d  d1        pop     de
734e  d1        pop     de
734f  211200    ld      hl,#0012
7352  39        add     hl,sp
7353  e5        push    hl
7354  cdcc05    call    #05cc
7357  d1        pop     de
7358  2600      ld      h,#00
735a  e5        push    hl
735b  211400    ld      hl,#0014
735e  39        add     hl,sp
735f  e5        push    hl
7360  216300    ld      hl,#0063
7363  39        add     hl,sp
7364  e5        push    hl
7365  cdc967    call    #67c9
7368  d1        pop     de
7369  d1        pop     de
736a  d1        pop     de
736b  cd7324    call    #2473
736e  c30a74    jp      #740a
7371  215f00    ld      hl,#005f
7374  39        add     hl,sp
7375  3687      ld      (hl),#87
7377  23        inc     hl
7378  3600      ld      (hl),#00
737a  23        inc     hl
737b  363c      ld      (hl),#3c
737d  23        inc     hl
737e  3600      ld      (hl),#00
7380  215a00    ld      hl,#005a
7383  e5        push    hl
7384  212c01    ld      hl,#012c
7387  e5        push    hl
7388  213c00    ld      hl,#003c
738b  e5        push    hl
738c  2e87      ld      l,#87
738e  e5        push    hl
738f  cd8a20    call    #208a
7392  210800    ld      hl,#0008
7395  39        add     hl,sp
7396  f9        ld      sp,hl
7397  215200    ld      hl,#0052
739a  39        add     hl,sp
739b  7e        ld      a,(hl)
739c  fe02      cp      #02
739e  201c      jr      nz,#73bc        ; (28)
73a0  2a246f    ld      hl,(#6f24)
73a3  e5        push    hl
73a4  cdcc05    call    #05cc
73a7  d1        pop     de
73a8  2600      ld      h,#00
73aa  e5        push    hl
73ab  2a246f    ld      hl,(#6f24)
73ae  e5        push    hl
73af  216300    ld      hl,#0063
73b2  39        add     hl,sp
73b3  e5        push    hl
73b4  cdc967    call    #67c9
73b7  d1        pop     de
73b8  d1        pop     de
73b9  d1        pop     de
73ba  181a      jr      #73d6           ; (26)
73bc  2a3d6f    ld      hl,(#6f3d)
73bf  e5        push    hl
73c0  cdcc05    call    #05cc
73c3  d1        pop     de
73c4  2600      ld      h,#00
73c6  e5        push    hl
73c7  2a3d6f    ld      hl,(#6f3d)
73ca  e5        push    hl
73cb  216300    ld      hl,#0063
73ce  39        add     hl,sp
73cf  e5        push    hl
73d0  cdc967    call    #67c9
73d3  d1        pop     de
73d4  d1        pop     de
73d5  d1        pop     de
73d6  cd7324    call    #2473
73d9  182f      jr      #740a           ; (47)
73db  215400    ld      hl,#0054
73de  39        add     hl,sp
73df  3655      ld      (hl),#55
73e1  23        inc     hl
73e2  3600      ld      (hl),#00
73e4  210e00    ld      hl,#000e
73e7  39        add     hl,sp
73e8  3601      ld      (hl),#01
73ea  23        inc     hl
73eb  3600      ld      (hl),#00
73ed  210100    ld      hl,#0001
73f0  e5        push    hl
73f1  215600    ld      hl,#0056
73f4  39        add     hl,sp
73f5  e5        push    hl
73f6  cd8108    call    #0881
73f9  d1        pop     de
73fa  d1        pop     de
73fb  eb        ex      de,hl
73fc  211000    ld      hl,#0010
73ff  39        add     hl,sp
7400  73        ld      (hl),e
7401  23        inc     hl
7402  72        ld      (hl),d
7403  2b        dec     hl
7404  5e        ld      e,(hl)
7405  1b        dec     de
7406  7a        ld      a,d
7407  b3        or      e
7408  20e3      jr      nz,#73ed        ; (-29)
740a  215300    ld      hl,#0053
740d  39        add     hl,sp
740e  7e        ld      a,(hl)
740f  fe01      cp      #01
7411  c25872    jp      nz,#7258
7414  215f00    ld      hl,#005f
7417  39        add     hl,sp
7418  3600      ld      (hl),#00
741a  23        inc     hl
741b  3600      ld      (hl),#00
741d  23        inc     hl
741e  3646      ld      (hl),#46
7420  23        inc     hl
7421  3600      ld      (hl),#00
7423  217000    ld      hl,#0070
7426  39        add     hl,sp
7427  7e        ld      a,(hl)
7428  fe05      cp      #05
742a  201d      jr      nz,#7449        ; (29)
742c  2a506f    ld      hl,(#6f50)
742f  e5        push    hl
7430  cdcc05    call    #05cc
7433  d1        pop     de
7434  2600      ld      h,#00
7436  e5        push    hl
7437  2a506f    ld      hl,(#6f50)
743a  e5        push    hl
743b  216300    ld      hl,#0063
743e  39        add     hl,sp
743f  e5        push    hl
7440  cdc967    call    #67c9
7443  d1        pop     de
7444  d1        pop     de
7445  d1        pop     de
7446  cd7324    call    #2473
7449  218e75    ld      hl,#758e
744c  e5        push    hl
744d  215600    ld      hl,#0056
7450  39        add     hl,sp
7451  e5        push    hl
7452  cdc605    call    #05c6
7455  d1        pop     de
7456  d1        pop     de
7457  210e00    ld      hl,#000e
745a  39        add     hl,sp
745b  3603      ld      (hl),#03
745d  23        inc     hl
745e  3600      ld      (hl),#00
7460  110300    ld      de,#0003
7463  210e00    ld      hl,#000e
7466  39        add     hl,sp
7467  7e        ld      a,(hl)
7468  23        inc     hl
7469  66        ld      h,(hl)
746a  6f        ld      l,a
746b  a7        and     a
746c  eb        ex      de,hl
746d  ed52      sbc     hl,de
746f  eb        ex      de,hl
7470  211000    ld      hl,#0010
7473  39        add     hl,sp
7474  73        ld      (hl),e
7475  23        inc     hl
7476  72        ld      (hl),d
7477  2b        dec     hl
7478  2b        dec     hl
7479  56        ld      d,(hl)
747a  2b        dec     hl
747b  5e        ld      e,(hl)
747c  d5        push    de
747d  216000    ld      hl,#0060
7480  39        add     hl,sp
7481  5e        ld      e,(hl)
7482  1600      ld      d,#00
7484  215600    ld      hl,#0056
7487  39        add     hl,sp
7488  19        add     hl,de
7489  e5        push    hl
748a  cd8108    call    #0881
748d  d1        pop     de
748e  d1        pop     de
748f  eb        ex      de,hl
7490  211000    ld      hl,#0010
7493  39        add     hl,sp
7494  73        ld      (hl),e
7495  23        inc     hl
7496  72        ld      (hl),d
7497  2b        dec     hl
7498  5e        ld      e,(hl)
7499  2b        dec     hl
749a  2b        dec     hl
749b  7e        ld      a,(hl)
749c  23        inc     hl
749d  66        ld      h,(hl)
749e  6f        ld      l,a
749f  a7        and     a
74a0  ed52      sbc     hl,de
74a2  281a      jr      z,#74be         ; (26)
74a4  210e00    ld      hl,#000e
74a7  39        add     hl,sp
74a8  5e        ld      e,(hl)
74a9  23        inc     hl
74aa  56        ld      d,(hl)
74ab  23        inc     hl
74ac  7e        ld      a,(hl)
74ad  23        inc     hl
74ae  66        ld      h,(hl)
74af  6f        ld      l,a
74b0  a7        and     a
74b1  eb        ex      de,hl
74b2  ed52      sbc     hl,de
74b4  eb        ex      de,hl
74b5  210e00    ld      hl,#000e
74b8  39        add     hl,sp
74b9  73        ld      (hl),e
74ba  23        inc     hl
74bb  72        ld      (hl),d
74bc  18a2      jr      #7460           ; (-94)
74be  21e803    ld      hl,#03e8
74c1  e5        push    hl
74c2  cd5c0a    call    #0a5c
74c5  d1        pop     de
74c6  216100    ld      hl,#0061
74c9  39        add     hl,sp
74ca  3650      ld      (hl),#50
74cc  23        inc     hl
74cd  3600      ld      (hl),#00
74cf  2a5f6f    ld      hl,(#6f5f)
74d2  e5        push    hl
74d3  cdcc05    call    #05cc
74d6  d1        pop     de
74d7  2600      ld      h,#00
74d9  e5        push    hl
74da  2a5f6f    ld      hl,(#6f5f)
74dd  e5        push    hl
74de  216300    ld      hl,#0063
74e1  39        add     hl,sp
74e2  e5        push    hl
74e3  cdc967    call    #67c9
74e6  d1        pop     de
74e7  d1        pop     de
74e8  d1        pop     de
74e9  21e803    ld      hl,#03e8
74ec  e5        push    hl
74ed  cd5c0a    call    #0a5c
74f0  d1        pop     de
74f1  cd7b08    call    #087b
74f4  cd7324    call    #2473
74f7  216971    ld      hl,#7169
74fa  e5        push    hl
74fb  210600    ld      hl,#0006
74fe  e5        push    hl
74ff  cded05    call    #05ed
7502  d1        pop     de
7503  d1        pop     de
7504  eb        ex      de,hl
7505  215300    ld      hl,#0053
7508  39        add     hl,sp
7509  73        ld      (hl),e
750a  7b        ld      a,e
750b  b7        or      a
750c  20e9      jr      nz,#74f7        ; (-23)
750e  217000    ld      hl,#0070
7511  39        add     hl,sp
7512  7e        ld      a,(hl)
7513  fe05      cp      #05
7515  2809      jr      z,#7520         ; (9)
7517  215200    ld      hl,#0052
751a  39        add     hl,sp
751b  5e        ld      e,(hl)
751c  1600      ld      d,#00
751e  eb        ex      de,hl
751f  c9        ret     

7520  210000    ld      hl,#0000
7523  c9        ret     

7524  ATI3\r\0
752a  ATI3\r\0
7530  V34\0
7534  AT&F0+MS=11,1,300,14400E0M1Q0S6=7S11=95S91=10S95=0DT\0
7569  AT&F0E0M1Q0S6=7S11=95S91=10S95=0DT\0
758c  \r\0
758e  ++++\0

7593  11fbfb    ld      de,#fbfb
7596  cd6b05    call    #056b

7599  210d00    ld      hl,#000d
759c  39        add     hl,sp
759d  361b      ld      (hl),#1b

759f  210800    ld      hl,#0008
75a2  39        add     hl,sp
75a3  361b      ld      (hl),#1b

75a5  210e00    ld      hl,#000e
75a8  39        add     hl,sp
75a9  3603      ld      (hl),#03

75ab  210800    ld      hl,#0008
75ae  39        add     hl,sp
75af  5e        ld      e,(hl)
75b0  1600      ld      d,#00
75b2  13        inc     de
75b3  13        inc     de
75b4  13        inc     de
75b5  73        ld      (hl),e
75b6  210f00    ld      hl,#000f
75b9  39        add     hl,sp
75ba  36fc      ld      (hl),#fc
75bc  210800    ld      hl,#0008
75bf  39        add     hl,sp
75c0  7e        ld      a,(hl)
75c1  c6fc      add     a,#fc
75c3  77        ld      (hl),a
75c4  23        inc     hl
75c5  23        inc     hl
75c6  23        inc     hl
75c7  3600      ld      (hl),#00
75c9  23        inc     hl
75ca  3600      ld      (hl),#00
75cc  210b00    ld      hl,#000b
75cf  39        add     hl,sp
75d0  5e        ld      e,(hl)
75d1  23        inc     hl
75d2  56        ld      d,(hl)
75d3  211000    ld      hl,#0010
75d6  39        add     hl,sp
75d7  19        add     hl,de
75d8  1e55      ld      e,#55
75da  73        ld      (hl),e
75db  210800    ld      hl,#0008
75de  39        add     hl,sp
75df  7e        ld      a,(hl)
75e0  c655      add     a,#55
75e2  77        ld      (hl),a
75e3  23        inc     hl
75e4  23        inc     hl
75e5  23        inc     hl
75e6  5e        ld      e,(hl)
75e7  23        inc     hl
75e8  56        ld      d,(hl)
75e9  13        inc     de
75ea  72        ld      (hl),d
75eb  2b        dec     hl
75ec  73        ld      (hl),e
75ed  23        inc     hl
75ee  56        ld      d,(hl)
75ef  2104fc    ld      hl,#fc04
75f2  19        add     hl,de
75f3  30d7      jr      nc,#75cc        ; (-41)
75f5  210800    ld      hl,#0008
75f8  39        add     hl,sp
75f9  5e        ld      e,(hl)
75fa  1600      ld      d,#00
75fc  21ff00    ld      hl,#00ff
75ff  a7        and     a
7600  ed52      sbc     hl,de
7602  23        inc     hl
7603  eb        ex      de,hl
7604  210800    ld      hl,#0008
7607  39        add     hl,sp
7608  73        ld      (hl),e
7609  210c04    ld      hl,#040c
760c  39        add     hl,sp
760d  73        ld      (hl),e
760e  210900    ld      hl,#0009
7611  39        add     hl,sp
7612  3600      ld      (hl),#00
7614  23        inc     hl
7615  3604      ld      (hl),#04
7617  110004    ld      de,#0400
761a  210900    ld      hl,#0009
761d  39        add     hl,sp
761e  7e        ld      a,(hl)
761f  23        inc     hl
7620  66        ld      h,(hl)
7621  6f        ld      l,a
7622  a7        and     a
7623  eb        ex      de,hl
7624  ed52      sbc     hl,de
7626  eb        ex      de,hl
7627  210b00    ld      hl,#000b
762a  39        add     hl,sp
762b  73        ld      (hl),e
762c  23        inc     hl
762d  72        ld      (hl),d
762e  2b        dec     hl
762f  2b        dec     hl
7630  56        ld      d,(hl)
7631  2b        dec     hl
7632  5e        ld      e,(hl)
7633  d5        push    de
7634  23        inc     hl
7635  23        inc     hl
7636  5e        ld      e,(hl)
7637  23        inc     hl
7638  56        ld      d,(hl)
7639  23        inc     hl
763a  19        add     hl,de
763b  e5        push    hl
763c  cd8108    call    #0881
763f  d1        pop     de
7640  d1        pop     de
7641  eb        ex      de,hl
7642  210b00    ld      hl,#000b
7645  39        add     hl,sp
7646  73        ld      (hl),e
7647  23        inc     hl
7648  72        ld      (hl),d
7649  2b        dec     hl
764a  5e        ld      e,(hl)
764b  2b        dec     hl
764c  2b        dec     hl
764d  7e        ld      a,(hl)
764e  23        inc     hl
764f  66        ld      h,(hl)
7650  6f        ld      l,a
7651  a7        and     a
7652  ed52      sbc     hl,de
7654  c8        ret     z

7655  210900    ld      hl,#0009
7658  39        add     hl,sp
7659  5e        ld      e,(hl)
765a  23        inc     hl
765b  56        ld      d,(hl)
765c  23        inc     hl
765d  7e        ld      a,(hl)
765e  23        inc     hl
765f  66        ld      h,(hl)
7660  6f        ld      l,a
7661  a7        and     a
7662  eb        ex      de,hl
7663  ed52      sbc     hl,de
7665  eb        ex      de,hl
7666  210900    ld      hl,#0009
7669  39        add     hl,sp
766a  73        ld      (hl),e
766b  23        inc     hl
766c  72        ld      (hl),d
766d  18a8      jr      #7617           ; (-88)
766f  11ecff    ld      de,#ffec
7672  cd6b05    call    #056b
7675  211600    ld      hl,#0016
7678  39        add     hl,sp
7679  3600      ld      (hl),#00
767b  2b        dec     hl
767c  2b        dec     hl
767d  3600      ld      (hl),#00
767f  2b        dec     hl
7680  3600      ld      (hl),#00
7682  210900    ld      hl,#0009
7685  39        add     hl,sp
7686  3600      ld      (hl),#00
7688  23        inc     hl
7689  3600      ld      (hl),#00
768b  23        inc     hl
768c  3600      ld      (hl),#00
768e  23        inc     hl
768f  3600      ld      (hl),#00
7691  23        inc     hl
7692  3640      ld      (hl),#40
7694  23        inc     hl
7695  3601      ld      (hl),#01
7697  23        inc     hl
7698  3680      ld      (hl),#80
769a  23        inc     hl
769b  3600      ld      (hl),#00
769d  23        inc     hl
769e  3600      ld      (hl),#00
76a0  211800    ld      hl,#0018
76a3  39        add     hl,sp
76a4  e5        push    hl
76a5  215ed4    ld      hl,#d45e
76a8  cd2402    call    #0224
76ab  e1        pop     hl
76ac  cd2f02    call    #022f
76af  cd6908    call    #0869
76b2  c2cb77    jp      nz,#77cb
76b5  cd6f08    call    #086f
76b8  eb        ex      de,hl
76b9  211700    ld      hl,#0017
76bc  39        add     hl,sp
76bd  73        ld      (hl),e
76be  2b        dec     hl
76bf  7e        ld      a,(hl)
76c0  eb        ex      de,hl
76c1  b7        or      a
76c2  2811      jr      z,#76d5         ; (17)
76c4  3d        dec     a
76c5  281f      jr      z,#76e6         ; (31)
76c7  3d        dec     a
76c8  2852      jr      z,#771c         ; (82)
76ca  3d        dec     a
76cb  ca5677    jp      z,#7756
76ce  3d        dec     a
76cf  ca9077    jp      z,#7790
76d2  c3b977    jp      #77b9
76d5  eb        ex      de,hl
76d6  23        inc     hl
76d7  7e        ld      a,(hl)
76d8  fe1b      cp      #1b
76da  c2b977    jp      nz,#77b9
76dd  2b        dec     hl
76de  3601      ld      (hl),#01
76e0  2b        dec     hl
76e1  361b      ld      (hl),#1b
76e3  c3b977    jp      #77b9
76e6  eb        ex      de,hl
76e7  23        inc     hl
76e8  5e        ld      e,(hl)
76e9  1600      ld      d,#00
76eb  210800    ld      hl,#0008
76ee  cd2905    call    #0529
76f1  eb        ex      de,hl
76f2  211300    ld      hl,#0013
76f5  39        add     hl,sp
76f6  73        ld      (hl),e
76f7  23        inc     hl
76f8  72        ld      (hl),d
76f9  211700    ld      hl,#0017
76fc  39        add     hl,sp
76fd  5e        ld      e,(hl)
76fe  1600      ld      d,#00
7700  d5        push    de
7701  211700    ld      hl,#0017
7704  39        add     hl,sp
7705  5e        ld      e,(hl)
7706  1600      ld      d,#00
7708  e1        pop     hl
7709  19        add     hl,de
770a  eb        ex      de,hl
770b  211500    ld      hl,#0015
770e  39        add     hl,sp
770f  73        ld      (hl),e
7710  210200    ld      hl,#0002
7713  eb        ex      de,hl
7714  211600    ld      hl,#0016
7717  39        add     hl,sp
7718  73        ld      (hl),e
7719  c3b977    jp      #77b9
771c  211700    ld      hl,#0017
771f  39        add     hl,sp
7720  5e        ld      e,(hl)
7721  1600      ld      d,#00
7723  211300    ld      hl,#0013
7726  39        add     hl,sp
7727  7e        ld      a,(hl)
7728  23        inc     hl
7729  66        ld      h,(hl)
772a  6f        ld      l,a
772b  19        add     hl,de
772c  eb        ex      de,hl
772d  211300    ld      hl,#0013
7730  39        add     hl,sp
7731  73        ld      (hl),e
7732  23        inc     hl
7733  72        ld      (hl),d
7734  211700    ld      hl,#0017
7737  39        add     hl,sp
7738  5e        ld      e,(hl)
7739  1600      ld      d,#00
773b  d5        push    de
773c  211700    ld      hl,#0017
773f  39        add     hl,sp
7740  5e        ld      e,(hl)
7741  1600      ld      d,#00
7743  e1        pop     hl
7744  19        add     hl,de
7745  eb        ex      de,hl
7746  211500    ld      hl,#0015
7749  39        add     hl,sp
774a  73        ld      (hl),e
774b  210300    ld      hl,#0003
774e  eb        ex      de,hl
774f  211600    ld      hl,#0016
7752  39        add     hl,sp
7753  73        ld      (hl),e
7754  1863      jr      #77b9           ; (99)
7756  211700    ld      hl,#0017
7759  39        add     hl,sp
775a  5e        ld      e,(hl)
775b  1600      ld      d,#00
775d  d5        push    de
775e  211700    ld      hl,#0017
7761  39        add     hl,sp
7762  5e        ld      e,(hl)
7763  1600      ld      d,#00
7765  e1        pop     hl
7766  19        add     hl,de
7767  eb        ex      de,hl
7768  211500    ld      hl,#0015
776b  39        add     hl,sp
776c  73        ld      (hl),e
776d  211300    ld      hl,#0013
7770  39        add     hl,sp
7771  e5        push    hl
7772  7e        ld      a,(hl)
7773  23        inc     hl
7774  66        ld      h,(hl)
7775  6f        ld      l,a
7776  2b        dec     hl
7777  eb        ex      de,hl
7778  e1        pop     hl
7779  73        ld      (hl),e
777a  23        inc     hl
777b  72        ld      (hl),d
777c  211300    ld      hl,#0013
777f  39        add     hl,sp
7780  7e        ld      a,(hl)
7781  23        inc     hl
7782  b6        or      (hl)
7783  2009      jr      nz,#778e        ; (9)
7785  210400    ld      hl,#0004
7788  eb        ex      de,hl
7789  211600    ld      hl,#0016
778c  39        add     hl,sp
778d  73        ld      (hl),e
778e  1829      jr      #77b9           ; (41)
7790  211700    ld      hl,#0017
7793  39        add     hl,sp
7794  5e        ld      e,(hl)
7795  1600      ld      d,#00
7797  d5        push    de
7798  211700    ld      hl,#0017
779b  39        add     hl,sp
779c  5e        ld      e,(hl)
779d  1600      ld      d,#00
779f  e1        pop     hl
77a0  19        add     hl,de
77a1  eb        ex      de,hl
77a2  211500    ld      hl,#0015
77a5  39        add     hl,sp
77a6  73        ld      (hl),e
77a7  211500    ld      hl,#0015
77aa  39        add     hl,sp
77ab  7e        ld      a,(hl)
77ac  b7        or      a
77ad  2004      jr      nz,#77b3        ; (4)
77af  210000    ld      hl,#0000
77b2  c9        ret     

77b3  210200    ld      hl,#0002
77b6  c9        ret     

77b7  1800      jr      #77b9           ; (0)
77b9  211800    ld      hl,#0018
77bc  39        add     hl,sp
77bd  e5        push    hl
77be  215ed4    ld      hl,#d45e
77c1  cd2402    call    #0224
77c4  e1        pop     hl
77c5  cd2f02    call    #022f
77c8  c3af76    jp      #76af
77cb  215ed4    ld      hl,#d45e
77ce  cd2402    call    #0224
77d1  211800    ld      hl,#0018
77d4  39        add     hl,sp
77d5  cd1802    call    #0218
77d8  cdd602    call    #02d6
77db  cd1102    call    #0211
77de  88        adc     a,b
77df  13        inc     de
77e0  00        nop     
77e1  00        nop     
77e2  cdcc04    call    #04cc
77e5  2804      jr      z,#77eb         ; (4)
77e7  210100    ld      hl,#0001
77ea  c9        ret     

77eb  cd0d7a    call    #7a0d
77ee  eb        ex      de,hl
77ef  211200    ld      hl,#0012
77f2  39        add     hl,sp
77f3  73        ld      (hl),e
77f4  211200    ld      hl,#0012
77f7  39        add     hl,sp
77f8  5e        ld      e,(hl)
77f9  1600      ld      d,#00
77fb  210100    ld      hl,#0001
77fe  cd0601    call    #0106
7801  2804      jr      z,#7807         ; (4)
7803  21ff00    ld      hl,#00ff
7806  c9        ret     

7807  c3af76    jp      #76af
780a  c9        ret     

780b  0d78
780d  Edit Number : \0

781c  11deff    ld      de,#ffde
781f  cd6b05    call    #056b
7822  210a00    ld      hl,#000a
7825  39        add     hl,sp
7826  3600      ld      (hl),#00
7828  23        inc     hl
7829  3600      ld      (hl),#00
782b  212e00    ld      hl,#002e
782e  39        add     hl,sp
782f  5e        ld      e,(hl)
7830  23        inc     hl
7831  56        ld      d,(hl)
7832  212000    ld      hl,#0020
7835  39        add     hl,sp
7836  73        ld      (hl),e
7837  23        inc     hl
7838  72        ld      (hl),d
7839  213000    ld      hl,#0030
783c  39        add     hl,sp
783d  5e        ld      e,(hl)
783e  23        inc     hl
783f  56        ld      d,(hl)
7840  212200    ld      hl,#0022
7843  39        add     hl,sp
7844  73        ld      (hl),e
7845  23        inc     hl
7846  72        ld      (hl),d
7847  23        inc     hl
7848  3640      ld      (hl),#40
784a  23        inc     hl
784b  3601      ld      (hl),#01
784d  23        inc     hl
784e  3680      ld      (hl),#80
7850  23        inc     hl
7851  3600      ld      (hl),#00
7853  23        inc     hl
7854  3600      ld      (hl),#00
7856  2a0b78    ld      hl,(#780b)
7859  e5        push    hl
785a  cdcc05    call    #05cc
785d  d1        pop     de
785e  2600      ld      h,#00
7860  e5        push    hl
7861  2a0b78    ld      hl,(#780b)
7864  e5        push    hl
7865  212400    ld      hl,#0024
7868  39        add     hl,sp
7869  e5        push    hl
786a  cdc967    call    #67c9
786d  d1        pop     de
786e  d1        pop     de
786f  d1        pop     de
7870  cd7324    call    #2473
7873  212e00    ld      hl,#002e
7876  39        add     hl,sp
7877  5e        ld      e,(hl)
7878  23        inc     hl
7879  56        ld      d,(hl)
787a  214100    ld      hl,#0041
787d  19        add     hl,de
787e  eb        ex      de,hl
787f  212000    ld      hl,#0020
7882  39        add     hl,sp
7883  73        ld      (hl),e
7884  23        inc     hl
7885  72        ld      (hl),d
7886  cd0d7a    call    #7a0d
7889  eb        ex      de,hl
788a  212900    ld      hl,#0029
788d  39        add     hl,sp
788e  73        ld      (hl),e
788f  7b        ld      a,e
7890  feff      cp      #ff
7892  28f2      jr      z,#7886         ; (-14)
7894  7e        ld      a,(hl)
7895  fe57      cp      #57
7897  2033      jr      nz,#78cc        ; (51)
7899  210b00    ld      hl,#000b
789c  39        add     hl,sp
789d  7e        ld      a,(hl)
789e  b7        or      a
789f  28e5      jr      z,#7886         ; (-27)
78a1  213000    ld      hl,#0030
78a4  39        add     hl,sp
78a5  5e        ld      e,(hl)
78a6  23        inc     hl
78a7  56        ld      d,(hl)
78a8  210a00    ld      hl,#000a
78ab  19        add     hl,de
78ac  e5        push    hl
78ad  214001    ld      hl,#0140
78b0  e5        push    hl
78b1  213400    ld      hl,#0034
78b4  39        add     hl,sp
78b5  5e        ld      e,(hl)
78b6  23        inc     hl
78b7  56        ld      d,(hl)
78b8  d5        push    de
78b9  2b        dec     hl
78ba  2b        dec     hl
78bb  56        ld      d,(hl)
78bc  2b        dec     hl
78bd  5e        ld      e,(hl)
78be  d5        push    de
78bf  cd8a20    call    #208a
78c2  210800    ld      hl,#0008
78c5  39        add     hl,sp
78c6  f9        ld      sp,hl
78c7  210b00    ld      hl,#000b
78ca  39        add     hl,sp
78cb  c9        ret     

78cc  fe01      cp      #01
78ce  202d      jr      nz,#78fd        ; (45)
78d0  213000    ld      hl,#0030
78d3  39        add     hl,sp
78d4  5e        ld      e,(hl)
78d5  23        inc     hl
78d6  56        ld      d,(hl)
78d7  210a00    ld      hl,#000a
78da  19        add     hl,de
78db  e5        push    hl
78dc  214001    ld      hl,#0140
78df  e5        push    hl
78e0  213400    ld      hl,#0034
78e3  39        add     hl,sp
78e4  5e        ld      e,(hl)
78e5  23        inc     hl
78e6  56        ld      d,(hl)
78e7  d5        push    de
78e8  2b        dec     hl
78e9  2b        dec     hl
78ea  56        ld      d,(hl)
78eb  2b        dec     hl
78ec  5e        ld      e,(hl)
78ed  d5        push    de
78ee  cd8a20    call    #208a
78f1  210800    ld      hl,#0008
78f4  39        add     hl,sp
78f5  f9        ld      sp,hl
78f6  210b00    ld      hl,#000b
78f9  39        add     hl,sp
78fa  3600      ld      (hl),#00
78fc  c9        ret     

78fd  fe35      cp      #35
78ff  2059      jr      nz,#795a        ; (89)
7901  210a00    ld      hl,#000a
7904  39        add     hl,sp
7905  7e        ld      a,(hl)
7906  b7        or      a
7907  2806      jr      z,#790f         ; (6)
7909  e5        push    hl
790a  6e        ld      l,(hl)
790b  2b        dec     hl
790c  eb        ex      de,hl
790d  e1        pop     hl
790e  73        ld      (hl),e
790f  210a00    ld      hl,#000a
7912  39        add     hl,sp
7913  5e        ld      e,(hl)
7914  1600      ld      d,#00
7916  23        inc     hl
7917  19        add     hl,de
7918  72        ld      (hl),d
7919  212200    ld      hl,#0022
791c  39        add     hl,sp
791d  5e        ld      e,(hl)
791e  23        inc     hl
791f  56        ld      d,(hl)
7920  210a00    ld      hl,#000a
7923  19        add     hl,de
7924  e5        push    hl
7925  214001    ld      hl,#0140
7928  e5        push    hl
7929  212600    ld      hl,#0026
792c  39        add     hl,sp
792d  5e        ld      e,(hl)
792e  23        inc     hl
792f  56        ld      d,(hl)
7930  d5        push    de
7931  2b        dec     hl
7932  2b        dec     hl
7933  56        ld      d,(hl)
7934  2b        dec     hl
7935  5e        ld      e,(hl)
7936  d5        push    de
7937  cd8a20    call    #208a
793a  210800    ld      hl,#0008
793d  39        add     hl,sp
793e  f9        ld      sp,hl
793f  210a00    ld      hl,#000a
7942  39        add     hl,sp
7943  5e        ld      e,(hl)
7944  1600      ld      d,#00
7946  d5        push    de
7947  23        inc     hl
7948  e5        push    hl
7949  212400    ld      hl,#0024
794c  39        add     hl,sp
794d  e5        push    hl
794e  cdc967    call    #67c9
7951  d1        pop     de
7952  d1        pop     de
7953  d1        pop     de
7954  cd7324    call    #2473
7957  c38678    jp      #7886

795a  e6f0      and     #f0
795c  1f        rra     
795d  1f        rra     
795e  1f        rra     
795f  1f        rra     
7960  e60f      and     #0f
7962  210900    ld      hl,#0009
7965  39        add     hl,sp
7966  77        ld      (hl),a
7967  212900    ld      hl,#0029
796a  39        add     hl,sp
796b  7e        ld      a,(hl)
796c  e60f      and     #0f
796e  5f        ld      e,a
796f  210800    ld      hl,#0008
7972  39        add     hl,sp
7973  77        ld      (hl),a
7974  1600      ld      d,#00
7976  d5        push    de
7977  23        inc     hl
7978  5e        ld      e,(hl)
7979  eb        ex      de,hl
797a  29        add     hl,hl
797b  29        add     hl,hl
797c  29        add     hl,hl
797d  d1        pop     de
797e  19        add     hl,de
797f  11e766    ld      de,#66e7
7982  19        add     hl,de
7983  5e        ld      e,(hl)
7984  212900    ld      hl,#0029
7987  39        add     hl,sp
7988  73        ld      (hl),e
7989  7b        ld      a,e
798a  fe30      cp      #30
798c  3805      jr      c,#7993         ; (5)
798e  7e        ld      a,(hl)
798f  fe3a      cp      #3a
7991  380a      jr      c,#799d         ; (10)
7993  212900    ld      hl,#0029
7996  39        add     hl,sp
7997  7e        ld      a,(hl)
7998  fe2c      cp      #2c
799a  c28678    jp      nz,#7886
799d  210a00    ld      hl,#000a
79a0  39        add     hl,sp
79a1  1600      ld      d,#00
79a3  7e        ld      a,(hl)
79a4  fe14      cp      #14
79a6  ca8678    jp      z,#7886
79a9  212900    ld      hl,#0029
79ac  39        add     hl,sp
79ad  5e        ld      e,(hl)
79ae  d5        push    de
79af  210c00    ld      hl,#000c
79b2  39        add     hl,sp
79b3  5e        ld      e,(hl)
79b4  23        inc     hl
79b5  19        add     hl,de
79b6  d1        pop     de
79b7  73        ld      (hl),e
79b8  210a00    ld      hl,#000a
79bb  39        add     hl,sp
79bc  e5        push    hl
79bd  6e        ld      l,(hl)
79be  23        inc     hl
79bf  eb        ex      de,hl
79c0  e1        pop     hl
79c1  73        ld      (hl),e
79c2  210a00    ld      hl,#000a
79c5  39        add     hl,sp
79c6  5e        ld      e,(hl)
79c7  1600      ld      d,#00
79c9  23        inc     hl
79ca  19        add     hl,de
79cb  72        ld      (hl),d
79cc  212200    ld      hl,#0022
79cf  39        add     hl,sp
79d0  5e        ld      e,(hl)
79d1  23        inc     hl
79d2  56        ld      d,(hl)
79d3  210a00    ld      hl,#000a
79d6  19        add     hl,de
79d7  e5        push    hl
79d8  214001    ld      hl,#0140
79db  e5        push    hl
79dc  212600    ld      hl,#0026
79df  39        add     hl,sp
79e0  5e        ld      e,(hl)
79e1  23        inc     hl
79e2  56        ld      d,(hl)
79e3  d5        push    de
79e4  2b        dec     hl
79e5  2b        dec     hl
79e6  56        ld      d,(hl)
79e7  2b        dec     hl
79e8  5e        ld      e,(hl)
79e9  d5        push    de
79ea  cd8a20    call    #208a
79ed  210800    ld      hl,#0008
79f0  39        add     hl,sp
79f1  f9        ld      sp,hl
79f2  210a00    ld      hl,#000a
79f5  39        add     hl,sp
79f6  5e        ld      e,(hl)
79f7  1600      ld      d,#00
79f9  d5        push    de
79fa  23        inc     hl
79fb  e5        push    hl
79fc  212400    ld      hl,#0024
79ff  39        add     hl,sp
7a00  e5        push    hl
7a01  cdc967    call    #67c9
7a04  d1        pop     de
7a05  d1        pop     de
7a06  d1        pop     de
7a07  cd7324    call    #2473
7a0a  c38678    jp      #7886
7a0d  11fbff    ld      de,#fffb
7a10  cd6b05    call    #056b
7a13  3e00      ld      a,#00
7a15  3258f6    ld      (#f658),a
7a18  210b00    ld      hl,#000b
7a1b  39        add     hl,sp
7a1c  e5        push    hl
7a1d  cd9a0a    call    #0a9a
7a20  d1        pop     de
7a21  2831      jr      z,#7a54         ; (49)
7a23  210b00    ld      hl,#000b
7a26  39        add     hl,sp
7a27  5e        ld      e,(hl)
7a28  23        inc     hl
7a29  56        ld      d,(hl)
7a2a  2b        dec     hl
7a2b  2b        dec     hl
7a2c  2b        dec     hl
7a2d  73        ld      (hl),e
7a2e  23        inc     hl
7a2f  72        ld      (hl),d
7a30  7a        ld      a,d
7a31  e640      and     #40
7a33  2805      jr      z,#7a3a         ; (5)
7a35  3e01      ld      a,#01
7a37  3258f6    ld      (#f658),a

7a3a  210b00    ld      hl,#000b
7a3d  39        add     hl,sp
7a3e  5e        ld      e,(hl)
7a3f  23        inc     hl
7a40  7e        ld      a,(hl)
7a41  e601      and     #01
7a43  2807      jr      z,#7a4c         ; (7)

7a45  210800    ld      hl,#0008
7a48  39        add     hl,sp
7a49  73        ld      (hl),e
7a4a  180e      jr      #7a5a           ; (14)

7a4c  210800    ld      hl,#0008
7a4f  39        add     hl,sp
7a50  36ff      ld      (hl),#ff
7a52  1806      jr      #7a5a           ; (6)

7a54  210800    ld      hl,#0008
7a57  39        add     hl,sp
7a58  36ff      ld      (hl),#ff

7a5a  210800    ld      hl,#0008
7a5d  39        add     hl,sp
7a5e  5e        ld      e,(hl)
7a5f  1600      ld      d,#00
7a61  eb        ex      de,hl
7a62  c9        ret     

7a63  00        nop     
7a64  00        nop     
7a65  00        nop     
7a66  00        nop     
7a67  00        nop     
7a68  00        nop     
7a69  00        nop     
7a6a  00        nop     
7a6b  00        nop     
7a6c  00        nop     
7a6d  00        nop     
7a6e  00        nop     
7a6f  00        nop     
7a70  00        nop     
7a71  00        nop     
7a72  00        nop     
7a73  00        nop     
7a74  00        nop     
7a75  00        nop     
7a76  00        nop     
7a77  00        nop     
7a78  00        nop     
7a79  00        nop     
7a7a  00        nop     
7a7b  00        nop     
7a7c  00        nop     
7a7d  00        nop     
7a7e  00        nop     
7a7f  00        nop     
7a80  00        nop     
7a81  00        nop     
7a82  00        nop     
7a83  00        nop     
7a84  00        nop     
7a85  00        nop     
7a86  00        nop     
7a87  00        nop     
7a88  00        nop     
7a89  00        nop     
7a8a  00        nop     
7a8b  00        nop     
7a8c  00        nop     
7a8d  00        nop     
7a8e  00        nop     
7a8f  00        nop     
7a90  00        nop     
7a91  00        nop     
7a92  00        nop     
7a93  00        nop     
7a94  00        nop     
7a95  00        nop     
7a96  00        nop     
7a97  00        nop     
7a98  00        nop     
7a99  00        nop     
7a9a  00        nop     
7a9b  00        nop     
7a9c  00        nop     
7a9d  00        nop     
7a9e  00        nop     
7a9f  00        nop     
7aa0  00        nop     
7aa1  00        nop     
7aa2  00        nop     
7aa3  00        nop     
7aa4  00        nop     
7aa5  00        nop     
7aa6  00        nop     
7aa7  00        nop     
7aa8  00        nop     
7aa9  00        nop     
7aaa  00        nop     
7aab  00        nop     
7aac  00        nop     
7aad  00        nop     
7aae  00        nop     
7aaf  00        nop     
7ab0  00        nop     
7ab1  00        nop     
7ab2  00        nop     
7ab3  00        nop     
7ab4  00        nop     
7ab5  00        nop     
7ab6  00        nop     
7ab7  00        nop     
7ab8  00        nop     
7ab9  00        nop     
7aba  00        nop     
7abb  00        nop     
7abc  00        nop     
7abd  00        nop     
7abe  00        nop     
7abf  00        nop     
7ac0  00        nop     
7ac1  00        nop     
7ac2  00        nop     
7ac3  00        nop     
7ac4  00        nop     
7ac5  00        nop     
7ac6  00        nop     
7ac7  00        nop     
7ac8  00        nop     
7ac9  00        nop     
7aca  00        nop     
7acb  00        nop     
7acc  00        nop     
7acd  00        nop     
7ace  00        nop     
7acf  00        nop     
7ad0  00        nop     
7ad1  00        nop     
7ad2  00        nop     
7ad3  00        nop     
7ad4  00        nop     
7ad5  00        nop     
7ad6  00        nop     
7ad7  00        nop     
7ad8  00        nop     
7ad9  00        nop     
7ada  00        nop     
7adb  00        nop     
7adc  00        nop     
7add  00        nop     
7ade  00        nop     
7adf  00        nop     
7ae0  00        nop     
7ae1  00        nop     
7ae2  00        nop     
7ae3  00        nop     
7ae4  00        nop     
7ae5  00        nop     
7ae6  00        nop     
7ae7  00        nop     
7ae8  00        nop     
7ae9  00        nop     
7aea  00        nop     
7aeb  00        nop     
7aec  00        nop     
7aed  00        nop     
7aee  00        nop     
7aef  00        nop     
7af0  00        nop     
7af1  00        nop     
7af2  00        nop     
7af3  00        nop     
7af4  00        nop     
7af5  00        nop     
7af6  00        nop     
7af7  00        nop     
7af8  00        nop     
7af9  00        nop     
7afa  00        nop     
7afb  00        nop     
7afc  00        nop     
7afd  00        nop     
7afe  00        nop     
7aff  00        nop     
7b00  00        nop     
7b01  00        nop     
7b02  00        nop     
7b03  00        nop     
7b04  00        nop     
7b05  00        nop     
7b06  00        nop     
7b07  00        nop     
7b08  00        nop     
7b09  00        nop     
7b0a  00        nop     
7b0b  00        nop     
7b0c  00        nop     
7b0d  00        nop     
7b0e  00        nop     
7b0f  00        nop     
7b10  00        nop     
7b11  00        nop     
7b12  00        nop     
7b13  00        nop     
7b14  00        nop     
7b15  00        nop     
7b16  00        nop     
7b17  00        nop     
7b18  00        nop     
7b19  00        nop     
7b1a  00        nop     
7b1b  00        nop     
7b1c  00        nop     
7b1d  00        nop     
7b1e  00        nop     
7b1f  00        nop     
7b20  00        nop     
7b21  00        nop     
7b22  00        nop     
7b23  00        nop     
7b24  00        nop     
7b25  00        nop     
7b26  00        nop     
7b27  00        nop     
7b28  00        nop     
7b29  00        nop     
7b2a  00        nop     
7b2b  00        nop     
7b2c  00        nop     
7b2d  00        nop     
7b2e  00        nop     
7b2f  00        nop     
7b30  00        nop     
7b31  00        nop     
7b32  00        nop     
7b33  00        nop     
7b34  00        nop     
7b35  00        nop     
7b36  00        nop     
7b37  00        nop     
7b38  00        nop     
7b39  00        nop     
7b3a  00        nop     
7b3b  00        nop     
7b3c  00        nop     
7b3d  00        nop     
7b3e  00        nop     
7b3f  00        nop     
7b40  00        nop     
7b41  00        nop     
7b42  00        nop     
7b43  00        nop     
7b44  00        nop     
7b45  00        nop     
7b46  00        nop     
7b47  00        nop     
7b48  00        nop     
7b49  00        nop     
7b4a  00        nop     
7b4b  00        nop     
7b4c  00        nop     
7b4d  00        nop     
7b4e  00        nop     
7b4f  00        nop     
7b50  00        nop     
7b51  00        nop     
7b52  00        nop     
7b53  00        nop     
7b54  00        nop     
7b55  00        nop     
7b56  00        nop     
7b57  00        nop     
7b58  00        nop     
7b59  00        nop     
7b5a  00        nop     
7b5b  00        nop     
7b5c  00        nop     
7b5d  00        nop     
7b5e  00        nop     
7b5f  00        nop     
7b60  00        nop     
7b61  00        nop     
7b62  00        nop     
7b63  00        nop     
7b64  00        nop     
7b65  00        nop     
7b66  00        nop     
7b67  00        nop     
7b68  00        nop     
7b69  00        nop     
7b6a  00        nop     
7b6b  00        nop     
7b6c  00        nop     
7b6d  00        nop     
7b6e  00        nop     
7b6f  00        nop     
7b70  00        nop     
7b71  00        nop     
7b72  00        nop     
7b73  00        nop     
7b74  00        nop     
7b75  00        nop     
7b76  00        nop     
7b77  00        nop     
7b78  00        nop     
7b79  00        nop     
7b7a  00        nop     
7b7b  00        nop     
7b7c  00        nop     
7b7d  00        nop     
7b7e  00        nop     
7b7f  00        nop     
7b80  00        nop     
7b81  00        nop     
7b82  00        nop     
7b83  00        nop     
7b84  00        nop     
7b85  00        nop     
7b86  00        nop     
7b87  00        nop     
7b88  00        nop     
7b89  00        nop     
7b8a  00        nop     
7b8b  00        nop     
7b8c  00        nop     
7b8d  00        nop     
7b8e  00        nop     
7b8f  00        nop     
7b90  00        nop     
7b91  00        nop     
7b92  00        nop     
7b93  00        nop     
7b94  00        nop     
7b95  00        nop     
7b96  00        nop     
7b97  00        nop     
7b98  00        nop     
7b99  00        nop     
7b9a  00        nop     
7b9b  00        nop     
7b9c  00        nop     
7b9d  00        nop     
7b9e  00        nop     
7b9f  00        nop     
7ba0  00        nop     
7ba1  00        nop     
7ba2  00        nop     
7ba3  00        nop     
7ba4  00        nop     
7ba5  00        nop     
7ba6  00        nop     
7ba7  00        nop     
7ba8  00        nop     
7ba9  00        nop     
7baa  00        nop     
7bab  00        nop     
7bac  00        nop     
7bad  00        nop     
7bae  00        nop     
7baf  00        nop     
7bb0  00        nop     
7bb1  00        nop     
7bb2  00        nop     
7bb3  00        nop     
7bb4  00        nop     
7bb5  00        nop     
7bb6  00        nop     
7bb7  00        nop     
7bb8  00        nop     
7bb9  00        nop     
7bba  00        nop     
7bbb  00        nop     
7bbc  00        nop     
7bbd  00        nop     
7bbe  00        nop     
7bbf  00        nop     
7bc0  00        nop     
7bc1  00        nop     
7bc2  00        nop     
7bc3  00        nop     
7bc4  00        nop     
7bc5  00        nop     
7bc6  00        nop     
7bc7  00        nop     
7bc8  00        nop     
7bc9  00        nop     
7bca  00        nop     
7bcb  00        nop     
7bcc  00        nop     
7bcd  00        nop     
7bce  00        nop     
7bcf  00        nop     
7bd0  00        nop     
7bd1  00        nop     
7bd2  00        nop     
7bd3  00        nop     
7bd4  00        nop     
7bd5  00        nop     
7bd6  00        nop     
7bd7  00        nop     
7bd8  00        nop     
7bd9  00        nop     
7bda  00        nop     
7bdb  00        nop     
7bdc  00        nop     
7bdd  00        nop     
7bde  00        nop     
7bdf  00        nop     
7be0  00        nop     
7be1  00        nop     
7be2  00        nop     
7be3  00        nop     
7be4  00        nop     
7be5  00        nop     
7be6  00        nop     
7be7  00        nop     
7be8  00        nop     
7be9  00        nop     
7bea  00        nop     
7beb  00        nop     
7bec  00        nop     
7bed  00        nop     
7bee  00        nop     
7bef  00        nop     
7bf0  00        nop     
7bf1  00        nop     
7bf2  00        nop     
7bf3  00        nop     
7bf4  00        nop     
7bf5  00        nop     
7bf6  00        nop     
7bf7  00        nop     
7bf8  00        nop     
7bf9  00        nop     
7bfa  00        nop     
7bfb  00        nop     
7bfc  00        nop     
7bfd  00        nop     
7bfe  00        nop     
7bff  00        nop     
7c00  00        nop     
7c01  00        nop     
7c02  00        nop     
7c03  00        nop     
7c04  00        nop     
7c05  00        nop     
7c06  00        nop     
7c07  00        nop     
7c08  00        nop     
7c09  00        nop     
7c0a  00        nop     
7c0b  00        nop     
7c0c  00        nop     
7c0d  00        nop     
7c0e  00        nop     
7c0f  00        nop     
7c10  00        nop     
7c11  00        nop     
7c12  00        nop     
7c13  00        nop     
7c14  00        nop     
7c15  00        nop     
7c16  00        nop     
7c17  00        nop     
7c18  00        nop     
7c19  00        nop     
7c1a  00        nop     
7c1b  00        nop     
7c1c  00        nop     
7c1d  00        nop     
7c1e  00        nop     
7c1f  00        nop     
7c20  00        nop     
7c21  00        nop     
7c22  00        nop     
7c23  00        nop     
7c24  00        nop     
7c25  00        nop     
7c26  00        nop     
7c27  00        nop     
7c28  00        nop     
7c29  00        nop     
7c2a  00        nop     
7c2b  00        nop     
7c2c  00        nop     
7c2d  00        nop     
7c2e  00        nop     
7c2f  00        nop     
7c30  00        nop     
7c31  00        nop     
7c32  00        nop     
7c33  00        nop     
7c34  00        nop     
7c35  00        nop     
7c36  00        nop     
7c37  00        nop     
7c38  00        nop     
7c39  00        nop     
7c3a  00        nop     
7c3b  00        nop     
7c3c  00        nop     
7c3d  00        nop     
7c3e  00        nop     
7c3f  00        nop     
7c40  00        nop     
7c41  00        nop     
7c42  00        nop     
7c43  00        nop     
7c44  00        nop     
7c45  00        nop     
7c46  00        nop     
7c47  00        nop     
7c48  00        nop     
7c49  00        nop     
7c4a  00        nop     
7c4b  00        nop     
7c4c  00        nop     
7c4d  00        nop     
7c4e  00        nop     
7c4f  00        nop     
7c50  00        nop     
7c51  00        nop     
7c52  00        nop     
7c53  00        nop     
7c54  00        nop     
7c55  00        nop     
7c56  00        nop     
7c57  00        nop     
7c58  00        nop     
7c59  00        nop     
7c5a  00        nop     
7c5b  00        nop     
7c5c  00        nop     
7c5d  00        nop     
7c5e  00        nop     
7c5f  00        nop     
7c60  00        nop     
7c61  00        nop     
7c62  00        nop     
7c63  00        nop     
7c64  00        nop     
7c65  00        nop     
7c66  00        nop     
7c67  00        nop     
7c68  00        nop     
7c69  00        nop     
7c6a  00        nop     
7c6b  00        nop     
7c6c  00        nop     
7c6d  00        nop     
7c6e  00        nop     
7c6f  00        nop     
7c70  00        nop     
7c71  00        nop     
7c72  00        nop     
7c73  00        nop     
7c74  00        nop     
7c75  00        nop     
7c76  00        nop     
7c77  00        nop     
7c78  00        nop     
7c79  00        nop     
7c7a  00        nop     
7c7b  00        nop     
7c7c  00        nop     
7c7d  00        nop     
7c7e  00        nop     
7c7f  00        nop     
7c80  00        nop     
7c81  00        nop     
7c82  00        nop     
7c83  00        nop     
7c84  00        nop     
7c85  00        nop     
7c86  00        nop     
7c87  00        nop     
7c88  00        nop     
7c89  00        nop     
7c8a  00        nop     
7c8b  00        nop     
7c8c  00        nop     
7c8d  00        nop     
7c8e  00        nop     
7c8f  00        nop     
7c90  00        nop     
7c91  00        nop     
7c92  00        nop     
7c93  00        nop     
7c94  00        nop     
7c95  00        nop     
7c96  00        nop     
7c97  00        nop     
7c98  00        nop     
7c99  00        nop     
7c9a  00        nop     
7c9b  00        nop     
7c9c  00        nop     
7c9d  00        nop     
7c9e  00        nop     
7c9f  00        nop     
7ca0  00        nop     
7ca1  00        nop     
7ca2  00        nop     
7ca3  00        nop     
7ca4  00        nop     
7ca5  00        nop     
7ca6  00        nop     
7ca7  00        nop     
7ca8  00        nop     
7ca9  00        nop     
7caa  00        nop     
7cab  00        nop     
7cac  00        nop     
7cad  00        nop     
7cae  00        nop     
7caf  00        nop     
7cb0  00        nop     
7cb1  00        nop     
7cb2  00        nop     
7cb3  00        nop     
7cb4  00        nop     
7cb5  00        nop     
7cb6  00        nop     
7cb7  00        nop     
7cb8  00        nop     
7cb9  00        nop     
7cba  00        nop     
7cbb  00        nop     
7cbc  00        nop     
7cbd  00        nop     
7cbe  00        nop     
7cbf  00        nop     
7cc0  00        nop     
7cc1  00        nop     
7cc2  00        nop     
7cc3  00        nop     
7cc4  00        nop     
7cc5  00        nop     
7cc6  00        nop     
7cc7  00        nop     
7cc8  00        nop     
7cc9  00        nop     
7cca  00        nop     
7ccb  00        nop     
7ccc  00        nop     
7ccd  00        nop     
7cce  00        nop     
7ccf  00        nop     
7cd0  00        nop     
7cd1  00        nop     
7cd2  00        nop     
7cd3  00        nop     
7cd4  00        nop     
7cd5  00        nop     
7cd6  00        nop     
7cd7  00        nop     
7cd8  00        nop     
7cd9  00        nop     
7cda  00        nop     
7cdb  00        nop     
7cdc  00        nop     
7cdd  00        nop     
7cde  00        nop     
7cdf  00        nop     
7ce0  00        nop     
7ce1  00        nop     
7ce2  00        nop     
7ce3  00        nop     
7ce4  00        nop     
7ce5  00        nop     
7ce6  00        nop     
7ce7  00        nop     
7ce8  00        nop     
7ce9  00        nop     
7cea  00        nop     
7ceb  00        nop     
7cec  00        nop     
7ced  00        nop     
7cee  00        nop     
7cef  00        nop     
7cf0  00        nop     
7cf1  00        nop     
7cf2  00        nop     
7cf3  00        nop     
7cf4  00        nop     
7cf5  00        nop     
7cf6  00        nop     
7cf7  00        nop     
7cf8  00        nop     
7cf9  00        nop     
7cfa  00        nop     
7cfb  00        nop     
7cfc  00        nop     
7cfd  00        nop     
7cfe  00        nop     
7cff  00        nop     
7d00  00        nop     
7d01  00        nop     
7d02  00        nop     
7d03  00        nop     
7d04  00        nop     
7d05  00        nop     
7d06  00        nop     
7d07  00        nop     
7d08  00        nop     
7d09  00        nop     
7d0a  00        nop     
7d0b  00        nop     
7d0c  00        nop     
7d0d  00        nop     
7d0e  00        nop     
7d0f  00        nop     
7d10  00        nop     
7d11  00        nop     
7d12  00        nop     
7d13  00        nop     
7d14  00        nop     
7d15  00        nop     
7d16  00        nop     
7d17  00        nop     
7d18  00        nop     
7d19  00        nop     
7d1a  00        nop     
7d1b  00        nop     
7d1c  00        nop     
7d1d  00        nop     
7d1e  00        nop     
7d1f  00        nop     
7d20  00        nop     
7d21  00        nop     
7d22  00        nop     
7d23  00        nop     
7d24  00        nop     
7d25  00        nop     
7d26  00        nop     
7d27  00        nop     
7d28  00        nop     
7d29  00        nop     
7d2a  00        nop     
7d2b  00        nop     
7d2c  00        nop     
7d2d  00        nop     
7d2e  00        nop     
7d2f  00        nop     
7d30  00        nop     
7d31  00        nop     
7d32  00        nop     
7d33  00        nop     
7d34  00        nop     
7d35  00        nop     
7d36  00        nop     
7d37  00        nop     
7d38  00        nop     
7d39  00        nop     
7d3a  00        nop     
7d3b  00        nop     
7d3c  00        nop     
7d3d  00        nop     
7d3e  00        nop     
7d3f  00        nop     
7d40  00        nop     
7d41  00        nop     
7d42  00        nop     
7d43  00        nop     
7d44  00        nop     
7d45  00        nop     
7d46  00        nop     
7d47  00        nop     
7d48  00        nop     
7d49  00        nop     
7d4a  00        nop     
7d4b  00        nop     
7d4c  00        nop     
7d4d  00        nop     
7d4e  00        nop     
7d4f  00        nop     
7d50  00        nop     
7d51  00        nop     
7d52  00        nop     
7d53  00        nop     
7d54  00        nop     
7d55  00        nop     
7d56  00        nop     
7d57  00        nop     
7d58  00        nop     
7d59  00        nop     
7d5a  00        nop     
7d5b  00        nop     
7d5c  00        nop     
7d5d  00        nop     
7d5e  00        nop     
7d5f  00        nop     
7d60  00        nop     
7d61  00        nop     
7d62  00        nop     
7d63  00        nop     
7d64  00        nop     
7d65  00        nop     
7d66  00        nop     
7d67  00        nop     
7d68  00        nop     
7d69  00        nop     
7d6a  00        nop     
7d6b  00        nop     
7d6c  00        nop     
7d6d  00        nop     
7d6e  00        nop     
7d6f  00        nop     
7d70  00        nop     
7d71  00        nop     
7d72  00        nop     
7d73  00        nop     
7d74  00        nop     
7d75  00        nop     
7d76  00        nop     
7d77  00        nop     
7d78  00        nop     
7d79  00        nop     
7d7a  00        nop     
7d7b  00        nop     
7d7c  00        nop     
7d7d  00        nop     
7d7e  00        nop     
7d7f  00        nop     
7d80  00        nop     
7d81  00        nop     
7d82  00        nop     
7d83  00        nop     
7d84  00        nop     
7d85  00        nop     
7d86  00        nop     
7d87  00        nop     
7d88  00        nop     
7d89  00        nop     
7d8a  00        nop     
7d8b  00        nop     
7d8c  00        nop     
7d8d  00        nop     
7d8e  00        nop     
7d8f  00        nop     
7d90  00        nop     
7d91  00        nop     
7d92  00        nop     
7d93  00        nop     
7d94  00        nop     
7d95  00        nop     
7d96  00        nop     
7d97  00        nop     
7d98  00        nop     
7d99  00        nop     
7d9a  00        nop     
7d9b  00        nop     
7d9c  00        nop     
7d9d  00        nop     
7d9e  00        nop     
7d9f  00        nop     
7da0  00        nop     
7da1  00        nop     
7da2  00        nop     
7da3  00        nop     
7da4  00        nop     
7da5  00        nop     
7da6  00        nop     
7da7  00        nop     
7da8  00        nop     
7da9  00        nop     
7daa  00        nop     
7dab  00        nop     
7dac  00        nop     
7dad  00        nop     
7dae  00        nop     
7daf  00        nop     
7db0  00        nop     
7db1  00        nop     
7db2  00        nop     
7db3  00        nop     
7db4  00        nop     
7db5  00        nop     
7db6  00        nop     
7db7  00        nop     
7db8  00        nop     
7db9  00        nop     
7dba  00        nop     
7dbb  00        nop     
7dbc  00        nop     
7dbd  00        nop     
7dbe  00        nop     
7dbf  00        nop     
7dc0  00        nop     
7dc1  00        nop     
7dc2  00        nop     
7dc3  00        nop     
7dc4  00        nop     
7dc5  00        nop     
7dc6  00        nop     
7dc7  00        nop     
7dc8  00        nop     
7dc9  00        nop     
7dca  00        nop     
7dcb  00        nop     
7dcc  00        nop     
7dcd  00        nop     
7dce  00        nop     
7dcf  00        nop     
7dd0  00        nop     
7dd1  00        nop     
7dd2  00        nop     
7dd3  00        nop     
7dd4  00        nop     
7dd5  00        nop     
7dd6  00        nop     
7dd7  00        nop     
7dd8  00        nop     
7dd9  00        nop     
7dda  00        nop     
7ddb  00        nop     
7ddc  00        nop     
7ddd  00        nop     
7dde  00        nop     
7ddf  00        nop     
7de0  00        nop     
7de1  00        nop     
7de2  00        nop     
7de3  00        nop     
7de4  00        nop     
7de5  00        nop     
7de6  00        nop     
7de7  00        nop     
7de8  00        nop     
7de9  00        nop     
7dea  00        nop     
7deb  00        nop     
7dec  00        nop     
7ded  00        nop     
7dee  00        nop     
7def  00        nop     
7df0  00        nop     
7df1  00        nop     
7df2  00        nop     
7df3  00        nop     
7df4  00        nop     
7df5  00        nop     
7df6  00        nop     
7df7  00        nop     
7df8  00        nop     
7df9  00        nop     
7dfa  00        nop     
7dfb  00        nop     
7dfc  00        nop     
7dfd  00        nop     
7dfe  00        nop     
7dff  00        nop     
7e00  00        nop     
7e01  00        nop     
7e02  00        nop     
7e03  00        nop     
7e04  00        nop     
7e05  00        nop     
7e06  00        nop     
7e07  00        nop     
7e08  00        nop     
7e09  00        nop     
7e0a  00        nop     
7e0b  00        nop     
7e0c  00        nop     
7e0d  00        nop     
7e0e  00        nop     
7e0f  00        nop     
7e10  00        nop     
7e11  00        nop     
7e12  00        nop     
7e13  00        nop     
7e14  00        nop     
7e15  00        nop     
7e16  00        nop     
7e17  00        nop     
7e18  00        nop     
7e19  00        nop     
7e1a  00        nop     
7e1b  00        nop     
7e1c  00        nop     
7e1d  00        nop     
7e1e  00        nop     
7e1f  00        nop     
7e20  00        nop     
7e21  00        nop     
7e22  00        nop     
7e23  00        nop     
7e24  00        nop     
7e25  00        nop     
7e26  00        nop     
7e27  00        nop     
7e28  00        nop     
7e29  00        nop     
7e2a  00        nop     
7e2b  00        nop     
7e2c  00        nop     
7e2d  00        nop     
7e2e  00        nop     
7e2f  00        nop     
7e30  00        nop     
7e31  00        nop     
7e32  00        nop     
7e33  00        nop     
7e34  00        nop     
7e35  00        nop     
7e36  00        nop     
7e37  00        nop     
7e38  00        nop     
7e39  00        nop     
7e3a  00        nop     
7e3b  00        nop     
7e3c  00        nop     
7e3d  00        nop     
7e3e  00        nop     
7e3f  00        nop     
7e40  00        nop     
7e41  00        nop     
7e42  00        nop     
7e43  00        nop     
7e44  00        nop     
7e45  00        nop     
7e46  00        nop     
7e47  00        nop     
7e48  00        nop     
7e49  00        nop     
7e4a  00        nop     
7e4b  00        nop     
7e4c  00        nop     
7e4d  00        nop     
7e4e  00        nop     
7e4f  00        nop     
7e50  00        nop     
7e51  00        nop     
7e52  00        nop     
7e53  00        nop     
7e54  00        nop     
7e55  00        nop     
7e56  00        nop     
7e57  00        nop     
7e58  00        nop     
7e59  00        nop     
7e5a  00        nop     
7e5b  00        nop     
7e5c  00        nop     
7e5d  00        nop     
7e5e  00        nop     
7e5f  00        nop     
7e60  00        nop     
7e61  00        nop     
7e62  00        nop     
7e63  00        nop     
7e64  00        nop     
7e65  00        nop     
7e66  00        nop     
7e67  00        nop     
7e68  00        nop     
7e69  00        nop     
7e6a  00        nop     
7e6b  00        nop     
7e6c  00        nop     
7e6d  00        nop     
7e6e  00        nop     
7e6f  00        nop     
7e70  00        nop     
7e71  00        nop     
7e72  00        nop     
7e73  00        nop     
7e74  00        nop     
7e75  00        nop     
7e76  00        nop     
7e77  00        nop     
7e78  00        nop     
7e79  00        nop     
7e7a  00        nop     
7e7b  00        nop     
7e7c  00        nop     
7e7d  00        nop     
7e7e  00        nop     
7e7f  00        nop     
7e80  00        nop     
7e81  00        nop     
7e82  00        nop     
7e83  00        nop     
7e84  00        nop     
7e85  00        nop     
7e86  00        nop     
7e87  00        nop     
7e88  00        nop     
7e89  00        nop     
7e8a  00        nop     
7e8b  00        nop     
7e8c  00        nop     
7e8d  00        nop     
7e8e  00        nop     
7e8f  00        nop     
7e90  00        nop     
7e91  00        nop     
7e92  00        nop     
7e93  00        nop     
7e94  00        nop     
7e95  00        nop     
7e96  00        nop     
7e97  00        nop     
7e98  00        nop     
7e99  00        nop     
7e9a  00        nop     
7e9b  00        nop     
7e9c  00        nop     
7e9d  00        nop     
7e9e  00        nop     
7e9f  00        nop     
7ea0  00        nop     
7ea1  00        nop     
7ea2  00        nop     
7ea3  00        nop     
7ea4  00        nop     
7ea5  00        nop     
7ea6  00        nop     
7ea7  00        nop     
7ea8  00        nop     
7ea9  00        nop     
7eaa  00        nop     
7eab  00        nop     
7eac  00        nop     
7ead  00        nop     
7eae  00        nop     
7eaf  00        nop     
7eb0  00        nop     
7eb1  00        nop     
7eb2  00        nop     
7eb3  00        nop     
7eb4  00        nop     
7eb5  00        nop     
7eb6  00        nop     
7eb7  00        nop     
7eb8  00        nop     
7eb9  00        nop     
7eba  00        nop     
7ebb  00        nop     
7ebc  00        nop     
7ebd  00        nop     
7ebe  00        nop     
7ebf  00        nop     
7ec0  00        nop     
7ec1  00        nop     
7ec2  00        nop     
7ec3  00        nop     
7ec4  00        nop     
7ec5  00        nop     
7ec6  00        nop     
7ec7  00        nop     
7ec8  00        nop     
7ec9  00        nop     
7eca  00        nop     
7ecb  00        nop     
7ecc  00        nop     
7ecd  00        nop     
7ece  00        nop     
7ecf  00        nop     
7ed0  00        nop     
7ed1  00        nop     
7ed2  00        nop     
7ed3  00        nop     
7ed4  00        nop     
7ed5  00        nop     
7ed6  00        nop     
7ed7  00        nop     
7ed8  00        nop     
7ed9  00        nop     
7eda  00        nop     
7edb  00        nop     
7edc  00        nop     
7edd  00        nop     
7ede  00        nop     
7edf  00        nop     
7ee0  00        nop     
7ee1  00        nop     
7ee2  00        nop     
7ee3  00        nop     
7ee4  00        nop     
7ee5  00        nop     
7ee6  00        nop     
7ee7  00        nop     
7ee8  00        nop     
7ee9  00        nop     
7eea  00        nop     
7eeb  00        nop     
7eec  00        nop     
7eed  00        nop     
7eee  00        nop     
7eef  00        nop     
7ef0  00        nop     
7ef1  00        nop     
7ef2  00        nop     
7ef3  00        nop     
7ef4  00        nop     
7ef5  00        nop     
7ef6  00        nop     
7ef7  00        nop     
7ef8  00        nop     
7ef9  00        nop     
7efa  00        nop     
7efb  00        nop     
7efc  00        nop     
7efd  00        nop     
7efe  00        nop     
7eff  00        nop     
7f00  00        nop     
7f01  00        nop     
7f02  00        nop     
7f03  00        nop     
7f04  00        nop     
7f05  00        nop     
7f06  00        nop     
7f07  00        nop     
7f08  00        nop     
7f09  00        nop     
7f0a  00        nop     
7f0b  00        nop     
7f0c  00        nop     
7f0d  00        nop     
7f0e  00        nop     
7f0f  00        nop     
7f10  00        nop     
7f11  00        nop     
7f12  00        nop     
7f13  00        nop     
7f14  00        nop     
7f15  00        nop     
7f16  00        nop     
7f17  00        nop     
7f18  00        nop     
7f19  00        nop     
7f1a  00        nop     
7f1b  00        nop     
7f1c  00        nop     
7f1d  00        nop     
7f1e  00        nop     
7f1f  00        nop     
7f20  00        nop     
7f21  00        nop     
7f22  00        nop     
7f23  00        nop     
7f24  00        nop     
7f25  00        nop     
7f26  00        nop     
7f27  00        nop     
7f28  00        nop     
7f29  00        nop     
7f2a  00        nop     
7f2b  00        nop     
7f2c  00        nop     
7f2d  00        nop     
7f2e  00        nop     
7f2f  00        nop     
7f30  00        nop     
7f31  00        nop     
7f32  00        nop     
7f33  00        nop     
7f34  00        nop     
7f35  00        nop     
7f36  00        nop     
7f37  00        nop     
7f38  00        nop     
7f39  00        nop     
7f3a  00        nop     
7f3b  00        nop     
7f3c  00        nop     
7f3d  00        nop     
7f3e  00        nop     
7f3f  00        nop     
7f40  00        nop     
7f41  00        nop     
7f42  00        nop     
7f43  00        nop     
7f44  00        nop     
7f45  00        nop     
7f46  00        nop     
7f47  00        nop     
7f48  00        nop     
7f49  00        nop     
7f4a  00        nop     
7f4b  00        nop     
7f4c  00        nop     
7f4d  00        nop     
7f4e  00        nop     
7f4f  00        nop     
7f50  00        nop     
7f51  00        nop     
7f52  00        nop     
7f53  00        nop     
7f54  00        nop     
7f55  00        nop     
7f56  00        nop     
7f57  00        nop     
7f58  00        nop     
7f59  00        nop     
7f5a  00        nop     
7f5b  00        nop     
7f5c  00        nop     
7f5d  00        nop     
7f5e  00        nop     
7f5f  00        nop     
7f60  00        nop     
7f61  00        nop     
7f62  00        nop     
7f63  00        nop     
7f64  00        nop     
7f65  00        nop     
7f66  00        nop     
7f67  00        nop     
7f68  00        nop     
7f69  00        nop     
7f6a  00        nop     
7f6b  00        nop     
7f6c  00        nop     
7f6d  00        nop     
7f6e  00        nop     
7f6f  00        nop     
7f70  00        nop     
7f71  00        nop     
7f72  00        nop     
7f73  00        nop     
7f74  00        nop     
7f75  00        nop     
7f76  00        nop     
7f77  00        nop     
7f78  00        nop     
7f79  00        nop     
7f7a  00        nop     
7f7b  00        nop     
7f7c  00        nop     
7f7d  00        nop     
7f7e  00        nop     
7f7f  00        nop     
7f80  00        nop     
7f81  00        nop     
7f82  00        nop     
7f83  00        nop     
7f84  00        nop     
7f85  00        nop     
7f86  00        nop     
7f87  00        nop     
7f88  00        nop     
7f89  00        nop     
7f8a  00        nop     
7f8b  00        nop     
7f8c  00        nop     
7f8d  00        nop     
7f8e  00        nop     
7f8f  00        nop     
7f90  00        nop     
7f91  00        nop     
7f92  00        nop     
7f93  00        nop     
7f94  00        nop     
7f95  00        nop     
7f96  00        nop     
7f97  00        nop     
7f98  00        nop     
7f99  00        nop     
7f9a  00        nop     
7f9b  00        nop     
7f9c  00        nop     
7f9d  00        nop     
7f9e  00        nop     
7f9f  00        nop     
7fa0  00        nop     
7fa1  00        nop     
7fa2  00        nop     
7fa3  00        nop     
7fa4  00        nop     
7fa5  00        nop     
7fa6  00        nop     
7fa7  00        nop     
7fa8  00        nop     
7fa9  00        nop     
7faa  00        nop     
7fab  00        nop     
7fac  00        nop     
7fad  00        nop     
7fae  00        nop     
7faf  00        nop     
7fb0  00        nop     
7fb1  00        nop     
7fb2  00        nop     
7fb3  00        nop     
7fb4  00        nop     
7fb5  00        nop     
7fb6  00        nop     
7fb7  00        nop     
7fb8  00        nop     
7fb9  00        nop     
7fba  00        nop     
7fbb  00        nop     
7fbc  00        nop     
7fbd  00        nop     
7fbe  00        nop     
7fbf  00        nop     
7fc0  00        nop     
7fc1  00        nop     
7fc2  00        nop     
7fc3  00        nop     
7fc4  00        nop     
7fc5  00        nop     
7fc6  00        nop     
7fc7  00        nop     
7fc8  00        nop     
7fc9  00        nop     
7fca  00        nop     
7fcb  00        nop     
7fcc  00        nop     
7fcd  00        nop     
7fce  00        nop     
7fcf  00        nop     
7fd0  00        nop     
7fd1  00        nop     
7fd2  00        nop     
7fd3  00        nop     
7fd4  00        nop     
7fd5  00        nop     
7fd6  00        nop     
7fd7  00        nop     
7fd8  00        nop     
7fd9  00        nop     
7fda  00        nop     
7fdb  00        nop     
7fdc  00        nop     
7fdd  00        nop     
7fde  00        nop     
7fdf  00        nop     
7fe0  00        nop     
7fe1  00        nop     
7fe2  00        nop     
7fe3  00        nop     
7fe4  00        nop     
7fe5  00        nop     
7fe6  00        nop     
7fe7  00        nop     
7fe8  00        nop     
7fe9  00        nop     
7fea  00        nop     
7feb  00        nop     
7fec  00        nop     
7fed  00        nop     
7fee  00        nop     
7fef  00        nop     
7ff0  00        nop     
7ff1  00        nop     
7ff2  00        nop     
7ff3  00        nop     
7ff4  00        nop     
7ff5  00        nop     
7ff6  00        nop     
7ff7  00        nop     
7ff8  00        nop     
7ff9  00        nop     
7ffa  00        nop     
7ffb  00        nop     
7ffc  00        nop     
7ffd  00        nop     
7ffe  00        nop     
7fff  00        nop     
