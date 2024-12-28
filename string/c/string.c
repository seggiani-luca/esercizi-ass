#include <stdio.h>
#include <string.h>

char string1[80];
char string2[80];

void test_strlen() {
	scanf("%79[^\n]%*c", string1);

	unsigned int len = strlen(string1);	
	printf("%u\n", len);
}

void test_strcpy(int off1, int off2) {
	scanf("%79[^\n]%*c", string1);
	scanf("%79[^\n]%*c", string2);

	char* str1_p = string1 + off1;
	char* str2_p = string2 + off2;

	strcpy(str2_p, str1_p);

	printf("%s\n", string1);
	printf("%s\n", string2);
}

void test_strcmp() {
	scanf("%79[^\n]%*c", string1);
	scanf("%79[^\n]%*c", string2);

	int cmp = strcmp(string1, string2);
	
	if(cmp < 0) cmp = -1;
	if(cmp > 0) cmp = 1;

	printf("%d\n", cmp);
}

void test_strchr() {
	scanf("%79[^\n]%*c", string1);
	
	char c;
	scanf("%c", &c);

	char* pos = strchr(string1, c);
	unsigned int off = pos - string1;
	if(pos == 0) off = 0;

	printf("%u\n", off);
}

void test_strrchr() {
	scanf(" %79[^\n]%*c", string1);
	
	char c;
	scanf("%c", &c);

	char* pos = strrchr(string1, c);
	unsigned int off = pos - string1;
	if(pos == 0) off = 0;

	printf("%u\n", off);
}

int main() {
	printf("=> prova strlen\n");
	test_strlen();
	
	printf("=> prova strcpy 1\n");
	test_strcpy(0, 8);
	
	printf("=> prova strcpy 2\n");
	test_strcpy(8, 0);

	printf("=> prova strcmp\n");
	test_strcmp();
	
	printf("=> prova strchr\n");
	test_strchr();
	
	printf("=> prova strrchr\n");
	test_strrchr();

	return 0;
}
