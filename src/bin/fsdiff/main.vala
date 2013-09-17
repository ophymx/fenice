namespace Fenice.Fsdiff {

public class Main {
    public static int main(string[] args) {
        Options options = new Options();
        options.parse(args);

        if (args.length != 2) {
            stderr.printf("error: wrong number of arguments (%d for 1)\n",
                args.length - 1);
            return 1;
        }

        string path = args[1];

        FileStream output;
        if (options.output_file == "-") {
            output = (owned) stdout;
        } else {
            output = FileStream.open(options.output_file, "w");
        }

        Loadset loadset = new Loadset();
        loadset.transcripts.add(new TranscriptFile(options.command_file));

        Transcript transcript = new TranscriptDiffer(loadset, new Fswalker(path));

        foreach (var object in transcript) {
            if (object.has_changed()) {
                output.printf("%s\n", object.to_string());
            }
        }

        return 0;
    }
}

}
