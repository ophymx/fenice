namespace Fenice {

public errordomain TranscriptEntryParserError {
    UNKNOWN_TYPE
}

public class TranscriptEntryParser : Object {

    public TranscriptEntry parse(string line)
        throws TranscriptEntryParserError {
        ChangeType change_type = ChangeType.UNCHANGED;
        int start = 0;

        if (line.has_prefix("- ")) {
            change_type = ChangeType.REMOVED;
            start = 2;
        }

        string[] args = Regex.split_simple("[ \t]+", line.substring(start));

        string type = args[0];

        switch (type) {
            case "b":
                return (new BlockParser()).parse(args, change_type);

            case "c":
                return (new CharParser()).parse(args, change_type);

            case "d":
                return (new DirParser()).parse(args, change_type);

            case "f":
                return (new FileParser()).parse(args, change_type);

            case "h":
                return (new LinkParser()).parse(args, change_type);

            case "l":
                return (new SymlinkParser()).parse(args, change_type);

            case "p":
                return (new PipeParser()).parse(args, change_type);

            case "s":
                return (new SocketParser()).parse(args, change_type);

            default:
                throw new TranscriptEntryParserError.UNKNOWN_TYPE(
                    "unknown transcript entry type '%s'", type);
        }
    }
}

}
