import socket
import threading
import struct

threads = [ ]
clientNumber = 0
stop = False
mylock = threading.Lock()
endingThread = 0


def function(c):
    global threads, clientNumber, stop, mylock
    msg = 'Hello client#'+ str(clientNumber)
    c.sendall(str.encode(msg))
    while stop == False:
        data = c.recv(4)
        number = struct.unpack('!I', data)[0]
        if (number != 0):
            c.sendall(struct.pack('!I', number*2))
        else:
            mylock.acquire()
            stop = True
            endingThread = threading.get_ident()
            mylock.release()
    if (endingThread == threading.get_ident()):
        c.sendall(struct.pack('!I', 0))
    else:
        c.sendall(struct.pack('!I', -1))
    c.close()

if __name__ == "__main__":
    host = '0.0.0.0'
    port = 7777
    addr = (host, port)

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind(addr)
    s.listen(5)
    while True:
        c, addr = s.accept()
        t = threading.Thread(target=function, args=(c,))
        threads.append(t)
        clientNumber += 1
        print("Client #", clientNumber, "was accepted")
        t.start()
