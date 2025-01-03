// final & const

// 공통점
// 변수 재할당 방지

// 차이점
// * final: 변수의 참조 재할당을 방지 역할
// * const: 컴파일 타임에 계산될 수 있는 상수를 선언하는 역할

// late 키워드 사용 가능 여부
// * final(o)
// * const(x) - (컴파일 타임에 선언되어야 하므로 나중이 없다.)

// 값 변경 여부
// final(o) - 변수 재할당 방지만 담당, 객체 생성과 관련이 없음.
// const(x)

// 내용물이 같은 네 개의 배열을 만들 때
// final: 각기 다른 배열을 만듬
// const: 값이 동일하기에 배열을 하나만 만든 후 참조를 공유

