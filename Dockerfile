## FROM : 기반이 되는 이미지 레이어
# <이미지 이름>:<태그> 형식으로 작성 ex) ubuntu:14.04
# FROM tensorflow/tensorflow:latest-gpu
FROM python:3


## 작업디렉토리(default)설정
WORKDIR /usr/src/app


## Install packages
# 현재 패키지 설치 정보를 도커 이미지에 복사
COPY requirements.txt ./
# 설치정보를 읽어 들여서 패키지를 설치
# RUN : 도커이미지가 생성되기 전에 수행할 쉘 명령어
RUN pip install -r requirements.txt

RUN apt-get update
RUN apt-get install -y libgl1-mesa-dev


# 현재경로에 존재하는 모든 소스파일을 이미지에 복사
COPY . .


# 8000번 포트를 외부에 개방하도록 설정
# EXPOSE : 호스트와 연결할 포트 번호
EXPOSE 8000


# CMD : 컨테이너가 시작되었을 때 실행할 실행 파일 또는 셸 스크립트
# 해당 명령어는 DockerFile내 1회만 쓸 수 있음
#CMD ["python", "./setup.py", "runserver", "--host=0.0.0.0", "-p 8080"] -> ./manage.py로 해도 됨.
#gunicorn을 사용해서 서버를 실행
# CMD ["gunicorn", "--bind", "0.0.0.0:8000", "sirenorder.wsgi:application"]
# CMD ["python", "manage.py", "runserver", "--host=0.0.0.0", "-p 8000"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# ENTRYPOINT ["python"]
# CMD ["manage.py"]

