
out/a.elf:     file format elf32-m68k


Disassembly of section .text:

00000000 <_start>:
extern void (*__init_array_start[])() __attribute__((weak));
extern void (*__init_array_end[])() __attribute__((weak));
extern void (*__fini_array_start[])() __attribute__((weak));
extern void (*__fini_array_end[])() __attribute__((weak));

__attribute__((used)) __attribute__((section(".text.unlikely"))) void _start() {
   0:	       movem.l d2-d3/a2,-(sp)
	// initialize globals, ctors etc.
	unsigned long count;
	unsigned long i;

	count = __preinit_array_end - __preinit_array_start;
   4:	       move.l #11028,d3
   a:	       subi.l #11028,d3
  10:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  12:	       move.l #11028,d0
  18:	       cmpi.l #11028,d0
  1e:	/----- beq.s 32 <_start+0x32>
  20:	|      lea 2b14 <DOSBase>,a2
  26:	|      moveq #0,d2
		__preinit_array_start[i]();
  28:	|  /-> movea.l (a2)+,a0
  2a:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  2c:	|  |   addq.l #1,d2
  2e:	|  |   cmp.l d3,d2
  30:	|  \-- bcs.s 28 <_start+0x28>

	count = __init_array_end - __init_array_start;
  32:	\----> move.l #11028,d3
  38:	       subi.l #11028,d3
  3e:	       asr.l #2,d3
	for (i = 0; i < count; i++)
  40:	       move.l #11028,d0
  46:	       cmpi.l #11028,d0
  4c:	/----- beq.s 60 <_start+0x60>
  4e:	|      lea 2b14 <DOSBase>,a2
  54:	|      moveq #0,d2
		__init_array_start[i]();
  56:	|  /-> movea.l (a2)+,a0
  58:	|  |   jsr (a0)
	for (i = 0; i < count; i++)
  5a:	|  |   addq.l #1,d2
  5c:	|  |   cmp.l d3,d2
  5e:	|  \-- bcs.s 56 <_start+0x56>

	main();
  60:	\----> jsr 8c <main>

	// call dtors
	count = __fini_array_end - __fini_array_start;
  66:	       move.l #11028,d2
  6c:	       subi.l #11028,d2
  72:	       asr.l #2,d2
	for (i = count; i > 0; i--)
  74:	/----- beq.s 86 <_start+0x86>
  76:	|      lea 2b14 <DOSBase>,a2
		__fini_array_start[i - 1]();
  7c:	|  /-> subq.l #1,d2
  7e:	|  |   movea.l -(a2),a0
  80:	|  |   jsr (a0)
	for (i = count; i > 0; i--)
  82:	|  |   tst.l d2
  84:	|  \-- bne.s 7c <_start+0x7c>
}
  86:	\----> movem.l (sp)+,d2-d3/a2
  8a:	       rts

0000008c <main>:
}

static const UWORD stuffChar[] = {0x16c0, 0x4e75};

