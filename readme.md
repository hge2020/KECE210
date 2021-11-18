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


### Project Schedule
1. 난수 발생기 및 사용 모듈 테스트 코드 설계, 회로 다이어그램 설계.
- Testbench를 통한 난수 발생기 정상 동작 확인.
- 각 모듈에 대한 정상 동작 확인하는 코드 설계. (*필수)
	- 7-segment*
	- number pad*
	- RGB LED*
	- Servo motor
2. 7-segment 및 Number pad, RGB LED로 심플 할리갈리 완성.
- 간단한 규칙만 적용
	- 카드 넘기기(Random, 7-seg, RGB LED, number pad)
	- 종 누르기(Compator, number pad)
3. Servo motor 를 추가하여 턴의 느낌을 살림
- 저번주에 설계한 심플 할리갈리에 추가 규칙을 적용
- 서보 모터를 통해 턴을 확인 가능하게끔 하기.
