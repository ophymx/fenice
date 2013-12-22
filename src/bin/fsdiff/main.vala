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

        var loadset_file = new LoadsetFile.from_path(Options.command_file);
        var loadset = loadset_file.loadset();

        var fs = new PosixFilesystem();
        var walker = new Fswalker(Options.path(), fs);
        var transcript = new TranscriptDiffer(loadset, walker);

        var presenter = new CreatableTranscriptPresenter();

        foreach (var entry in transcript) {
            if (entry.has_changed()) {
                output.printf("%s\n", presenter.present(entry));
            }
        }

        return 0;
    }
}

}
