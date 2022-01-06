import socket
import threading

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

client.connect(('192.168.207.128', 7000))

address = ''

def receive():
    global address
    while True:
        try:
            message = client.recv(1024).decode('ascii')
            if message.find('You are now connected: ') == 0:
                #client.send(nickname.encode('ascii'))
                address = message[message.find('('):len(message)]
                print('Your address is ' + address)
            else:
                print(message)
        except:
            print("You are disconnected from the server")
            client.close()
            break

def write():
    global address
    while True:
        msg = input()
        #message = f'{address}' + f': {input()}'
        message = address + ": " + msg
        client.send(message.encode('ascii'))
        if (msg == 'quit'):
            client.send("I'm out".encode('ascii'))
            client.close()

if __name__ == '__main__':
    receive_thread = threading.Thread(target=receive)
    receive_thread.start()
    write_thread = threading.Thread(target=write)
    write_thread.start()