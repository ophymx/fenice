namespace Fenice.Fsdiff {

public class Main {
    public static int main(string[] args) {
        Options.parse(args);

        if (Options.path() == "") {
            stderr.printf("error: must provide path\n");
            return 1;
        }

        FileStream output;
        if (Options.output_file == "-") {
           output = (owned) stdout;
        } else {
            output = FileStream.open(Options.output_file, "w");
        }

        Loadset loadset = new Loadset();
        loadset.transcripts.add(new TranscriptFile(Options.command_file));

        Fswalker walker = new Fswalker(Options.path(), loadset.excludes());
        Transcript transcript = new TranscriptDiffer(loadset, walker);

        foreach (var object in transcript) {
            if (object.has_changed()) {
                output.printf("%s\n", object.to_string());
            }
        }

        return 0;
    }
}

}