int main(void)
{
  8c:	                                                       lea -520(sp),sp
  90:	                                                       movem.l d2-d7/a2-a6,-(sp)

    SysBase = *((struct Library **)4UL);
  94:	                                                       movea.l 4 <_start+0x4>,a6
  98:	                                                       move.l a6,2b1c <SysBase>

    IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library", 37);
  9e:	                                                       lea a13 <doy_return+0x4b>,a1
  a4:	                                                       moveq #37,d0
  a6:	                                                       jsr -552(a6)
  aa:	                                                       move.l d0,2b18 <IntuitionBase>
    if (!IntuitionBase)
  b0:	/----------------------------------------------------- beq.w 47c <main+0x3f0>
    {
        return RETURN_FAIL;
    }

    DOSBase = OpenLibrary("dos.library", 0);
  b4:	|                                                      movea.l 2b1c <SysBase>,a6
  ba:	|                                                      lea a25 <doy_return+0x5d>,a1
  c0:	|                                                      moveq #0,d0
  c2:	|                                                      jsr -552(a6)
  c6:	|                                                      movea.l d0,a6
  c8:	|                                                      move.l d0,2b14 <DOSBase>
    if (!DOSBase)
  ce:	|  /-------------------------------------------------- beq.w 488 <main+0x3fc>
    Score scores[16];

    LONG bytesRead;

    // Open the file for reading
    fileHandler = Open(filename, MODE_OLDFILE);
  d2:	|  |                                                   move.l #2609,d1
  d8:	|  |                                                   move.l #1005,d2
  de:	|  |                                                   jsr -30(a6)
  e2:	|  |                                                   move.l d0,d6

    if (!fileHandler)
  e4:	|  |  /----------------------------------------------- beq.w 45c <main+0x3d0>
        Printf("Failed to open the file: %s\n", filename);
        return RETURN_FAIL;
    }
    else
    {
        Printf("File opened\n");
  e8:	|  |  |                                                movea.l 2b14 <DOSBase>,a6
  ee:	|  |  |                                                move.l #2643,d1
  f4:	|  |  |                                                move.l sp,d2
  f6:	|  |  |                                                addi.l #180,d2
  fc:	|  |  |                                                jsr -954(a6)
    }

    if (Seek(fileHandler, 10, OFFSET_BEGINNING) == -1)
 100:	|  |  |                                                movea.l 2b14 <DOSBase>,a6
 106:	|  |  |                                                move.l d6,d1
 108:	|  |  |                                                moveq #10,d2
 10a:	|  |  |                                                moveq #-1,d3
 10c:	|  |  |                                                jsr -66(a6)
 110:	|  |  |                                                addq.l #1,d0
 112:	|  |  |  /-------------------------------------------- beq.w 434 <main+0x3a8>

   FLOAT flop = 2.3;
        FLOAT flip = flop / 2;
        DOUBLE flod = 2.3;
        DOUBLE flid = flod / 2;
        Printf("%3.4ld\n", flip);
 116:	|  |  |  |                                             moveq #1,d0
 118:	|  |  |  |                                             move.l d0,180(sp)
 11c:	|  |  |  |                                             movea.l 2b14 <DOSBase>,a6
 122:	|  |  |  |                                             move.l #2699,d1
 128:	|  |  |  |                                             move.l sp,d2
 12a:	|  |  |  |                                             addi.l #180,d2
 130:	|  |  |  |                                             jsr -954(a6)
    int tableNumber = 0;
 134:	|  |  |  |                                             moveq #0,d7
    int validScoreNumber = 0;
 136:	|  |  |  |                                             moveq #0,d4
    int scoreNumber = 0;
 138:	|  |  |  |                                             moveq #0,d5
 13a:	|  |  |  |                                             movea.l d2,a4
            for (int i = 0; i < 8; i++)
            {
                inputArray[i] = (LONG)scoreBytes[i];
            }

            RawDoFmt("%02lx%02lx%02lx%02lx%02lx%02lx%02lx%02lx", (APTR)&inputArray, stuffChar, bufPtr);
 13c:	|  |  |  |                                             lea a93 <doy_return+0xcb>,a5
        bytesRead = Read(fileHandler, name, 4);
 142:	|  |  |  |                                   /-------> movea.l 2b14 <DOSBase>,a6
 148:	|  |  |  |                                   |         move.l d6,d1
 14a:	|  |  |  |                                   |         moveq #46,d2
 14c:	|  |  |  |                                   |         add.l sp,d2
 14e:	|  |  |  |                                   |         moveq #4,d3
 150:	|  |  |  |                                   |         jsr -42(a6)
        if (bytesRead == 0)
 154:	|  |  |  |                                   |         tst.l d0
 156:	|  |  |  |                                   |  /----- beq.w 234 <main+0x1a8>
        name[3] = '\0';
 15a:	|  |  |  |                                   |  |      clr.b 49(sp)
        bytesRead = Read(fileHandler, scoreBytes, 8);
 15e:	|  |  |  |                                   |  |      movea.l 2b14 <DOSBase>,a6
        if (name[0] != 'T' || name[1] != 'S' || name[2] != 'L')
 164:	|  |  |  |                                   |  |      cmpi.b #84,46(sp)
 16a:	|  |  |  |     /-----------------------------|--|----- beq.w 3ea <main+0x35e>
        bytesRead = Read(fileHandler, scoreBytes, 8);
 16e:	|  |  |  |  /--|-----------------------------|--|----> move.l d6,d1
 170:	|  |  |  |  |  |                             |  |      moveq #50,d2
 172:	|  |  |  |  |  |                             |  |      add.l sp,d2
 174:	|  |  |  |  |  |                             |  |      moveq #8,d3
 176:	|  |  |  |  |  |                             |  |      jsr -42(a6)
 17a:	|  |  |  |  |  |                             |  |      move.l d0,d3
            my_strcpy(scores[validScoreNumber].name,name);
 17c:	|  |  |  |  |  |                             |  |      move.l d4,d1
 17e:	|  |  |  |  |  |                             |  |      add.l d4,d1
 180:	|  |  |  |  |  |                             |  |      move.l d1,d2
 182:	|  |  |  |  |  |                             |  |      add.l d4,d2
 184:	|  |  |  |  |  |                             |  |      lsl.l #3,d2
 186:	|  |  |  |  |  |                             |  |      lea (0,a4,d2.l),a1
    while ((*dest++ = *src++));
 18a:	|  |  |  |  |  |                             |  |      lea 46(sp),a0
 18e:	|  |  |  |  |  |                             |  |  /-> move.b (a0)+,d0
 190:	|  |  |  |  |  |                             |  |  |   move.b d0,(a1)+
 192:	|  |  |  |  |  |                             |  |  \-- bne.s 18e <main+0x102>
            scores[validScoreNumber].table = tableNumber;
 194:	|  |  |  |  |  |                             |  |      add.l d4,d1
 196:	|  |  |  |  |  |                             |  |      lsl.l #3,d1
 198:	|  |  |  |  |  |                             |  |      lea 564(sp),a0
 19c:	|  |  |  |  |  |                             |  |      adda.l d1,a0
 19e:	|  |  |  |  |  |                             |  |      move.w d7,-362(a0)
            scoreBytes[8] = '\0';
 1a2:	|  |  |  |  |  |                             |  |      clr.b 58(sp)
                inputArray[i] = (LONG)scoreBytes[i];
 1a6:	|  |  |  |  |  |                             |  |      moveq #0,d0
 1a8:	|  |  |  |  |  |                             |  |      move.b 50(sp),d0
 1ac:	|  |  |  |  |  |                             |  |      move.l d0,80(sp)
 1b0:	|  |  |  |  |  |                             |  |      move.b 51(sp),d0
 1b4:	|  |  |  |  |  |                             |  |      move.l d0,84(sp)
 1b8:	|  |  |  |  |  |                             |  |      move.b 52(sp),d0
 1bc:	|  |  |  |  |  |                             |  |      move.l d0,88(sp)
 1c0:	|  |  |  |  |  |                             |  |      move.b 53(sp),d0
 1c4:	|  |  |  |  |  |                             |  |      move.l d0,92(sp)
 1c8:	|  |  |  |  |  |                             |  |      move.b 54(sp),d0
 1cc:	|  |  |  |  |  |                             |  |      move.l d0,96(sp)
 1d0:	|  |  |  |  |  |                             |  |      move.b 55(sp),d0
 1d4:	|  |  |  |  |  |                             |  |      move.l d0,100(sp)
 1d8:	|  |  |  |  |  |                             |  |      move.b 56(sp),d0
 1dc:	|  |  |  |  |  |                             |  |      move.l d0,104(sp)
 1e0:	|  |  |  |  |  |                             |  |      move.b 57(sp),d0
 1e4:	|  |  |  |  |  |                             |  |      move.l d0,108(sp)
            RawDoFmt("%02lx%02lx%02lx%02lx%02lx%02lx%02lx%02lx", (APTR)&inputArray, stuffChar, bufPtr);
 1e8:	|  |  |  |  |  |                             |  |      movea.l 2b1c <SysBase>,a6
 1ee:	|  |  |  |  |  |                             |  |      movea.l a5,a0
 1f0:	|  |  |  |  |  |                             |  |      lea 80(sp),a1
 1f4:	|  |  |  |  |  |                             |  |      lea b10 <stuffChar>,a2
 1fa:	|  |  |  |  |  |                             |  |      lea 60(sp),a3
 1fe:	|  |  |  |  |  |                             |  |      jsr -522(a6)
    while (*str && my_strchr(chars_to_trim, *str))
 202:	|  |  |  |  |  |                             |  |      move.b 60(sp),d0
 206:	|  |  |  |  |  |                             |  |      movea.l a3,a1
 208:	|  |  |  |  |  |  /--------------------------|--|----- beq.w 416 <main+0x38a>
 20c:	|  |  |  |  |  |  |  /-----------------------|--|----> movea.l a1,a0
        str++;
 20e:	|  |  |  |  |  |  |  |                       |  |      addq.l #1,a1
        if (*str == character)
 210:	|  |  |  |  |  |  |  |                       |  |      cmpi.b #48,d0
 214:	|  |  |  |  |  |  |  |     /-----------------|--|----- beq.w 410 <main+0x384>

            char *trimmed = trim_start_chars(buffer, "0");

           

             my_strcpy(scores[validScoreNumber].score,trimmed);
 218:	|  |  |  |  |  |  |  |     |                 |  |      lea (4,a4,d2.l),a1
    while ((*dest++ = *src++));
 21c:	|  |  |  |  |  |  |  |  /--|-----------------|--|----> move.b (a0)+,d0
 21e:	|  |  |  |  |  |  |  |  |  |                 |  |      move.b d0,(a1)+
 220:	|  |  |  |  |  |  |  |  +--|-----------------|--|----- bne.s 21c <main+0x190>
            validScoreNumber++;
 222:	|  |  |  |  |  |  |  |  |  |                 |  |      addq.l #1,d4
        }
        scoreNumber++;
 224:	|  |  |  |  |  |  |  |  |  |  /--------------|--|----> addq.l #1,d5
        if (scoreNumber % 4 == 0)
 226:	|  |  |  |  |  |  |  |  |  |  |              |  |      moveq #3,d0
 228:	|  |  |  |  |  |  |  |  |  |  |              |  |      and.l d5,d0
 22a:	|  |  |  |  |  |  |  |  |  |  |              |  |  /-- bne.s 22e <main+0x1a2>
        {
            tableNumber++;
 22c:	|  |  |  |  |  |  |  |  |  |  |              |  |  |   addq.l #1,d7
        }
    } while (bytesRead > 0);
 22e:	|  |  |  |  |  |  |  |  |  |  |              |  |  \-> tst.l d3
 230:	|  |  |  |  |  |  |  |  |  |  |              \--|----- bgt.w 142 <main+0xb6>

    Close(fileHandler);
 234:	|  |  |  |  |  |  |  |  |  |  |                 \----> movea.l 2b14 <DOSBase>,a6
 23a:	|  |  |  |  |  |  |  |  |  |  |                        move.l d6,d1
 23c:	|  |  |  |  |  |  |  |  |  |  |                        jsr -36(a6)

    UBYTE choices[100] = "";
 240:	|  |  |  |  |  |  |  |  |  |  |                        moveq #80,d5
 242:	|  |  |  |  |  |  |  |  |  |  |                        add.l sp,d5
 244:	|  |  |  |  |  |  |  |  |  |  |                        pea 64 <_start+0x64>
 248:	|  |  |  |  |  |  |  |  |  |  |                        clr.l -(sp)
 24a:	|  |  |  |  |  |  |  |  |  |  |                        move.l d5,-(sp)
 24c:	|  |  |  |  |  |  |  |  |  |  |                        jsr 4b4 <memset>
    struct EasyStruct es;
    LONG choice;

    es.es_StructSize = sizeof(struct EasyStruct);
 252:	|  |  |  |  |  |  |  |  |  |  |                        moveq #20,d1
 254:	|  |  |  |  |  |  |  |  |  |  |                        move.l d1,72(sp)
    es.es_Flags = 0;
 258:	|  |  |  |  |  |  |  |  |  |  |                        clr.l 76(sp)
    es.es_Title = "Choose table";
 25c:	|  |  |  |  |  |  |  |  |  |  |                        move.l #2748,80(sp)
    es.es_TextFormat = "I want to send score:";
 264:	|  |  |  |  |  |  |  |  |  |  |                        move.l #2761,84(sp)


    for (int i = 0; i < validScoreNumber; i++)
 26c:	|  |  |  |  |  |  |  |  |  |  |                        lea 12(sp),sp
 270:	|  |  |  |  |  |  |  |  |  |  |                        tst.l d4
 272:	|  |  |  |  |  |  |  |  |  |  |           /----------- ble.w 33a <main+0x2ae>
 276:	|  |  |  |  |  |  |  |  |  |  |           |            lea 22(a4),a1
 27a:	|  |  |  |  |  |  |  |  |  |  |           |            moveq #0,d0
 27c:	|  |  |  |  |  |  |  |  |  |  |           |            lea b04 <CSWTCH.33>,a5
    switch (tableId)
 282:	|  |  |  |  |  |  |  |  |  |  |           |  /-------> move.w (a1),d1
 284:	|  |  |  |  |  |  |  |  |  |  |           |  |         subq.w #1,d1
 286:	|  |  |  |  |  |  |  |  |  |  |           |  |         cmpi.w #2,d1
 28a:	|  |  |  |  |  |  |  |  |  |  |  /--------|--|-------- bhi.w 420 <main+0x394>
 28e:	|  |  |  |  |  |  |  |  |  |  |  |        |  |         andi.l #65535,d1
 294:	|  |  |  |  |  |  |  |  |  |  |  |        |  |         add.l d1,d1
 296:	|  |  |  |  |  |  |  |  |  |  |  |        |  |         add.l d1,d1
 298:	|  |  |  |  |  |  |  |  |  |  |  |        |  |         movea.l (0,a5,d1.l),a2
    while (*dest)
 29c:	|  |  |  |  |  |  |  |  |  |  |  |        |  |         movea.l d5,a0
 29e:	|  |  |  |  |  |  |  |  |  |  |  |        |  |         tst.b 80(sp)
 2a2:	|  |  |  |  |  |  |  |  |  |  |  |  /-----|--|-------- beq.s 2aa <main+0x21e>
        dest++;
 2a4:	|  |  |  |  |  |  |  |  |  |  |  |  |  /--|--|-------> addq.l #1,a0
    while (*dest)
 2a6:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         tst.b (a0)
 2a8:	|  |  |  |  |  |  |  |  |  |  |  |  |  +--|--|-------- bne.s 2a4 <main+0x218>
    while ((*dest++ = *src++))
 2aa:	|  |  |  |  |  |  |  |  |  |  |  |  >--|--|--|-------> move.b (a2)+,d1
 2ac:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         move.b d1,(a0)+
 2ae:	|  |  |  |  |  |  |  |  |  |  |  |  +--|--|--|-------- bne.s 2aa <main+0x21e>
    while (*dest)
 2b0:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         movea.l d5,a0
 2b2:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         tst.b 80(sp)
 2b6:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /----- beq.s 2be <main+0x232>
        dest++;
 2b8:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /-> addq.l #1,a0
    while (*dest)
 2ba:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   tst.b (a0)
 2bc:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \-- bne.s 2b8 <main+0x22c>
 2be:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \----> lea a0a <doy_return+0x42>,a2
    while ((*dest++ = *src++))
 2c4:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     /-> move.b (a2)+,d1
 2c6:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     |   move.b d1,(a0)+
 2c8:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     \-- bne.s 2c4 <main+0x238>
    {
        my_strcat(choices, getTableName(scores[i].table));
        my_strcat(choices, " ");
        my_strcat(choices, scores[i].score);
 2ca:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         lea -18(a1),a2
    while (*dest)
 2ce:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         movea.l d5,a0
 2d0:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         tst.b 80(sp)
 2d4:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /----- beq.s 2dc <main+0x250>
        dest++;
 2d6:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /-> addq.l #1,a0
    while (*dest)
 2d8:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   tst.b (a0)
 2da:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \-- bne.s 2d6 <main+0x24a>
    while ((*dest++ = *src++))
 2dc:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  >----> move.b (a2)+,d1
 2de:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      move.b d1,(a0)+
 2e0:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \----- bne.s 2dc <main+0x250>
    while (*dest)
 2e2:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         movea.l d5,a0
 2e4:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         tst.b 80(sp)
 2e8:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /----- beq.s 2f0 <main+0x264>
        dest++;
 2ea:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /-> addq.l #1,a0
    while (*dest)
 2ec:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   tst.b (a0)
 2ee:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \-- bne.s 2ea <main+0x25e>
 2f0:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \----> lea a0a <doy_return+0x42>,a2
    while ((*dest++ = *src++))
 2f6:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     /-> move.b (a2)+,d1
 2f8:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     |   move.b d1,(a0)+
 2fa:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     \-- bne.s 2f6 <main+0x26a>
        my_strcat(choices, " ");
        my_strcat(choices, scores[i].name);
 2fc:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         lea -22(a1),a2
    while (*dest)
 300:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         movea.l d5,a0
 302:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         tst.b 80(sp)
 306:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /----- beq.s 30e <main+0x282>
        dest++;
 308:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /-> addq.l #1,a0
    while (*dest)
 30a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   tst.b (a0)
 30c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \-- bne.s 308 <main+0x27c>
    while ((*dest++ = *src++))
 30e:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  >----> move.b (a2)+,d1
 310:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |      move.b d1,(a0)+
 312:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \----- bne.s 30e <main+0x282>
    while (*dest)
 314:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         movea.l d5,a0
 316:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         tst.b 80(sp)
 31a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /----- beq.s 322 <main+0x296>
        dest++;
 31c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  /-> addq.l #1,a0
    while (*dest)
 31e:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   tst.b (a0)
 320:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \-- bne.s 31c <main+0x290>
 322:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \----> lea a0c <doy_return+0x44>,a2
    while ((*dest++ = *src++))
 328:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     /-> move.b (a2)+,d1
 32a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     |   move.b d1,(a0)+
 32c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |     \-- bne.s 328 <main+0x29c>
    for (int i = 0; i < validScoreNumber; i++)
 32e:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         addq.l #1,d0
 330:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         lea 24(a1),a1
 334:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |         cmp.l d4,d0
 336:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  \-------- bne.w 282 <main+0x1f6>
    while (*dest)
 33a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |  \----------> movea.l d5,a0
 33c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               tst.b 80(sp)
 340:	|  |  |  |  |  |  |  |  |  |  |  |  |  |        /----- beq.s 348 <main+0x2bc>
        dest++;
 342:	|  |  |  |  |  |  |  |  |  |  |  |  |  |        |  /-> addq.l #1,a0
    while (*dest)
 344:	|  |  |  |  |  |  |  |  |  |  |  |  |  |        |  |   tst.b (a0)
 346:	|  |  |  |  |  |  |  |  |  |  |  |  |  |        |  \-- bne.s 342 <main+0x2b6>
 348:	|  |  |  |  |  |  |  |  |  |  |  |  |  |        \----> lea a0e <doy_return+0x46>,a1
    while ((*dest++ = *src++))
 34e:	|  |  |  |  |  |  |  |  |  |  |  |  |  |           /-> move.b (a1)+,d0
 350:	|  |  |  |  |  |  |  |  |  |  |  |  |  |           |   move.b d0,(a0)+
 352:	|  |  |  |  |  |  |  |  |  |  |  |  |  |           \-- bne.s 34e <main+0x2c2>
        my_strcat(choices, "|");
    }
    

    my_strcat(choices, "Exit");
    es.es_GadgetFormat = choices;
 354:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               moveq #80,d0
 356:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               add.l sp,d0
 358:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               move.l d0,76(sp)

    choice = EasyRequestArgs(NULL, &es, NULL, NULL);
 35c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               movea.l 2b18 <IntuitionBase>,a6
 362:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               suba.l a0,a0
 364:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               lea 60(sp),a1
 368:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               suba.l a2,a2
 36a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               suba.l a3,a3
 36c:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               jsr -588(a6)
   
    default:
        break;
    }

    Printf("%s\n", scores[choice-1].name);
 370:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               subq.l #1,d0
 372:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               move.l d0,d3
 374:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               add.l d0,d3
 376:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               add.l d0,d3
 378:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               lsl.l #3,d3
 37a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               lea (0,a4,d3.l),a0
 37e:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               move.l a0,50(sp)
 382:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               movea.l 2b14 <DOSBase>,a6
 388:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               move.l #2783,d1
 38e:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               moveq #50,d2
 390:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               add.l sp,d2
 392:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               jsr -954(a6)
    Printf("%s\n", scores[choice-1].score);
 396:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               lea (4,a4,d3.l),a4
 39a:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               move.l a4,50(sp)
 39e:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               movea.l 2b14 <DOSBase>,a6
 3a4:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               move.l #2783,d1
 3aa:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               jsr -954(a6)
    Printf("\n");
 3ae:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               movea.l 2b14 <DOSBase>,a6
 3b4:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               move.l #2787,d1
 3ba:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               jsr -954(a6)


    CloseLibrary((struct Library *)IntuitionBase);
 3be:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               movea.l 2b1c <SysBase>,a6
 3c4:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               movea.l 2b18 <IntuitionBase>,a1
 3ca:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               jsr -414(a6)
    CloseLibrary((struct Library *)DOSBase);
 3ce:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               movea.l 2b1c <SysBase>,a6
 3d4:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               movea.l 2b14 <DOSBase>,a1
 3da:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               jsr -414(a6)
        return 0;
 3de:	|  |  |  |  |  |  |  |  |  |  |  |  |  |               moveq #0,d0

    return RETURN_OK;
}
 3e0:	|  |  |  |  |  |  |  |  |  |  |  |  |  |           /-> movem.l (sp)+,d2-d7/a2-a6
 3e4:	|  |  |  |  |  |  |  |  |  |  |  |  |  |           |   lea 520(sp),sp
 3e8:	|  |  |  |  |  |  |  |  |  |  |  |  |  |           |   rts
        if (name[0] != 'T' || name[1] != 'S' || name[2] != 'L')
 3ea:	|  |  |  |  |  \--|--|--|--|--|--|--|--|-----------|-> cmpi.b #83,47(sp)
 3f0:	|  |  |  |  +-----|--|--|--|--|--|--|--|-----------|-- bne.w 16e <main+0xe2>
 3f4:	|  |  |  |  |     |  |  |  |  |  |  |  |           |   cmpi.b #76,48(sp)
 3fa:	|  |  |  |  \-----|--|--|--|--|--|--|--|-----------|-- bne.w 16e <main+0xe2>
        bytesRead = Read(fileHandler, scoreBytes, 8);
 3fe:	|  |  |  |        |  |  |  |  |  |  |  |           |   move.l d6,d1
 400:	|  |  |  |        |  |  |  |  |  |  |  |           |   moveq #50,d2
 402:	|  |  |  |        |  |  |  |  |  |  |  |           |   add.l sp,d2
 404:	|  |  |  |        |  |  |  |  |  |  |  |           |   moveq #8,d3
 406:	|  |  |  |        |  |  |  |  |  |  |  |           |   jsr -42(a6)
 40a:	|  |  |  |        |  |  |  |  |  |  |  |           |   move.l d0,d3
        if (nameIsValid)
 40c:	|  |  |  |        |  |  |  |  \--|--|--|-----------|-- bra.w 224 <main+0x198>
    while (*str && my_strchr(chars_to_trim, *str))
 410:	|  |  |  |        |  |  |  \-----|--|--|-----------|-> move.b (a1),d0
 412:	|  |  |  |        |  \--|--------|--|--|-----------|-- bne.w 20c <main+0x180>
 416:	|  |  |  |        \-----|--------|--|--|-----------|-> movea.l a1,a0
             my_strcpy(scores[validScoreNumber].score,trimmed);
 418:	|  |  |  |              |        |  |  |           |   lea (4,a4,d2.l),a1
 41c:	|  |  |  |              \--------|--|--|-----------|-- bra.w 21c <main+0x190>
    switch (tableId)
 420:	|  |  |  |                       \--|--|-----------|-> lea a00 <doy_return+0x38>,a2
    while (*dest)
 426:	|  |  |  |                          |  |           |   movea.l d5,a0
 428:	|  |  |  |                          |  |           |   tst.b 80(sp)
 42c:	|  |  |  |                          |  \-----------|-- bne.w 2a4 <main+0x218>
 430:	|  |  |  |                          \--------------|-- bra.w 2aa <main+0x21e>
        Printf("Error occurred while seeking in the file.\n");
 434:	|  |  |  \-----------------------------------------|-> movea.l 2b14 <DOSBase>,a6
 43a:	|  |  |                                            |   move.l #2656,d1
 440:	|  |  |                                            |   move.l sp,d2
 442:	|  |  |                                            |   addi.l #180,d2
 448:	|  |  |                                            |   jsr -954(a6)
        Close(fileHandler);
 44c:	|  |  |                                            |   movea.l 2b14 <DOSBase>,a6
 452:	|  |  |                                            |   move.l d6,d1
 454:	|  |  |                                            |   jsr -36(a6)
        return 0;
 458:	|  |  |                                            |   moveq #0,d0
 45a:	|  |  |                                            \-- bra.s 3e0 <main+0x354>
        Printf("Failed to open the file: %s\n", filename);
 45c:	|  |  \----------------------------------------------> move.l #2609,180(sp)
 464:	|  |                                                   movea.l 2b14 <DOSBase>,a6
 46a:	|  |                                                   move.l #2614,d1
 470:	|  |                                                   move.l sp,d2
 472:	|  |                                                   addi.l #180,d2
 478:	|  |                                                   jsr -954(a6)
        return RETURN_FAIL;
 47c:	\--|-------------------------------------------------> moveq #20,d0
}
 47e:	   |                                               /-> movem.l (sp)+,d2-d7/a2-a6
 482:	   |                                               |   lea 520(sp),sp
 486:	   |                                               |   rts
        CloseLibrary(IntuitionBase);
 488:	   \-----------------------------------------------|-> movea.l 2b1c <SysBase>,a6
 48e:	                                                   |   movea.l 2b18 <IntuitionBase>,a1
 494:	                                                   |   jsr -414(a6)
        return RETURN_FAIL;
 498:	                                                   |   moveq #20,d0
 49a:	                                                   \-- bra.s 47e <main+0x3f2>

