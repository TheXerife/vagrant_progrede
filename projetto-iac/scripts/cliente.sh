#!/bin/bash

echo "[CLIENTE] Atualizando pacotes..."
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y

echo "[CLIENTE] Aguardando IP via DHCP..."
while ! ip addr show enp0s8 | grep -q "inet "; do
  echo "[CLIENTE] Aguardando enp0s8 obter IP..."
  sleep 1
done

echo "[CLIENTE] Redefinindo rota padrão para passar pelo firewall..."
sudo ip route del default || true
sudo ip route add default via 192.168.56.10 dev enp0s8

echo "[CLIENTE] Configuração finalizada com sucesso."
