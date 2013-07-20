namespace Fenice {

public class Tsymlink : Object, TranscriptEntry, Tperm {
    private path_t _path;
    private mode_t _mode;
    private uid_t _uid;
    private gid_t _gid;

    public path_t path { get { return _path; }}

    public mode_t mode { get { return _mode; }}

    public uid_t uid { get { return _uid; }}

    public gid_t gid { get { return _gid; }}

    public ChangeType change_type { get; set; }

    public target_t target { get; private set; }

    public Tsymlink(path_t path, mode_t mode, uid_t uid, gid_t gid,
        target_t target, ChangeType change_type = ChangeType.DEFAULT) {
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