0000049c <strlen>:
	while(*s++)
 49c:	   /-> movea.l 4(sp),a0
 4a0:	   |   tst.b (a0)+
 4a2:	/--|-- beq.s 4b0 <strlen+0x14>
 4a4:	|  |   move.l a0,-(sp)
 4a6:	|  \-- jsr 49c <strlen>(pc)
 4aa:	|      addq.l #4,sp
 4ac:	|      addq.l #1,d0
}
 4ae:	|      rts
	unsigned long t=0;
 4b0:	\----> moveq #0,d0
}
 4b2:	       rts

000004b4 <memset>:
void* memset(void *dest, int val, unsigned long len) {
 4b4:	                      movem.l d2-d7/a2,-(sp)
 4b8:	                      move.l 32(sp),d0
 4bc:	                      move.l 36(sp),d3
 4c0:	                      movea.l 40(sp),a0
	while(len-- > 0)
 4c4:	                      lea -1(a0),a1
 4c8:	                      cmpa.w #0,a0
 4cc:	               /----- beq.w 57a <memset+0xc6>
		*ptr++ = val;
 4d0:	               |      move.b d3,d7
 4d2:	               |      move.l d0,d2
 4d4:	               |      neg.l d2
 4d6:	               |      moveq #3,d1
 4d8:	               |      and.l d2,d1
 4da:	               |      moveq #5,d4
 4dc:	               |      cmp.l a1,d4
 4de:	/--------------|----- bcc.w 61a <memset+0x166>
 4e2:	|              |      tst.l d1
 4e4:	|           /--|----- beq.w 5b4 <memset+0x100>
 4e8:	|           |  |      movea.l d0,a1
 4ea:	|           |  |      move.b d3,(a1)
	while(len-- > 0)
 4ec:	|           |  |      btst #1,d2
 4f0:	|           |  |  /-- beq.w 580 <memset+0xcc>
		*ptr++ = val;
 4f4:	|           |  |  |   move.b d3,1(a1)
	while(len-- > 0)
 4f8:	|           |  |  |   moveq #3,d2
 4fa:	|           |  |  |   cmp.l d1,d2
 4fc:	|  /--------|--|--|-- bne.w 5e4 <memset+0x130>
		*ptr++ = val;
 500:	|  |        |  |  |   lea 3(a1),a2
 504:	|  |        |  |  |   move.b d3,2(a1)
	while(len-- > 0)
 508:	|  |        |  |  |   lea -4(a0),a1
 50c:	|  |        |  |  |   move.l a0,d4
 50e:	|  |        |  |  |   sub.l d1,d4
 510:	|  |        |  |  |   moveq #0,d5
 512:	|  |        |  |  |   move.b d3,d5
 514:	|  |        |  |  |   move.l d5,d6
 516:	|  |        |  |  |   swap d6
 518:	|  |        |  |  |   clr.w d6
 51a:	|  |        |  |  |   move.l d3,d2
 51c:	|  |        |  |  |   lsl.w #8,d2
 51e:	|  |        |  |  |   swap d2
 520:	|  |        |  |  |   clr.w d2
 522:	|  |        |  |  |   lsl.l #8,d5
 524:	|  |        |  |  |   or.l d6,d2
 526:	|  |        |  |  |   or.l d5,d2
 528:	|  |        |  |  |   move.b d7,d2
 52a:	|  |        |  |  |   movea.l d0,a0
 52c:	|  |        |  |  |   adda.l d1,a0
 52e:	|  |        |  |  |   moveq #-4,d5
 530:	|  |        |  |  |   and.l d4,d5
 532:	|  |        |  |  |   move.l d5,d1
 534:	|  |        |  |  |   add.l a0,d1
		*ptr++ = val;
 536:	|  |  /-----|--|--|-> move.l d2,(a0)+
	while(len-- > 0)
 538:	|  |  |     |  |  |   cmp.l a0,d1
 53a:	|  |  +-----|--|--|-- bne.s 536 <memset+0x82>
 53c:	|  |  |     |  |  |   cmp.l d5,d4
 53e:	|  |  |     |  +--|-- beq.s 57a <memset+0xc6>
 540:	|  |  |     |  |  |   lea (0,a2,d5.l),a0
 544:	|  |  |     |  |  |   suba.l d5,a1
		*ptr++ = val;
 546:	|  |  |  /--|--|--|-> move.b d3,(a0)
	while(len-- > 0)
 548:	|  |  |  |  |  |  |   cmpa.w #0,a1
 54c:	|  |  |  |  |  +--|-- beq.s 57a <memset+0xc6>
		*ptr++ = val;
 54e:	|  |  |  |  |  |  |   move.b d3,1(a0)
	while(len-- > 0)
 552:	|  |  |  |  |  |  |   moveq #1,d1
 554:	|  |  |  |  |  |  |   cmp.l a1,d1
 556:	|  |  |  |  |  +--|-- beq.s 57a <memset+0xc6>
		*ptr++ = val;
 558:	|  |  |  |  |  |  |   move.b d3,2(a0)
	while(len-- > 0)
 55c:	|  |  |  |  |  |  |   moveq #2,d2
 55e:	|  |  |  |  |  |  |   cmp.l a1,d2
 560:	|  |  |  |  |  +--|-- beq.s 57a <memset+0xc6>
		*ptr++ = val;
 562:	|  |  |  |  |  |  |   move.b d3,3(a0)
	while(len-- > 0)
 566:	|  |  |  |  |  |  |   moveq #3,d4
 568:	|  |  |  |  |  |  |   cmp.l a1,d4
 56a:	|  |  |  |  |  +--|-- beq.s 57a <memset+0xc6>
		*ptr++ = val;
 56c:	|  |  |  |  |  |  |   move.b d3,4(a0)
	while(len-- > 0)
 570:	|  |  |  |  |  |  |   moveq #4,d1
 572:	|  |  |  |  |  |  |   cmp.l a1,d1
 574:	|  |  |  |  |  +--|-- beq.s 57a <memset+0xc6>
		*ptr++ = val;
 576:	|  |  |  |  |  |  |   move.b d3,5(a0)
}
 57a:	|  |  |  |  |  \--|-> movem.l (sp)+,d2-d7/a2
 57e:	|  |  |  |  |     |   rts
		*ptr++ = val;
 580:	|  |  |  |  |     \-> lea 1(a1),a2
	while(len-- > 0)
 584:	|  |  |  |  |         lea -2(a0),a1
 588:	|  |  |  |  |         move.l a0,d4
 58a:	|  |  |  |  |         sub.l d1,d4
 58c:	|  |  |  |  |         moveq #0,d5
 58e:	|  |  |  |  |         move.b d3,d5
 590:	|  |  |  |  |         move.l d5,d6
 592:	|  |  |  |  |         swap d6
 594:	|  |  |  |  |         clr.w d6
 596:	|  |  |  |  |         move.l d3,d2
 598:	|  |  |  |  |         lsl.w #8,d2
 59a:	|  |  |  |  |         swap d2
 59c:	|  |  |  |  |         clr.w d2
 59e:	|  |  |  |  |         lsl.l #8,d5
 5a0:	|  |  |  |  |         or.l d6,d2
 5a2:	|  |  |  |  |         or.l d5,d2
 5a4:	|  |  |  |  |         move.b d7,d2
 5a6:	|  |  |  |  |         movea.l d0,a0
 5a8:	|  |  |  |  |         adda.l d1,a0
 5aa:	|  |  |  |  |         moveq #-4,d5
 5ac:	|  |  |  |  |         and.l d4,d5
 5ae:	|  |  |  |  |         move.l d5,d1
 5b0:	|  |  |  |  |         add.l a0,d1
 5b2:	|  |  +--|--|-------- bra.s 536 <memset+0x82>
	unsigned char *ptr = (unsigned char *)dest;
 5b4:	|  |  |  |  \-------> movea.l d0,a2
 5b6:	|  |  |  |            move.l a0,d4
 5b8:	|  |  |  |            sub.l d1,d4
 5ba:	|  |  |  |            moveq #0,d5
 5bc:	|  |  |  |            move.b d3,d5
 5be:	|  |  |  |            move.l d5,d6
 5c0:	|  |  |  |            swap d6
 5c2:	|  |  |  |            clr.w d6
 5c4:	|  |  |  |            move.l d3,d2
 5c6:	|  |  |  |            lsl.w #8,d2
 5c8:	|  |  |  |            swap d2
 5ca:	|  |  |  |            clr.w d2
 5cc:	|  |  |  |            lsl.l #8,d5
 5ce:	|  |  |  |            or.l d6,d2
 5d0:	|  |  |  |            or.l d5,d2
 5d2:	|  |  |  |            move.b d7,d2
 5d4:	|  |  |  |            movea.l d0,a0
 5d6:	|  |  |  |            adda.l d1,a0
 5d8:	|  |  |  |            moveq #-4,d5
 5da:	|  |  |  |            and.l d4,d5
 5dc:	|  |  |  |            move.l d5,d1
 5de:	|  |  |  |            add.l a0,d1
 5e0:	|  |  +--|----------- bra.w 536 <memset+0x82>
		*ptr++ = val;
 5e4:	|  \--|--|----------> lea 2(a1),a2
	while(len-- > 0)
 5e8:	|     |  |            lea -3(a0),a1
 5ec:	|     |  |            move.l a0,d4
 5ee:	|     |  |            sub.l d1,d4
 5f0:	|     |  |            moveq #0,d5
 5f2:	|     |  |            move.b d3,d5
 5f4:	|     |  |            move.l d5,d6
 5f6:	|     |  |            swap d6
 5f8:	|     |  |            clr.w d6
 5fa:	|     |  |            move.l d3,d2
 5fc:	|     |  |            lsl.w #8,d2
 5fe:	|     |  |            swap d2
 600:	|     |  |            clr.w d2
 602:	|     |  |            lsl.l #8,d5
 604:	|     |  |            or.l d6,d2
 606:	|     |  |            or.l d5,d2
 608:	|     |  |            move.b d7,d2
 60a:	|     |  |            movea.l d0,a0
 60c:	|     |  |            adda.l d1,a0
 60e:	|     |  |            moveq #-4,d5
 610:	|     |  |            and.l d4,d5
 612:	|     |  |            move.l d5,d1
 614:	|     |  |            add.l a0,d1
 616:	|     \--|----------- bra.w 536 <memset+0x82>
	unsigned char *ptr = (unsigned char *)dest;
 61a:	\--------|----------> movea.l d0,a0
 61c:	         \----------- bra.w 546 <memset+0x92>

