//
// Created by gatovsky on 01/04/22.
//

#ifndef GATO_APP_H
#define GATO_APP_H
#include <iostream>
#include <random>
#include <functional>

using namespace std;


class App {

public:
    App();
    static void loop(char (*arr)[3]);
    static void Intro_first(char (*arr)[3]);
    static void Dibujar_Tablero(char (*arr)[3]);
    static void Intro_User(char (*arr)[3]);
    static void Intro_CPU(char (*arr)[3]);
    static void MessageOwO(char (*arr)[3], int i, int j);
    static int Verificar_casilla(char (*arr)[3], int i, int j);
    static char Victoria(char (*arr)[3]);

};


#endif //GATO_APP_H
