#!/bin/bash

echo "[FIREWALL] Atualizando pacotes..."
sudo apt-get update -y

echo "[FIREWALL] Instalando servidor DHCP e iptables-persistent..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y isc-dhcp-server iptables-persistent

echo "[FIREWALL] Configurando DHCP..."
cat <<EOF | sudo tee /etc/dhcp/dhcpd.conf > /dev/null
default-lease-time 600;
max-lease-time 7200;
subnet 192.168.56.0 netmask 255.255.255.0 {
  range 192.168.56.100 192.168.56.200;
  option routers 192.168.56.10;
  option domain-name-servers 8.8.8.8, 8.8.4.4;
}
EOF

echo "[FIREWALL] Definindo interface de escuta do DHCP..."
sudo sed -i 's/^INTERFACESv4=.*/INTERFACESv4="enp0s8"/' /etc/default/isc-dhcp-server

echo "[FIREWALL] Ativando encaminhamento de IP..."
sudo sed -i 's/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sudo sysctl -w net.ipv4.ip_forward=1

echo "[FIREWALL] Limpando regras antigas do iptables..."
sudo iptables -F
sudo iptables -t nat -F

echo "[FIREWALL] Definindo políticas padrão..."
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

echo "[FIREWALL] Regras de entrada seguras..."
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p icmp -j ACCEPT

echo "[FIREWALL] Regras de NAT e encaminhamento..."
sudo iptables -A FORWARD -i enp0s8 -o enp0s3 -j ACCEPT
sudo iptables -A FORWARD -i enp0s3 -o enp0s8 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE

echo "[FIREWALL] Salvando regras do iptables..."
sudo netfilter-persistent save

echo "[FIREWALL] Reiniciando e habilitando serviço DHCP..."
sudo systemctl restart isc-dhcp-server
sudo systemctl enable isc-dhcp-server

echo "[FIREWALL] Configuração finalizada com sucesso!"
