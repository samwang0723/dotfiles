# Coding necessary Installation & Tools

*iTerm2 + Oh-My-Zsh - https://technofob.com/2020/12/24/the-ultimate-mac-m1-terminal-iterm2-oh-my-zsh-zsh-syntax-highlighting/*
*Golang - https://golang.org/doc/tutorial/getting-started*
*NeoVim - https://amikai.github.io/2021/08/16/go_neovim_env_0.5/*
*Homebrew - https://www.cyberciti.biz/faq/how-to-install-homebrew-on-macos-package-manager/*

## pre-commit

    $ brew install pre-commit
    $ touch .pre-commit-config.yaml
    $ pre-commit install

## Ripgrep (file seaching)

    brew install ripgrep

## Simple HTTP server to serve files locally

    python -m http.server

## Kafka

    /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server kafka:9092 --list
    /opt/bitnami/kafka/bin/kafka-topics.sh --bootstrap-server kafka:9092 --create --topic {{topic}} --replication-factor 1 --partitions 1

## Docker
Docker build
```bash
docker build -t samwang0723/{image-name}:latest -f Dockerfile .
docker image ls
docker rmi ${image_id}
docker run -p 8080-8081:8080-8081 -p 80:80--name {container-name}- -env-file=./.env samwang0723/{image-name}
```
Docker buildx on M1/M2/M3 Mac
```bash
docker buildx create --name m1-builder
docker buildx use m1-builder
docker buildx inspect --bootstrap
docker buildx build --load --platform=linux/amd64 -t samwang0723/{image-name}:latest -f Dockerfile .
docker push samwang0723/{image-name}:latest
```

## Port being taken after program shutdown unexpected

    sudo lsof -i tcp:{{port}}

## Cog commit messages
[*https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines*](https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#-commit-message-guidelines)

- ***build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)*
- ***ci**: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)*
- ***docs**: Documentation only changes*
- ***feat**: A new feature*
- ***fix**: A bug fix*
- ***perf**: A code change that improves performance*
- ***refactor**: A code change that neither fixes a bug nor adds a feature*
- ***style**: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)*
- ***test**: Adding missing tests or correcting existing tests*

**`*cog commit`** provides a set of predefined arguments that correspond to conventional commit types and the Angular commit convention. These arguments include **`feat`**, **`fix`**, **`style`**, **`build`**, **`refactor`**, **`ci`**, **`test`**, **`perf`**, **`chore`**, **`revert`**, and **`docs`**[2](https://docs.cocogitto.io/guide/#:~:text=cog%20commit%20allows%20you%20to,perf%2C%20chore%2C%20revert%2C%20docs).*


