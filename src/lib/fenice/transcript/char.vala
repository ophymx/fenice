namespace Fenice {

public class Tchar : Object, TranscriptEntry, Tperm, Tspecial {
    private path_t _path;
    private mode_t _mode;
    private uid_t _uid;
    private gid_t _gid;
    private uint _major;
    private uint _minor;

    public path_t path { get { return _path; }}

    public mode_t mode { get { return _mode; }}

    public uid_t uid { get { return _uid; }}

    public gid_t gid { get { return _gid; }}

    public uint major { get { return _major; }}

    public uint minor { get { return _minor; }}

    public ChangeType change_type { get; set; }

    public Tchar(path_t path, mode_t mode, uid_t uid, gid_t gid, uint major,
        uint minor, ChangeType change_type = ChangeType.DEFAULT) {
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
        return 'c';
    }
}

}
