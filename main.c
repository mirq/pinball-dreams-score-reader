#include <exec/types.h>
#include <intuition/intuition.h>
#include <proto/exec.h>
#include <proto/intuition.h>
#include <proto/dos.h>
#include <dos/dos.h>
#include <string.h>
#include <float.h>

struct IntuitionBase *IntuitionBase;
struct ExecBase *SysBase;
struct DosLibrary *DOSBase;

struct score
{
    char name[4];
    char score[17];
    short table;
};

typedef struct score Score;

char* my_strcpy(char* dest, const char* src) {
    char* original_dest = dest;

    // Copy characters from src to dest
    while ((*dest++ = *src++));

    return original_dest;
}


void my_strcat(char *dest, const char *src)
{
    // Find the end of dest
    while (*dest)
    {
        dest++;
    }

    // Copy characters from src to dest
    while ((*dest++ = *src++))
        ;
}

char *my_strchr(const char *str, int character)
{
    while (*str)
    {
        if (*str == character)
        {
            return (char *)str;
        }
        str++;
    }
    return NULL;
}

char *trim_start_chars(char *str, const char *chars_to_trim)
{
    if (!str || !chars_to_trim)
        return str;

    while (*str && my_strchr(chars_to_trim, *str))
    {
        str++;
    }

    return str;
}

char * getTableName(short tableId){
    switch (tableId)
    {
        case 1: return "Steel Wheel";
        case 2: return "BeatBox";
        case 3: return "Nightmare";
        default:
    return "Iginition";
        break;
    }
    return "Iginition";
}

static const UWORD stuffChar[] = {0x16c0, 0x4e75};

int main(void)
{

    SysBase = *((struct Library **)4UL);

    IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library", 37);
    if (!IntuitionBase)
    {
        return RETURN_FAIL;
    }

    DOSBase = OpenLibrary("dos.library", 0);
    if (!DOSBase)
    {
        CloseLibrary(IntuitionBase);
        return RETURN_FAIL;
    }

    BPTR fileHandler;
    STRPTR filename = "HI00";
    Score scores[16];

    LONG bytesRead;

    // Open the file for reading
    fileHandler = Open(filename, MODE_OLDFILE);

    if (!fileHandler)
    {
        Printf("Failed to open the file: %s\n", filename);
        return RETURN_FAIL;
    }
    else
    {
        Printf("File opened\n");
    }

    if (Seek(fileHandler, 10, OFFSET_BEGINNING) == -1)
    {
        Printf("Error occurred while seeking in the file.\n");
        Close(fileHandler);
        return 0;
    }

    int scoreNumber = 0;
    int validScoreNumber = 0;
    int tableNumber = 0;

   FLOAT flop = 2.3;
        FLOAT flip = flop / 2;
        DOUBLE flod = 2.3;
        DOUBLE flid = flod / 2;
        Printf("%3.4ld\n", flip);

    do
    {

        UBYTE name[4];
        bytesRead = Read(fileHandler, name, 4);
        if (bytesRead == 0)
            break;
        name[3] = '\0';

        BOOL nameIsValid = FALSE;
        if (name[0] != 'T' || name[1] != 'S' || name[2] != 'L')
        {
            nameIsValid = TRUE;
        }

 
        char byte;
     

        UBYTE scoreBytes[9];

        bytesRead = Read(fileHandler, scoreBytes, 8);

        if (nameIsValid)
        {
            my_strcpy(scores[validScoreNumber].name,name);
      
            scores[validScoreNumber].table = tableNumber;
            scoreBytes[8] = '\0';

            UBYTE buffer[17];
            UBYTE *bufPtr = buffer;

            LONG inputArray[8];

            for (int i = 0; i < 8; i++)
            {
                inputArray[i] = (LONG)scoreBytes[i];
            }

            RawDoFmt("%02lx%02lx%02lx%02lx%02lx%02lx%02lx%02lx", (APTR)&inputArray, stuffChar, bufPtr);

        

            char *trimmed = trim_start_chars(buffer, "0");

           

             my_strcpy(scores[validScoreNumber].score,trimmed);
            validScoreNumber++;
        }
        scoreNumber++;
        if (scoreNumber % 4 == 0)
        {
            tableNumber++;
        }
    } while (bytesRead > 0);

    Close(fileHandler);

    UBYTE choices[100] = "";
    struct EasyStruct es;
    LONG choice;

    es.es_StructSize = sizeof(struct EasyStruct);
    es.es_Flags = 0;
    es.es_Title = "Choose table";
    es.es_TextFormat = "I want to send score:";


    for (int i = 0; i < validScoreNumber; i++)
    {
        my_strcat(choices, getTableName(scores[i].table));
        my_strcat(choices, " ");
        my_strcat(choices, scores[i].score);
        my_strcat(choices, " ");
        my_strcat(choices, scores[i].name);
        my_strcat(choices, "|");
    }
    

    my_strcat(choices, "Exit");
    es.es_GadgetFormat = choices;

    choice = EasyRequestArgs(NULL, &es, NULL, NULL);
    switch (choice)
    {
   
    default:
        break;
    }

    Printf("%s\n", scores[choice-1].name);
    Printf("%s\n", scores[choice-1].score);
    Printf("\n");


    CloseLibrary((struct Library *)IntuitionBase);
    CloseLibrary((struct Library *)DOSBase);

    return RETURN_OK;
}
