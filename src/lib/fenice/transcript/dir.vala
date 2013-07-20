namespace Fenice {

public class Tdir : Object, TranscriptEntry, Tperm {
    private path_t _path;
    private mode_t _mode;
    private uid_t _uid;
    private gid_t _gid;

    public path_t path { get { return _path; } }

    public mode_t mode { get { return _mode; } }

    public uid_t uid { get { return _uid; } }

    public gid_t gid { get { return _gid; } }

    public bool check { get; set construct; }

    public ChangeType change_type { get; set; }

    public Tdir(path_t path, mode_t mode, uid_t uid, gid_t gid,
        ChangeType change_type = ChangeType.DEFAULT, bool check=true) {
        _path = path;
        _mode = mode;
        _uid = uid;
        _gid = gid;
        this.check = check;
        this.change_type = change_type;
    }

    public bool equal(TranscriptEntry other) {
        return object_equal(other) && perm_equal(other as Tperm);
    }

    public string to_string() {
        return perm_string().str;
    }

    public char type_char() {
        return 'd';
    }
}

}
