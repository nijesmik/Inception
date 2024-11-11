# Docker Compose

- 여러 개의 도커 컨테이너를 하나의 애플리케이션으로 정의하고 실행하기 위한 도구
- 주로 개발 환경에서 여러 개의 도커 컨테이너를 쉽게 관리하고자 할 때 사용
- `docker-compose.yml` 파일에 서비스들의 설정을 정의하고, `docker compose` 명령어로 서비스들을 관리

## 명령어

1. `docker compose up`

- `docker-compose.yml` 파일에 정의된 서비스들을 시작하고, 필요한 이미지가 없으면 이미지를 빌드하거나 다운로드해서 실행
- 옵션:
    - `-d` : 백그라운드 모드로 컨테이너를 실행하여 터미널에서 분리
    - `--build` : 기존 이미지가 있어도 강제로 다시 빌드하여 서비스를 시작

2. `docker compose down`

- `docker compose up`으로 생성된 모든 컨테이너, 네트워크 등을 중지하고 삭제
- 옵션:
    - `-v` : 컨테이너가 사용하는 익명 및 명시적 볼륨도 함께 삭제
    - `--rmi all` : 컨테이너와 함께 빌드한 모든 이미지를 삭제

3. `docker compose build`

- `docker-compose.yml` 파일에 정의된 서비스들을 위한 이미지를 빌드
- `-up` 명령어와 달리 컨테이너를 실행하지 않고 이미지만 생성
- 옵션:
    - `--no-cache` : 캐시를 사용하지 않고 이미지를 빌드하여 최신 상태로 생성
    - `--pull` : 빌드 전에 최신 이미지가 있는지 확인하고 가져옴


4. `docker compose stop`

- 실행 중인 모든 컨테이너를 중지
- 컨테이너는 삭제되지 않으며, 언제든지 `start` 명령어로 다시 시작 가능

5. `docker compose start`

- 중지된 컨테이너들을 다시 시작
- 새로 컨테이너를 생성하지 않으며, `up`과 달리 컨테이너가 이미 있는 경우에만 동작

## `docker-compose.yml`

### `networks`

여러 컨테이너 간의 네트워크 연결을 정의하고, 컨테이너들이 서로 통신할 수 있도록 설정

1. `networks` 정의의 위치

`docker-compose.yml` 파일의 `networks`는 두 가지 위치에서 정의될 수 있다.

- 글로벌 네트워크: `networks`라는 최상위 키로 설정하여 네트워크의 유형과 구성을 정의
- 서비스별 네트워크: 각 서비스(`services` 섹션) 내부에 설정하여 특정 서비스가 연결할 네트워크를 지정

```yaml
# 예시

# 글로벌 네트워크 정의
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge

# 서비스별 네트워크 지정
services:
  web:
    image: nginx
    networks:
      - frontend
  api:
    image: myapi
    networks:
      - frontend
      - backend
  db:
    image: mysql
    networks:
      - backend
```

2. 네트워크 유형 (`driver` 옵션)

Docker Compose에서 `driver` 옵션으로 네트워크의 유형을 지정할 수 있다.

- `bridge`: 기본 드라이버로, 각 컨테이너에 가상 네트워크 인터페이스를 연결하고 독립적인 네임스페이스를 제공하여, 컨테이너들이 호스트의 네트워크로부터 분리된 상태에서 통신하도록 한다.
- `host`: 호스트 네트워크를 사용하는 드라이버로, 컨테이너가 호스트와 동일한 네트워크 인터페이스를 사용한다. 컨테이너와 호스트 간 네트워크 분리를 원하지 않을 때 사용한다.
- `overlay`: 여러 Docker 호스트에 걸쳐 네트워크를 구축하는 데 사용된다. 클러스터에서 서비스가 서로 통신할 수 있도록 해주며, 주로 Docker Swarm과 함께 사용한다.