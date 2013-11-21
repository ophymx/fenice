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

    public LoadsetFile.from_path(string path) {
        this.base_dir = Path.get_dirname(path);
        this.filename = Path.get_basename(path);
    }

    public Loadset loadset() throws LoadsetFileParseError {
        var loadset = new Loadset();
        var wsv_file = new WSVFile(base_dir, filename);

        foreach (var entry in wsv_file) {
            if (entry.comment || entry.blank)
                continue;

            if (entry.args.length != 2) {
                throw new LoadsetFileParseError.INVALID_ARGUMENTS("");
            }

            var type = entry.args[0];
            var path = entry.args[1];

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
                    var transcript = new TranscriptFile(path, base_dir);
                    loadset.transcripts.add(new NegativeTranscript(transcript));
                    break;

                case "k":
                    var loadset_file = new LoadsetFile(path, base_dir);
                    loadset.transcripts.add(loadset_file.loadset());
                    break;

                default:
                    throw new LoadsetFileParseError.UNKNOWN_TYPE(
                        "%s:%d: unknown loadset entry type '%s'", filename,
                        entry.line_number, type);
            }
        }

        return loadset;
    }
}

}
