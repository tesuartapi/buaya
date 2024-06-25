FROM asia-docker.pkg.dev/vertex-ai/training/tf-tpu-pod-base-cp38:latest
WORKDIR /

# Download and install `tensorflow`.
RUN wget https://storage.googleapis.com/cloud-tpu-tpuvm-artifacts/tensorflow/tf-2.8.0/tensorflow-2.8.0-cp38-cp38-linux_x86_64.whl
RUN pip3 install tensorflow-2.8.0-cp38-cp38-linux_x86_64.whl
RUN rm tensorflow-2.8.0-cp38-cp38-linux_x86_64.whl

# Download and install `libtpu`.
# You must save `libtpu.so` in the '/lib' directory of the container image.
RUN wget https://storage.googleapis.com/cloud-tpu-tpuvm-artifacts/libtpu/1.2.0/libtpu.so -O /lib/libtpu.so
RUN chmod 777 /lib/libtpu.so

# Copies the trainer code to the docker image.
COPY trainer /trainer
# Sets up the entry point to invoke the trainer.
ENTRYPOINT ["python", "-m", "trainer.task"]
