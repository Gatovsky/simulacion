//
// Created by gatovsky on 01/04/22.
//

#include "App.h"


void App::loop(char (*arr)[3]) {
    int i = 0;
    char j;
    Intro_first(arr);

    do {
        system("clear");
        Dibujar_Tablero(arr);
        //std::cout << "\x1B[2J\x1B[H";
        //¿Quién va primero?
        if (i % 2 == 0){
            Intro_User(arr);
        } else{
            Intro_CPU(arr);
        }

        j = Victoria(arr);
        i++;
    } while (i <= 9 && j == 'e');

    system("clear");
    Dibujar_Tablero(arr);

    if(j == 'X'){
        std::cout << "Victoria para el usuario." << std::endl;
    }else if (j == 'O'){
        std::cout << "Victoria para CPU." << std::endl;
    }else if (j == 'e'){
        std::cout << "Empate." << std::endl;
    }
}

void App::Intro_first(char (*arr)[3]) {
    char numero_casilla = '1';
    for(int i=0; i<3; i++){
        for(int j=0; j<3; j++){
            arr[i][j]=numero_casilla++;
        }
    }
}

void App::Dibujar_Tablero(char (*arr)[3]) {
    for(int i=0; i<3; i++){
        for(int j=0; j<3; j++){
            if (j > 0 && j < 3){
                std::cout << "  ║  " << arr[i][j];
            } else{
                std::cout << "  " << arr[i][j];
            }
        }
        if(i < 2){
            std::cout <<"\n ═══════════════\n";
        }
    }
    std::cout << std::endl;
    std::cout << std::endl;
}

void App::Intro_User(char (*arr)[3]) {
    char tmp; int i, j, k;
    do{
        do{
            std::cout <<"\nColaca tu ficha: " << std::endl;
            fflush(stdin);
            std::cin >> tmp;
        } while (tmp < '1' || tmp > '9');

        k = 0;
        switch (tmp) {
            case '1':{
                i = 0; j= 0;
                k = Verificar_casilla(arr, i, j);
                break;
            }
            case '2':{
                i = 0; j= 1;
                k = Verificar_casilla(arr, i, j);
                break;
            }
            case '3':{
                i = 0; j= 2;
                k = Verificar_casilla(arr, i, j);
                break;
            }
            case '4':{
                i = 1; j= 0;
                k = Verificar_casilla(arr, i, j);
                break;
            }
            case '5':{
                i = 1; j= 1;
                k = Verificar_casilla(arr, i, j);
                break;
            }
            case '6':{
                i = 1; j= 2;
                k = Verificar_casilla(arr, i, j);
                break;
            }
            case '7':{
                i = 2; j= 0;
                k = Verificar_casilla(arr, i, j);
                break;
            }
            case '8':{
                i = 2; j= 1;
                k = Verificar_casilla(arr, i, j);
                break;
            }
            case '9':{
                i = 2; j= 2;
                k = Verificar_casilla(arr, i, j);
                break;
            }
            default: break;

        }
    } while (k == 1);

    arr[i][j] = 'X';
}

void App::Intro_CPU(char (*arr)[3]) {
    int i, j, k;
    srand(time(NULL));

    do {

        //std::default_random_engine generator;
        //std::uniform_int_distribution<int> distribution(1, 3);
        //auto s = std::bind(distribution, generator);
        //int roll = s()

        i = rand() %3;
        j = rand() %3;
        //i = s() % int(1e4);
        //j = s() % int(1e4);
        k = 0;

        if(arr[i][j] == toupper('X') || arr[i][j] == toupper('O')){
            k = 1;
        }
    } while (k == 1);

    arr[i][j] = 'O';
}

void App::MessageOwO(char (*arr)[3], int i, int j) {
    std::cout << "Opps! " << arr[i][j] <<" exist. It's not empty Owo" << std::endl;
}

int App::Verificar_casilla(char (*arr)[3], int i, int j) {
    if(arr[i][j] == toupper('X') || arr[i][j] == toupper('O')){
        MessageOwO(arr, i, j);
        return 1;
    }else return 0;
}

char App::Victoria(char (*arr)[3]) {

    //Caso casilla primera [0,0] (1)
    if(arr[0][0] == toupper('X') || arr[0][0] == toupper('O')){
        //1, 2 ,3
        if(arr[0][0] == arr[0][1] && arr[0][0] == arr[0][2]){
            return arr[0][0];
        }
        //1, 4, 7
        if(arr[0][0] == arr[1][0] && arr[0][0] == arr[2][0]){
            return arr[0][0];
        }
    }
    //Caso casilla central [1][1] (5)
    if(arr[1][1] == toupper('X') || arr[1][1] == toupper('O')){
        //1, 5, 9
        if(arr[1][1] == arr[0][0] && arr[1][1] == arr[2][2]){
            return arr[1][1];
        }
        //4, 5, 6
        if(arr[1][1] == arr[1][0] && arr[1][1] == arr[1][2]){
            return arr[1][1];
        }
        //7, 5, 3
        if(arr[1][1] == arr[2][0] && arr[1][1] == arr[0][2]){
            return arr[1][1];
        }
        //2, 5, 8
        if(arr[1][1] == arr[0][1] && arr[1][1] == arr[2][1]){
            return arr[1][1];
        }
    }
    //Caso casilla final [2,2] (9)
    if(arr[2][2] == toupper('X') || arr[2][2] == toupper('O')){
        //7, 8, 9
        if(arr[2][2] == arr[2][0] && arr[2][2] == arr[2][1]){
            return arr[2][2];
        }
        //3, 6 , 9
        if(arr[2][2] == arr[0][2] && arr[2][2] == arr[1][2]){
            return arr[2][2];
        }
    }
    return 'e';
}

App::App() = default;
