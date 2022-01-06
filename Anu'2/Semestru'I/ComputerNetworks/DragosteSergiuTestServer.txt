import socket
import threading

host = '192.168.207.128'
port = 7000

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((host, port))
s.listen()

clients = [ ]
addresses = [ ]

def broadcast(message):
    global clients
    for client in clients:
        client.send(message)

def handler(client):
    global clients
    while True:
        try:
            message = client.recv(1024)
            if (message.decode('ascii').find('quit') < 0):
                broadcast(message)
            else:
                index = clients.index(client)
                clients.remove(client)
                client.close()
                addr = addresses[index]
                broadcast(f'{addr} left the chat'.encode('ascii'))
                addresses.remove(addr)
        except:
            if (len(clients) == 0):
                s.close()
def receive():
    while True:
        client, address = s.accept()
        print(f'Connected with {str(address)}')
        client.send(f'You are now connected: {address}'.encode('ascii'))
        clients.append(client)

        addresses.append(address)
        broadcast(f'{address} joined the server'.encode('ascii'))
        thread = threading.Thread(target=handler, args=(client,))
        thread.start()

if __name__ == '__main__':
    receive()
