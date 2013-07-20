namespace Fenice {

public class Tdir : Object, TranscriptEntry, Tperm {
    private Tpath _path;
    private Tmode _mode;
    private Tuid _uid;
    private Tgid _gid;

    public Tpath path {
        get { return _path; }
    }

    public Tmode mode {
        get { return _mode; }
    }

    public Tuid uid {
        get { return _uid; }
    }

    public Tgid gid {
        get { return _gid; }
    }

    public bool check { get; set construct; }

    public ChangeType change_type { get; set; }

    public Tdir(Tpath path, Tmode mode, Tuid uid, Tgid gid,
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
