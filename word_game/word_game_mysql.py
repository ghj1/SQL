# 타이핑 게임 제작 및 기본완성

import random
import time
# py sound for linux, pip install pyglet 설치
import pyglet
import datetime
import keyboard
import pymysql

words = []                                   # 영어 단어 리스트(1000개 로드)
game_cnt = 1                                 # 게임 시도 횟수
corr_cnt = 0                                 # 정답 개수
check = dict()                               # 중복 단어 확인 dictionary

# DB 생성
conn = pymysql.connect(host='localhost',
                       port=3306,
                       user='ubuntu',
                       passwd='1234',
                       db='mydb',
                       charset='utf8'
                       )
cur = conn.cursor()

# DB 테이블 생성
# id 자동 증가
# 정답수
# 걸린 시간
# 저장한 시간.
cur.execute("""
                CREATE TABLE if not exists wordgameDB(id INTEGER PRIMARY KEY AUTO_INCREMENT, 
                                                     corr_cnt TEXT not null,
                                                     timelapse TEXT not null,
                                                     regdate TEXT not null
                                                     )
            """
            )

# /home/ubuntu/sql/word_game/
with open('/home/ubuntu/sql/word_game/word.txt', 'r') as f:  # 문제 txt 파일 로드
    for c in f:
        temp = c.strip()
        words.append(temp)
        check[temp] = False

print(f"words Length : {len(words)}")
print(f"check Length : {len(check)}")        

# 가로 10단어 왼쪽 정렬하여 출력
strFormat = ''
for _ in range(10):
    strFormat += '%-16s' # 왼쪽 정렬
strFormat += '\n'

# 컬럼명 입력
strOut = strFormat % ('sep1','sep2','sep3','sep4','sep5','sep6','sep7','sep8','sep9','sep10') 

tmp = []
k = 0
for i in range(985):
    tmp1 = []
    for j in range(10):
        tmp1.append(words[k])
        k += 1
    tmp.append(tmp1)

for y in tmp:
    strOut += strFormat % (y[0],y[1],y[2],y[3],y[4],y[5],y[6],y[7],y[8],y[9])

# 예외 사항 추가 출력 (맨끝 9개 단어)
strFormat = ''
for _ in range(9):
    strFormat += '%-16s' # 왼쪽 정렬
strFormat += '\n'

e = []
for i in range(-9,0,1): # 맨끝 9개 단어
    e.append(words[i])

strOut += strFormat % (e[0],e[1],e[2],e[3],e[4],e[5],e[6],e[7],e[8])

print(strOut)

# print(words)                                 # 단어 리스트 확인
input("Ready? Press Enter Key!")             # Enter Game Start!

start = time.time()                          # Start Time
while game_cnt <= 5:                         # 5회 반복
    # random.shuffle(words)                    # List shuffle!
    que_word = random.choice(words)                 # List -> words random extract!

    # 중복 단어 방지 check dictionary
    # 한번 나왔던 단어는 True이므로 if문을 통과하여
    # while로 올라가서 반복문 다시 시작.
    if check[que_word]:
       continue
    else:
        # False -> True로 update!
        check[que_word] = True
        print()
        print(f"*Question # {game_cnt}")
        print(que_word)                                 # 문제 출력

        input_word = input()                            # 타이핑 입력
        print()
        # input() 입력 자체가 string 형식이므로 중복으로 연산할 필요없으므로 str() 제거
        if que_word.strip() == input_word.strip():      # 입력 확인(공백제거)
            good_sound = pyglet.media.load(                  # 정답 소리 재생
                './word_game/assets/good.wav')
            good_sound.play()
            print("Pass!")
            corr_cnt += 1                         # 정답 개수 카운트
        else:
            #/home/ubuntu/sql/word_game
            bad_sound = pyglet.media.load(              # 오답 소리 재생
                './word_game/assets/bad.wav')
            bad_sound.play()
            print("Wrong!")

        game_cnt += 1                                   # 다음 문제 전환
end = time.time()                            # End Time
time.sleep(0.2)  # 단위:sec(초), 마지막 문제 소리 재생을 위해 시간 지연
# exe_time = end - start                             # 총 게임 시간

# exe_time = format(end-start, ".3f")                       # 소수 셋째 자리 출력(시간)

now = datetime.datetime.now()
nowDatetime = now.strftime('%Y-%m-%d %H:%M:%S')

# DB 테이블에 넣기
# cur.execute(
#     """
#     INSERT INTO wordgameDB(corr_cnt, timelapse, regdate)
#     VALUES('"""+str(corr_cnt)+"""',
#            '"""+str(f'{end-start:0.3f}')+"""',
#            '"""+str(nowDatetime)+"""');
#     """)
# conn.commit()

cur.execute(
    """
    INSERT INTO wordgameDB(corr_cnt, timelapse, regdate)
    VALUES(%s,%s,%s);
    """,
    (corr_cnt,f'{end-start:0.3f}',nowDatetime))
conn.commit()

# DB 연결 종료
conn.close()


# 사용자가 키보드 "1"을 누르면 
# DB 내용을 출력한다.

# while True:
#     if keyboard.is_pressed("1"):
#         cur.execute("SELECT * FROM wordgameDB")
#         for i in cur.fetchall():
#             print(i)
#         break

cur.execute("SELECT * FROM wordgameDB")
for i in cur.fetchall():
    print(i)
    
# DB 연결 종료
conn.close()

if corr_cnt >= 3:                             # 3개 이상 합격
    print("결과 : 합격")
else:
    print("결과 : 불합격")
    
# 수행 시간 출력
print("게임 시간 :", f'{end-start:.3f} 초', f"\n정답 개수 : {corr_cnt}")

# 시작지점
if __name__ == '__main__':
    pass