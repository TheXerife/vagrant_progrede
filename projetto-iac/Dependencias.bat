@echo off
echo Baixando o VirtualBox 7.1.10...
powershell -Command "Invoke-WebRequest -Uri https://download.virtualbox.org/virtualbox/7.1.10/VirtualBox-7.1.10-158379-Win.exe -OutFile VirtualBox-installer.exe"

echo Baixando o Vagrant 2.4.7...
powershell -Command "Invoke-WebRequest -Uri https://releases.hashicorp.com/vagrant/2.4.7/vagrant_2.4.7_x86_64.msi -OutFile vagrant-installer.msi"

echo Downloads concluídos.
pause
]