#include<stdio.h>
#include<math.h>

int mygcd(int a, int b){
    int tmp;
    while (b != 0) {
        tmp = b;
        b = a % b;
        a = tmp;
    }
    return a;
}

double calcpi(int N){
    int cnt = 0;
    for (int a=1; a<=N; a++){
        for(int b=1; b<=N; b++){
            if (mygcd(a, b)==1){
                cnt++;
            }
        }
    }
    double prob = (double)cnt / N / N;
    return sqrt(6/prob);
}

int main(){
    double approx = calcpi(10000);
    printf("%.15f\n", approx);
    return 0;
}