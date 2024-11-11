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

1. `networks` 정의 위치

`docker-compose.yml` 파일의 `networks`는 두 가지 위치에서 정의될 수 있다.

- 글로벌 네트워크: `networks`라는 최상위 키로 설정하여 네트워크의 유형과 구성을 정의
- 서비스별 네트워크: 각 서비스(`services` 섹션) 내부에 설정하여 특정 서비스가 연결할 네트워크를 지정

2. 설정 구조

```yaml
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

3. 네트워크 유형 (`driver` 옵션)

Docker Compose에서 `driver` 옵션으로 네트워크의 유형을 지정할 수 있다.

- `bridge`: 기본 드라이버로, 각 컨테이너에 가상 네트워크 인터페이스를 연결하고 독립적인 네임스페이스를 제공하여, 컨테이너들이 호스트의 네트워크로부터 분리된 상태에서 통신하도록 한다.
- `host`: 호스트 네트워크를 사용하는 드라이버로, 컨테이너가 호스트와 동일한 네트워크 인터페이스를 사용한다. 컨테이너와 호스트 간 네트워크 분리를 원하지 않을 때 사용한다.
- `overlay`: 여러 Docker 호스트에 걸쳐 네트워크를 구축하는 데 사용된다. 클러스터에서 서비스가 서로 통신할 수 있도록 해주며, 주로 Docker Swarm과 함께 사용한다.

### `volumes`

**볼륨**은 데이터를 컨테이너 외부에 저장하여, 컨테이너가 삭제되더라도 데이터가 유지될 수 있도록 해준다. 이 기능은 특히 데이터베이스와 같은 데이터를 저장하는 서비스에서 유용하다.

1. `volumes` 정의 위치

`docker-compose.yml` 파일에서 `volumes`는 두 가지 위치에서 정의할 수 있다.

- 글로벌 볼륨: `volumes`라는 최상위 키로 정의하여 공유 볼륨을 설정하고, 여러 서비스에서 해당 볼륨을 사용
- 서비스별 볼륨: `services` 섹션 내의 특정 서비스에 볼륨을 설정하여 그 서비스에서 사용할 볼륨을 지정

2. 설정 구조

```yaml
# 글로벌 볼륨 정의
volumes:
  db-data:

# 서비스별 볼륨 지정
services:
  db:
    image: mysql
    volumes:
      - db-data:/var/lib/mysql # Named Volume

  app:
    image: myapp
    volumes:
      - ./app:/app  # Bind Mount
```

3. 볼륨의 종류

- Named Volume:
    - 볼륨의 이름을 지정하여 볼륨을 생성하고, 여러 컨테이너에서 공유하여 사용
    - `docker volume` 명령어로 관리되는 볼륨으로, Docker가 볼륨 데이터를 저장할 위치를 자동으로 지정
    - 위 예시의 `db-data`처럼 이름만 정의하고 Docker가 내부적으로 저장소를 관리하도록 할 수 있음
- Bind Mount:
    - 호스트의 특정 디렉토리를 컨테이너에 연결하는 방식으로, 로컬 파일 시스템의 경로를 직접 지정
    - 주로 개발 환경에서 코드 디렉토리를 컨테이너에 연결할 때 사용

4. 볼륨 옵션

- `driver`:
    - 볼륨이 데이터를 저장하는 위치나 방식을 정의하는 속성
    - 기본값은 `local`이며, 로컬 파일 시스템에 저장
    - 다른 드라이버를 사용하여 NFS, 클라우드, 클러스터 등의 외부 스토리지에도 데이터를 저장 가능
        - `nfs`: 네트워크 파일 시스템을 통해 외부 스토리지에 데이터를 저장
        - `overlay`: Docker Swarm이나 Kubernetes에서 클러스터 환경에 걸쳐 분산된 데이터를 저장할 때 사용
- `driver_opts`:
    - 선택한 `driver`에 대해 추가 설정을 지정
    - `type`: 파일 시스템의 유형을 지정
        - `none`: 별도의 파일 시스템 유형을 지정하지 않고 기본 파일 시스템 그대로 바인드 마운트를 진행
        - `tmpfs`: 메모리 기반의 임시 파일 시스템으로 설정
    - `o`: 마운트 옵션을 지정
        - `bind`: 호스트의 특정 디렉토리를 컨테이너의 디렉토리에 연결하는 바인드 마운트를 수행
        - `ro`: 읽기 전용
    - `device`: 호스트의 실제 파일 시스템 경로를 지정
- `external`:
    - `true`로 설정하면, Docker Compose가 외부에 이미 존재하는 볼륨을 참조
