import java.util.*;
import java.io.*;

public class Main {
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int m = sc.nextInt();
        long x = sc.nextLong();

        String s = sc.next();

        long[] a = new long[n];
        for (int i = 0; i < n; i++) {
            a[i] = sc.nextLong();
        }

        System.out.println(solve(n));
    }

    static String solve(int n) {
        String result = "";
        // StringBuilder result = new StringBuilder("");
        //int result = 0;

        return result;
    }
}
