namespace Fenice {

public class Tfile : Object, TranscriptEntry, Tperm {

    public path_t path { get; protected set; }

    public mode_t mode { get; protected set; }

    public uid_t uid { get; protected set; }

    public gid_t gid { get; protected set; }

    public mtime_t mtime { get; protected set; }

    public fsize_t size { get; protected set; }

    public checksum_t checksum { get; protected set; }

    public ChangeType change_type { get; set; }

    public Tfile(path_t path, mode_t mode, uid_t uid, gid_t gid, mtime_t mtime,
        fsize_t size, checksum_t checksum,
        ChangeType change_type = ChangeType.DEFAULT) {
        this.path = path;
        this.mode = mode;
        this.uid = uid;
        this.gid = gid;
        this.mtime = mtime;
        this.size = size;
        this.checksum = checksum;
        this.change_type = change_type;
    }

    public TranscriptEntryType entry_type() {
        return TranscriptEntryType.FILE;
    }

    public bool equal(TranscriptEntry other) {
        return object_equal(other) && perm_equal(other as Tperm) &&
            mtime.equal((other as Tfile).mtime) &&
            size.equal((other as Tfile).size) &&
            checksum.equal((other as Tfile).checksum);
    }
}

}
