package com.craftinginterpreters.lox;

import java.io.IOException; // for throw execeptions
import java.nio.charset.Charset; // for reading bytes in file
import java.nio.file.Files; // import file class
import java.nio.file.Paths; // import path class
import java.util.List;
import java.util.Scanner; // will use this instead for std in

public class Lox {

    static boolean hadError = false;

    public static void main(String[] args) throws IOException {
        if (args.length > 1) {
            // what if you wanted to use flags?
            // what if you wanted to use flags?
            System.out.println("Usage: jlox [script]");
            return;
        } else if (args.length == 1) {
            // what if no permision to open file?, or does not exist?
            System.out.println("Running script: " + args[0]);
            runFile(args[0]);
            return;
        } else {
            runPrompt();
        }
    }

    private static void runFile(String path) throws IOException {
        // you feed the path to it so you could do stuff
        // like, $ lox src/main.lox
        // Paths.get(path)), so it doest not matter, where im
        // lox interpreter is in my path, it always knows how to reach the file?
        byte[] bytes = Files.readAllBytes(Paths.get(path));
        //run(new String(bytes, Charset.defaultCharset()));

        if (hadError) System.exit(65);
        //System.out.println(Charset.defaultCharset());
        //
        //for (int i = 0; i < bytes.length; i++) {
        //System.out.print(bytes[i] + " ");
        //}
    }

    // repl
    private static void runPrompt() throws IOException {
        // why not use the Scanner()?
        // InputStreamReader input = new InputStreamReader(System.in);
        // BufferedReader reader = new BufferedReader(input);
        // String line = reader.readLine();
        Scanner input = new Scanner(System.in);

        while (true) {
            // irb: irb(main):[line]>
            // python: >>>
            System.out.print("> ");
            String line = input.nextLine();

            if (line == null) break;

            //if (line == ".q"): '==' why not work?
            if (line.equals(".q") || line.equals(".exit")) {
                return;
            }
            System.out.println(line);
            // run(line);
            hadError = false;
        }
    }

    // why does he use scanner here? and does not import it?
    // maybe, he means his own scanner class? he does
    // ill prob change its name to lexer
    private static void run(String source) {
        Lexer lexer = new Lexer(source);
        //List<Token> tokens = lexer.scanTokens();

        // for now print tokens
        //for (Token token : tokens) {
        //   System.out.println(token);
        //}
    }

    static void error(int line, String message) {
        report(line, "", message);
    }

    // error helper
    private static void report(int line, String where, String message) {
        System.err.println(
            "[line " + line + "] Error" + where + ": " + message
        );
        hadError = true;
    }
}
