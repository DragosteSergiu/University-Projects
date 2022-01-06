import socket
def Main():
    host = '192.168.207.128' 

    port = 7777
    addr = (host, port)

    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(addr)


    while True:
        message = input("introdu o comanda : ")
        text = str.encode(message)
        s.send(text)
        data = s.recv(1024)

        print("Primit de la server : ", data.decode())
        ok = input("\nDoresti sa continui?")
        if (ok == "da"):
            continue
        else:
            break
    s.close()
if __name__=='__main__':
    Main()
