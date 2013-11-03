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

            string type = entry.args[0];
            string path = entry.args[1];

            switch (type) {
                case "x":
                    loadset.add_exclude(path);
                    break;

                case "s":
                    loadset.add_special(path);
                    break;

                case "p":
                    loadset.transcripts.add(new TranscriptFile(path, base_dir));
                    break;

                case "n":
                    break;

                case "k":
                    LoadsetFile loadset_file = new LoadsetFile(path, base_dir);
                    loadset.transcripts.add(loadset_file.loadset());
                    break;

                default:
                    throw new LoadsetFileParseError.UNKNOWN_TYPE(
                        "%s:%d: unknown loadset entry type '%s'", filename,
                        entry.line_number, type);
                    break;
            }
        }

        return loadset;
    }
}

}
