class: center, middle

# [MyWorkflow.jl](https://github.com/terasakisatoshi/MyWorkflow.jl) の宣伝

ごまふあざらし

---

# Motivation

- プログラミング言語の学習における学習者の負荷を軽減するため
  - 環境構築
  - Jupyter Notebook の管理
  - パッケージ構成
  - テスト/CI/CD をどうするか？
  - 公開/配布をどうするか？

---

# Have a try!

- https://mybinder.org/ を利用して Julia の環境が手元になくても Web で動かすことができる.

## Example

  - MyWorkflow.jl master (nightly) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/terasakisatoshi/MyWorkflow.jl/master) Julia v1.6.1

  - MyWorkflow.jl v0.24.0 (stable) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/terasakisatoshi/MyWorkflow.jl/v0.24.0) Julia v1.6.1

---

# Result (Part 1)

<img width="800" alt="Screen Shot 2021-05-23 at 17 53 37" src="https://user-images.githubusercontent.com/16760547/119254180-e3e5d400-bbef-11eb-82f2-4cf07c1b91f4.png">

---

# Result (Part 2)

<img width="600" alt="Screen Shot 2021-05-23 at 17 55 13" src="https://user-images.githubusercontent.com/16760547/119254221-1263af00-bbf0-11eb-8a06-dc8820776cd4.png">

---

# Usage (Part 1)

- Install Docker and Docker Compose. see the following link to learn more with your operating system:
  - [Install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/)
  - [Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)
  - [Get Docker Engine - Community for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

- To test out you've installed docker, just try:

```console
$ docker run --rm -it julia
# some staff happens ...
```

---

# Usage (Part 2)

```console
$ https://github.com/terasakisatoshi/MyWorkflow.jl.git
$ make
$ docker-compose up lab
Docker Compose is now in the Docker CLI, try `docker compose up`
Starting mylab ... done
Attaching to mylab
# some staff happens...
mylab      |
mylab      |     To access the server, open this file in a browser:
mylab      |         file:///root/.local/share/jupyter/runtime/jpserver-1-open.html
mylab      |     Or copy and paste one of these URLs:
mylab      |         http://1bafb42c152f:8888/lab?token=xxxxx...
mylab      |         http://127.0.0.1:8888/lab?token=xxxxx...
```

Open a Browser and go to `http://localhost:8888/lab?token=xxxxx...`


---

# Result

<img width="800" src="https://user-images.githubusercontent.com/16760547/119253138-c3ffe180-bbea-11eb-888b-424d5896f47e.png">

---

# Result (Gif)

<img width="800" src="https://user-images.githubusercontent.com/16760547/119253679-4f7a7200-bbed-11eb-812a-ac4bd50d5a5e.gif">

---

class: center, middle

# おちまい

