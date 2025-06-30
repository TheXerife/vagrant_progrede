Vagrant.configure("2") do |config|
  # ------------------------
  # Servidor DHCP
  # ------------------------
  config.vm.define "servidor" do |srv|
    srv.vm.box = "ubuntu/jammy64"
    srv.vm.hostname = "servidor"
    srv.vm.network "private_network", ip: "192.168.56.10"

    srv.vm.provision "shell", inline: <<-SHELL
      sudo apt update
      sudo apt install -y isc-dhcp-server

      echo 'INTERFACESv4="eth1"' | sudo tee /etc/default/isc-dhcp-server

      sudo bash -c 'cat > /etc/dhcp/dhcpd.conf' <<EOF
subnet 192.168.56.0 netmask 255.255.255.0 {
  range 192.168.56.100 192.168.56.200;
  option routers 192.168.56.1;
  option domain-name-servers 8.8.8.8;
}
EOF

      sudo systemctl restart isc-dhcp-server
    SHELL
  end

  # ------------------------
  # Cliente DHCP
  # ------------------------
  config.vm.define "cliente" do |cli|
    cli.vm.box = "ubuntu/jammy64"
    cli.vm.hostname = "cliente"

    cli.vm.network "private_network", ip: "0.0.0.0", auto_config: false
    cli.vm.provision "shell", inline: <<-SHELL
      sudo dhclient -v eth1
    SHELL
  end
end
