#include "../include/myfilefunctions.h"
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LEN 1024
#define INITIAL_MATCH_CAPACITY 8

int wordCount(FILE* file, int* lines, int* words, int* chars)
{
    if (file == NULL || lines == NULL || words == NULL || chars == NULL)
        return -1;

    rewind(file);

    *lines = 0;
    *words = 0;
    *chars = 0;

    int c;
    int inWord = 0;

    while ((c = fgetc(file)) != EOF)
    {
        (*chars)++;

        if (c == '\n')
        {
            (*lines)++;
        }

        if (c == ' ' || c == '\n' || c == '\t')
        {
            inWord = 0;
        }
        else if (inWord == 0)
        {
            inWord = 1;
            (*words)++;
        }
    }

    rewind(file);
    return 0;
}

int mygrep(FILE* fp, const char* search_str, char*** matches)
{
    if (fp == NULL || search_str == NULL || matches == NULL)
        return -1;

    rewind(fp);

    int capacity = INITIAL_MATCH_CAPACITY;
    int count = 0;
    char** results = malloc(capacity * sizeof(char*));
    if (results == NULL)
        return -1;

    char line[MAX_LINE_LEN];

    while (fgets(line, MAX_LINE_LEN, fp) != NULL)
    {
        int len = strlen(line);
        if (len > 0 && line[len - 1] == '\n')
        {
            line[len - 1] = '\0';
        }

        if (strstr(line, search_str) != NULL)
        {
            if (count == capacity)
            {
                capacity *= 2;
                char** newResults = realloc(results, capacity * sizeof(char*));
                if (newResults == NULL)
                {
                    for (int i = 0; i < count; i++)
                    {
                        free(results[i]);
                    }
                    free(results);
                    return -1;
                }
                results = newResults;
            }

            results[count] = malloc(strlen(line) + 1);
            if (results[count] == NULL)
            {
                for (int i = 0; i < count; i++)
                {
                    free(results[i]);
                }
                free(results);
                return -1;
            }
            strcpy(results[count], line);
            count++;
        }
    }

    rewind(fp);
    *matches = results;
    return count;
}
