#include <stdio.h>
#include <stdint.h>
#include <time.h>

uint8_t cnt(double ReZ,double ImZ,double ReC,double ImC){
    uint8_t k=0;
    while(k < 255){
        double new_ReZ = ReZ * ReZ - ImZ * ImZ + ReC ;
        double new_ImZ = 2 * ReZ * ImZ + ImC;
        if (new_ReZ * new_ReZ+new_ImZ * new_ImZ>4){
            return k;
        }
        ReZ = new_ReZ;
        ImZ = new_ImZ;
        k+=1;
    }
    return k;
}


int main()
{
    clock_t start,end;
    start = clock();
    int M = 1250;
    int N = 1250;
    uint8_t grid[M][N];
    double init_Re = 0.0;
    double init_Im = 0.0;
    for (int j = 0; j < M; j++)
    {
        for (int i = 0; i < N; i++)
        {
            double ReC = 4.0 / (N - 1) * i - 2.0;
            double ImC = 4.0 / (M - 1) * j - 2.0;
            double ReZ = init_Re;
            double ImZ = init_Im;
            grid[j][i] = cnt(ReZ,ImZ,ReC,ImC);
        }
    }
    end = clock();
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Elapsed time %f [sec]\n", cpu_time_used);
    FILE *fp;
    fp = fopen("/tmp/benchC.txt", "w");
    for (int j = 0; j < M; j++)
    {
        for (int i = 0; i < N; i++)
        {
            fprintf(fp, "%d", grid[j][i]);
            if (i != N - 1)
            {
                fprintf(fp, ",");
            }
            else
            {
                fprintf(fp, "\n");
            }
        }
    }
    fclose(fp);
    return 0;
}