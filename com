apt update && apt upgrade -y && apt install git -y && git clone https://github.com/Kavindu-Deshapriya/build && cd build && chmod +x script.sh && ./script.sh
