# 타이핑 게임 제작 및 기본완성
import random
import time
# py sound for linux, pip install pyglet 설치
import pyglet 
import sqlite3
import datetime


now = datetime.datetime.now()
nowDatetime = now.strftime('%Y-%m-%d %H:%M:%S')

words = []                                   # 영어 단어 리스트(1000개 로드)
game_cnt = 1                                 # 게임 시도 횟수
corr_cnt = 0                                 # 정답 개수

# 파일 로딩 전 DB생성 및 cursor 연결
conn = sqlite3.connect("wordgameDB.db", isolation_level=None)   # DB 연결
curr = conn.cursor()  # cursor 생성
# DB 테이블 생성
curr.execute("create table if not exists wordgame(id integer primary key AUTOINCREMENT, \
corr_cnt text not null, exe_time text not null,  reg_date text not null)")
#id 자동증가, 정답수: corr_cnt, 걸린시간: exe_time, 
# 저장한 시간: reg_date  -> tabel 생성

with open('./data/word.txt', 'r') as f:  # 문제 txt 파일 로드
    for c in f:
        words.append(c.strip())
# print(words)                                 # 단어 리스트 확인

input("Ready? Press Enter Key!")             # Enter Game Start!

start = time.time()                          # Start Time
print(start)                                 # 확인
while game_cnt <= 5:                         # 5회 반복
    random.shuffle(words)                    # List shuffle!
    que_word = random.choice(words)                 # List -> words random extract!

    print()
    print("*Question # {}".format(game_cnt))
    print(que_word)                                 # 문제 출력

    input_word = input()                              # 타이핑 입력
    print()
    
    if str(que_word).strip() == str(input_word).strip():     # 입력 확인(공백제거)
        good_sound = pyglet.resource.media(                  # 정답 소리 재생
            'assets/good.wav',
        )
        good_sound.play()        
        print("Pass!")
        corr_cnt += 1                         # 정답 개수 카운트
    else:
        bad_sound = pyglet.resource.media(              # 오답 소리 재생
            'assets/bad.wav',
        )
        bad_sound.play()        
        print("Wrong!")

    game_cnt += 1                                   # 다음 문제 전환

end = time.time()                            # End Time
print(end)
time.sleep(0.2)  # 단위 : sec, 마지막 문제 소리 재생을 위해 시간 지연 (이것을 안주면 소리가 나지 않음 바로 넘어가기 때문에)

exe_time = end - start                             # 총 게임 시간

exe_time = format(exe_time, ".3f")                       # 소수 셋째 자리 출력(시간)


if corr_cnt >= 3:                             # 3개 이상 합격
    print("결과 : 합격")
else:
    print("불합격")



#DB 테이블에 넣기: 
curr.execute("INSERT INTO wordgame(corr_cnt, exe_time, reg_date) VALUES(?,?,?)",
(
    corr_cnt, exe_time, nowDatetime
))

curr.execute("SELECT*FROM wordgame")



# 수행 시간 출력
print("게임 시간 :", exe_time, "초", "정답 개수 : {}".format(corr_cnt))

#접속 해제 
conn.close()
# 시작지점
if __name__ == '__main__':
    pass