00000620 <memcpy>:
void* memcpy(void *dest, const void *src, unsigned long len) {
 620:	             movem.l d2-d4/a2,-(sp)
 624:	             move.l 20(sp),d0
 628:	             movea.l 24(sp),a2
 62c:	             move.l 28(sp),d1
	while(len--)
 630:	             move.l d1,d3
 632:	             subq.l #1,d3
 634:	             tst.l d1
 636:	/----------- beq.s 686 <memcpy+0x66>
 638:	|            moveq #6,d2
 63a:	|            cmp.l d3,d2
 63c:	|  /-------- bcc.s 68c <memcpy+0x6c>
 63e:	|  |         move.l a2,d2
 640:	|  |         or.l d0,d2
 642:	|  |         moveq #3,d4
 644:	|  |         and.l d4,d2
 646:	|  |         lea 1(a2),a0
 64a:	|  |  /----- bne.s 690 <memcpy+0x70>
 64c:	|  |  |      movea.l d0,a1
 64e:	|  |  |      suba.l a0,a1
 650:	|  |  |      moveq #2,d2
 652:	|  |  |      cmp.l a1,d2
 654:	|  |  +----- bcc.s 690 <memcpy+0x70>
 656:	|  |  |      movea.l a2,a0
 658:	|  |  |      movea.l d0,a1
 65a:	|  |  |      moveq #-4,d2
 65c:	|  |  |      and.l d1,d2
 65e:	|  |  |      adda.l d2,a2
		*d++ = *s++;
 660:	|  |  |  /-> move.l (a0)+,(a1)+
	while(len--)
 662:	|  |  |  |   cmpa.l a2,a0
 664:	|  |  |  \-- bne.s 660 <memcpy+0x40>
 666:	|  |  |      movea.l d0,a0
 668:	|  |  |      adda.l d2,a0
 66a:	|  |  |      sub.l d2,d3
 66c:	|  |  |      cmp.l d1,d2
 66e:	+--|--|----- beq.s 686 <memcpy+0x66>
		*d++ = *s++;
 670:	|  |  |      move.b (a2),(a0)
	while(len--)
 672:	|  |  |      tst.l d3
 674:	+--|--|----- beq.s 686 <memcpy+0x66>
		*d++ = *s++;
 676:	|  |  |      move.b 1(a2),1(a0)
	while(len--)
 67c:	|  |  |      subq.l #1,d3
 67e:	+--|--|----- beq.s 686 <memcpy+0x66>
		*d++ = *s++;
 680:	|  |  |      move.b 2(a2),2(a0)
}
 686:	>--|--|----> movem.l (sp)+,d2-d4/a2
 68a:	|  |  |      rts
 68c:	|  \--|----> lea 1(a2),a0
 690:	|     \----> movea.l d0,a1
 692:	|            add.l a2,d1
		*d++ = *s++;
 694:	|        /-> move.b -1(a0),(a1)+
	while(len--)
 698:	|        |   cmp.l a0,d1
 69a:	\--------|-- beq.s 686 <memcpy+0x66>
 69c:	         |   addq.l #1,a0
 69e:	         \-- bra.s 694 <memcpy+0x74>

