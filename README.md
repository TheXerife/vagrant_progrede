## Projeto de Provisionamento com Vagrant e Shell Script

Este projeto demonstra a criação automatizada de duas máquinas virtuais utilizando **Vagrant** e **Shell Script**. As máquinas são configuradas da seguinte forma:

- **Firewall**: Atua como servidor DHCP e NAT.
- **Cliente**: Recebe IP via DHCP e roteia tráfego através do firewall.

## Tecnologias Utilizadas

- **VirtualBox** (7.1.10) — Hypervisor para máquinas virtuais.
- **Vagrant** (2.4.7) — Ferramenta para gerenciar ambientes de máquinas virtuais.
- **Shell Script** — Utilizado para o provisionamento automatizado das VMs.
- **Ubuntu 18.04** (bionic64) — Sistema operacional utilizado nas máquinas virtuais.

## Funcionalidade

- **Firewall**:
  - Instala o servidor DHCP (`isc-dhcp-server`).
  - Configura o DHCP para fornecer IPs dentro do intervalo de **192.168.56.100** a **192.168.56.200**.
  - Ativa NAT e configura as regras de **iptables** para o roteamento de tráfego.
  - Habilita o encaminhamento de IP para permitir o tráfego de uma rede para outra.

- **Cliente**:
  - Recebe um IP dinâmico via DHCP.
  - Configura o **firewall** como gateway padrão para roteamento de tráfego.

## Como Executar

### Pré-Requisitos

Antes de executar o projeto, certifique-se de ter os seguintes softwares instalados:

1. **[Vagrant](https://www.vagrantup.com/)**
2. **[VirtualBox](https://www.virtualbox.org/)**

## Instalação das Dependências

Para facilitar o processo de instalação das dependências, criamos um script **`Dependencias.bat`** que automatiza o download e a instalação do **VirtualBox** e do **Vagrant**.

### Como usar o `Dependencias.bat`:

1. Navegue até a pasta do projeto.

2. Execute o script **`Dependencias.bat`**. O script irá:
   - Baixar as dependências **VirtualBox 7.1.10** e **Vagrant 2.4.7** (caso ainda não estejam presentes).
   - Instalar o **VirtualBox** e o **Vagrant** automaticamente.

3. Para executar o script, basta rodar o seguinte comando no terminal:

   ```bash
   .\projetto-iac\Dependencias.bat

### Passos para Execução

1. Clone este repositório ou baixe o código para sua máquina local.
2. Abra o terminal na pasta onde o projeto foi baixado.
3. Execute o comando abaixo para inicializar as VMs e aplicar as configurações automáticas:

```bash
vagrant up
```


## Diagrama de Arquitetura (Ilograph)

Abaixo está o diagrama da arquitetura do projeto representado em **[Ilograph](https://app.ilograph.com/)**

![Texto alternativo](URL-ou-caminho-da-imagem)

```yaml
resources:
- name: Vagrant Progrede
  subtitle: Simulação de rede local
  color: Navy
  icon: Networking/cloud-network.svg
  children:
    - name: Servidor
      subtitle: VM com DHCP + Firewall
      color: RoyalBlue
      icon: Networking/server.svg
      children:
        - name: DHCP
          subtitle: Serviço de IP Dinâmico
          icon: Networking/cloud-server.svg
        - name: Firewall
          subtitle: Regras de IPTables
          icon: Networking/firewall.svg
    - name: Cliente
      subtitle: VM com IP dinâmico via DHCP
      color: DarkGreen
      icon: Networking/workstation.svg

- name: Scripts de Provisionamento
  subtitle: Arquivos shell usados no setup
  color: DimGray
  style: plural
  icon: Documents/script.svg
  children:
    - name: Vagrantfile
      subtitle: Define rede e VMs
      icon: Networking/cloud-server.svg
    - name: firewall.sh
      subtitle: Aplica regras de firewall
    - name: dhcp.sh
      subtitle: Configura o servidor DHCP
    - name: servidor.sh
      subtitle: Inicializa o servidor
    - name: cliente.sh
      subtitle: Inicializa o cliente

perspectives:
- name: Fluxo de Rede
  relations:
    - from: Cliente
      to: DHCP
      label: Solicita IP via DHCP
    - from: DHCP
      to: Cliente
      label: Fornece IP
    - from: Firewall
      to: Cliente
      label: Permite/Deny acesso
    - from: Vagrantfile
      to: Servidor, Cliente
      label: Cria VM e conecta rede
  notes: |-
    Este diagrama mostra a arquitetura do projeto `vagrant_progrede`, que simula uma rede local com duas VMs usando Vagrant.

    - O **Cliente** recebe IP dinâmico via **DHCP**.
    - O **Servidor** aplica regras de firewall via `firewall.sh`.
    - Todos os scripts são definidos no `Vagrantfile`.
```


