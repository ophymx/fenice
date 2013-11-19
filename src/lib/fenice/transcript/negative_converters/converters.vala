namespace Fenice {

public interface TranscriptEntryConverter : Object {
    public abstract TranscriptEntry convert(TranscriptEntry entry);
}

public class NegativeConverter : Object, TranscriptEntryConverter {
    private Gee.Map<TranscriptEntryType,TranscriptEntryConverter> converters =
        new Gee.HashMap<TranscriptEntryType,TranscriptEntryConverter>();

    public NegativeConverter() {
        converters[TranscriptEntryType.BLOCK] = new BlockConverter();
        converters[TranscriptEntryType.CHAR] = new CharConverter();
        converters[TranscriptEntryType.DIR] = new DirConverter();
        converters[TranscriptEntryType.FILE] = new FileConverter();
        converters[TranscriptEntryType.LINK] = new LinkConverter();
        converters[TranscriptEntryType.SYMLINK] = new SymlinkConverter();
        converters[TranscriptEntryType.PIPE] = new PipeConverter();
        converters[TranscriptEntryType.SOCKET] = new SocketConverter();
    }

    public TranscriptEntry convert(TranscriptEntry entry) {
        return converters[entry.entry_type()].convert(entry);
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