000006a0 <memmove>:
void* memmove(void *dest, const void *src, unsigned long len) {
 6a0:	             movem.l d2-d4/a2-a3,-(sp)
 6a4:	             move.l 24(sp),d0
 6a8:	             move.l 28(sp),d1
 6ac:	             move.l 32(sp),d2
		while (len--)
 6b0:	             movea.l d2,a2
 6b2:	             subq.l #1,a2
	if (d < s) {
 6b4:	             cmp.l d0,d1
 6b6:	      /----- bls.s 716 <memmove+0x76>
		while (len--)
 6b8:	      |      tst.l d2
 6ba:	/-----|----- beq.s 710 <memmove+0x70>
 6bc:	|     |      moveq #6,d3
 6be:	|     |      movea.l d1,a1
 6c0:	|     |      addq.l #1,a1
 6c2:	|     |      cmp.l a2,d3
 6c4:	|  /--|----- bcc.s 73c <memmove+0x9c>
 6c6:	|  |  |      movea.l d0,a0
 6c8:	|  |  |      suba.l a1,a0
 6ca:	|  |  |      moveq #2,d4
 6cc:	|  |  |      cmp.l a0,d4
 6ce:	|  +--|----- bcc.s 73c <memmove+0x9c>
 6d0:	|  |  |      move.l d1,d3
 6d2:	|  |  |      or.l d0,d3
 6d4:	|  |  |      moveq #3,d4
 6d6:	|  |  |      and.l d4,d3
 6d8:	|  +--|----- bne.s 73c <memmove+0x9c>
 6da:	|  |  |      movea.l d1,a0
 6dc:	|  |  |      movea.l d0,a1
 6de:	|  |  |      moveq #-4,d1
 6e0:	|  |  |      and.l d2,d1
 6e2:	|  |  |      lea (0,a0,d1.l),a3
			*d++ = *s++;
 6e6:	|  |  |  /-> move.l (a0)+,(a1)+
		while (len--)
 6e8:	|  |  |  |   cmpa.l a3,a0
 6ea:	|  |  |  \-- bne.s 6e6 <memmove+0x46>
 6ec:	|  |  |      movea.l d0,a0
 6ee:	|  |  |      adda.l d1,a0
 6f0:	|  |  |      suba.l d1,a2
 6f2:	|  |  |      cmp.l d2,d1
 6f4:	+--|--|----- beq.s 710 <memmove+0x70>
			*d++ = *s++;
 6f6:	|  |  |      move.b (a3),(a0)
		while (len--)
 6f8:	|  |  |      cmpa.w #0,a2
 6fc:	+--|--|----- beq.s 710 <memmove+0x70>
			*d++ = *s++;
 6fe:	|  |  |      move.b 1(a3),1(a0)
		while (len--)
 704:	|  |  |      moveq #1,d1
 706:	|  |  |      cmp.l a2,d1
 708:	+--|--|----- beq.s 710 <memmove+0x70>
			*d++ = *s++;
 70a:	|  |  |      move.b 2(a3),2(a0)
}
 710:	>--|--|----> movem.l (sp)+,d2-d4/a2-a3
 714:	|  |  |      rts
		const char *lasts = s + (len - 1);
 716:	|  |  \----> lea (0,a2,d1.l),a0
		char *lastd = d + (len - 1);
 71a:	|  |         lea (0,a2,d0.l),a1
		while (len--)
 71e:	|  |         tst.l d2
 720:	+--|-------- beq.s 710 <memmove+0x70>
 722:	|  |         move.l a0,d1
 724:	|  |         sub.l d2,d1
			*lastd-- = *lasts--;
 726:	|  |     /-> move.b (a0),(a1)
		while (len--)
 728:	|  |     |   subq.l #1,a0
 72a:	|  |     |   subq.l #1,a1
 72c:	|  |     |   cmp.l a0,d1
 72e:	+--|-----|-- beq.s 710 <memmove+0x70>
			*lastd-- = *lasts--;
 730:	|  |     |   move.b (a0),(a1)
		while (len--)
 732:	|  |     |   subq.l #1,a0
 734:	|  |     |   subq.l #1,a1
 736:	|  |     |   cmp.l a0,d1
 738:	|  |     \-- bne.s 726 <memmove+0x86>
 73a:	+--|-------- bra.s 710 <memmove+0x70>
 73c:	|  \-------> movea.l d0,a2
 73e:	|            movea.l d1,a0
 740:	|            adda.l d2,a0
			*d++ = *s++;
 742:	|        /-> move.b -1(a1),(a2)+
		while (len--)
 746:	|        |   cmpa.l a1,a0
 748:	\--------|-- beq.s 710 <memmove+0x70>
 74a:	         |   addq.l #1,a1
 74c:	         \-- bra.s 742 <memmove+0xa2>
 74e:	             nop

00000750 <__mulsi3>:
	.text
	.type __mulsi3, function
	.globl	__mulsi3
__mulsi3:
	.cfi_startproc
	movew	sp@(4), d0	/* x0 -> d0 */
 750:	move.w 4(sp),d0
	muluw	sp@(10), d0	/* x0*y1 */
 754:	mulu.w 10(sp),d0
	movew	sp@(6), d1	/* x1 -> d1 */
 758:	move.w 6(sp),d1
	muluw	sp@(8), d1	/* x1*y0 */
 75c:	mulu.w 8(sp),d1
	addw	d1, d0
 760:	add.w d1,d0
	swap	d0
 762:	swap d0
	clrw	d0
 764:	clr.w d0
	movew	sp@(6), d1	/* x1 -> d1 */
 766:	move.w 6(sp),d1
	muluw	sp@(10), d1	/* x1*y1 */
 76a:	mulu.w 10(sp),d1
	addl	d1, d0
 76e:	add.l d1,d0
	rts
 770:	rts

00000772 <__udivsi3>:
	.text
	.type __udivsi3, function
	.globl	__udivsi3
__udivsi3:
	.cfi_startproc
	movel	d2, sp@-
 772:	       move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	sp@(12), d1	/* d1 = divisor */
 774:	       move.l 12(sp),d1
	movel	sp@(8), d0	/* d0 = dividend */
 778:	       move.l 8(sp),d0

	cmpl	#0x10000, d1 /* divisor >= 2 ^ 16 ?   */
 77c:	       cmpi.l #65536,d1
	jcc	3f		/* then try next algorithm */
 782:	   /-- bcc.s 79a <__udivsi3+0x28>
	movel	d0, d2
 784:	   |   move.l d0,d2
	clrw	d2
 786:	   |   clr.w d2
	swap	d2
 788:	   |   swap d2
	divu	d1, d2          /* high quotient in lower word */
 78a:	   |   divu.w d1,d2
	movew	d2, d0		/* save high quotient */
 78c:	   |   move.w d2,d0
	swap	d0
 78e:	   |   swap d0
	movew	sp@(10), d2	/* get low dividend + high rest */
 790:	   |   move.w 10(sp),d2
	divu	d1, d2		/* low quotient */
 794:	   |   divu.w d1,d2
	movew	d2, d0
 796:	   |   move.w d2,d0
	jra	6f
 798:	/--|-- bra.s 7ca <__udivsi3+0x58>

3:	movel	d1, d2		/* use d2 as divisor backup */
 79a:	|  \-> move.l d1,d2
4:	lsrl	#1, d1	/* shift divisor */
 79c:	|  /-> lsr.l #1,d1
	lsrl	#1, d0	/* shift dividend */
 79e:	|  |   lsr.l #1,d0
	cmpl	#0x10000, d1 /* still divisor >= 2 ^ 16 ?  */
 7a0:	|  |   cmpi.l #65536,d1
	jcc	4b
 7a6:	|  \-- bcc.s 79c <__udivsi3+0x2a>
	divu	d1, d0		/* now we have 16-bit divisor */
 7a8:	|      divu.w d1,d0
	andl	#0xffff, d0 /* mask out divisor, ignore remainder */
 7aa:	|      andi.l #65535,d0

/* Multiply the 16-bit tentative quotient with the 32-bit divisor.  Because of
   the operand ranges, this might give a 33-bit product.  If this product is
   greater than the dividend, the tentative quotient was too large. */
	movel	d2, d1
 7b0:	|      move.l d2,d1
	mulu	d0, d1		/* low part, 32 bits */
 7b2:	|      mulu.w d0,d1
	swap	d2
 7b4:	|      swap d2
	mulu	d0, d2		/* high part, at most 17 bits */
 7b6:	|      mulu.w d0,d2
	swap	d2		/* align high part with low part */
 7b8:	|      swap d2
	tstw	d2		/* high part 17 bits? */
 7ba:	|      tst.w d2
	jne	5f		/* if 17 bits, quotient was too large */
 7bc:	|  /-- bne.s 7c8 <__udivsi3+0x56>
	addl	d2, d1		/* add parts */
 7be:	|  |   add.l d2,d1
	jcs	5f		/* if sum is 33 bits, quotient was too large */
 7c0:	|  +-- bcs.s 7c8 <__udivsi3+0x56>
	cmpl	sp@(8), d1	/* compare the sum with the dividend */
 7c2:	|  |   cmp.l 8(sp),d1
	jls	6f		/* if sum > dividend, quotient was too large */
 7c6:	+--|-- bls.s 7ca <__udivsi3+0x58>
5:	subql	#1, d0	/* adjust quotient */
 7c8:	|  \-> subq.l #1,d0

6:	movel	sp@+, d2
 7ca:	\----> move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
 7cc:	       rts

000007ce <__divsi3>:
	.text
	.type __divsi3, function
	.globl	__divsi3
 __divsi3:
 	.cfi_startproc
	movel	d2, sp@-
 7ce:	    move.l d2,-(sp)
	.cfi_adjust_cfa_offset 4

	moveq	#1, d2	/* sign of result stored in d2 (=1 or =-1) */
 7d0:	    moveq #1,d2
	movel	sp@(12), d1	/* d1 = divisor */
 7d2:	    move.l 12(sp),d1
	jpl	1f
 7d6:	/-- bpl.s 7dc <__divsi3+0xe>
	negl	d1
 7d8:	|   neg.l d1
	negb	d2		/* change sign because divisor <0  */
 7da:	|   neg.b d2
1:	movel	sp@(8), d0	/* d0 = dividend */
 7dc:	\-> move.l 8(sp),d0
	jpl	2f
 7e0:	/-- bpl.s 7e6 <__divsi3+0x18>
	negl	d0
 7e2:	|   neg.l d0
	negb	d2
 7e4:	|   neg.b d2

2:	movel	d1, sp@-
 7e6:	\-> move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 7e8:	    move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3	/* divide abs(dividend) by abs(divisor) */
 7ea:	    bsr.s 772 <__udivsi3>
	addql	#8, sp
 7ec:	    addq.l #8,sp
	.cfi_adjust_cfa_offset -8

	tstb	d2
 7ee:	    tst.b d2
	jpl	3f
 7f0:	/-- bpl.s 7f4 <__divsi3+0x26>
	negl	d0
 7f2:	|   neg.l d0

3:	movel	sp@+, d2
 7f4:	\-> move.l (sp)+,d2
	.cfi_adjust_cfa_offset -4
	rts
 7f6:	    rts

000007f8 <__modsi3>:
	.text
	.type __modsi3, function
	.globl	__modsi3
__modsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
 7f8:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
 7fc:	move.l 4(sp),d0
	movel	d1, sp@-
 800:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 802:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__divsi3
 804:	bsr.s 7ce <__divsi3>
	addql	#8, sp
 806:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
 808:	move.l 8(sp),d1
	movel	d1, sp@-
 80c:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 80e:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
 810:	bsr.w 750 <__mulsi3>
	addql	#8, sp
 814:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
 816:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
 81a:	sub.l d0,d1
	movel	d1, d0
 81c:	move.l d1,d0
	rts
 81e:	rts

00000820 <__umodsi3>:
	.text
	.type __umodsi3, function
	.globl	__umodsi3
__umodsi3:
	.cfi_startproc
	movel	sp@(8), d1	/* d1 = divisor */
 820:	move.l 8(sp),d1
	movel	sp@(4), d0	/* d0 = dividend */
 824:	move.l 4(sp),d0
	movel	d1, sp@-
 828:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 82a:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__udivsi3
 82c:	bsr.w 772 <__udivsi3>
	addql	#8, sp
 830:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(8), d1	/* d1 = divisor */
 832:	move.l 8(sp),d1
	movel	d1, sp@-
 836:	move.l d1,-(sp)
	.cfi_adjust_cfa_offset 4
	movel	d0, sp@-
 838:	move.l d0,-(sp)
	.cfi_adjust_cfa_offset 4
	jbsr	__mulsi3	/* d0 = (a/b)*b */
 83a:	bsr.w 750 <__mulsi3>
	addql	#8, sp
 83e:	addq.l #8,sp
	.cfi_adjust_cfa_offset -8
	movel	sp@(4), d1	/* d1 = dividend */
 840:	move.l 4(sp),d1
	subl	d0, d1		/* d1 = a - (a/b)*b */
 844:	sub.l d0,d1
	movel	d1, d0
 846:	move.l d1,d0
	rts
 848:	rts

0000084a <KPutCharX>:
	.type KPutCharX, function
	.globl	KPutCharX

KPutCharX:
	.cfi_startproc
    move.l  a6, -(sp)
 84a:	move.l a6,-(sp)
	.cfi_adjust_cfa_offset 4
    move.l  4.w, a6
 84c:	movea.l 4 <_start+0x4>,a6
    jsr     -0x204(a6)
 850:	jsr -516(a6)
    move.l (sp)+, a6
 854:	movea.l (sp)+,a6
	.cfi_adjust_cfa_offset -4
    rts
 856:	rts

00000858 <PutChar>:
	.type PutChar, function
	.globl	PutChar

PutChar:
	.cfi_startproc
	move.b d0, (a3)+
 858:	move.b d0,(a3)+
	rts
 85a:	rts

0000085c <_doynaxdepack_asm>:

	|Entry point. Wind up the decruncher
	.type _doynaxdepack_asm,function
	.globl _doynaxdepack_asm
_doynaxdepack_asm:
	movea.l	(a0)+,a2				|Unaligned literal buffer at the end of
 85c:	                         movea.l (a0)+,a2
	adda.l	a0,a2					|the stream
 85e:	                         adda.l a0,a2
	move.l	a2,a3
 860:	                         movea.l a2,a3
	move.l	(a0)+,d0				|Seed the shift register
 862:	                         move.l (a0)+,d0
	moveq	#0x38,d4				|Masks for match offset extraction
 864:	                         moveq #56,d4
	moveq	#8,d5
 866:	                         moveq #8,d5
	bra.s	.Lliteral
 868:	   /-------------------- bra.s 8d2 <_doynaxdepack_asm+0x76>

	|******** Copy a literal sequence ********

.Llcopy:							|Copy two bytes at a time, with the
	move.b	(a0)+,(a1)+				|deferral of the length LSB helping
 86a:	/--|-------------------> move.b (a0)+,(a1)+
	move.b	(a0)+,(a1)+				|slightly in the unrolling
 86c:	|  |                     move.b (a0)+,(a1)+
	dbf		d1,.Llcopy
 86e:	+--|-------------------- dbf d1,86a <_doynaxdepack_asm+0xe>

	lsl.l	#2,d0					|Copy odd bytes separately in order
 872:	|  |                     lsl.l #2,d0
	bcc.s	.Lmatch					|to keep the source aligned
 874:	|  |     /-------------- bcc.s 878 <_doynaxdepack_asm+0x1c>
.Llsingle:
	move.b	(a2)+,(a1)+
 876:	|  |  /--|-------------> move.b (a2)+,(a1)+

	|******** Process a match ********

	|Start by refilling the bit-buffer
.Lmatch:
	DOY_REFILL1 mprefix
 878:	|  |  |  >-------------> tst.w d0
 87a:	|  |  |  |           /-- bne.s 884 <_doynaxdepack_asm+0x28>
	cmp.l	a0,a3					|Take the opportunity to test for the
 87c:	|  |  |  |           |   cmpa.l a0,a3
	bls.s	.Lreturn				|end of the stream while refilling
 87e:	|  |  |  |           |   bls.s 8f6 <doy_table+0x6>
.Lmrefill:
	DOY_REFILL2
 880:	|  |  |  |           |   move.w (a0)+,d0
 882:	|  |  |  |           |   swap d0

.Lmprefix:
	|Fetch the first three bits identifying the match length, and look up
	|the corresponding table entry
	rol.l	#3+3,d0
 884:	|  |  |  |           \-> rol.l #6,d0
	move.w	d0,d1
 886:	|  |  |  |               move.w d0,d1
	and.w	d4,d1
 888:	|  |  |  |               and.w d4,d1
	eor.w	d1,d0
 88a:	|  |  |  |               eor.w d1,d0
	movem.w	doy_table(pc,d1.w),d2/d3/a4
 88c:	|  |  |  |               movem.w (8f0 <doy_table>,pc,d1.w),d2-d3/a4

	|Extract the offset bits and compute the relative source address from it
	rol.l	d2,d0					|Reduced by 3 to account for 8x offset
 892:	|  |  |  |               rol.l d2,d0
	and.w	d0,d3					|scaling
 894:	|  |  |  |               and.w d0,d3
	eor.w	d3,d0
 896:	|  |  |  |               eor.w d3,d0
	suba.w	d3,a4
 898:	|  |  |  |               suba.w d3,a4
	adda.l	a1,a4
 89a:	|  |  |  |               adda.l a1,a4

	|Decode the match length
	DOY_REFILL
 89c:	|  |  |  |               tst.w d0
 89e:	|  |  |  |           /-- bne.s 8a4 <_doynaxdepack_asm+0x48>
 8a0:	|  |  |  |           |   move.w (a0)+,d0
 8a2:	|  |  |  |           |   swap d0
	and.w	d5,d1					|Check the initial length bit from the
 8a4:	|  |  |  |           \-> and.w d5,d1
	beq.s	.Lmcopy					|type triple
 8a6:	|  |  |  |  /----------- beq.s 8be <_doynaxdepack_asm+0x62>

	moveq	#1,d1					|This loops peeks at the next flag
 8a8:	|  |  |  |  |            moveq #1,d1
	tst.l	d0						|through the sign bit bit while keeping
 8aa:	|  |  |  |  |            tst.l d0
	bpl.s	.Lmendlen2				|the LSB in carry
 8ac:	|  |  |  |  |  /-------- bpl.s 8ba <_doynaxdepack_asm+0x5e>
	lsl.l	#2,d0
 8ae:	|  |  |  |  |  |         lsl.l #2,d0
	bpl.s	.Lmendlen1
 8b0:	|  |  |  |  |  |  /----- bpl.s 8b8 <_doynaxdepack_asm+0x5c>
.Lmgetlen:
	addx.b	d1,d1
 8b2:	|  |  |  |  |  |  |  /-> addx.b d1,d1
	lsl.l	#2,d0
 8b4:	|  |  |  |  |  |  |  |   lsl.l #2,d0
	bmi.s	.Lmgetlen
 8b6:	|  |  |  |  |  |  |  \-- bmi.s 8b2 <_doynaxdepack_asm+0x56>
.Lmendlen1:
	addx.b	d1,d1
 8b8:	|  |  |  |  |  |  \----> addx.b d1,d1
.Lmendlen2:
	|Copy the match data a word at a time. Note that the minimum length is
	|two bytes
	lsl.l	#2,d0					|The trailing length payload bit is
 8ba:	|  |  |  |  |  \-------> lsl.l #2,d0
	bcc.s	.Lmhalf					|stored out-of-order
 8bc:	|  |  |  |  |        /-- bcc.s 8c0 <_doynaxdepack_asm+0x64>
.Lmcopy:
	move.b	(a4)+,(a1)+
 8be:	|  |  |  |  >--------|-> move.b (a4)+,(a1)+
.Lmhalf:
	move.b	(a4)+,(a1)+
 8c0:	|  |  |  |  |        \-> move.b (a4)+,(a1)+
	dbf		d1,.Lmcopy
 8c2:	|  |  |  |  \----------- dbf d1,8be <_doynaxdepack_asm+0x62>

	|Fetch a bit flag to see whether what follows is a literal run or
	|another match
	add.l	d0,d0
 8c6:	|  |  |  |               add.l d0,d0
	bcc.s	.Lmatch
 8c8:	|  |  |  \-------------- bcc.s 878 <_doynaxdepack_asm+0x1c>


	|******** Process a run of literal bytes ********

	DOY_REFILL						|Replenish the shift-register
 8ca:	|  |  |                  tst.w d0
 8cc:	|  +--|----------------- bne.s 8d2 <_doynaxdepack_asm+0x76>
 8ce:	|  |  |                  move.w (a0)+,d0
 8d0:	|  |  |                  swap d0
.Lliteral:
	|Extract delta-coded run length in the same swizzled format as the
	|matches above
	moveq	#0,d1
 8d2:	|  \--|----------------> moveq #0,d1
	add.l	d0,d0
 8d4:	|     |                  add.l d0,d0
	bcc.s	.Llsingle				|Single out the one-byte case
 8d6:	|     \----------------- bcc.s 876 <_doynaxdepack_asm+0x1a>
	bpl.s	.Llendlen
 8d8:	|                 /----- bpl.s 8e0 <_doynaxdepack_asm+0x84>
.Llgetlen:
	addx.b	d1,d1
 8da:	|                 |  /-> addx.b d1,d1
	lsl.l	#2,d0
 8dc:	|                 |  |   lsl.l #2,d0
	bmi.s	.Llgetlen
 8de:	|                 |  \-- bmi.s 8da <_doynaxdepack_asm+0x7e>
.Llendlen:
	addx.b	d1,d1
 8e0:	|                 \----> addx.b d1,d1
	|or greater, in which case the sixteen guaranteed bits in the buffer
	|may have run out.
	|In the latter case simply give up and stuff the payload bits back onto
	|the stream before fetching a literal 16-bit run length instead
.Llcopy_near:
	dbvs	d1,.Llcopy
 8e2:	\--------------------/-X dbv.s d1,86a <_doynaxdepack_asm+0xe>

	add.l	d0,d0
 8e6:	                     |   add.l d0,d0
	eor.w	d1,d0		
 8e8:	                     |   eor.w d1,d0
	ror.l	#7+1,d0					|Note that the constant MSB acts as a
 8ea:	                     |   ror.l #8,d0
	move.w	(a0)+,d1				|substitute for the unfetched stop bit
 8ec:	                     |   move.w (a0)+,d1
	bra.s	.Llcopy_near
 8ee:	                     \-- bra.s 8e2 <_doynaxdepack_asm+0x86>

000008f0 <doy_table>:
 8f0:	......Nu........
doy_table:
	DOY_OFFSET 3,1					|Short A
.Lreturn:
	rts
	DOY_OFFSET 4,1					|Long A
	dc.w	0						|(Empty hole)
 900:	...?............
	DOY_OFFSET 6,1+8				|Short B
	dc.w	0						|(Empty hole)
	DOY_OFFSET 7,1+16				|Long B
	dc.w	0						|(Empty hole)
 910:	.............o..
	DOY_OFFSET 8,1+8+64				|Short C
	dc.w	0						|(Empty hole)
	DOY_OFFSET 10,1+16+128			|Long C
	dc.w	0						|(Empty hole)
 920:	.............o

Disassembly of section CODE:

0000092e <_doynaxdepack_vasm>:
		swap.w	d0						;encoder is in on the scheme
		endm

		;Entry point. Wind up the decruncher
_doynaxdepack_vasm:
		movea.l	(a0)+,a2				;Unaligned literal buffer at the end of
 92e:	movea.l (a0)+,a2
		adda.l	a0,a2					;the stream
 930:	adda.l a0,a2
		move.l	a2,a3
 932:	movea.l a2,a3
		move.l	(a0)+,d0				;Seed the shift register
 934:	move.l (a0)+,d0
		moveq	#@70,d4					;Masks for match offset extraction
 936:	moveq #56,d4
		moveq	#@10,d5
 938:	moveq #8,d5
		bra.s	doy_literal
 93a:	bra.s 9a4 <doy_full_000006>

0000093c <doy_lcopy>:


		;******** Copy a literal sequence ********

doy_lcopy:								;Copy two bytes at a time, with the
		move.b	(a0)+,(a1)+				;deferral of the length LSB helping
 93c:	/-> move.b (a0)+,(a1)+
		move.b	(a0)+,(a1)+				;slightly in the unrolling
 93e:	|   move.b (a0)+,(a1)+
		dbf		d1,doy_lcopy
 940:	\-- dbf d1,93c <doy_lcopy>

		lsl.l	#2,d0					;Copy odd bytes separately in order
 944:	    lsl.l #2,d0
		bcc.s	doy_match				;to keep the source aligned
 946:	    bcc.s 94a <doy_match>

00000948 <doy_lsingle>:
doy_lsingle:
		move.b	(a2)+,(a1)+
 948:	move.b (a2)+,(a1)+

0000094a <doy_match>:
		tst.w	d0
 94a:	tst.w d0
		bne.s	\1
 94c:	bne.s 956 <doy_mprefix>
		;******** Process a match ********

		;Start by refilling the bit-buffer
doy_match:
		DOY_REFILL1 doy_mprefix
		cmp.l	a0,a3					;Take the opportunity to test for the
 94e:	cmpa.l a0,a3
		bls.s	doy_return				;end of the stream while refilling
 950:	bls.s 9c8 <doy_return>

00000952 <doy_mrefill>:
		move.w	(a0)+,d0				;old, but that's fine as long as the
 952:	move.w (a0)+,d0
		swap.w	d0						;encoder is in on the scheme
 954:	swap d0

00000956 <doy_mprefix>:
		DOY_REFILL2

doy_mprefix:
		;Fetch the first three bits identifying the match length, and look up
		;the corresponding table entry
		rol.l	#3+3,d0
 956:	rol.l #6,d0
		move.w	d0,d1
 958:	move.w d0,d1
		and.w	d4,d1
 95a:	and.w d4,d1
		eor.w	d1,d0
 95c:	eor.w d1,d0
		movem.w	doy_table(pc,d1.w),d2/d3/a4
 95e:	movem.w (9c2 <doy_table>,pc,d1.w),d2-d3/a4

		;Extract the offset bits and compute the relative source address from it
		rol.l	d2,d0					;Reduced by 3 to account for 8x offset
 964:	rol.l d2,d0
		and.w	d0,d3					;scaling
 966:	and.w d0,d3
		eor.w	d3,d0
 968:	eor.w d3,d0
		suba.w	d3,a4
 96a:	suba.w d3,a4
		adda.l	a1,a4
 96c:	adda.l a1,a4
		tst.w	d0
 96e:	tst.w d0
		bne.s	\1
 970:	bne.s 976 <doy_full_000003>
		move.w	(a0)+,d0				;old, but that's fine as long as the
 972:	move.w (a0)+,d0
		swap.w	d0						;encoder is in on the scheme
 974:	swap d0

00000976 <doy_full_000003>:

		;Decode the match length
		DOY_REFILL
		and.w	d5,d1					;Check the initial length bit from the
 976:	and.w d5,d1
		beq.s	doy_mcopy				;type triple
 978:	beq.s 990 <doy_mcopy>

		moveq	#1,d1					;This loops peeks at the next flag
 97a:	moveq #1,d1
		tst.l	d0						;through the sign bit bit while keeping
 97c:	tst.l d0
		bpl.s	doy_mendlen2			;the LSB in carry
 97e:	bpl.s 98c <doy_mendlen2>
		lsl.l	#2,d0
 980:	lsl.l #2,d0
		bpl.s	doy_mendlen1
 982:	bpl.s 98a <doy_mendlen1>

00000984 <doy_mgetlen>:
doy_mgetlen:
		addx.b	d1,d1
 984:	/-> addx.b d1,d1
		lsl.l	#2,d0
 986:	|   lsl.l #2,d0
		bmi.s	doy_mgetlen
 988:	\-- bmi.s 984 <doy_mgetlen>

0000098a <doy_mendlen1>:
doy_mendlen1:
		addx.b	d1,d1
 98a:	addx.b d1,d1

0000098c <doy_mendlen2>:
doy_mendlen2:

		;Copy the match data a word at a time. Note that the minimum length is
		;two bytes
		lsl.l	#2,d0					;The trailing length payload bit is
 98c:	lsl.l #2,d0
		bcc.s	doy_mhalf				;stored out-of-order
 98e:	bcc.s 992 <doy_mhalf>

00000990 <doy_mcopy>:
doy_mcopy:
		move.b	(a4)+,(a1)+
 990:	move.b (a4)+,(a1)+

00000992 <doy_mhalf>:
doy_mhalf:
		move.b	(a4)+,(a1)+
 992:	move.b (a4)+,(a1)+
		dbf		d1,doy_mcopy
 994:	dbf d1,990 <doy_mcopy>

		;Fetch a bit flag to see whether what follows is a literal run or
		;another match
		add.l	d0,d0
 998:	add.l d0,d0
		bcc.s	doy_match
 99a:	bcc.s 94a <doy_match>
		tst.w	d0
 99c:	tst.w d0
		bne.s	\1
 99e:	bne.s 9a4 <doy_full_000006>
		move.w	(a0)+,d0				;old, but that's fine as long as the
 9a0:	move.w (a0)+,d0
		swap.w	d0						;encoder is in on the scheme
 9a2:	swap d0

000009a4 <doy_full_000006>:

		DOY_REFILL						;Replenish the shift-register
doy_literal:
		;Extract delta-coded run length in the same swizzled format as the
		;matches above
		moveq	#0,d1
 9a4:	moveq #0,d1
		add.l	d0,d0
 9a6:	add.l d0,d0
		bcc.s	doy_lsingle				;Single out the one-byte case
 9a8:	bcc.s 948 <doy_lsingle>
		bpl.s	doy_lendlen
 9aa:	bpl.s 9b2 <doy_lendlen>

000009ac <doy_lgetlen>:
doy_lgetlen:
		addx.b	d1,d1
 9ac:	/-> addx.b d1,d1
		lsl.l	#2,d0
 9ae:	|   lsl.l #2,d0
		bmi.s	doy_lgetlen
 9b0:	\-- bmi.s 9ac <doy_lgetlen>

000009b2 <doy_lendlen>:
doy_lendlen:
		addx.b	d1,d1
 9b2:	addx.b d1,d1

000009b4 <doy_lcopy_near>:
		;or greater, in which case the sixteen guaranteed bits in the buffer
		;may have run out.
		;In the latter case simply give up and stuff the payload bits back onto
		;the stream before fetching a literal 16-bit run length instead
doy_lcopy_near:
		dbvs	d1,doy_lcopy
 9b4:	/-> dbv.s d1,93c <doy_lcopy>

		add.l	d0,d0
 9b8:	|   add.l d0,d0
		eor.w	d1,d0		
 9ba:	|   eor.w d1,d0
		ror.l	#7+1,d0					;Note that the constant MSB acts as a
 9bc:	|   ror.l #8,d0
		move.w	(a0)+,d1				;substitute for the unfetched stop bit
 9be:	|   move.w (a0)+,d1
		bra.s	doy_lcopy_near
 9c0:	\-- bra.s 9b4 <doy_lcopy_near>

000009c2 <doy_table>:
 9c2:	ori.b #7,d0
 9c6:	.short 0xffff

000009c8 <doy_return>:
		endm

doy_table:
		DOY_OFFSET 3,1					;Short A
doy_return:
		rts
 9c8:	rts
 9ca:	ori.b #15,d1
 9ce:	.short 0xffff
 9d0:	ori.b #3,d0
 9d4:	.short 0x003f
 9d6:	.short 0xfff7
 9d8:	ori.b #4,d0
 9dc:	.short 0x007f
 9de:	.short 0xffef
 9e0:	ori.b #5,d0
 9e4:	.short 0x00ff
 9e6:	.short 0xffb7
 9e8:	ori.b #7,d0
 9ec:	.short 0x03ff
 9ee:	.short 0xff6f
 9f0:	ori.b #7,d0
 9f4:	.short 0x03ff
 9f6:	.short 0xfeb7
 9f8:	ori.b #10,d0
 9fc:	.short 0x1fff
 9fe:	.short 0xfb6f
