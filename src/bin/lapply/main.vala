namespace Fenice.Lapply {

public class Main {
    public static int main(string[] args){
        Options options = new Options();
        options.parse(args);

        stdout.printf("%d\n", args.length);

        return 0;
    }
}

}
