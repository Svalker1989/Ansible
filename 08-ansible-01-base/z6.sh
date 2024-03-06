#! /bin/bash
inventory="/home/str/ansible/08-ansible-01-base/playbook/inventory/prod.yml"
playbook="/home/str/ansible/08-ansible-01-base/playbook/site.yml"
bash -c 'sudo docker compose -f ./docker-compose.yml up -d'
cont_deb=$(sudo docker ps -a | grep ubuntu | awk '{print $1}')
cont_el=$(sudo docker ps -a | grep centos | awk '{print $1}')
cont_fed=$(sudo docker ps -a | grep fedora | awk '{print $1}')
bash -c "sudo docker exec -it $cont_deb apt update" 
bash -c "sudo docker exec -it $cont_deb apt install python3 -y"
bash -c "sudo ansible-playbook -i $inventory $playbook"
bash -c "sudo docker container stop $cont_deb $cont_el $cont_fed"
bash -c "sudo docker container rm $cont_deb $cont_el $cont_fed"