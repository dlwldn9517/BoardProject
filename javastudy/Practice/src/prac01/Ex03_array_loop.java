package prac01;

import java.util.Scanner;

public class Ex03_array_loop {

	public static void main(String[] args) {
		
		Scanner sc = new Scanner(System.in);
		
		System.out.println("금액을 입력하시오  >> ");
		int money = sc.nextInt();
		
		int[] unit = {50000, 10000, 5000, 1000, 500, 100, 50, 10, 5, 1};
		int[] count = new int[unit.length];
		
		for(int i = 0; i < unit.length; i++) {
			count[i] = money / unit[i];
			money = money % unit[i];
			if(count[i] == 0) {
				continue;
			}
			System.out.println(unit[i] + "원 짜리 : " + count[i] + "개");
		}	
		
		
	}
	
}
