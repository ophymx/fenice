namespace Fenice {

public class Tfile : Object, TranscriptEntry, Tperm {
    private path_t _path;
    private mode_t _mode;
    private uid_t _uid;
    private gid_t _gid;
    private mtime_t _mtime;
    private fsize_t _size;
    private checksum_t _checksum;

    public path_t path { get { return _path; }}

    public mode_t mode { get { return _mode; }}

    public uid_t uid { get { return _uid; }}

    public gid_t gid { get { return _gid; }}

    public mtime_t mtime { get { return _mtime; }}

    public fsize_t size { get { return _size; }}

    public checksum_t checksum { get { return _checksum; }}

    public ChangeType change_type { get; set; }

    public TranscriptEntryType entry_type() {
        return TranscriptEntryType.FILE;
    }

    public Tfile(path_t path, mode_t mode, uid_t uid, gid_t gid, mtime_t mtime,
        fsize_t size, checksum_t checksum,
        ChangeType change_type = ChangeType.DEFAULT) {
        _path = path;
        _mode = mode;
        _uid = uid;
        _gid = gid;
        _mtime = mtime;
        _size = size;
        _checksum = checksum;
        this.change_type = change_type;
    }

    public bool equal(TranscriptEntry other) {
        return object_equal(other) && perm_equal(other as Tperm) &&
            mtime.equal((other as Tfile).mtime) &&
            size.equal((other as Tfile).size) &&
            checksum.equal((other as Tfile).checksum);
    }
}

}
