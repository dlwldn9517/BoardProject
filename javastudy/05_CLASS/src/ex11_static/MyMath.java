package ex11_static;

public class MyMath {

	// static
	// 1. 정적 요소
	// 2. 객체 생성 이전에 메소리에 미리 만들어지는 공유 요소
	// 3. 클래스에서 1개만 만들어진다. (어차피 공식이 똑같아서 여러개 만들 필요X)
	// 4. 클래스를 이용해서 호출하기 때문에 클래스 변수, 클래스 메소드라고 부른다.
	
	// 필드
	public static final double PI = 3.141592;	
	// final이라서 값이 바뀌지 않아서 공개(public) 
	
	// 메소드
	public static int abs(int n) {
		return (n >= 0) ? n: -n;
	// 어차피 공식이 똑같으니까 static
	// Math. 요소는 공식을 새로 만들지 않는다. 전부다 static
	}
	
	public static int pow(int a, int b) {
		// a의 b제곱 반환
		// for문 구현
		int result = 1;
		for(int cnt = 0; cnt < b; cnt++) {
			result *= a;
		}
		return result;
	}
	
}
