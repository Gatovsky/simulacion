import random
import time
import tkinter as tk


##----------- MOSTRAR LAS IMÁGENES DE LOS DADOS LANZADOS --------------##

def ventana(dado1, dado2):
    ventana = tk.Tk()
    ventana.title("Dados")
    ventana.geometry("1050x800")
    img1 = tk.PhotoImage(file="/home/gatovsky/simulacion/dados/imagenes_dados/"+dado1+".png")
    img2 = tk.PhotoImage(file="/home/gatovsky/simulacion/dados/imagenes_dados/"+dado2+".png")
    canvas1 = tk.Canvas(ventana, width=1050, height=800, background="dodgerblue")
    canvas1.grid(column=0, row=0)
    canvas1.create_image(0, 100, image=img1, anchor="nw")
    canvas1.create_image(538, 100, image=img2, anchor="nw")
    # tk.Button(ventana, text = "Quit", command = ventana.destroy)
    ventana.mainloop()


def dados():
    lanzar_dados = True

    print("\nLANZAMIENTO DE DADOS INICIA SIN PREVIO AVISO\n")
    time.sleep(1)

    while lanzar_dados:
        print("Lanzando dados....")
        time.sleep(2)
        dado1 = random.randint(1, 6)
        dado2 = random.randint(1, 6)

        id_dado1 = "dado"+str(dado1)
        id_dado2 = "dado"+str(dado2)

        ventana(id_dado1, id_dado2)

        time.sleep(0.3)
        print("Continuar lanzando?")

        lanzar_dados = "s" in input().lower()

    print("\nadiós")


def main():
    dados()


if __name__ == '__main__':
    main()
