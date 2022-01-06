#include <Winsock2.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>

#define max 100

int main()
{
    int c, cod;
    int32_t r;
    uint16_t nr;

    struct sockaddr_in server;
    char s[max];

    c = socket(PF_INET, SOCK_STREAM, 0);
    if (c < 0)
    {
        fprintf("Eroare la creare socket client\n");
        return -1;
    }

    memset(&server, 0, sizeof(struct sockaddr_in));
    server.sin_family = AF_INET;
    server.sin_port = htons(4321);
    server.sin_addr.s_addr = inet_addr("192.168.207.128");

    cod = connect(c, (struct sockaddr *)&server, sizeof(struct sockaddr_in));
    if (cod < 0)
    {
        fprintf(stderr, "Eroare la conectare la server");
        return 1;
    }

    printf("Dati un numar");
    //fgets(s, max, stdin);
    scanf("%hu", &nr);

    //cod = send(c, s, strlen(s) + 1, 0);
    cod = send(c, &nr, sizeof(nr), 0);
    r = ntohl(r);

}

