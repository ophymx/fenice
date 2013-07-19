namespace Fenice {

public class Tfile : Object, Tobject, Tperm {
    private Tpath _path;
    private Tmode _mode;
    private Tuid _uid;
    private Tgid _gid;
    private Tmtime _mtime;
    private Tsize _size;
    private Tchecksum _checksum;

    public Tpath path { get { return _path; }}

    public Tmode mode { get { return _mode; }}

    public Tuid uid { get { return _uid; }}

    public Tgid gid { get { return _gid; }}

    public Tmtime mtime { get { return _mtime; }}

    public Tsize size { get { return _size; }}

    public Tchecksum checksum { get { return _checksum; }}

    public ChangeType change_type { get; set; }

    public Tfile(Tpath path, Tmode mode, Tuid uid, Tgid gid, Tmtime mtime,
        Tsize size, Tchecksum checksum,
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

    public char type_char() {
        return 'f';
    }

    public bool equal(Tobject other) {
        return object_equal(other) && perm_equal(other as Tperm) &&
            mtime.equal((other as Tfile).mtime) &&
            size.equal((other as Tfile).size) &&
            checksum.equal((other as Tfile).checksum);
    }

    public string to_string() {
        var builder = perm_string();
        builder.append_printf(" %9s %7s %s", mtime.to_string(),
            size.to_string(), checksum.to_string());
        return builder.str;
    }
}

}
