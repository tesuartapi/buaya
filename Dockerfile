FROM gcr.io/deeplearning-platform-release/tf-cpu.2-9:latest
WORKDIR /
RUN apt update && apt -y install curl git wget
# Copies the trainer code to the docker image.
COPY trainer /trainer
# Sets up the entry point to invoke the trainer.
ENTRYPOINT ["python", "-m", "trainer.task"]
