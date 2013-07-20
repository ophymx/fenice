namespace Fenice {

public class Tsocket : Object, TranscriptEntry, Tperm {
    private Tpath _path;
    private Tmode _mode;
    private Tuid _uid;
    private Tgid _gid;

    public Tpath path { get { return _path; }}

    public Tmode mode { get { return _mode; }}

    public Tuid uid { get { return _uid; }}

    public Tgid gid { get { return _gid; }}

    public ChangeType change_type { get; set; }

    public Tsocket(Tpath path, Tmode mode, Tuid uid, Tgid gid,
        ChangeType change_type = ChangeType.DEFAULT) {
        _path = path;
        _mode = mode;
        _uid = uid;
        _gid = gid;
        this.change_type = change_type;
    }

    public bool equal(TranscriptEntry other) {
        return object_equal(other) && perm_equal(other as Tperm);
    }


    public string to_string() {
        return perm_string().str;
    }

    public char type_char() {
        return 's';
    }
}

}
