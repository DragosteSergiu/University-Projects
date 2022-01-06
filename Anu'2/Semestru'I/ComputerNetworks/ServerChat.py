import socket
import threading

host = '127.0.0.1'
port = 7777

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((host, port))
s.listen()

clients = [ ]
nicknames = [ ]

def broadcast(message):
    global clients
    for client in clients:
        client.send(message)

def handler(client):
    global clients, nicknames
    while True:
        try:
            message = client.recv(1024)
            broadcast(message)
        except:
            index = clients.index(client)
            clients.remove(client)
            client.close()
            nickname = nicknames[index]
            broadcast(f'{nickname} left the chat'.encode('ascii'))
            nicknames.remove(nickname)
            break

def receive():
    while True:
        client, address = s.accept()
        print(f'Connected with {str(address)}')

        client.send('Nick: '.encode('ascii'))
        nickname = client.recv(1024).decode('ascii')
        nicknames.append(nickname)
        clients.append(client)

        print(f'Nickname of the client is {nickname}')
        broadcast(f'{nickname} joined this chat'.encode('ascii'))
        client.send('Connected to the server'.encode('ascii'))

        thread = threading.Thread(target=handler, args=(client,))
        thread.start()

if __name__ == '__main__':
    receive()




