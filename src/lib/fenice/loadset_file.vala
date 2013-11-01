namespace Fenice {

public errordomain LoadsetFileParseError {
    INVALID_ARGUMENTS,
    UNKNOWN_TYPE
}

public class LoadsetFile : Object {

    public string filename { get; set construct; }
    public string base_dir { get; set construct; }

    public LoadsetFile(string filename, string base_dir) {
        this.filename = filename;
        this.base_dir = base_dir;
    }

    public Loadset loadset() throws LoadsetFileParseError {
        Loadset loadset = new Loadset();
        WSVFile wsv_file = new WSVFile(Path.build_filename(base_dir, filename));

        foreach (var entry in wsv_file) {
            if (entry.comment || entry.blank)
                continue;

            if (entry.args.length != 2) {
                throw new LoadsetFileParseError.INVALID_ARGUMENTS("");
            }

            switch (entry.args[0]) {
                case "x":
                    loadset.add_exclude(entry.args[1]);
                    break;

                case "s":
                    loadset.add_special(entry.args[1]);
                    break;

                case "p":
                    loadset.transcripts.add(new TranscriptFile(
                            Path.build_filename(base_dir, entry.args[1])
                        ));
                    break;

                case "n":
                    break;

                case "k":
                    LoadsetFile loadset_file = new LoadsetFile(entry.args[1],
                        base_dir);
                    loadset.transcripts.add(loadset_file.loadset());
                    break;

                default:
                    throw new LoadsetFileParseError.UNKNOWN_TYPE("");
                    break;
            }
        }

        return loadset;
    }
}

}
