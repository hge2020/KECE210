# KECE 210 Final Project
## 2조(유민재, 허가은)
### 주제: 할리갈리
### FPGA module
1. 8 array 7-segment
	- 카드에 새겨진 과일의 수를 표현
	- 양 끝 7-segment만 사용.
2. servo motor
	- 누구의 턴인지 표시
3. Number pad
	- 자신의 카드 넘김 버튼
	- 종 치기 버튼(각자, 서로 같은 버튼을 누르면 구분이 안되기 때문)
4. RGB LED
	- 카드에 새겨진 과일의 종류를 표현하기 위함


### module define
1. 게임 진행
	- turn  
		keypad에서 넘기기 버튼이 눌렸는지 감지하여 state를 바꾼다. rand gen에게 enable을 주어 다음 값을 만들어내도록 하고, temp1과 temp2중 어디에 값을 저장할지 알려준다.
	- rand gen  
		5bit 무작위 random값을 만든다.
	- card_value1  
		5bit register. LED와 7seg의 값을 저장한다.
	- card_value2  
		5bit register. LED와 7seg의 값을 저장한다.
	- LED  
		temp1과 temp2의 값(앞 2bit)을 받아와 LED를 색상에 맞게 켠다. *range가 0~3이므로 %3연산
	- 7seg  
		temp1과 temp2의 값(뒤 3bit)을 받아와 7seg를 값에 맞게 켠다. *range가 0~7이므로 %5연산
	- 쌓인 개수 counter  
		turn에서 enable이 들어올때마다 1올리기. 점수컨트롤에게 값을 준다.

2. 점수 판정
	- 올바르게 쳤는지 판정  
		temp1과 temp2의 값을 받아와 올바르게 쳤는지 판정하고 점수 control에게 값을 보내줌.
	- 친사람 판정  
		개빠른 clock으로 간발의 차를 감지, 해당 턴에서 친 사람을 저장하고 있는다.
	- 점수 reg1  
		player 1의 점수를 저장
	- 점수 reg2  
		player 2의 점수를 저장
	- 점수 controll  
		- 올바르게 친 경우
			쌓인개수 counter과 친 사람 판정값을 받아와, 해당 점수 reg에 counter 값을 더해줌. 쌓인개수 counter 값 내보냄.
		- 틀리게 친 경우
			친 사람 판정값을 받아와 해당 점수 reg에는 -1값을, 다른 reg에는 +1값을 더해줌.

	- 승패판정  
		만약 reg의 값 차이가 50 이상이면 우승자를 보여주고 게임 종료.

### Project Schedule
1. 난수 발생기 및 사용 모듈 테스트 코드 설계, 회로 다이어그램 설계.
	- Testbench를 통한 난수 발생기 정상 동작 확인.
		- mux를 통해 pseudo random generator 만들기

	- 각 모듈에 대한 정상 동작 확인하는 코드 설계. (*필수)
		- 7-segment* <완>
		- number pad* <완>
		- RGB LED* <완>
		- Servo motor
2. 7-segment 및 Number pad, RGB LED로 심플 할리갈리 완성.
	- 간단한 규칙만 적용
		- 카드 넘기기(Random, 7-seg, RGB LED, number pad)
		- 종 누르기(Compator, number pad)
	
	^^ 이거 구현하기

	
3. Servo motor 를 추가하여 턴의 느낌을 살림
	- 저번주에 설계한 심플 할리갈리에 추가 규칙을 적용
	- 서보 모터를 통해 턴을 확인 가능하게끔 하기.
