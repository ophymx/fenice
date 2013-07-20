namespace Fenice {

public class Tblock : Object, TranscriptEntry, Tperm, Tspecial {
    private Tpath _path;
    private Tmode _mode;
    private Tuid _uid;
    private Tgid _gid;
    private int _major;
    private int _minor;

    public Tpath path { get { return _path; }}

    public Tmode mode { get { return _mode; }}

    public Tuid uid { get { return _uid; }}

    public Tgid gid { get { return _gid; }}

    public int major { get { return _major; }}
    public int minor { get { return _minor; }}
    public ChangeType change_type { get; set; }


    public Tblock(Tpath path, Tmode mode, Tuid uid, Tgid gid, int major,
        int minor, ChangeType change_type = ChangeType.DEFAULT) {
        _path = path;
        _mode = mode;
        _uid = uid;
        _gid = gid;
        _major = major;
        _minor = minor;
        this.change_type = change_type;
    }

    public bool equal(TranscriptEntry other) {
        return object_equal(other) &&
            perm_equal(other as Tperm) &&
            special_equal(other as Tspecial);
    }

    public string to_string() {
        return special_string().str;
    }

    public char type_char() {
        return 'b';
    }
}

}
