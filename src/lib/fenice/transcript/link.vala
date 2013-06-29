namespace Fenice {

public class Tlink : Object, Tobject {
    private Tpath _path;
    private Ttarget _target;

    public Tpath path {
        get { return _path; }
    }

    public Ttarget target {
        get { return _target; }
        private set { _target = value; }
    }

    public ChangeType change_type { get; set; }

    public Tlink(Tpath path, Ttarget target,
        ChangeType change_type = ChangeType.DEFAULT) {
        _path = path;
        this.target = target;
        this.change_type = change_type;
    }

    public char type_char() {
        return 'h';
    }

    public bool equal(Tobject other) {
        return get_class() == other.get_class() &&
            target.equal((other as Tlink).target);
    }

    public string to_string() {
        StringBuilder builder = object_string();
        builder.append(target.to_string());
        return builder.str;
    }
}

}
