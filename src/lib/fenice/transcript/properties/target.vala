namespace Fenice {

public struct target_t {

    public path_t target;
    public bool check;

    public target_t(path_t target, bool check=true) {
        this.target = target;
        this.check = check;
    }

    public target_t.from_symlink(string symlink, bool check=true) {
        var target = "";
        try {
            target = FileUtils.read_link(symlink);
        } catch(FileError e) {
            stderr.printf("%s\n", e.message);
        }
        this.target = path_t(target);
        this.check = check;
    }

    public target_t.parse(string target) {
        if (target[0] == '-') {
            this.target = path_t.parse(target.substring(1));
            check = false;
        } else {
            this.target = path_t.parse(target);
            check = true;
        }
    }

    public bool equal(target_t other) {
        return (!check) | target.equal(other.target);
    }

    public int compare_to(target_t other) {
        return target.compare_to(other.target);
    }

    public string to_string() {
        var builder = new StringBuilder();
        if (!check)
            builder.append_c('-');
        builder.append(target.to_string());
        return builder.str;
    }
}

}
