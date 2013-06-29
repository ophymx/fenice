namespace Fenice {

public struct Ttarget {

    public Tpath target;
    public bool check;

    public Ttarget(Tpath target, bool check=true) {
        this.target = target;
        this.check = check;
    }

    public Ttarget.from_symlink(string symlink, bool check=true) {
        string target = "";
        try {
            target = FileUtils.read_link(symlink);
        } catch(FileError e) {
            stderr.printf("%s\n", e.message);
        }
        this.target = Tpath(target);
        this.check = check;
    }

    public Ttarget.parse(string target) {
        if (target[0] == '-') {
            this.target = Tpath.parse(target.substring(1));
            check = false;
        } else {
            this.target = Tpath.parse(target);
            check = true;
        }
    }

    public bool equal(Ttarget other) {
        return (!check) | target.equal(other.target);
    }

    public int compare_to(Ttarget other) {
        return target.compare_to(other.target);
    }

    public string to_string() {
        StringBuilder builder = new StringBuilder();
        if (!check)
            builder.append_c('-');
        builder.append(target.to_string());
        return builder.str;
    }
}

}
