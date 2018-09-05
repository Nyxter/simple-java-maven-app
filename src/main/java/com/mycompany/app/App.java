package com.mycompany.app;

/**
 * Hello world!
 */
public class App
{

    private final String message = "Hello World!";

    public App() {}

    public static void main(String[] args) {
        System.out.println(new App().getMessage());
        if ( false == true ){
            System.out.println("oops");
        }
    }

    public void missed(){
        String.format("%d", "1");
    }

    private final String getMessage() {
        return message;
    }

}
