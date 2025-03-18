sudo apt update && sudo apt upgrade -y && sudo apt install git -y && git clone https://github.com/Kavindu-Deshapriya/build && cd build && chmod +x build.sh && ./build.sh
