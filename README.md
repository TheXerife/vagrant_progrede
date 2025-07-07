# vagrant_progredes

# Projeto de Provisionamento com Vagrant e Shell Script

Este projeto demonstra a criação automatizada de duas máquinas virtuais usando **Vagrant** e **Shell Script**:

**Firewall**: atua como servidor DHCP e NAT.
**Cliente**: recebe IP via DHCP e roteia tráfego pelo firewall.




Tecnologias Utilizadas

 - VirtualBox (7.1.10)
 - Vagrant (2.4.7)
 - Shell Script (provisionamento)
 - Ubuntu 18.04 (bionic64)



Como executar

> **Pré-requisitos:**  
>  Instale o [Vagrant](https://www.vagrantup.com/) 
>  Instale o [VirtualBox](https://www.virtualbox.org/)

Depois, abra o terminal na pasta "projetto-iac" e execute:

```bash
vagrant up
```

O que é configurado automaticamente
VM: firewall
Instala o isc-dhcp-server

Configura o DHCP para entregar IPs entre 192.168.56.100 e 192.168.56.200

Ativa NAT e regras de iptables

Habilita encaminhamento IP

VM: cliente
Recebe IP via DHCP

Define o firewall como gateway padrão

- Eduarda Thamyres Flores
- Gustavo Luiz Xavier

Aluno de Redes de Computadores — 2025

Projeto para a disciplina de Programação para Redes
