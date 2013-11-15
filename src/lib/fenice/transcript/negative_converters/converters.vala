namespace Fenice {

public interface TranscriptEntryConverter : Object {
    public abstract TranscriptEntry convert(TranscriptEntry entry);
}

public class NegativeConverter : Object, TranscriptEntryConverter {

    public TranscriptEntry convert(TranscriptEntry entry) {
        switch (entry.entry_type()) {
            case TranscriptEntryType.BLOCK:
                return (new BlockConverter()).convert(entry);

            case TranscriptEntryType.CHAR:
                return (new CharConverter()).convert(entry);

            case TranscriptEntryType.DIR:
                return (new DirConverter()).convert(entry);

            case TranscriptEntryType.FILE:
                return (new FileConverter()).convert(entry);

            case TranscriptEntryType.LINK:
                return (new LinkConverter()).convert(entry);

            case TranscriptEntryType.SYMLINK:
                return (new SymlinkConverter()).convert(entry);

            case TranscriptEntryType.PIPE:
                return (new PipeConverter()).convert(entry);

            case TranscriptEntryType.SOCKET:
                return (new SocketConverter()).convert(entry);

            default:
                assert_not_reached();
        }
    }

    private class BlockConverter : Object, TranscriptEntryConverter {
        public TranscriptEntry convert(TranscriptEntry entry) {
            return entry;
        }
    }

    private class CharConverter : Object, TranscriptEntryConverter {
        public TranscriptEntry convert(TranscriptEntry entry) {
            var e = entry as Tchar;
            return new Tchar(e.path, mode_t(e.mode.mode, mode_t.PERM_MASK),
                uid_t(e.uid.uid, false), gid_t(e.gid.gid, false), e.major,
                e.minor);
        }
    }

    private class DirConverter : Object, TranscriptEntryConverter {
        public TranscriptEntry convert(TranscriptEntry entry) {
            var e = entry as Tdir;
            return new Tdir(e.path, e.mode, e.uid, e.gid, e.change_type, false);
        }
    }

    private class FileConverter : Object, TranscriptEntryConverter {
        public TranscriptEntry convert(TranscriptEntry entry) {
            var e = entry as Tfile;
            return new Tfile(e.path, e.mode, e.uid, e.gid,
                mtime_t(e.mtime.mtime, false), fsize_t(e.size.size, false),
                checksum_t(e.checksum.checksum, false,
                    e.checksum.checksum_type));
        }
    }

    private class LinkConverter : Object, TranscriptEntryConverter {
        public TranscriptEntry convert(TranscriptEntry entry) {
            return entry;
        }
    }

    private class SymlinkConverter : Object, TranscriptEntryConverter {
        public TranscriptEntry convert(TranscriptEntry entry) {
            var e = entry as Tsymlink;
            return new Tsymlink(e.path, e.mode, e.uid, e.gid,
                target_t(e.target.target, false));
        }
    }

    private class PipeConverter : Object, TranscriptEntryConverter {
        public TranscriptEntry convert(TranscriptEntry entry) {
            return entry;
        }
    }

    private class SocketConverter : Object, TranscriptEntryConverter {
        public TranscriptEntry convert(TranscriptEntry entry) {
            return entry;
        }
    }
}

}
