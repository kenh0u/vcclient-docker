FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y git wget gcc g++ portaudio19-dev && \
    cd && \
    wget https://repo.anaconda.com/archive/Anaconda3-2023.03-1-Linux-x86_64.sh && \
    bash Anaconda3-2023.03-1-Linux-x86_64.sh -b && \
    rm Anaconda3-2023.03-1-Linux-x86_64.sh && \
    export PATH=/root/anaconda3/bin:$PATH && \
    conda init && \
    conda create -n vcclient python=3.10 && \
    echo "conda activate vcclient" >> /root/.bashrc

ENV PATH /root/anaconda3/bin:$PATH
SHELL ["conda","run","-n","vcclient","/bin/bash","-c"]

RUN cd && \
    git clone https://github.com/w-okada/voice-changer.git && \
    cd voice-changer/server && \
    git clone https://github.com/isletennos/MMVC_Client.git MMVC_Client_v13 && \
    git clone https://github.com/isletennos/MMVC_Client.git MMVC_Client_v15 && \
    git clone https://github.com/StarStringStudio/so-vits-svc.git so-vits-svc-40 && \
    cp -r so-vits-svc-40 so-vits-svc-40v2 && \
    cd so-vits-svc-40v2 && git checkout 08c70ff3d2f7958820b715db2a2180f4b7f92f8d && cd .. && \
    git clone https://github.com/yxlllc/DDSP-SVC.git DDSP-SVC && \
    git clone https://github.com/liujing04/Retrieval-based-Voice-Conversion-WebUI.git RVC && \
    pip install -r requirements.txt

WORKDIR /root/voice-changer/server

ENTRYPOINT ["conda","run","--no-capture-output","-n","vcclient","python3","MMVCServerSIO.py","--https","true","--content_vec_500","pretrain/checkpoint_best_legacy_500.pt","--hubert_base","pretrain/hubert_base.pt","--hubert_soft","pretrain/hubert/hubert-soft-0d54a1f4.pt","--nsf_hifigan","pretrain/nsf_hifigan/model","--hubert_base_jp","pretrain/rinna_hubert_base_jp.pt","--model_dir","models"]
CMD ["-p","18888"]
