namespace Fenice {

public class Tsymlink : Object, TranscriptEntry, Tperm {
    private Tpath _path;
    private Tmode _mode;
    private Tuid _uid;
    private Tgid _gid;

    public Tpath path { get { return _path; }}

    public Tmode mode { get { return _mode; }}

    public Tuid uid { get { return _uid; }}

    public Tgid gid { get { return _gid; }}

    public ChangeType change_type { get; set; }

    public Ttarget target { get; private set; }

    public Tsymlink(Tpath path, Tmode mode, Tuid uid, Tgid gid,
        Ttarget target, ChangeType change_type = ChangeType.DEFAULT) {
        _path = path;
        _mode = mode;
        _uid = uid;
        _gid = gid;
        _target = target;
        this.change_type = change_type;
    }

    public char type_char() {
        return 'l';
    }


    public string to_string() {
        var builder = perm_string();
        builder.append_c(' ');
        builder.append(target.to_string());
        return builder.str;
    }

    public bool equal(TranscriptEntry other) {
        return object_equal(other) &&
            perm_equal(other as Tperm) &&
            target.equal((other as Tsymlink).target);
    }
}

}
