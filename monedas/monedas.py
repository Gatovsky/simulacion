import tkinter as tk
import random
import time


##----------- MOSTRAR LAS IMÁGENES DE LAS MONEDAS LANZADOS --------------##

def ventana(moneda1, moneda2):
    ventana = tk.Tk()
    ventana.title("Monedas")
    ventana.geometry("1050x800")
    img1 = tk.PhotoImage(file="/home/gatovsky/simulacion/monedas/imagenes_monedas/" + moneda1 + ".png")
    img2 = tk.PhotoImage(file="/home/gatovsky/simulacion/monedas/imagenes_monedas/" + moneda2 + ".png")
    canvas1 = tk.Canvas(ventana, width=1050, height=800, background="dodgerblue")
    canvas1.grid(column=0, row=0)
    canvas1.create_image(0, 100, image=img1, anchor="nw")
    canvas1.create_image(538, 100, image=img2, anchor="nw")
    ventana.mainloop()



##----------- LANZAR MONEDAS -----------##
def monedas():
    lanzar_monedas = True

    print("\nLANZAMIENTO DE MONEDAS INICIA SIN PREVIO AVISO\n")
    time.sleep(1)

    while lanzar_monedas:
        print("Lanzando monedas....")
        time.sleep(2)
        moneda1 = random.randint(1, 2)
        moneda2 = random.randint(1, 2)

        id_moneda1 = "moneda" + str(moneda1)
        id_moneda2 = "moneda" + str(moneda2)

        ventana(id_moneda1, id_moneda2)

        time.sleep(0.3)
        print("Continuar lanzando? s/n")

        lanzar_monedas = "s" in input().lower()

    print("\nadiós")


def main():
    monedas()


if __name__ == '__main__':
    main()
