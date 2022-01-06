import socket
import struct
import time

if __name__ == '__main__':
    try:
        s = socket.create_connection(('192.168.207.128', 7777))
    except socket.error as msg:
        print("Error: ", msg.strerror)
        exit(-1)

    finished = False
    data = s.recv(1024)
    print(data.decode('ascii'))


    while not finished:
        num = int(input("Give the number :"))
        try:
            s.sendall(struct.pack('!I', num))
            data = s.recv(4)
        except socket.error as msg:
            print('Error: ', msg.strerror)
            s.close()
            exit(-2)
        receivedNumber = struct.unpack('!I', data)[0]
        print(receivedNumber)
        if (receivedNumber == 0 or receivedNumber == -1):
            finished = True
        else:
            print ('Received from server : ', struct.unpack('!I', data)[0])
        time.sleep(0.25)
    s.close()
    if  (receivedNumber == 0):
        print('I sent 0')
    else:
        print('Not me')
           