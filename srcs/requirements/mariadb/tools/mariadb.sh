#!/bin/sh

# .env 파일로부터 환경 변수 로드
if [ -f .env ]; then
    # .env 파일을 읽어와서 환경 변수로 설정합니다.
    export $(cat .env | grep -v '^#' | xargs)
fi

# MySQL 데이터 디렉토리 초기화
mysql_install_db

# MySQL 서버 시작
service mysql start

# 데이터베이스 존재 여부 확인
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Database already exists"
else
    # 루트 비밀번호 설정 및 기본 보안 설정
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"
    
    # 익명 사용자 제거
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.user WHERE User='';"
    
    # 테스트 데이터베이스 삭제
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "DROP DATABASE IF EXISTS test;"
    
    # 테스트 데이터베이스 관련 권한 제거
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';"
    
    # 권한 테이블 다시 로드
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

    # 원격 접속을 위한 루트 사용자 추가
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;"

    # WordPress용 데이터베이스 및 사용자 생성
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;"

    # 초기 데이터 가져오기
    mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql
fi

# MySQL 서버 중지
service mysql stop

# 전달된 명령어 실행
exec "$@"
